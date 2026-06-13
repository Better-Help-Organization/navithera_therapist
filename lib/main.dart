import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jailbreak_detection_plus/flutter_jailbreak_detection_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:navicare/core/localization/providers/locale_provider.dart';
import 'package:navicare/core/notification/notification_service.dart';
import 'package:navicare/core/providers/socket_provider.dart';
import 'package:navicare/core/routes/app_router.dart';
import 'package:navicare/core/security/rootdetection.dart';
import 'package:navicare/feature/auth/presentation/providers/auth_provider.dart';
import 'package:navicare/feature/chat/presentation/providers/chat_provider.dart';
import 'package:navicare/firebase_options.dart';
import 'package:navicare/l10n/l10n.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:shared_preferences/shared_preferences.dart';
import "package:navicare/l10n/app_localization.dart";
import "package:navicare/core/localization/fallback_localization.dart";
// CallKit incoming
import 'package:flutter_callkit_incoming/flutter_callkit_incoming.dart';

// Make sure this is exported so other files can import it
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // Notification part (title, body, etc.)
  if (message.notification != null) {
    log("🔔 Notification title: ${message.notification?.title}");
    log("🔔 Notification body: ${message.notification?.body}");
    log(
      "🔔 Notification imageUrl: ${message.notification?.android?.imageUrl ?? message.notification?.apple?.imageUrl}",
    );
  } else {
    log("⚠️ No notification object found (maybe data-only message)");
  }

  // If you want raw JSON (for debuggingr
  try {
    log("🔔 FULL RemoteMessage JSON: ${jsonEncode(message.toMap())}");
  } catch (e) {
    log("Could not encode message to JSON: $e");
  }

  try {
    await FCMBackgroundBridge.handleBackgroundMessage(message);
  } catch (e, st) {
    log('Background handler error: $e\n$st');
  }
}

Future<bool> _isFridaDetected() async {
  try {
    final socket = await Socket.connect(
      '127.0.0.1',
      27042,
      timeout: const Duration(milliseconds: 300),
    );
    socket.destroy();
    return true;
  } catch (_) {}
  return false;
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  final sharedPreferences = await SharedPreferences.getInstance();

  if (!kDebugMode && (Platform.isAndroid || Platform.isIOS)) {
    try {
      final isRooted = await FlutterJailbreakDetectionPlus.jailbroken;
      final developerMode = await FlutterJailbreakDetectionPlus.developerMode;
      final fridaDetected = await _isFridaDetected();

      if (isRooted || developerMode || fridaDetected) {
        runApp(Rootdetection());
        return;
      }
    } catch (e) {}
  }

  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(sharedPreferences),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    // Initialize FCM
    final fcmService = ref.read(fcmServiceProvider);
    fcmService.initialize();
    fcmService.initFCMWeb();

    // Listen CallKit actions when app is foregrounded/resumed
    _listenCallKitActions();

    // Check for active calls that were accepted before Flutter initialized (Android fix)
    _checkForActiveCallOnStartup();
  }

  Map<String, dynamic> _asMap(dynamic v) {
    if (v == null) return <String, dynamic>{};
    if (v is Map) {
      return v.map((k, val) => MapEntry(k.toString(), val));
    }
    if (v is String) {
      try {
        final decoded = jsonDecode(v);
        if (decoded is Map) {
          return decoded.map((k, val) => MapEntry(k.toString(), val));
        }
      } catch (_) {}
    }
    // Try toJson on objects coming from plugin models
    try {
      final toJson = (v as dynamic).toJson();
      if (toJson is Map) {
        return toJson.map((k, val) => MapEntry(k.toString(), val));
      }
    } catch (_) {}
    return <String, dynamic>{};
  }

  /// Checks for active calls on app startup (Android fix).
  /// When the app was terminated and a call was accepted via the notification,
  /// the CallKit event may fire before Flutter's listener is ready.
  /// This method checks for any active calls and stores them as pending routes.
  Future<void> _checkForActiveCallOnStartup() async {
    try {
      final activeCalls = await FlutterCallkitIncoming.activeCalls();
      if (activeCalls == null || activeCalls.isEmpty) return;

      // Find the first valid, accepted call that hasn't expired
      for (var activeCall in activeCalls) {
        final call = activeCall as Map<dynamic, dynamic>;
        final extra = call['extra'] as Map<dynamic, dynamic>?;

        if (extra == null) continue;

        // Skip calls that aren't actually accepted (maybe ringing but app opened manually)
        if (call['accepted'] != true) continue;

        final roomName = extra['room']?.toString();
        final chatId = extra['chatId']?.toString();
        final token = extra['token']?.toString();
        final isVideoCall = extra['isVideoCall'] == true;
        final isGroupCall = extra['isGroupCall'] == true;
        final callerName = extra['callerName']?.toString() ?? 'Caller';

        if (roomName == null || chatId == null || token == null) continue;

        // Verify token hasn't expired to prevent crashing on launch with old active calls
        try {
          final parts = token.split('.');
          if (parts.length != 3) continue;

          var payloadPattern = parts[1];
          // Base64Url decoding requires padding if length is not a multiple of 4
          while (payloadPattern.length % 4 != 0) {
            payloadPattern += '=';
          }
          final String payloadJson = utf8.decode(
            base64Url.decode(payloadPattern),
          );
          final payload = jsonDecode(payloadJson) as Map<String, dynamic>;

          if (payload.containsKey('exp')) {
            final exp = payload['exp'] as int;
            final now = DateTime.now().millisecondsSinceEpoch ~/ 1000;
            if (exp < now) {
              print('Active call found but token is expired. Skipping.');
              // Tell CallKit to clean it up so it doesn't linger
              await FlutterCallkitIncoming.endCall(
                call['id']?.toString() ?? '',
              );
              continue; // Expired
            }
          }
        } catch (e) {
          print('Failed to decode token on startup: $e');
        }

        print('Active call found on startup: room=$roomName, chatId=$chatId');

        // Store as pending route - will be processed when auth gate completes
        ref.read(pendingRouteProvider.notifier).state = PendingRoute(
          path: '/call-screen',
          callData: {
            'roomName': roomName,
            'participantName': callerName,
            'chatId': chatId,
            'isVideoCall': isVideoCall,
            'isGroupCall': isGroupCall,
            'token': token,
          },
        );

        // We only want to join one call
        break;
      }
    } catch (e) {
      print('Error checking active calls on startup: $e');
    }
  }

  void _listenCallKitActions() {
    final FlutterSecureStorage _secureStorage = const FlutterSecureStorage(
      aOptions: AndroidOptions(encryptedSharedPreferences: true),
      iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock),
    );
    FlutterCallkitIncoming.onEvent.listen((callEvent) async {
      if (callEvent == null) return;

      // --- normalize the event ---
      final eventMap = _asMap(callEvent);

      // --- event type ---
      String? type =
          (() {
            final m = eventMap;
            String? t =
                (m['event'] ??
                        m['name'] ??
                        m['action'] ??
                        (m['type'] is String ? m['type'] : null))
                    ?.toString();

            if (t == null) {
              final ev = _asMap(m['event']);
              t = ev['name']?.toString() ?? ev['type']?.toString();
            }
            if (t == null) {
              try {
                t = (callEvent as dynamic).event?.toString();
              } catch (_) {}
            }
            return t;
          })();

      // --- body ---
      final body = _asMap(eventMap['body'] ?? (callEvent as dynamic).body);

      // --- extra ---
      Map<String, dynamic> extra = _asMap(body['extra']);
      if (extra.isEmpty) {
        extra = {...body, ..._asMap(body['android']), ..._asMap(body['ios'])};
      }

      // --- idMap from event (FCM payload style) ---
      final idMap = _asMap(eventMap['id']);
      // Merge any missing pieces into extra
      extra.addAll({
        if (!extra.containsKey('chatId') && idMap['chatId'] != null)
          'chatId': idMap['chatId'],
        if (!extra.containsKey('room') && idMap['room'] != null)
          'room': idMap['room'],
        if (!extra.containsKey('callerName') && idMap['callerName'] != null)
          'callerName': idMap['callerName'],
        if (!extra.containsKey('isVideoCall') && idMap['isVideoCall'] != null)
          'isVideoCall': idMap['isVideoCall'],
        if (!extra.containsKey('isGroupCall') && idMap['isGroupCall'] != null)
          'isGroupCall': idMap['isGroupCall'],
        if (!extra.containsKey('token') && idMap['token'] != null)
          'token': idMap['token'],
      });

      // --- Extract variables ---
      final String? chatId =
          (extra['chatId'] ?? idMap['chatId'] ?? body['chatId'])?.toString();
      final String? roomName =
          (extra['room'] ?? idMap['room'] ?? body['room'])?.toString();
      String? token =
          (extra['token'] ?? idMap['token'] ?? body['token'])?.toString();

      if (token == null && chatId != null) {
        try {
          // final prefs = await SharedPreferences.getInstance();
          token = await _secureStorage.read(key: 'call_token_$chatId');
          // print("Recovered token from SharedPreferences for chatId: $chatId");
        } catch (e) {
          print("Failed to recover token: $e");
        }
      }
      final bool isVideoCall =
          (extra['isVideoCall'] ??
              idMap['isVideoCall'] ??
              body['isVideoCall'] ??
              false) ==
          true;
      final bool isGroupCall =
          (extra['isGroupCall'] ??
              idMap['isGroupCall'] ??
              body['isGroupCall'] ??
              false) ==
          true;

      String? callerName =
          (extra['callerName'] ??
                  body['callerName'] ??
                  body['nameCaller'] ??
                  extra['nameCaller'] ??
                  body['name'] ??
                  extra['name'])
              ?.toString();

      callerName ??= 'Caller';

      final context = navigatorKey.currentContext;
      // if (context == null) return;

      switch (type) {
        case 'Event.actionCallAccept':
        case 'ACTION_CALL_ACCEPT':
        case 'actionCallAccept':
          print("4x4x4x   context not null praying1");
          if (roomName != null && chatId != null && token != null) {
            print("3x3x3x");
            if (context != null) {
              print("1x1x1x");
              // App is in foreground/background - navigate directly
              print("Navigating directly to call screen");
              ref
                  .read(fcmServiceProvider)
                  .joinCallFromCallKit(
                    roomName: roomName,
                    participantName: callerName,
                    chatId: chatId,
                    isVideocall: isVideoCall,
                    isGroupCall: isGroupCall,
                    token: token,
                  );
            } else {
              // App was terminated - set pending route
              ref.read(pendingRouteProvider.notifier).state = PendingRoute(
                path: '/call-screen',
                callData: {
                  'roomName': roomName,
                  'participantName': callerName,
                  'chatId': chatId,
                  'isVideoCall': isVideoCall,
                },
              );
            }
          } else {
            debugPrint('Missing room/chatId on accept; cannot join');
          }
          break;

        case 'Event.actionCallDecline':
        case 'Event.actionCallEnded':
        case 'ACTION_CALL_DECLINE':
        case 'ACTION_CALL_ENDED':
          print("context not null praying4");
          if (chatId != null) {
            await ref.read(fcmServiceProvider).rejectCall(chatId);
          }
          break;

        default:
          break;
      }
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final authState = ref.read(authProvider);
    if (state == AppLifecycleState.resumed) {
      // App came to foreground - mark messages as read and check for new ones
      authState.whenOrNull(
        authenticated: (user) async {
          await ref.read(chatProvider.notifier).getChatThreads(silent: true);
          try {
            final socketService = ref.read(socketServiceProvider);
            await socketService.connect();
          } catch (e) {
            // ignore
          }
          // If there is an active match request, ensure ringtone is playing again
          final fcm = ref.read(fcmServiceProvider);
          if (fcm.hasActiveMatchRequest) {
            //  await fcm.startMatchRequestRingtone();
          }
          return null;
        },
      );
    } else if (state == AppLifecycleState.hidden) {
      authState.whenOrNull(
        authenticated: (user) async {
          final socketService = ref.read(socketServiceProvider);
          socketService.disconnect();
          return null;
        },
      );
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final router = ref.watch(routerProvider);
    final locale = ref.watch(localeProvider);

    return OverlaySupport.global(
      child: MaterialApp.router(
        //navigatorKey: navigatorKey,
        routerConfig: router,
        debugShowCheckedModeBanner: false,
        title: 'Navicare',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.teal,
            brightness: Brightness.light,
          ),
          fontFamily: 'PlusJakartaSans',
        ),
        supportedLocales: L10n.all,
        localizationsDelegates: const [
          ...AppLocalizations.localizationsDelegates,
          FallbackMaterialLocalizationsDelegate(),
          FallbackWidgetsLocalizationsDelegate(),
          FallbackCupertinoLocalizationsDelegate(),
        ],
        locale: locale,
      ),
    );
  }
}
