import 'dart:convert';
import 'dart:developer';

import 'package:audioplayers/audioplayers.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_callkit_incoming/entities/android_params.dart';
import 'package:flutter_callkit_incoming/entities/call_kit_params.dart';
import 'package:flutter_callkit_incoming/entities/ios_params.dart';
import 'package:flutter_callkit_incoming/flutter_callkit_incoming.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:livekit_client/livekit_client.dart';
import 'package:navicare/core/constants/base_url.dart';
import 'package:navicare/core/notification/new_message_notificaiton.dart';
import 'package:navicare/feature/auth/data/models/auth_models.dart';
import 'package:navicare/feature/auth/presentation/providers/auth_provider.dart';
import 'package:navicare/feature/calendar/presentation/pages/pages/events_example.dart';
import 'package:navicare/feature/call/exts.dart';
import 'package:navicare/feature/call/pages/room.dart';
import 'package:navicare/feature/chat/presentation/pages/chat_list_screen.dart';
import 'package:navicare/feature/chat/presentation/providers/chat_provider.dart';
import 'package:navicare/feature/chat/presentation/providers/message_provider.dart';
import 'package:navicare/feature/home/presentation/pages/home_screen.dart';
import 'package:navicare/feature/home/presentation/providers/chart_data_provider.dart';
import 'package:navicare/feature/questionnaire/presentation/pages/match_request_screen.dart';
import 'package:navicare/main.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class PendingRoute {
  final String path;
  final Object? extra;
  final Map<String, dynamic>? callData; // Add call-specific data

  PendingRoute({required this.path, this.extra, this.callData});
}

final pendingRouteProvider = StateProvider<PendingRoute?>((ref) => null);

final fcmServiceProvider = Provider<FCMService>((ref) {
  return FCMService(FirebaseMessaging.instance, ref);
});

final activeCallDialogProvider =
    StateProvider<Map<String, OverlaySupportEntry?>>((ref) => {});

class FCMService {
  final FirebaseMessaging _fcm;
  final Ref _ref;

  FCMService(this._fcm, this._ref);

  AudioPlayer? _ringtonePlayer;
  String? _activeCallChatId;
  bool get _isCallDialogOpen => _activeCallChatId != null;
  // Match request ringtone state
  AudioPlayer? _matchRequestPlayer;
  bool _hasActiveMatchRequest = false;
  bool get hasActiveMatchRequest => _hasActiveMatchRequest;

  // Future<void> startMatchRequestRingtone() async {
  //   try {
  //     _hasActiveMatchRequest = true;
  //     // If already playing, do nothing
  //     final p = _matchRequestPlayer ?? AudioPlayer();
  //     _matchRequestPlayer = p;
  //     // Ensure loop mode
  //     await p.setReleaseMode(ReleaseMode.loop);
  //     await p.setVolume(1.0);
  //     // Use existing positive.wav asset
  //     await p.play(AssetSource('sounds/positive.wav'));
  //   } catch (e) {
  //     print('Error starting match-request ringtone: $e');
  //   }
  // }

  // Future<void> stopMatchRequestRingtone() async {
  //   try {
  //     await _matchRequestPlayer?.stop();
  //     await _matchRequestPlayer?.release();
  //   } catch (e) {
  //     print('Error stopping match-request ringtone: $e');
  //   } finally {
  //     _matchRequestPlayer = null;
  //     _hasActiveMatchRequest = false;
  //   }
  // }

  _join(
    String url,
    String token,
    BuildContext context, {
    required bool isVideoCall,
    required bool isGroupCall,
    required String chatId,
  }) async {
    // _busy = true;
    // setState(() {});

    // final args = widget.args;

    try {
      //create new room
      const cameraEncoding = VideoEncoding(
        maxBitrate: 5 * 1000 * 1000,
        maxFramerate: 30,
      );

      const screenEncoding = VideoEncoding(
        maxBitrate: 3 * 1000 * 1000,
        maxFramerate: 15,
      );

      final room = Room(
        roomOptions: RoomOptions(
          // adaptiveStream: args.adaptiveStream,
          adaptiveStream: true,
          dynacast: true,
          defaultAudioPublishOptions: const AudioPublishOptions(
            name: 'custom_audio_track_name',
          ),
          defaultCameraCaptureOptions: const CameraCaptureOptions(
            maxFrameRate: 30,
            params: VideoParameters(dimensions: VideoDimensions(1280, 720)),
          ),
          defaultVideoPublishOptions: VideoPublishOptions(
            simulcast: false,
            // simulcast: args.simulcast,
            videoCodec: "VP8",

            videoEncoding: cameraEncoding,
            screenShareEncoding: screenEncoding,
          ),
          // encryption: e2eeOptions,
        ),
      );
      // Create a Listener before connecting
      final listener = room.createListener();

      await room.prepareConnection(url, token);

      // Try to connect to the room
      // This will throw an Exception if it fails for any reason.
      await room.connect(
        url,
        token,
        fastConnectOptions: FastConnectOptions(
          microphone: TrackOption(enabled: true),
          camera: TrackOption(enabled: isVideoCall),
        ),
      );

      print("printed after connected ${context.mounted}");

      // Use navigatorKey instead of the passed context
      if (navigatorKey.currentContext == null) return;

      // Navigate using GoRouter or Navigator with navigatorKey
      Navigator.of(navigatorKey.currentContext!, rootNavigator: true).push(
        MaterialPageRoute(
          builder:
              (_) => RoomPage(
                room,
                listener,
                showVideoControl: isVideoCall,
                isGroup: isGroupCall,
                chatId: chatId,
              ),
        ),
      );
    } catch (error) {
      print('Could not connect $error');
      if (!context.mounted) return;
      await context.showErrorDialog(error);
    } finally {}
  }

  Future<String?> getToken() async {
    try {
      return await _fcm.getToken();
    } catch (e) {
      print('Error getting FCM token: $e');
      return null;
    }
  }

  Future<void> initialize() async {
    await _fcm.requestPermission(alert: true, badge: true, sound: true);

    FirebaseMessaging.onMessage.listen(_handleForegroundMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(_handleBackgroundMessage);
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    print("initialMessage");
    if (initialMessage != null) {
      _handleInitialBackgroundMessage(initialMessage);
    }

    // Listen CallKit actions also here if needed (handled in main with a single listener)

    print('FCM initialized. Token: ${await getToken()}');
  }

  Future<void> initFCMWeb() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    String? token = await messaging.getToken(
      vapidKey:
          "BLNDhw5cLZSe1sd25T-4WvG5MwCXxPuqG2z6GiVaMRp9ZFbYrYqmEEThcdgn0ae6waFPcnkRi2h-wNDV8FmeKSc",
    );

    print("token $token");
  }

  Future<void> _loadUnreadCount() async {
    final context = navigatorKey.currentContext;
    if (context == null) return;
    final container = ProviderScope.containerOf(context);
    final notificationService = container.read(notificationServiceProvider);
    final unreadCount = await notificationService.fetchUnreadCount();

    // if (mounted) {
    container
        .read(notificationCountProvider.notifier)
        .setCount(unreadCount ?? 0);
    // }
  }

  // ========= INCOMING PROCESSING =========

  void _handleForegroundMessage(RemoteMessage message) async {
    log("Full message: ${message.data}");
    print("Message Info: ${message.notification?.body}");

    _loadUnreadCount();

    const refreshArr = [
      "1",
      "8",
      "9",
      "29",
      "11",
      "12",
      "15",
      "24",
      "26",
      "27",
      "28",
      "29",
      "18",
      '11',
    ];
    // final context = navigatorKey.currentContext;
    //         if (context == null) return;
    //         final container = ProviderScope.containerOf(context);
    //         //container.read(chatProvider.notifier).getChatThreads(silent: true);
    //         container.read(chartDataProvider.notifier).load();
    //         _showNewMessageNotificationBanner(message);
    //         return;

    try {
      final messageCode = message.data['code']?.toString();
      if (messageCode != null && refreshArr.contains(messageCode)) {
        final context = navigatorKey.currentContext;
        if (context == null) return;

        final container = ProviderScope.containerOf(context);
        // Refresh chat data
        container.read(chartDataProvider.notifier).load();
        // Show notification banner
        // _showNewMessageNotificationBanner(message);
        // return;
      }

      if (message.data['code'] == '14' || message.data['code'] == 14) {
        final idJson = message.data['id'];
        final idMap = jsonDecode(idJson);
        final chatId = idMap['chat'];
        _updateChatData(chatId);
        return;
      }

      if (message.data['code'] == '29' || message.data['code'] == 29) {
        final context = navigatorKey.currentContext;
        if (context == null) return;
        final container = ProviderScope.containerOf(context);
        container.read(sessionProvider.notifier).loadSessions();
        return;
      }

      if (message.data['code'] == '15' || message.data['code'] == 15) {
        final context = navigatorKey.currentContext;
        if (context == null) return;
        final container = ProviderScope.containerOf(context);
        container.read(sessionProvider.notifier).loadSessions();
        return;
      }

      if (message.data['code'] == '11' || message.data['code'] == 11) {
        final context = navigatorKey.currentContext;
        if (context == null) return;
        final container = ProviderScope.containerOf(context);
        await container.read(authProvider.notifier).getCurrentUser();
        GoRouter.of(context).push('/auth-gate');
        showOverlayNotification(
          (context) {
            return NewMessageNotificationBanner(
              title: "Status Change",
              body: "Your status is ${message.data['id']}.",
              isMessage: false,
              onTap: () {},
            );
          },
          duration: const Duration(seconds: 5),
          position: NotificationPosition.top,
        );
        return;
      }

      // Call Ended
      if (message.notification?.title == 'Call Ended' ||
          message.notification?.body?.toLowerCase().contains('call ended') ==
              true ||
          message.data['code'] == '6' ||
          message.data['code'] == 6) {
        final chatId = _extractChatIdFromMessage(message);
        if (chatId != null) {
          _dismissCallPopupIfMatches(chatId);
          // Also end CallKit calls
          try {
            await FlutterCallkitIncoming.endAllCalls();
          } catch (_) {}
          //_showCallEndedSnackbar('Call ended by the other party');
        }
        return;
      }

      if (message.data['code'] == '4' || message.data['code'] == 4) {
        _handleMessageReadEvent(message);
        return;
      }

      // Incoming call (foreground): show your custom popup
      if (_isIncomingCallMessage(message)) {
        final call = _parseIncomingCall(message);

        if (call != null) {
          _showCallInvitationDialog(
            call.room,
            call.callerName,
            call.chatId,
            call.isVideoCall,
            call.token,
            call.isGroupCall,
          );
        }
        return;
      }

      if (message.data['code'] == '2' || message.data['code'] == 2) {
        _showNewMessageNotificationBanner(message);
        return;
      }

      if (message.notification?.title == 'Session scheduled') {
        final context = navigatorKey.currentContext;
        if (context == null) return;
        final container = ProviderScope.containerOf(context);
        container.read(chatProvider.notifier).getChatThreads(silent: true);
        return;
      }

      if (message.notification?.title == 'New match request') {
        // await startMatchRequestRingtone();
        final payload = extractMatchPayload(message);
        if (payload != null) {
          final request = MatchRequest.fromMap(payload);
          _openNewMatchRequestPage(request);
        }

        return;
      }
    } catch (e, st) {
      log('Foreground handler error: $e\n$st');
    }
  }

  void _handleInitialBackgroundMessage(RemoteMessage message) async {
    print("Initial message: ${message.data}");

    if (message.data['code'] == '4' || message.data['code'] == 4) {
      _handleMessageReadEvent(message);
      return;
    }

    if (_isIncomingCallMessage(message)) {
      print("new kind: ${message}");
      // App opened from terminated by tapping notification is typical.
      // We should present CallKit immediately to mirror Telegram-like behavior.
      final call = _parseIncomingCall(message);
      //final container = ProviderScope.containerOf(context);
      // container.read(pendingRouteProvider.notifier).state = PendingRoute(
      //   path: '/chat/$chatId',
      //   extra: chat,
      // );
      if (call != null) {
        await _showCallKitIncoming(call);
      }
      return;
    }

    if (message.data['code'] == '29' || message.data['code'] == 29) {
      final context = navigatorKey.currentContext;
      if (context == null) return;
      final container = ProviderScope.containerOf(context);
      container.read(sessionProvider.notifier).loadSessions();
      return;
    }

    if (message.data['code'] == '15' || message.data['code'] == 15) {
      final context = navigatorKey.currentContext;
      if (context == null) return;
      final container = ProviderScope.containerOf(context);
      container.read(sessionProvider.notifier).loadSessions();
      return;
    }

    if (message.notification?.title == 'Session scheduled') {
      final context = navigatorKey.currentContext;
      if (context == null) return;
      final container = ProviderScope.containerOf(context);
      container.read(chatProvider.notifier).getChatThreads(silent: true);
      return;
    }

    if (message.data['code'] == '2' || message.data['code'] == 2) {
      final context = navigatorKey.currentContext;
      if (context == null) return;

      final data = message.data;
      final chatData = jsonDecode(data["id"]);
      final chatId = chatData['chat']['id'];
      _updateChatData(chatId);

      final senderName =
          chatData['chat']['client']['firstName'] +
          ' ' +
          chatData['chat']['client']['lastName'];

      final clientMap = chatData['chat']['client'];
      final client = UserModel.fromJson(clientMap);
      final senderProfile = chatData['chat']['client']['profile'] ?? '';
      final senderAvatar = chatData['chat']['client']['avatar'] ?? '';

      final chat = Chat(
        id: chatId,
        name: senderName,
        lastMessage: 'I sent you the design files 📎',
        avatarUrl:
            (senderAvatar == 7) &&
                    senderProfile != null &&
                    senderProfile.isNotEmpty
                ? '$base_url_for_image$senderProfile?v=${DateTime.now().millisecondsSinceEpoch}'
                : null,
        unreadCount: 0,
        timestamp: DateTime(2025, 4, 2, 14, 15),
        isOutgoing: true,
        isRead: true,
        user: client,
        avatar: senderAvatar,
      );

      final container = ProviderScope.containerOf(context);
      container.read(pendingRouteProvider.notifier).state = PendingRoute(
        path: '/chat/$chatId',
        extra: chat,
      );
      return;
    }

    if (message.notification?.title == 'New match request') {
      final payload = extractMatchPayload(message);
      if (payload != null) {
        final request = MatchRequest.fromMap(payload);
        final context = navigatorKey.currentContext;
        if (context == null) return;

        final container = ProviderScope.containerOf(context);
        container.read(pendingRouteProvider.notifier).state = PendingRoute(
          path: '/match-request',
          extra: request,
        );
        // Ensure ringtone starts when app is brought to foreground later
        //await startMatchRequestRingtone();
      }
    }
  }

  void _handleBackgroundMessage(RemoteMessage message) async {
    print("onMessageOpenedApp: ${message.data}");

    _loadUnreadCount();

    if (message.data['code'] == '4' || message.data['code'] == 4) {
      _handleMessageReadEvent(message);
      return;
    }

    if (message.data['code'] == '29' || message.data['code'] == 29) {
      final context = navigatorKey.currentContext;
      if (context == null) return;
      final container = ProviderScope.containerOf(context);
      container.read(sessionProvider.notifier).loadSessions();
      return;
    }

    if (message.data['code'] == '15' || message.data['code'] == 15) {
      final context = navigatorKey.currentContext;
      if (context == null) return;
      final container = ProviderScope.containerOf(context);
      container.read(sessionProvider.notifier).loadSessions();
      return;
    }

    if (message.data['code'] == '11' || message.data['code'] == 11) {
      final context = navigatorKey.currentContext;
      if (context == null) return;
      final container = ProviderScope.containerOf(context);
      await container.read(authProvider.notifier).getCurrentUser();
      GoRouter.of(context).push('/auth-gate');
      showOverlayNotification(
        (context) {
          return NewMessageNotificationBanner(
            title: "Status Change",
            body: "Your status is ${message.data['id']}.",
            isMessage: false,
            onTap: () {},
          );
        },
        duration: const Duration(seconds: 5),
        position: NotificationPosition.top,
      );
      return;
    }

    if (_isIncomingCallMessage(message)) {
      final call = _parseIncomingCall(message);
      if (call != null) {
        await _showCallKitIncoming(call);
      }
      return;
    }

    if (message.data['code'] == '2' || message.data['code'] == 2) {
      final context = navigatorKey.currentContext;
      if (context == null) return;

      final data = message.data;
      final chatData = jsonDecode(data["id"]);
      final chatId = chatData['chat']['id'];
      _updateChatData(chatId);

      final senderName =
          chatData['chat']['client']['firstName'] +
          ' ' +
          chatData['chat']['client']['lastName'];

      final clientMap = chatData['chat']['client'];
      final client = UserModel.fromJson(clientMap);
      final senderProfile = chatData['chat']['client']['profile'] ?? '';
      final senderAvatar = chatData['chat']['client']['avatar'] ?? '';

      final newRoute = '/chat/$chatId';
      final currentLocation =
          GoRouter.of(
            context,
          ).routerDelegate.currentConfiguration.last.matchedLocation;

      if (currentLocation != newRoute) {
        final chat = Chat(
          id: chatId,
          name: senderName,
          lastMessage: 'I sent you the design files 📎',
          avatarUrl:
              (senderAvatar == 7) &&
                      senderProfile != null &&
                      senderProfile.isNotEmpty
                  ? '$base_url_for_image$senderProfile?v=${DateTime.now().millisecondsSinceEpoch}'
                  : null,
          unreadCount: 0,
          timestamp: DateTime(2025, 4, 2, 14, 15),
          isOutgoing: true,
          isRead: true,
          user: client,
          avatar: senderAvatar,
        );
        GoRouter.of(context).push('/chat/$chatId', extra: chat);
      }
      return;
    }

    if (message.notification?.title == 'New match request') {
      final payload = extractMatchPayload(message);
      if (payload != null) {
        final request = MatchRequest.fromMap(payload);
        final context = navigatorKey.currentContext;
        if (context == null) return;
        // Start ringtone and navigate
        //await startMatchRequestRingtone();
        GoRouter.of(context).push('/match-request', extra: request);
      }
    }
  }

  // ========= Helpers =========

  void _dismissCallPopupIfMatches(String chatId) async {
    if (_activeCallChatId == null) return;
    if (_activeCallChatId != chatId) return;

    try {
      await _ringtonePlayer?.stop();
    } catch (e) {
      print('Error stopping ringtone: $e');
    }

    final context = navigatorKey.currentContext;
    if (context != null) {
      if (Navigator.of(context, rootNavigator: true).canPop()) {
        Navigator.of(context, rootNavigator: true).pop();
      }
    }

    _activeCallChatId = null;
    _ringtonePlayer = null;
  }

  String? _extractChatIdFromMessage(RemoteMessage message) {
    try {
      if (message.data['id'] != null) {
        final raw = message.data['id'];
        final decoded = raw is String ? jsonDecode(raw) : raw;
        if (decoded is Map<String, dynamic>) {
          if (decoded['chatId'] is String) return decoded['chatId'] as String;
          if (decoded['chat'] is Map && decoded['chat']['id'] is String) {
            return decoded['chat']['id'] as String;
          }
        }
      }
      if (message.data['chatId'] is String) {
        return message.data['chatId'] as String;
      }
    } catch (e) {
      print('Error extracting chatId: $e');
    }
    return null;
  }

  void _showNewMessageNotificationBanner(RemoteMessage message) {
    final context = navigatorKey.currentContext;
    if (context == null) return;

    final currentLocation =
        GoRouter.of(
          context,
        ).routerDelegate.currentConfiguration.last.matchedLocation;

    final notification = message.notification;
    final data = message.data;

    String body = data['message_preview'] ?? notification?.body ?? '';
    final chatData = jsonDecode(data["id"]);
    final chatId = chatData['chat']['id'];
    String senderName = 'Group Chat';

    try {
      final clientMap = chatData['chat']['client'];
      final client = UserModel.fromJson(clientMap);
      final senderProfile = chatData['chat']['client']['profile'] ?? '';
      final senderAvatar = chatData['chat']['client']['avatar'] ?? '';

      if (currentLocation == '/chat/$chatId') {
        _updateChatData(chatId);
        return;
      }

      try {
        senderName =
            chatData['chat']['client']['firstName'] +
            ' ' +
            chatData['chat']['client']['lastName'];
      } catch (_) {}

      showOverlayNotification(
        (context) {
          return NewMessageNotificationBanner(
            title: senderName,
            body: body,
            onTap: () {
              OverlaySupportEntry.of(context)?.dismiss(animate: false);
              final chat = Chat(
                id: chatId,
                name: senderName,
                lastMessage: 'I sent you the design files 📎',
                avatarUrl:
                    (senderAvatar == 7) &&
                            senderProfile != null &&
                            senderProfile.isNotEmpty
                        ? '$base_url_for_image$senderProfile?v=${DateTime.now().millisecondsSinceEpoch}'
                        : null,
                unreadCount: 0,
                timestamp: DateTime(2025, 4, 2, 14, 15),
                isOutgoing: true,
                isRead: true,
                avatar: senderAvatar,
                user: client,
              );
              final currentLocationTap =
                  GoRouter.of(
                    context,
                  ).routerDelegate.currentConfiguration.last.matchedLocation;
              if (currentLocationTap != '/chat/$chatId') {
                GoRouter.of(context).push('/chat/$chatId', extra: chat);
              }
            },
          );
        },
        duration: const Duration(seconds: 5),
        position: NotificationPosition.top,
      );

      _updateChatData(chatId);
    } catch (e) {
      String title = notification?.title ?? 'New Message';
      String body = data['message_preview'] ?? notification?.body ?? '';
      final chatData = jsonDecode(data["id"]);
      final chatId = chatData['chat']['id'];
      print("chatId: ${chatId}");
      _updateChatData(chatId);
      print('Error showing notification banner: $e');
    }
  }

  Map<String, dynamic>? extractMatchPayload(RemoteMessage message) {
    try {
      if (message.data.containsKey('id')) {
        final raw = message.data['id'];
        if (raw is String) {
          final decoded = jsonDecode(raw);
          if (decoded is Map<String, dynamic>) return decoded;
        } else if (raw is Map<String, dynamic>) {
          return raw;
        }
      }
      if ((message.notification?.body ?? '').isNotEmpty) {
        final bodyDecoded = jsonDecode(message.notification!.body!);
        if (bodyDecoded is Map<String, dynamic>) {
          if (bodyDecoded['matchData'] != null &&
              bodyDecoded['clientData'] != null) {
            return bodyDecoded;
          }
          if (bodyDecoded['id'] is Map<String, dynamic>) {
            return bodyDecoded['id'] as Map<String, dynamic>;
          }
        }
      }
      if (message.data['matchData'] != null &&
          message.data['clientData'] != null) {
        return Map<String, dynamic>.from(message.data);
      }
    } catch (e) {
      print('Failed to extract match payload: $e');
    }
    return null;
  }

  void _openNewMatchRequestPage(MatchRequest request) {
    final context = navigatorKey.currentContext;
    if (context == null) return;
    GoRouter.of(context).push('/match-request', extra: request);
  }

  void _updateChatData(String chatId) {
    final context = navigatorKey.currentContext;
    if (context == null) return;

    final container = ProviderScope.containerOf(context);
    container.read(chatProvider.notifier).getChatThreads(silent: true);
    container.read(messageProvider(chatId).notifier).getMessages(silent: true);
  }

  void _handleMessageReadEvent(RemoteMessage message) {
    try {
      final data = message.data;
      if (data.containsKey('id')) {
        final eventData = json.decode(data['id']) as Map<String, dynamic>;
        final chatId = eventData['chatId'];
        _updateChatData(chatId);
      }
    } catch (e) {
      print('Error handling message read event: $e');
    }
  }

  void _showCallEndedSnackbar(String message) {
    final context = navigatorKey.currentContext;
    if (context == null) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.grey[800],
      ),
    );
  }

  // ========= Foreground in-app popup =========

  void _showCallInvitationDialog(
    String roomName,
    String participant,
    String chatId,
    bool isVideocall,
    String token,
    bool isGroupCall,
  ) async {
    final context = navigatorKey.currentContext;
    if (context == null) {
      print("Navigator context is null");
      return;
    }

    if (_activeCallChatId != null) {
      _dismissCallPopupIfMatches(_activeCallChatId!);
    }

    _ringtonePlayer = AudioPlayer();
    _activeCallChatId = chatId;
    try {
      await _ringtonePlayer!.play(
        AssetSource('sounds/ringtone.mp3'),
        volume: 1.0,
      );
    } catch (e) {
      print('Error playing ringtone: $e');
    }

    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      barrierLabel: "Incoming Call",
      barrierColor: Colors.black.withOpacity(0.05),
      transitionDuration: const Duration(milliseconds: 300),
      useRootNavigator: true,
      pageBuilder: (dialogContext, animation, secondaryAnimation) {
        return SafeArea(
          child: Align(
            alignment: Alignment.topCenter,
            child: Material(
              color: Colors.transparent,
              child: Container(
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                width: MediaQuery.of(context).size.width * 0.95,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Incoming Call',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      participant,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            shape: const StadiumBorder(),
                            padding: const EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 20,
                            ),
                          ),
                          icon: const Icon(Icons.call_end),
                          label: const Text('Reject'),
                          onPressed: () async {
                            await _ringtonePlayer?.stop();
                            Navigator.of(
                              dialogContext,
                              rootNavigator: true,
                            ).pop();
                            _activeCallChatId = null;
                            _ringtonePlayer = null;
                            try {
                              await rejectCall(chatId);
                            } catch (e) {
                              print('Error sending rejection: $e');
                            }
                          },
                        ),
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            shape: const StadiumBorder(),
                            padding: const EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 20,
                            ),
                          ),
                          icon: const Icon(Icons.call),
                          label: const Text('Accept'),
                          onPressed: () async {
                            await _ringtonePlayer?.stop();
                            Navigator.of(
                              dialogContext,
                              rootNavigator: true,
                            ).pop();
                            _activeCallChatId = null;
                            _ringtonePlayer = null;
                            print("xoxoch; ${chatId}");
                            print("xoxo: ${isGroupCall}");
                            _joinCallRoom(
                              roomName,
                              participant,
                              dialogContext,
                              chatId,
                              isVideocall,
                              token,
                              isGroupCall,
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  // ========= CallKit (background/terminated) =========

  Future<void> _showCallKitIncoming(_IncomingCall call) async {
    final uuid = const Uuid().v4();

    final params = CallKitParams(
      id: uuid,
      nameCaller: call.callerName,
      appName: 'Navicare',
      avatar: '', // Empty string for generic user icon
      handle: call.callerName,
      type: call.isVideoCall ? 1 : 0, // 0 = audio, 1 = video
      duration: 30000,
      textAccept: 'Accept',
      textDecline: 'Reject',
      // textMissedCall: 'Missed Call', // Add this to control missed call text
      // textCallback: 'Callback', // Add this
      extra: {
        'chatId': call.chatId,
        'room': call.room,
        'callerName': call.callerName,
        'isVideoCall': call.isVideoCall,
      },
      headers: <String, dynamic>{},
      android: AndroidParams(
        //isCustomNotification: true,
        isShowLogo: false, // Set to false to hide logo/text
        ringtonePath: 'ringtone',
        backgroundColor: '#0bb89b', // Your app's green color
        backgroundUrl: '', // No background image
        actionColor: '#4CAF50',
        // incomingCallNotificationChannelName: 'Incoming Calls',
        // missedCallNotificationChannelName: 'Missed Calls',
        // Hide the app name in notification
        //notificationIcon: 'ic_notification', // Use your app's notification icon
      ),
      ios: IOSParams(
        iconName: 'AppIcon', // Use your app's icon
        handleType: '',
        supportsVideo: true,
        maximumCallGroups: 2,
        // includesCallsInRecents: false,
      ),
    );

    await FlutterCallkitIncoming.showCallkitIncoming(params);
  }

  bool _isIncomingCallMessage(RemoteMessage message) {
    if (message.data['code'] == '5' || message.data['code'] == 5) return true;
    final code = message.data['code'];
    return code == 'CALL_INCOMING' || code == 1 || code == '1';
  }

  _IncomingCall? _parseIncomingCall(RemoteMessage message) {
    try {
      final idJsonString = message.data['id'];
      Map<String, dynamic>? idMap;
      if (idJsonString is String) {
        idMap = json.decode(idJsonString) as Map<String, dynamic>;
      } else if (idJsonString is Map<String, dynamic>) {
        idMap = idJsonString;
      } else {
        idMap = {};
      }

      final chatId = idMap['chatId'] ?? idMap['chat']?['id'];
      final room = idMap['room'] as String?;
      final token = idMap['token'] as String?;
      final isVideoCall = idMap['isVideoCall'] as bool? ?? false;
      final isGroupCall = idMap['isGroupCall'] as bool? ?? false;
      print("isVideoCall4: ${isVideoCall}");
      final callerData = idMap['callerData'] as Map<String, dynamic>?;
      final firstName = callerData?['firstName'] as String? ?? '';
      final lastName = callerData?['lastName'] as String? ?? '';
      final fullName =
          (firstName + ' ' + lastName).trim().isEmpty
              ? 'Caller'
              : '$firstName $lastName';

      if (chatId == null || room == null) return null;

      return _IncomingCall(
        chatId: chatId.toString(),
        room: room,
        callerName: fullName,
        isVideoCall: isVideoCall,
        token: token!,
        isGroupCall: isGroupCall,
      );
    } catch (e) {
      log('parse incoming call error: $e');
      return null;
    }
  }

  Future<void> rejectCall(String chatId) async {
    final Dio dio = Dio();
    try {
      final sharedPreferences = await SharedPreferences.getInstance();
      final accessToken = sharedPreferences.getString('access_token');

      dio.options.headers['Authorization'] = 'Bearer $accessToken';

      final response = await dio.post('$base_url_dev/chat/call/reject/$chatId');

      if (response.statusCode == 201) {
        print('Call rejected successfully');
      } else {
        print('Failed to reject call: ${response.data}');
      }
    } catch (e) {
      print('Error rejecting call: $e');
    }
  }

  void joinCallFromCallKit({
    required String roomName,
    required String participantName,
    required String chatId,
    required bool isVideocall,
    required String token,
    required bool isGroupCall,
  }) {
    print("context not null praying");
    final context = navigatorKey.currentContext;
    if (context == null) return;
    print("context not null praying: $context");

    if (context == null) {
      _ref.read(pendingRouteProvider.notifier).state = PendingRoute(
        path: '/call-screen',
        callData: {
          'roomName': roomName,
          'participantName': participantName,
          'chatId': chatId,
          'isVideoCall': isVideocall,
          'token': token,
          'isGroupCall': isGroupCall,
        },
      );
      return;
    }

    _join(
      "wss://demo-eukecq5l.livekit.cloud",
      token,
      context,
      isVideoCall: isVideocall,
      isGroupCall: isGroupCall,
      chatId: chatId,
    );

    // Navigator.of(context).push(
    //   MaterialPageRoute(
    //     builder:
    //         (context) => PreJoinPage(
    //           args: JoinArgs(
    //             url: "wss://demo-eukecq5l.livekit.cloud", // Your known URL
    //             token: token, // Your known token
    //             adaptiveStream: true,
    //             dynacast: true,
    //             simulcast: false,
    //             e2ee: false,
    //             preferredCodec: 'VP8',
    //             enableBackupVideoCodec: true,
    //           ),
    //         ),
    //     //  CallScreen(
    //     //   roomName: roomName,
    //     //   participantName: participantName,
    //     //   isVideoCall: isVideocall,
    //     //   chatId: chatId,
    //     // ),
    //   ),
    // );
  }

  void _joinCallRoom(
    String roomName,
    String participantName,
    BuildContext context,
    String chatId,
    bool isVideoCall,
    String token,
    bool isGroupCall,
  ) {
    print("isVideoCall1: ${isVideoCall}");
    final token2 =
        "eyJhbGciOiJIUzI1NiJ9.eyJ2aWRlbyI6eyJyb29tSm9pbiI6dHJ1ZSwicm9vbSI6InF1aWNrc3RhcnQtcm9vbSJ9LCJpc3MiOiJBUEkzclBhWnVHcWIyODgiLCJleHAiOjE3NjQyMzU0MzYsIm5iZiI6MCwic3ViIjoibWVtZS11c2VybmFtZSJ9.MonNLbSa1SibeZh6M51kWCX5jmuesbg06psBD7ykSbE";
    _join(
      "wss://demo-eukecq5l.livekit.cloud",
      token,
      context,
      isVideoCall: isVideoCall,
      isGroupCall: isGroupCall,
      chatId: chatId,
    );

    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder:
    //         (context) =>
    //         //  CallScreen(
    //         //   roomName: roomName,
    //         //   participantName: participantName,
    //         //   isVideoCall: isVideoCall,
    //         //   chatId: chatId,
    //         // ),
    //         PreJoinPage(
    //           args: JoinArgs(
    //             url: "wss://demo-eukecq5l.livekit.cloud",
    //             token: token, // Your known URL
    //             // token:
    //             //     "eyJhbGciOiJIUzI1NiJ9.eyJ2aWRlbyI6eyJyb29tSm9pbiI6dHJ1ZSwicm9vbSI6InF1aWNrc3RhcnQtcm9vbSIsImNhblB1Ymxpc2giOnRydWUsImNhblN1YnNjcmliZSI6dHJ1ZX0sImlzcyI6IkFQSTNyUGFadUdxYjI4OCIsImV4cCI6MTc2NDE5NDM3OSwibmJmIjowLCJzdWIiOiJ4by1tZW1lLXVzZXJuYW1lIn0._1FxCuD1OlcMJ_mQusKOhfEzD_RZObzHIHYb2y2Z_70", // Your known token
    //             adaptiveStream: true,
    //             dynacast: true,
    //             simulcast: false,
    //             e2ee: false,
    //             preferredCodec: 'VP8',
    //             enableBackupVideoCodec: true,
    //           ),
    //         ),
    //   ),
    // );
  }
}

// A minimal struct to carry call data
class _IncomingCall {
  final String chatId;
  final String room;
  final String callerName;
  final bool isVideoCall;
  final String token; // Add this
  final bool isGroupCall;

  _IncomingCall({
    required this.chatId,
    required this.room,
    required this.callerName,
    required this.isVideoCall,
    required this.token, // Add this
    required this.isGroupCall,
  });
}

// Background bridge usable from top-level background handler
class FCMBackgroundBridge {
  @pragma('vm:entry-point')
  static Future<void> handleBackgroundMessage(RemoteMessage message) async {
    try {
      // Show CallKit incoming for incoming call messages
      if (_isIncomingCallMessage(message)) {
        print("new kind bg: ${message}");
        final call = _parseIncomingCall(message);
        if (call != null) {
          await _showCallKitIncoming(call);
        }
        return;
      }

      // End call case
      if (message.notification?.title == 'Call Ended' ||
          message.notification?.body?.toLowerCase().contains('call ended') ==
              true ||
          message.data['code'] == '6' ||
          message.data['code'] == 6) {
        try {
          await FlutterCallkitIncoming.endAllCalls();
        } catch (_) {}
      }
    } catch (e, st) {
      log('FCMBackgroundBridge error: $e\n$st');
    }
  }

  static bool _isIncomingCallMessage(RemoteMessage message) {
    if (message.data['code'] == '5' || message.data['code'] == 5) return true;
    final code = message.data['code'];
    return code == 'CALL_INCOMING' || code == 1 || code == '1';
  }

  static _IncomingCall? _parseIncomingCall(RemoteMessage message) {
    try {
      final idJsonString = message.data['id'];
      Map<String, dynamic>? idMap;
      if (idJsonString is String) {
        idMap = json.decode(idJsonString) as Map<String, dynamic>;
      } else if (idJsonString is Map<String, dynamic>) {
        idMap = idJsonString;
      } else {
        idMap = {};
      }

      final chatId = idMap['chatId'] ?? idMap['chat']?['id'];
      final room = idMap['room'] as String?;
      final token = idMap['token'] as String?;
      final callerData = idMap['callerData'] as Map<String, dynamic>?;
      final isVideoCall = idMap['isVideoCall'] as bool? ?? false;
      final isGroupCall = idMap['isGroupCall'] as bool? ?? false;
      print("isVideoCall5: ${isVideoCall}");
      final firstName = callerData?['firstName'] as String? ?? '';
      final lastName = callerData?['lastName'] as String? ?? '';
      final fullName =
          (firstName + ' ' + lastName).trim().isEmpty
              ? 'Caller'
              : '$firstName $lastName';

      if (chatId == null || room == null || token == null) return null;

      return _IncomingCall(
        chatId: chatId.toString(),
        room: room,
        callerName: fullName,
        isVideoCall: isVideoCall,
        token: token,
        isGroupCall: isGroupCall,
      );
    } catch (e) {
      log('parse incoming call error (bg): $e');
      return null;
    }
  }

  static Future<void> _showCallKitIncoming(_IncomingCall call) async {
    final uuid = const Uuid().v4();
    final params = CallKitParams(
      id: uuid,
      nameCaller: call.callerName,
      appName: 'Navicare',
      handle: call.callerName,
      type: 0, // set 1 if you want to mark as video capable
      duration: 30000,
      textAccept: 'Accept',
      textDecline: 'Reject',
      extra: {
        'chatId': call.chatId,
        'room': call.room,
        'callerName': call.callerName,
        'isVideoCall': call.isVideoCall,
        'token': call.token,
      },
      android: const AndroidParams(
        // isCustomNotification: true,
        isShowLogo: false,
        actionColor: '#4CAF50',
        // incomingCallNotificationChannelName: 'Incoming Calls',
        // missedCallNotificationChannelName: 'Missed Calls',
        ringtonePath: 'ringtone',
      ),
      ios: const IOSParams(handleType: 'generic', supportsVideo: true),
    );
    await FlutterCallkitIncoming.showCallkitIncoming(params);
  }
}
