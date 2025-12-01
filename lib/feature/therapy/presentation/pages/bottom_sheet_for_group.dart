import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:livekit_client/livekit_client.dart';
import 'package:navicare/core/constants/base_url.dart';
import 'package:navicare/core/theme/app_colors.dart';
import 'package:navicare/core/util/avatar_util.dart';
import 'package:navicare/feature/auth/data/models/auth_models.dart';
import 'package:navicare/feature/call/exts.dart';
import 'package:navicare/feature/call/pages/room.dart';
import 'package:navicare/feature/chat/presentation/pages/user_profile_screen.dart';
import 'package:navicare/feature/chat/presentation/widgets/gradient_avatar.dart';
import 'package:navicare/feature/therapy/presentation/pages/group_call_screen.dart';
import 'package:navicare/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GroupMemberSelectionBottomSheet extends StatefulWidget {
  final String groupName;
  final List<UserModel>? groupMembers;
  final String chatId;

  const GroupMemberSelectionBottomSheet({
    super.key,
    required this.groupName,
    required this.groupMembers,
    required this.chatId,
  });

  @override
  State<GroupMemberSelectionBottomSheet> createState() =>
      _GroupMemberSelectionBottomSheetState();
}

class _GroupMemberSelectionBottomSheetState
    extends State<GroupMemberSelectionBottomSheet> {
  final Set<String> _selectedUserIds = {};

  Future<void> _startCallWithSelectedUsers({required bool isVideoCall}) async {
    // Validate selection
    if (_selectedUserIds.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select at least one participant'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    print("Selected chatid: ${widget.chatId}");
    print('Selected user IDs: ${_selectedUserIds.toList()}');

    _join(
      String url,
      String token,
      BuildContext context, {
      required bool isVideoCall,
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
                (_) => RoomPage(room, listener, showVideoControl: isVideoCall),
          ),
        );
      } catch (error) {
        print('Could not connect $error');
        if (!context.mounted) return;
        await context.showErrorDialog(error);
      } finally {}
    }

    String _generateRandomRoomName() {
      const chars =
          'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
      final random = Random();
      return String.fromCharCodes(
        Iterable.generate(
          8,
          (_) => chars.codeUnitAt(random.nextInt(chars.length)),
        ),
      );
    }

    final sharedPreferences = await SharedPreferences.getInstance();
    final accessToken = sharedPreferences.getString('access_token');
    final roomName = _generateRandomRoomName();

    // Show loading indicator
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Starting ${isVideoCall ? "video" : "audio"} call with ${_selectedUserIds.length} user${_selectedUserIds.length > 1 ? 's' : ''}...',
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
        duration: const Duration(seconds: 2),
      ),
    );

    try {
      final dio = Dio();
      dio.options.headers['Authorization'] = 'Bearer $accessToken';

      final response = await dio.post(
        '${base_url_dev}/chat/call/${widget.chatId}',
        data: {
          'room': roomName,
          'isVideoCall': isVideoCall,
          "calleeIds": _selectedUserIds.toList(),
        },
      );

      print("Response from backend: ${response.data}");
      print("Status code: ${response.statusCode}");

      if (response.statusCode == 201) {
        if (!mounted) return;
        final responseData = response.data['data'];
        final String token = responseData['token'];

        print("✅ Backend call successful, navigating to GroupCallScreen...");
        print("Room name: $roomName");
        print("Chat ID: ${widget.chatId}");
        print("Is video call: $isVideoCall");

        // Close the bottom sheet first
        Navigator.of(context).pop();

        // Navigate to group call screen
        try {
          // await Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder:
          //         (context) => GroupCallScreen(
          //           roomName: roomName,
          //           participantName: "Group Call",
          //           isVideoCall: isVideoCall,
          //           chatId: widget.chatId,
          //         ),
          //   ),
          // );
          _join(
            "wss://demo-eukecq5l.livekit.cloud",
            token,
            context,
            isVideoCall: isVideoCall,
          );
          print("✅ Navigation completed successfully");
        } catch (navError) {
          print("❌ Navigation error: $navError");
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Navigation error: $navError'),
                backgroundColor: Colors.red,
                duration: const Duration(seconds: 5),
              ),
            );
          }
        }
      } else {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to start call: ${response.statusMessage}'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    } on DioException catch (e) {
      print("DioException: ${e.toString()}");
      print("Response data: ${e.response?.data}");
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: ${e.response?.data['message'] ?? e.message}'),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 3),
        ),
      );
    } catch (e) {
      print("Unexpected error: ${e.toString()}");
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An unexpected error occurred: $e'),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  void _toggleUserSelection(UserModel user) {
    setState(() {
      if (_selectedUserIds.contains(user.id)) {
        _selectedUserIds.remove(user.id);
      } else {
        _selectedUserIds.add(user.id);
      }
    });
  }

  void _navigateToUserProfile(UserModel user) {
    print("userId: ${user.id}");
    // Close bottom sheet first
    Navigator.of(context).pop();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => ContactDetailPage(
              clientId: user.id,
              clientName: '${user.firstName} ${user.lastName}',
              avatarUrl: user.profile,
              avatar: user.avatar,
            ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Convert UserModel objects to Member objects for display
    final members =
        widget.groupMembers
            ?.map(
              (user) => Member(
                name: '${user.firstName} ${user.lastName}',
                status: user.isOnline == true ? 'online' : 'offline',
                gradient: getRandomGradient(),
                isOwner: false, // Set this based on your logic
                user: user,
              ),
            )
            .toList() ??
        [];

    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Select Participants',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Group info
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                GradientAvatar(
                  label: initials(widget.groupName),
                  gradient: const [Color(0xFFF595A7), Color(0xFFF4B6A2)],
                  size: 40,
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.groupName,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      '${members.length} members',
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Selection info
          if (_selectedUserIds.isNotEmpty)
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.blue.shade200),
              ),
              child: Row(
                children: [
                  Icon(Icons.group, color: Colors.blue.shade700, size: 20),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      '${_selectedUserIds.length} user${_selectedUserIds.length > 1 ? 's' : ''} selected',
                      style: TextStyle(
                        color: Colors.blue.shade800,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade600,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      _selectedUserIds.length.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          const SizedBox(height: 16),

          // Members list
          Expanded(
            child: ListView.separated(
              itemCount: members.length,
              separatorBuilder: (_, __) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                final m = members[index];
                final isSelected = _selectedUserIds.contains(m.user.id);

                return Container(
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.blue.shade50 : Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color:
                          isSelected ? Colors.blue.shade200 : Colors.grey[300]!,
                    ),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    leading: Stack(
                      children: [
                        GradientAvatar(
                          label: initials(m.name),
                          gradient: m.gradient,
                          size: 45,
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            width: 18,
                            height: 18,
                            decoration: BoxDecoration(
                              color:
                                  isSelected
                                      ? Colors.green
                                      : Colors.grey.shade300,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                            child:
                                isSelected
                                    ? const Icon(
                                      Icons.check,
                                      color: Colors.white,
                                      size: 10,
                                    )
                                    : null,
                          ),
                        ),
                      ],
                    ),
                    title: Text(
                      m.name,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: Text(
                      m.status,
                      style: TextStyle(
                        fontSize: 12,
                        color:
                            m.status == 'online'
                                ? Colors.green
                                : Colors.grey[600],
                      ),
                    ),
                    trailing:
                        m.isOwner
                            ? Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.primary.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                'Owner',
                                style: TextStyle(
                                  color: AppColors.primary,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            )
                            : null,
                    onTap: () {
                      _toggleUserSelection(m.user);
                    },
                    onLongPress: () {
                      _navigateToUserProfile(m.user);
                    },
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),

          // Call buttons
          if (_selectedUserIds.isNotEmpty)
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed:
                        () => _startCallWithSelectedUsers(isVideoCall: false),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    icon: const Icon(Icons.call, size: 20),
                    label: const Text(
                      'Audio Call',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed:
                        () => _startCallWithSelectedUsers(isVideoCall: true),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade600,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    icon: const Icon(Icons.video_call, size: 20),
                    label: const Text(
                      'Video Call',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}

// Helper models
class Member {
  final String name;
  final String status;
  final bool isOwner;
  final List<Color> gradient;
  final UserModel user;

  const Member({
    required this.name,
    required this.status,
    this.isOwner = false,
    this.gradient = const [Color(0xFF6AA8FF), Color(0xFF7BC1FF)],
    required this.user,
  });
}
