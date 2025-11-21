import 'dart:convert';
import 'dart:developer';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:navicare/core/localization/providers/locale_provider.dart';
import 'package:navicare/core/notification/notification_service.dart';
import 'package:navicare/core/providers/socket_provider.dart';
import 'package:navicare/core/routes/app_router.dart';
import 'package:navicare/feature/auth/presentation/providers/auth_provider.dart';
import 'package:navicare/feature/chat/presentation/providers/chat_provider.dart';
import 'package:navicare/firebase_options.dart';
import 'package:navicare/l10n/l10n.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:shared_preferences/shared_preferences.dart';
import "package:flutter_gen/gen_l10n/app_localization.dart";
import "package:navicare/core/localization/fallback_localization.dart";
import 'package:audioplayers/audioplayers.dart';

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

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  final sharedPreferences = await SharedPreferences.getInstance();

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

  void _listenCallKitActions() {
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
      });

      // --- Extract variables ---
      final String? chatId =
          (extra['chatId'] ?? idMap['chatId'] ?? body['chatId'])?.toString();
      final String? roomName =
          (extra['room'] ?? idMap['room'] ?? body['room'])?.toString();
      final bool isVideoCall =
          (extra['isVideoCall'] ??
              idMap['isVideoCall'] ??
              body['isVideoCall'] ??
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
          if (roomName != null && chatId != null && isVideoCall != null) {
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
                  );
            } else {
              print("2x2x2x");
              // App was terminated - set pending route
              print("App was terminated, setting pending call route");
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
