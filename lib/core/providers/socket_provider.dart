import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:navicare/core/providers/user_status_provider.dart';
import 'package:navicare/feature/chat/presentation/providers/chat_provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:shared_preferences/shared_preferences.dart';

final socketServiceProvider = Provider<SocketService>((ref) {
  return SocketService(ref);
});

class SocketService {
  final Ref ref;
  io.Socket? socket;
  bool _isConnected = false;

  SocketService(this.ref);

  Future<void> connect() async {
    FlutterSecureStorage _secureStorage = const FlutterSecureStorage(
      aOptions: AndroidOptions(encryptedSharedPreferences: true),
      iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock),
    );
    // Get token from shared preferences
    final accessToken = await _secureStorage.read(key: 'access_token');

    print('Attempting to connect to socket with token: $accessToken');

    if (accessToken == null) {
      print('No access token found');
      return;
    }

    // Disconnect if already connected
    disconnect();

    // Determine base path (similar to your web implementation)
    // For Flutter, you might need a different approach to get the environment
    // For now, let's assume 'dev' as in your web example
    const basePath = 'dev';

    // Create socket connection
    socket = io.io(
      'https://app.navithera.com',
      io.OptionBuilder()
          .setTransports(['websocket'])
          .setPath('/$basePath/socket.io')
          .enableAutoConnect()
          .setAuth({'token': accessToken})
          .build(),
    );

    socket!.onConnect((_) {
      print('✅ Connected with id: ${socket!.id}');
      _isConnected = true;
    });

    socket!.onDisconnect((_) {
      print('❌ Disconnected');
      _isConnected = false;
    });

    socket!.onConnectError((err) {
      print('⚠️ Connection error: $err');
      _isConnected = false;
    });

    socket!.onError((err) {
      print('⚠️ Socket error: $err');
      _isConnected = false;
    });

    socket!.on('userStatus', (data) {
      print('📢 User status update: $data');

      // Parse the data properly
      try {
        final statusData = Map<String, dynamic>.from(data);
        final userId = statusData['userId'] as String;
        final isOnline = statusData['isOnline'] as bool;

        // Update the user status provider
        final userStatusNotifier = ref.read(userStatusProvider.notifier);
        userStatusNotifier.updateStatus(userId, isOnline);

        print('Updated status for user $userId: $isOnline');
      } catch (e) {
        print('Error parsing user status: $e');
      }
    });

    socket!.onAny((event, data) {
      print('📩 Event received: $event → $data');
    });

    socket!.on('userProfileUpdated', (data) {
      print('📢 User profile updated event received: $data');

      try {
        // Example: parse the event if it’s a Map
        final profileData = Map<String, dynamic>.from(data);
        final updatedUserId = profileData['userId'];
        final updatedFields = profileData['updatedFields'];

        ref.read(chatProvider.notifier).getChatThreads(silent: true);

        //     final container = ProviderScope.containerOf(context);
        // container.read(chatProvider.notifier).getChatThreads(silent: true);

        print(
          '✅ Profile updated for user $updatedUserId with changes: $updatedFields',
        );

        // Here you can update your provider or do any other action
        // final userProfileNotifier = ref.read(userProfileProvider.notifier);
        // userProfileNotifier.updateProfile(updatedUserId, updatedFields);
      } catch (e) {
        print('⚠️ Error parsing userProfileUpdated event: $e');
      }
    });

    socket!.connect();
  }

  void disconnect() {
    socket?.disconnect();
    socket = null;
    _isConnected = false;
  }

  bool get isConnected => _isConnected;

  // Method to listen for specific user status updates
  void listenForUserStatus(String userId, Function(dynamic) callback) {
    socket?.on('userStatus', (data) {
      final statusData = data as Map<String, dynamic>;
      if (statusData['userId'] == userId) {
        callback(statusData);
      }
    });
  }

  // Method to stop listening for user status
  void stopListeningForUserStatus() {
    socket?.off('userStatus');
  }
}
