import 'dart:async';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:navicare/core/constants/base_url.dart';
import 'package:navicare/core/notification/notification_service.dart';
import 'package:navicare/core/providers/socket_provider.dart';
import 'package:navicare/core/providers/user_status_provider.dart';
import 'package:navicare/core/theme/app_colors.dart';
import 'package:navicare/core/util/avatar_util.dart';
import 'package:navicare/feature/auth/data/models/auth_models.dart';
import 'package:navicare/feature/chat/data/models/chat_models.dart';
import 'package:navicare/feature/chat/domain/repositories/chat_repository.dart';
import 'package:navicare/feature/chat/presentation/pages/chat_list_screen.dart';
import 'package:navicare/feature/chat/presentation/pages/group_profile_screen.dart';
import 'package:navicare/feature/chat/presentation/pages/user_profile_screen.dart';
import 'package:navicare/feature/chat/presentation/providers/chat_provider.dart'
    show chatProvider;
import 'package:navicare/feature/chat/presentation/providers/message_provider.dart';
import 'package:navicare/feature/therapy/presentation/pages/call_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

final clientInfoProvider = FutureProvider.family<UserModel, String>((
  ref,
  clientId,
) async {
  final chatRepository = ref.read(chatRepositoryProvider);
  final result = await chatRepository.getClientInfo(clientId);
  return result.fold((failure) => throw failure, (user) => user);
});

class ChatMessageScreen extends ConsumerStatefulWidget {
  final Chat chat;

  const ChatMessageScreen({super.key, required this.chat});

  @override
  ConsumerState<ChatMessageScreen> createState() => _ChatMessageScreenState();
}

class _ChatMessageScreenState extends ConsumerState<ChatMessageScreen>
    with WidgetsBindingObserver {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final ValueNotifier<bool> _isSendingVN = ValueNotifier<bool>(false);
  //bool _isSending = false;
  StreamSubscription? _messageReadSubscription;
  bool _initialStatusChecked = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(messageProvider(widget.chat.id).notifier).getMessages();
      _markChatAsRead();
      _setupMessageReadListener();
      _setupUserStatusListener();
      _fetchInitialClientStatus();
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // App came to foreground - mark messages as read and check for new ones
      _markChatAsRead();
      ref
          .read(messageProvider(widget.chat.id).notifier)
          .getMessages(silent: true);
    }
  }

  void _fetchInitialClientStatus() {
    final clientId = widget.chat.user?.id;
    if (clientId != null && !_initialStatusChecked) {
      // Fetch client info to get initial online status
      ref
          .read(clientInfoProvider(clientId).future)
          .then((clientInfo) {
            if (mounted) {
              setState(() {
                _initialStatusChecked = true;
                // Update the chat's online status based on client info
                // You might need to add an isOnline field to your Chat model
                // or handle this differently based on your data structure
              });
            }
          })
          .catchError((error) {
            print('Failed to fetch client info: $error');
          });
    }
  }

  void _setupUserStatusListener() {
    final socketService = ref.read(socketServiceProvider);
    final userStatusNotifier = ref.read(userStatusProvider.notifier);

    // Listen for user status updates
    socketService.socket?.on('userStatus', (data) {
      final statusData = data as Map<String, dynamic>;
      final userId = statusData['userId'];
      final isOnline = statusData['isOnline'];

      // Update the status provider
      userStatusNotifier.updateStatus(userId, isOnline);

      // If this status is for the current chat user, update UI
      // if (userId == widget.chat.user?.id) {
      //   setState(() {
      //     widget.chat.isOnline = isOnline;
      //   });
      // }
    });

    // If socket is not connected, try to connect
    if (!socketService.isConnected) {
      socketService.connect();
    }
  }

  void _markChatAsRead() async {
    ref.read(chatProvider.notifier).markChatAsRead(widget.chat.id);

    final messageNotifier = ref.read(messageProvider(widget.chat.id).notifier);
    await messageNotifier.markAsRead();
  }

  void _setupMessageReadListener() {
    //print("hey hey");
    // Listen for message read events (adjust this based on your notification system)
    _messageReadSubscription = FirebaseMessaging.onMessage.listen((event) {
      if (event.data['code'] == '2' || event.data['code'] == 2) {
        _markChatAsRead();
        print("hey hey new message");
      }
      // print("hey hey event data is ${event.data}");
    });
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

  Future<void> _startCall({bool isVideoCall = false}) async {
    final sharedPreferences = await SharedPreferences.getInstance();

    final accessToken = sharedPreferences.getString('access_token');
    final roomName = _generateRandomRoomName();

    try {
      final dio = Dio();
      dio.options.headers['Authorization'] = 'Bearer $accessToken';

      final response = await dio.post(
        '${base_url_dev}/chat/call/${widget.chat.id}',
        data: {'room': roomName, 'isVideoCall': isVideoCall},
      );

      if (response.statusCode == 201) {
        if (!mounted) return;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (context) => CallScreen(
                  roomName: roomName,
                  participantName: widget.chat.name ?? "Unknown",
                  isVideoCall: isVideoCall,
                  chatId: widget.chat.id,
                ),
          ),
        );
      } else {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to start call'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } on DioException catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: ${e.response?.data['message'] ?? e.message}'),
          backgroundColor: Colors.red,
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('An unexpected error occurred'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _sendMessage() async {
    final content = _messageController.text.trim();
    _messageController.clear();
    if (content.isEmpty) return;

    _isSendingVN.value = true;

    await ref
        .read(messageProvider(widget.chat.id).notifier)
        .sendMessage(content);

    // Silent update of chat threads (no global spinner on chat list)
    await ref.read(chatProvider.notifier).getChatThreads(silent: true);

    _isSendingVN.value = false;
  }

  String _formatMessageTime(DateTime dt) {
    // Convert UTC to local time
    final localDt = dt.toLocal();
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final messageDate = DateTime(localDt.year, localDt.month, localDt.day);

    if (messageDate == today) {
      return '${localDt.hour.toString().padLeft(2, '0')}:${localDt.minute.toString().padLeft(2, '0')}';
    } else if (messageDate == yesterday) {
      return 'Yesterday, ${localDt.hour.toString().padLeft(2, '0')}:${localDt.minute.toString().padLeft(2, '0')}';
    } else {
      return '${localDt.month}/${localDt.day}, ${localDt.hour.toString().padLeft(2, '0')}:${localDt.minute.toString().padLeft(2, '0')}';
    }
  }

  Widget _buildDateSeparator(String date) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Expanded(child: Divider(color: Colors.grey[400], thickness: 0.5)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              date,
              style: TextStyle(color: Colors.grey[600], fontSize: 12),
            ),
          ),
          Expanded(child: Divider(color: Colors.grey[400], thickness: 0.5)),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(ChatMessageDetail message) {
    final isMe = message.client == null;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        if (!isMe)
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: getRandomGradient(),
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Center(
                child: Text(
                  initials(message.client?.firstName ?? 'G'),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        Flexible(
          child: Align(
            alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Three dots menu (only for user's own messages)
                if (isMe)
                  PopupMenuButton<String>(
                    icon: Icon(
                      Icons.more_vert,
                      size: 16,
                      color: Colors.grey[400],
                    ),
                    onSelected: (value) {
                      if (value == 'delete') {
                        _showDeleteDialog(message);
                      }
                    },
                    itemBuilder:
                        (BuildContext context) => [
                          const PopupMenuItem<String>(
                            value: 'delete',
                            child: Row(
                              children: [
                                Icon(Icons.delete, color: Colors.red, size: 16),
                                SizedBox(width: 8),
                                Text(
                                  'Delete',
                                  style: TextStyle(color: Colors.red),
                                ),
                              ],
                            ),
                          ),
                        ],
                    padding: EdgeInsets.zero,
                    offset: const Offset(-10, 20),
                  ),

                // Message bubble
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.65,
                  ),
                  decoration: BoxDecoration(
                    color: isMe ? AppColors.primary : Colors.grey[200],
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  child: Column(
                    crossAxisAlignment:
                        isMe
                            ? CrossAxisAlignment.end
                            : CrossAxisAlignment.start,
                    children: [
                      Text(
                        message.content,
                        style: TextStyle(
                          color: isMe ? Colors.white : AppColors.primary,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            _formatMessageTime(message.createdAt),
                            style: TextStyle(
                              color: isMe ? Colors.white70 : Colors.grey[600],
                              fontSize: 10,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Icon(
                            message.isRead == true && isMe
                                ? Icons.done_all
                                : message.isRead == false && isMe
                                ? Icons.done
                                : null,
                            size: 12,
                            color: isMe ? Colors.white70 : Colors.grey[600],
                          ),
                          if (message.isPending) ...[
                            const SizedBox(width: 6),
                            Icon(
                              Icons.access_time,
                              size: 12,
                              color: isMe ? Colors.white70 : Colors.grey[600],
                            ),
                          ] else if (message.isFailed) ...[
                            const SizedBox(width: 6),
                            const Icon(
                              Icons.error,
                              size: 12,
                              color: Colors.red,
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _showDeleteDialog(ChatMessageDetail message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Message'),
          content: const Text('Are you sure you want to delete this message?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                ref
                    .read(messageProvider(widget.chat.id).notifier)
                    .deleteMessage(message.id);
              },
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final clientId = widget.chat.user?.id;
    final isOnlineFromSocket = ref.watch(userStatusProvider)[clientId];

    // Watch the client info provider
    final clientInfoAsync =
        clientId != null ? ref.watch(clientInfoProvider(clientId)) : null;

    // Determine the final online status
    final bool isOnline;
    if (isOnlineFromSocket != null) {
      print("user st id: ${clientInfoAsync?.value?.id}");
      print("user st Online 1 socket: ${isOnlineFromSocket}");
      // Prefer real-time socket status
      isOnline = isOnlineFromSocket;
    } else if (clientInfoAsync != null &&
        clientInfoAsync is AsyncData<UserModel>) {
      print("user st Online 2 socket: ${clientInfoAsync}");
      // Use client info status as fallback
      isOnline =
          clientInfoAsync.value.isOnline ??
          false; // Adjust based on your UserModel
    } else {
      // Default to chat's stored status
      isOnline = widget.chat.isOnline ?? false;
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leadingWidth: 30,
        title: Row(
          children: [
            GestureDetector(
              onTap: () {
                if (widget.chat.isGroup != null &&
                    widget.chat.isGroup == true) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => GroupProfileScreen(
                            groupName: widget.chat.name ?? 'Group Chat',
                            groupMembers: widget.chat.groupList,
                          ),
                    ),
                  );
                } else {
                  print("clientId: ${clientId}");
                  // For non-group chat, fetch therapist info
                  if (clientId != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => ContactDetailPage(
                              clientId: clientId,
                              clientName: widget.chat.name!,
                              avatarUrl: widget.chat.avatarUrl,
                              avatar: widget.chat.avatar,
                            ),
                      ),
                    );
                  }
                }
              },
              child:
                  (widget.chat.isGroup != null && widget.chat.isGroup == false)
                      ? ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child:
                            widget.chat.avatarUrl != null &&
                                    widget.chat.avatarUrl!.isNotEmpty
                                ? Image(
                                  image: NetworkImage(
                                    '${widget.chat.avatarUrl}',
                                  ),
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Image(
                                      image: AssetImage(
                                        getAvatarImage(widget.chat.avatar ?? 0),
                                      ),
                                      width: 50,
                                      height: 50,
                                    );
                                  },
                                )
                                : Image.asset(
                                  getAvatarImage(widget.chat.avatar ?? 0),
                                  width: 40,
                                  height: 40,
                                  fit: BoxFit.cover,
                                ),
                      )
                      : Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          shape:
                              (widget.chat.isGroup != null &&
                                      widget.chat.isGroup == true)
                                  ? BoxShape.rectangle
                                  : BoxShape.circle,
                          borderRadius:
                              (widget.chat.isGroup != null &&
                                      widget.chat.isGroup == true)
                                  ? BorderRadius.circular(12)
                                  : null,
                          gradient: LinearGradient(
                            colors: getRandomGradient(),
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            initials(
                              widget.chat.isGroup != null &&
                                      widget.chat.isGroup == false
                                  ? '${widget.chat.name}'
                                  : 'Group',
                            ),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.chat.name ?? 'Unknown',
                  // widget.chat.user?.phoneNumber ?? "x",
                  style: const TextStyle(fontSize: 16),
                ),
                if (widget.chat.isGroup == false)
                  Text(
                    isOnline ? 'Online' : 'Offline',
                    style: TextStyle(
                      fontSize: 12,
                      color: isOnline ? Colors.green : Colors.grey,
                    ),
                  ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.phone),
            onPressed: () => _startCall(isVideoCall: false),
          ),
          IconButton(
            icon: const Icon(Icons.videocam_outlined),
            onPressed: () => _startCall(isVideoCall: true),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Consumer(
              builder: (context, ref, _) {
                final messageState = ref.watch(messageProvider(widget.chat.id));
                return switch (messageState) {
                  Initial() => const Center(child: Text('No messages yet')),
                  Loading() => const Center(
                    child: CircularProgressIndicator(color: AppColors.primary),
                  ),
                  Error(:final failure) => Center(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Text(failure.message.toString()),
                      ),
                    ),
                  ),
                  Loaded(:final messages, :final canLoadMore) =>
                    _buildMessageList(messages),
                  MessageState() => throw UnimplementedError(),
                };
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Type a message',
                      hintStyle: TextStyle(color: Colors.grey[500]),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                    ),
                    minLines: 1,
                    maxLines: 5,
                  ),
                ),
                const SizedBox(width: 8),
                ValueListenableBuilder<bool>(
                  valueListenable: _isSendingVN,
                  builder: (context, isSending, _) {
                    return CircleAvatar(
                      backgroundColor:
                          isSending ? Colors.grey : AppColors.primary,
                      child: IconButton(
                        icon: const Icon(Icons.send, color: Colors.white),
                        onPressed: isSending ? null : _sendMessage,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageList(List<ChatMessageDetail> messages) {
    final widgets = <Widget>[];
    for (final m in messages) {
      widgets.add(_buildMessageBubble(m));
    }
    return ListView(
      controller: _scrollController,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      reverse: true,
      children: widgets,
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}
