// import 'dart:async';
// import 'dart:math';

// import 'package:dio/dio.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:livekit_client/livekit_client.dart';
// import 'package:navicare/core/constants/base_url.dart';
// import 'package:navicare/core/notification/notification_service.dart';
// import 'package:navicare/core/providers/socket_provider.dart';
// import 'package:navicare/core/providers/user_status_provider.dart';
// import 'package:navicare/core/theme/app_colors.dart';
// import 'package:navicare/core/util/avatar_util.dart';
// import 'package:navicare/feature/auth/data/models/auth_models.dart';
// import 'package:navicare/feature/call/exts.dart';
// import 'package:navicare/feature/call/pages/prejoin.dart';
// import 'package:navicare/feature/call/pages/room.dart';
// import 'package:navicare/feature/chat/data/models/chat_models.dart';
// import 'package:navicare/feature/chat/domain/repositories/chat_repository.dart';
// import 'package:navicare/feature/chat/presentation/pages/chat_list_screen.dart';
// import 'package:navicare/feature/chat/presentation/pages/group_profile_screen.dart';
// import 'package:navicare/feature/chat/presentation/pages/user_profile_screen.dart';
// import 'package:navicare/feature/chat/presentation/providers/chat_provider.dart'
//     show chatProvider;
// import 'package:navicare/feature/chat/presentation/providers/message_provider.dart';
// import 'package:navicare/feature/therapy/presentation/pages/bottom_sheet_for_group.dart';
// import 'package:navicare/feature/therapy/presentation/pages/call_screen.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// final clientInfoProvider = FutureProvider.family<UserModel, String>((
//   ref,
//   clientId,
// ) async {
//   final chatRepository = ref.read(chatRepositoryProvider);
//   final result = await chatRepository.getClientInfo(clientId);
//   return result.fold((failure) => throw failure, (user) => user);
// });

// class ChatMessageScreen extends ConsumerStatefulWidget {
//   final Chat chat;

//   const ChatMessageScreen({super.key, required this.chat});

//   @override
//   ConsumerState<ChatMessageScreen> createState() => _ChatMessageScreenState();
// }

// class _ChatMessageScreenState extends ConsumerState<ChatMessageScreen>
//     with WidgetsBindingObserver {
//   final TextEditingController _messageController = TextEditingController();
//   final ScrollController _scrollController = ScrollController();
//   final ValueNotifier<bool> _isSendingVN = ValueNotifier<bool>(false);
//   //bool _isSending = false;
//   StreamSubscription? _messageReadSubscription;
//   bool _initialStatusChecked = false;
//   bool _busy = false;
//   bool _isSelectionMode = false;
//   final Set<String> _selectedMessageIds = {};

//   @override
//   void initState() {
//     super.initState();

//     WidgetsBinding.instance.addObserver(this);
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       ref.read(messageProvider(widget.chat.id).notifier).getMessages();
//       _markChatAsRead();
//       _setupMessageReadListener();
//       _setupUserStatusListener();
//       _fetchInitialClientStatus();
//     });
//   }

//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) {
//     if (state == AppLifecycleState.resumed) {
//       // App came to foreground - mark messages as read and check for new ones
//       _markChatAsRead();
//       ref
//           .read(messageProvider(widget.chat.id).notifier)
//           .getMessages(silent: true);
//     }
//   }

//   void _toggleSelectionMode(String messageId) {
//     setState(() {
//       if (_isSelectionMode) {
//         if (_selectedMessageIds.contains(messageId)) {
//           _selectedMessageIds.remove(messageId);
//           if (_selectedMessageIds.isEmpty) {
//             _isSelectionMode = false;
//           }
//         } else {
//           _selectedMessageIds.add(messageId);
//         }
//       } else {
//         _isSelectionMode = true;
//         _selectedMessageIds.add(messageId);
//       }
//     });
//   }

//   void _exitSelectionMode() {
//     setState(() {
//       _isSelectionMode = false;
//       _selectedMessageIds.clear();
//     });
//   }

//   Future<void> _deleteSelectedMessages() async {
//     final idsToDelete = _selectedMessageIds.toList();

//     final confirmed = await showDialog<bool>(
//       context: context,
//       builder:
//           (context) => AlertDialog(
//             title: const Text('Delete Messages'),
//             content: Text(
//               'Are you sure you want to delete ${idsToDelete.length} messages?',
//             ),
//             actions: [
//               TextButton(
//                 onPressed: () => Navigator.pop(context, false),
//                 child: const Text('Cancel'),
//               ),
//               TextButton(
//                 onPressed: () => Navigator.pop(context, true),
//                 style: TextButton.styleFrom(foregroundColor: Colors.red),
//                 child: const Text('Delete'),
//               ),
//             ],
//           ),
//     );

//     if (confirmed == true) {
//       final notifier = ref.read(messageProvider(widget.chat.id).notifier);
//       for (final id in idsToDelete) {
//         notifier.deleteMessage(id);
//       }
//       _exitSelectionMode();
//     }
//   }

//   void _fetchInitialClientStatus() {
//     final clientId = widget.chat.user?.id;
//     if (clientId != null && !_initialStatusChecked) {
//       // Fetch client info to get initial online status
//       ref
//           .read(clientInfoProvider(clientId).future)
//           .then((clientInfo) {
//             if (mounted) {
//               setState(() {
//                 _initialStatusChecked = true;
//                 // Update the chat's online status based on client info
//                 // You might need to add an isOnline field to your Chat model
//                 // or handle this differently based on your data structure
//               });
//             }
//           })
//           .catchError((error) {
//             print('Failed to fetch client info: $error');
//           });
//     }
//   }

//   void _setupUserStatusListener() {
//     final socketService = ref.read(socketServiceProvider);
//     final userStatusNotifier = ref.read(userStatusProvider.notifier);

//     // Listen for user status updates
//     socketService.socket?.on('userStatus', (data) {
//       final statusData = data as Map<String, dynamic>;
//       final userId = statusData['userId'];
//       final isOnline = statusData['isOnline'];

//       // Update the status provider
//       userStatusNotifier.updateStatus(userId, isOnline);

//       // If this status is for the current chat user, update UI
//       // if (userId == widget.chat.user?.id) {
//       //   setState(() {
//       //     widget.chat.isOnline = isOnline;
//       //   });
//       // }
//     });

//     // If socket is not connected, try to connect
//     if (!socketService.isConnected) {
//       socketService.connect();
//     }
//   }

//   void _markChatAsRead() async {
//     ref.read(chatProvider.notifier).markChatAsRead(widget.chat.id);

//     final messageNotifier = ref.read(messageProvider(widget.chat.id).notifier);
//     await messageNotifier.markAsRead();
//   }

//   void _setupMessageReadListener() {
//     //print("hey hey");
//     // Listen for message read events (adjust this based on your notification system)
//     _messageReadSubscription = FirebaseMessaging.onMessage.listen((event) {
//       if (event.data['code'] == '2' || event.data['code'] == 2) {
//         _markChatAsRead();
//         print("hey hey new message");
//       }
//       // print("hey hey event data is ${event.data}");
//     });
//   }

//   String _generateRandomRoomName() {
//     const chars =
//         'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
//     final random = Random();
//     return String.fromCharCodes(
//       Iterable.generate(
//         8,
//         (_) => chars.codeUnitAt(random.nextInt(chars.length)),
//       ),
//     );
//   }

//   _join(
//     String url,
//     String token,
//     BuildContext context, {
//     required bool isVideoCall,
//   }) async {
//     _busy = true;
//     setState(() {});

//     // final args = widget.args;

//     try {
//       //create new room
//       const cameraEncoding = VideoEncoding(
//         maxBitrate: 5 * 1000 * 1000,
//         maxFramerate: 30,
//       );

//       const screenEncoding = VideoEncoding(
//         maxBitrate: 3 * 1000 * 1000,
//         maxFramerate: 15,
//       );

//       final room = Room(
//         roomOptions: RoomOptions(
//           // adaptiveStream: args.adaptiveStream,
//           adaptiveStream: true,
//           dynacast: true,
//           defaultAudioPublishOptions: const AudioPublishOptions(
//             name: 'custom_audio_track_name',
//           ),
//           defaultCameraCaptureOptions: const CameraCaptureOptions(
//             maxFrameRate: 30,
//             params: VideoParameters(dimensions: VideoDimensions(1280, 720)),
//           ),
//           defaultVideoPublishOptions: VideoPublishOptions(
//             simulcast: false,
//             // simulcast: args.simulcast,
//             videoCodec: "VP8",

//             videoEncoding: cameraEncoding,
//             screenShareEncoding: screenEncoding,
//           ),
//           // encryption: e2eeOptions,
//         ),
//       );
//       // Create a Listener before connecting
//       final listener = room.createListener();

//       await room.prepareConnection(url, token);

//       // Try to connect to the room
//       // This will throw an Exception if it fails for any reason.
//       await room.connect(
//         url,
//         token,
//         fastConnectOptions: FastConnectOptions(
//           microphone: TrackOption(enabled: true),
//           camera: TrackOption(enabled: isVideoCall),
//         ),
//       );

//       if (!context.mounted) return;
//       await Navigator.push<void>(
//         context,
//         MaterialPageRoute(
//           builder:
//               (_) => RoomPage(room, listener, showVideoControl: isVideoCall),
//         ),
//       );
//     } catch (error) {
//       print('Could not connect $error');
//       if (!context.mounted) return;
//       await context.showErrorDialog(error);
//     } finally {
//       setState(() {
//         _busy = false;
//       });
//     }
//   }

//   Future<void> _startCall({bool isVideoCall = false}) async {
//     final sharedPreferences = await SharedPreferences.getInstance();

//     final accessToken = sharedPreferences.getString('access_token');
//     final roomName = _generateRandomRoomName();

//     try {
//       final dio = Dio();
//       dio.options.headers['Authorization'] = 'Bearer $accessToken';

//       final response = await dio.post(
//         '${base_url_dev}/chat/call/${widget.chat.id}',
//         data: {'room': roomName, 'isVideoCall': isVideoCall},
//       );

//       // if (response.statusCode == 201) {
//       //   if (!mounted) return;
//       //   Navigator.push(
//       //     context,
//       //     MaterialPageRoute(
//       //       builder:
//       //           (context) => CallScreen(
//       //             roomName: roomName,
//       //             participantName: widget.chat.name ?? "Unknown",
//       //             isVideoCall: isVideoCall,
//       //             chatId: widget.chat.id,
//       //             //   isGroupCall: widget.chat.isGroup ?? false,
//       //           ),
//       //     ),
//       //   );
//       // } else {
//       //   if (!mounted) return;
//       //   ScaffoldMessenger.of(context).showSnackBar(
//       //     SnackBar(
//       //       content: Text('Failed to start call'),
//       //       backgroundColor: Colors.red,
//       //     ),
//       //   );
//       // }
//       if (response.statusCode == 201) {
//         final responseData = response.data['data'];
//         final String token = responseData['token'];

//         if (token == null || token.isEmpty) {
//           if (!mounted) return;
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(
//               content: Text('Failed to start call'),
//               backgroundColor: Colors.red,
//             ),
//           );
//           return;
//         }
//         // _joinRoomDirectly(context);
//         // return;
//         // Navigate to CallScreen with the generated room name
//         if (!mounted) return;
//         print("token ${token}");
//         // _join(
//         //   "wss://navicare-dmw0dh3w.livekit.cloud",
//         //   token,
//         //   context,
//         // );
//         final token2 =
//             "eyJhbGciOiJIUzI1NiJ9.eyJ2aWRlbyI6eyJyb29tSm9pbiI6dHJ1ZSwicm9vbSI6InF1aWNrc3RhcnQtcm9vbSJ9LCJpc3MiOiJBUEkzclBhWnVHcWIyODgiLCJleHAiOjE3NjQyMzU0MzYsIm5iZiI6MCwic3ViIjoibWVtZS11c2VybmFtZSJ9.MonNLbSa1SibeZh6M51kWCX5jmuesbg06psBD7ykSbE";

//         _join(
//           "wss://livekit.navigo.et",
//           token,
//           context,
//           isVideoCall: isVideoCall,
//         );
//         // Navigator.push(
//         //   context,
//         //   MaterialPageRoute(
//         //     builder:
//         //         (context) =>
//         //         // CallScreen(
//         //         //   roomName: roomName,
//         //         //   participantName: widget.chat.name ?? "Unknown",
//         //         //   isVideoCall: isVideoCall,
//         //         //   chatId: widget.chat.id,
//         //         // ),
//         //         PreJoinPage(
//         //           args: JoinArgs(
//         //             url: "wss://livekit.navigo.et", // Your known URL
//         //             token: token, // Your known token
//         //             adaptiveStream: true,
//         //             dynacast: true,
//         //             simulcast: false,
//         //             e2ee: false,
//         //             preferredCodec: 'VP8',
//         //             enableBackupVideoCodec: true,
//         //           ),
//         //         ),
//         //   ),
//         // );
//       } else {
//         if (!mounted) return;
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text(
//               'Failed to start call: ${response.data['message'] ?? 'Unknown error'}',
//             ),
//             backgroundColor: Colors.red,
//           ),
//         );
//       }
//     } on DioException catch (e) {
//       if (!mounted) return;
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Error: ${e.response?.data['message'] ?? e.message}'),
//           backgroundColor: Colors.red,
//         ),
//       );
//     } catch (e) {
//       if (!mounted) return;
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('An unexpected error occurred'),
//           backgroundColor: Colors.red,
//         ),
//       );
//     }
//   }

//   Future<void> _sendMessage() async {
//     final content = _messageController.text.trim();
//     _messageController.clear();
//     if (content.isEmpty) return;

//     _isSendingVN.value = true;

//     await ref
//         .read(messageProvider(widget.chat.id).notifier)
//         .sendMessage(content);

//     // Silent update of chat threads (no global spinner on chat list)
//     await ref.read(chatProvider.notifier).getChatThreads(silent: true);

//     _isSendingVN.value = false;
//   }

//   String _formatMessageTime(DateTime dt) {
//     // Convert UTC to local time
//     final localDt = dt.toLocal();
//     final now = DateTime.now();
//     final today = DateTime(now.year, now.month, now.day);
//     final yesterday = today.subtract(const Duration(days: 1));
//     final messageDate = DateTime(localDt.year, localDt.month, localDt.day);

//     if (messageDate == today) {
//       return '${localDt.hour.toString().padLeft(2, '0')}:${localDt.minute.toString().padLeft(2, '0')}';
//     } else if (messageDate == yesterday) {
//       return 'Yesterday, ${localDt.hour.toString().padLeft(2, '0')}:${localDt.minute.toString().padLeft(2, '0')}';
//     } else {
//       return '${localDt.month}/${localDt.day}, ${localDt.hour.toString().padLeft(2, '0')}:${localDt.minute.toString().padLeft(2, '0')}';
//     }
//   }

//   Widget _buildDateSeparator(String date) {
//     return Container(
//       padding: const EdgeInsets.symmetric(vertical: 10),
//       child: Row(
//         children: [
//           Expanded(child: Divider(color: Colors.grey[400], thickness: 0.5)),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 10),
//             child: Text(
//               date,
//               style: TextStyle(color: Colors.grey[600], fontSize: 12),
//             ),
//           ),
//           Expanded(child: Divider(color: Colors.grey[400], thickness: 0.5)),
//         ],
//       ),
//     );
//   }

//   // Widget _buildMessageBubble(ChatMessageDetail message) {
//   //   final isMe = message.client == null;

//   //   return Row(
//   //     crossAxisAlignment: CrossAxisAlignment.end,
//   //     mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
//   //     children: [
//   //       if (!isMe)
//   //         Padding(
//   //           padding: const EdgeInsets.only(right: 8.0),
//   //           child: Container(
//   //             width: 40,
//   //             height: 40,
//   //             decoration: BoxDecoration(
//   //               shape: BoxShape.circle,
//   //               gradient: LinearGradient(
//   //                 colors: getRandomGradient(),
//   //                 begin: Alignment.topLeft,
//   //                 end: Alignment.bottomRight,
//   //               ),
//   //             ),
//   //             child: Center(
//   //               child: Text(
//   //                 initials(message.client?.firstName ?? 'G'),
//   //                 style: const TextStyle(
//   //                   color: Colors.white,
//   //                   fontSize: 18,
//   //                   fontWeight: FontWeight.bold,
//   //                 ),
//   //               ),
//   //             ),
//   //           ),
//   //         ),
//   //       Flexible(
//   //         child: Align(
//   //           alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
//   //           child: Row(
//   //             mainAxisSize: MainAxisSize.min,
//   //             crossAxisAlignment: CrossAxisAlignment.start,
//   //             children: [
//   //               // Three dots menu (only for user's own messages)
//   //               if (isMe)
//   //                 PopupMenuButton<String>(
//   //                   icon: Icon(
//   //                     Icons.more_vert,
//   //                     size: 16,
//   //                     color: Colors.grey[400],
//   //                   ),
//   //                   onSelected: (value) {
//   //                     if (value == 'delete') {
//   //                       _showDeleteDialog(message);
//   //                     }
//   //                   },
//   //                   itemBuilder:
//   //                       (BuildContext context) => [
//   //                         const PopupMenuItem<String>(
//   //                           value: 'delete',
//   //                           child: Row(
//   //                             children: [
//   //                               Icon(Icons.delete, color: Colors.red, size: 16),
//   //                               SizedBox(width: 8),
//   //                               Text(
//   //                                 'Delete',
//   //                                 style: TextStyle(color: Colors.red),
//   //                               ),
//   //                             ],
//   //                           ),
//   //                         ),
//   //                       ],
//   //                   padding: EdgeInsets.zero,
//   //                   offset: const Offset(-10, 20),
//   //                 ),

//   //               // Message bubble
//   //               Container(
//   //                 margin: const EdgeInsets.symmetric(vertical: 4),
//   //                 constraints: BoxConstraints(
//   //                   maxWidth: MediaQuery.of(context).size.width * 0.65,
//   //                 ),
//   //                 decoration: BoxDecoration(
//   //                   color: isMe ? AppColors.primary : Colors.grey[200],
//   //                   borderRadius: BorderRadius.circular(16),
//   //                 ),
//   //                 padding: const EdgeInsets.symmetric(
//   //                   horizontal: 16,
//   //                   vertical: 10,
//   //                 ),
//   //                 child: Column(
//   //                   crossAxisAlignment:
//   //                       isMe
//   //                           ? CrossAxisAlignment.end
//   //                           : CrossAxisAlignment.start,
//   //                   children: [
//   //                     Text(
//   //                       message.content,
//   //                       style: TextStyle(
//   //                         color: isMe ? Colors.white : AppColors.primary,
//   //                         fontSize: 16,
//   //                       ),
//   //                     ),
//   //                     const SizedBox(height: 4),
//   //                     Row(
//   //                       mainAxisSize: MainAxisSize.min,
//   //                       children: [
//   //                         Text(
//   //                           _formatMessageTime(message.createdAt),
//   //                           style: TextStyle(
//   //                             color: isMe ? Colors.white70 : Colors.grey[600],
//   //                             fontSize: 10,
//   //                           ),
//   //                         ),
//   //                         const SizedBox(width: 6),
//   //                         Icon(
//   //                           message.isRead == true && isMe
//   //                               ? Icons.done_all
//   //                               : message.isRead == false && isMe
//   //                               ? Icons.done
//   //                               : null,
//   //                           size: 12,
//   //                           color: isMe ? Colors.white70 : Colors.grey[600],
//   //                         ),
//   //                         if (message.isPending) ...[
//   //                           const SizedBox(width: 6),
//   //                           Icon(
//   //                             Icons.access_time,
//   //                             size: 12,
//   //                             color: isMe ? Colors.white70 : Colors.grey[600],
//   //                           ),
//   //                         ] else if (message.isFailed) ...[
//   //                           const SizedBox(width: 6),
//   //                           const Icon(
//   //                             Icons.error,
//   //                             size: 12,
//   //                             color: Colors.red,
//   //                           ),
//   //                         ],
//   //                       ],
//   //                     ),
//   //                   ],
//   //                 ),
//   //               ),
//   //             ],
//   //           ),
//   //         ),
//   //       ),
//   //     ],
//   //   );
//   // }

//   Widget _buildMessageBubble(ChatMessageDetail message) {
//     final isMe = message.client == null;
//     final isSelected = _selectedMessageIds.contains(message.id);

//     Widget bubbleContent = Row(
//       crossAxisAlignment: CrossAxisAlignment.end,
//       mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
//       children: [
//         if (!isMe)
//           Padding(
//             padding: const EdgeInsets.only(right: 8.0),
//             child: Container(
//               width: 40,
//               height: 40,
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 gradient: LinearGradient(
//                   colors: getRandomGradient(),
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                 ),
//               ),
//               child: Center(
//                 child: Text(
//                   initials(message.client?.firstName ?? 'G'),
//                   style: const TextStyle(
//                     color: Colors.white,
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         Flexible(
//           child: Align(
//             alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
//             child: Row(
//               mainAxisSize: MainAxisSize.min,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Remove the PopupMenuButton and replace with message bubble only
//                 Container(
//                   margin: const EdgeInsets.symmetric(vertical: 4),
//                   constraints: BoxConstraints(
//                     maxWidth: MediaQuery.of(context).size.width * 0.65,
//                   ),
//                   decoration: BoxDecoration(
//                     color: isMe ? AppColors.primary : Colors.grey[200],
//                     borderRadius: BorderRadius.circular(16),
//                   ),
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 16,
//                     vertical: 10,
//                   ),
//                   child: Column(
//                     crossAxisAlignment:
//                         isMe
//                             ? CrossAxisAlignment.end
//                             : CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         message.content,
//                         style: TextStyle(
//                           color: isMe ? Colors.white : AppColors.primary,
//                           fontSize: 16,
//                         ),
//                       ),
//                       const SizedBox(height: 4),
//                       Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           Text(
//                             _formatMessageTime(message.createdAt),
//                             style: TextStyle(
//                               color: isMe ? Colors.white70 : Colors.grey[600],
//                               fontSize: 10,
//                             ),
//                           ),
//                           const SizedBox(width: 6),
//                           Icon(
//                             message.isRead == true && isMe
//                                 ? Icons.done_all
//                                 : message.isRead == false && isMe
//                                 ? Icons.done
//                                 : null,
//                             size: 12,
//                             color: isMe ? Colors.white70 : Colors.grey[600],
//                           ),
//                           if (message.isPending) ...[
//                             const SizedBox(width: 6),
//                             Icon(
//                               Icons.access_time,
//                               size: 12,
//                               color: isMe ? Colors.white70 : Colors.grey[600],
//                             ),
//                           ] else if (message.isFailed) ...[
//                             const SizedBox(width: 6),
//                             const Icon(
//                               Icons.error,
//                               size: 12,
//                               color: Colors.red,
//                             ),
//                           ],
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );

//     return GestureDetector(
//       onLongPress: () {
//         _toggleSelectionMode(message.id);
//       },
//       onTap: () {
//         if (_isSelectionMode) {
//           _toggleSelectionMode(message.id);
//         }
//       },
//       child: Container(
//         color:
//             _isSelectionMode && isSelected
//                 ? AppColors.primary.withOpacity(0.1)
//                 : Colors.transparent,
//         padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
//         child: Row(
//           children: [
//             if (_isSelectionMode)
//               Padding(
//                 padding: const EdgeInsets.only(right: 12.0),
//                 child: Container(
//                   width: 22,
//                   height: 22,
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     color: isSelected ? AppColors.primary : Colors.transparent,
//                     border: Border.all(
//                       color: isSelected ? AppColors.primary : Colors.grey[400]!,
//                       width: 2,
//                     ),
//                   ),
//                   child:
//                       isSelected
//                           ? const Icon(
//                             Icons.check,
//                             size: 16,
//                             color: Colors.white,
//                           )
//                           : null,
//                 ),
//               ),
//             Expanded(child: bubbleContent),
//           ],
//         ),
//       ),
//     );
//   }

//   // void _showDeleteDialog(ChatMessageDetail message) {
//   //   showDialog(
//   //     context: context,
//   //     builder: (BuildContext context) {
//   //       return AlertDialog(
//   //         title: const Text('Delete Message'),
//   //         content: const Text('Are you sure you want to delete this message?'),
//   //         actions: [
//   //           TextButton(
//   //             onPressed: () => Navigator.of(context).pop(),
//   //             child: const Text('Cancel'),
//   //           ),
//   //           TextButton(
//   //             onPressed: () {
//   //               Navigator.of(context).pop();
//   //               ref
//   //                   .read(messageProvider(widget.chat.id).notifier)
//   //                   .deleteMessage(message.id);
//   //             },
//   //             style: TextButton.styleFrom(foregroundColor: Colors.red),
//   //             child: const Text('Delete'),
//   //           ),
//   //         ],
//   //       );
//   //     },
//   //   );
//   // }

//   @override
//   Widget build(BuildContext context) {
//     final clientId = widget.chat.user?.id;
//     final isOnlineFromSocket = ref.watch(userStatusProvider)[clientId];

//     // Watch the client info provider
//     final clientInfoAsync =
//         clientId != null ? ref.watch(clientInfoProvider(clientId)) : null;

//     // Determine the final online status
//     final bool isOnline;
//     if (isOnlineFromSocket != null) {
//       print("user st id: ${clientInfoAsync?.value?.id}");
//       print("user st Online 1 socket: ${isOnlineFromSocket}");
//       // Prefer real-time socket status
//       isOnline = isOnlineFromSocket;
//     } else if (clientInfoAsync != null &&
//         clientInfoAsync is AsyncData<UserModel>) {
//       print("user st Online 2 socket: ${clientInfoAsync}");
//       // Use client info status as fallback
//       isOnline =
//           clientInfoAsync.value.isOnline ??
//           false; // Adjust based on your UserModel
//     } else {
//       // Default to chat's stored status
//       isOnline = widget.chat.isOnline ?? false;
//     }

//     return Scaffold(
//       backgroundColor: Colors.white,
//       // appBar:
//       appBar:
//           _isSelectionMode
//               ? AppBar(
//                 backgroundColor: Colors.white,
//                 elevation: 1,
//                 leading: IconButton(
//                   icon: const Icon(Icons.close, color: Colors.black),
//                   onPressed: _exitSelectionMode,
//                 ),
//                 title: Text(
//                   '${_selectedMessageIds.length}',
//                   style: const TextStyle(
//                     color: Colors.black,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 actions: [
//                   IconButton(
//                     icon: const Icon(Icons.delete, color: Colors.black),
//                     onPressed: _deleteSelectedMessages,
//                   ),
//                 ],
//               )
//               : AppBar(
//                 backgroundColor: Colors.white,
//                 leadingWidth: 30,
//                 title: Row(
//                   children: [
//                     GestureDetector(
//                       onTap: () {
//                         print("Tapped avatar ${widget.chat.groupList}");
//                         if (widget.chat.isGroup != null &&
//                             widget.chat.isGroup == true) {
//                           // Navigator.push(
//                           //   context,
//                           //   MaterialPageRoute(
//                           //     builder:
//                           //         (context) => GroupProfileScreen(
//                           //           groupName: widget.chat.name ?? 'Group Chat',
//                           //           groupMembers: widget.chat.groupList,
//                           //           chatId: widget.chat.id,
//                           //         ),
//                           //   ),
//                           // );
//                         } else {
//                           print("clientId: ${clientId}");
//                           // For non-group chat, fetch therapist info
//                           if (clientId != null) {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder:
//                                     (context) => ContactDetailPage(
//                                       clientId: clientId,
//                                       clientName: widget.chat.name!,
//                                       avatarUrl: widget.chat.avatarUrl,
//                                       avatar: widget.chat.avatar,
//                                     ),
//                               ),
//                             );
//                           }
//                         }
//                       },
//                       child:
//                           (widget.chat.isGroup != null &&
//                                   widget.chat.isGroup == false)
//                               ? ClipRRect(
//                                 borderRadius: BorderRadius.circular(25),
//                                 child:
//                                     widget.chat.avatarUrl != null &&
//                                             widget.chat.avatarUrl!.isNotEmpty
//                                         ? Image(
//                                           image: NetworkImage(
//                                             '${widget.chat.avatarUrl}',
//                                           ),
//                                           width: 50,
//                                           height: 50,
//                                           fit: BoxFit.cover,
//                                           errorBuilder: (
//                                             context,
//                                             error,
//                                             stackTrace,
//                                           ) {
//                                             return Image(
//                                               image: AssetImage(
//                                                 getAvatarImage(
//                                                   widget.chat.avatar ?? 0,
//                                                 ),
//                                               ),
//                                               width: 50,
//                                               height: 50,
//                                             );
//                                           },
//                                         )
//                                         : Image.asset(
//                                           getAvatarImage(
//                                             widget.chat.avatar ?? 0,
//                                           ),
//                                           width: 40,
//                                           height: 40,
//                                           fit: BoxFit.cover,
//                                         ),
//                               )
//                               : Container(
//                                 width: 40,
//                                 height: 40,
//                                 decoration: BoxDecoration(
//                                   shape:
//                                       (widget.chat.isGroup != null &&
//                                               widget.chat.isGroup == true)
//                                           ? BoxShape.rectangle
//                                           : BoxShape.circle,
//                                   borderRadius:
//                                       (widget.chat.isGroup != null &&
//                                               widget.chat.isGroup == true)
//                                           ? BorderRadius.circular(12)
//                                           : null,
//                                   gradient: LinearGradient(
//                                     colors: getRandomGradient(),
//                                     begin: Alignment.topLeft,
//                                     end: Alignment.bottomRight,
//                                   ),
//                                 ),
//                                 child: Center(
//                                   child: Text(
//                                     initials(
//                                       widget.chat.isGroup != null &&
//                                               widget.chat.isGroup == false
//                                           ? '${widget.chat.name}'
//                                           : 'Group',
//                                     ),
//                                     style: const TextStyle(
//                                       color: Colors.white,
//                                       fontSize: 18,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                     ),
//                     const SizedBox(width: 10),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           widget.chat.name ?? 'Unknown',
//                           // widget.chat.user?.phoneNumber ?? "x",
//                           style: const TextStyle(fontSize: 16),
//                         ),
//                         if (widget.chat.isGroup == false)
//                           Text(
//                             isOnline ? 'Online' : 'Offline',
//                             style: TextStyle(
//                               fontSize: 12,
//                               color: isOnline ? Colors.green : Colors.grey,
//                             ),
//                           ),
//                       ],
//                     ),
//                   ],
//                 ),
//                 actions: [
//                   // Individual call buttons
//                   if (widget.chat.isGroup != null &&
//                       widget.chat.isGroup == false)
//                     IconButton(
//                       icon: const Icon(Icons.phone),
//                       onPressed: () => _startCall(isVideoCall: false),
//                     ),
//                   if (widget.chat.isGroup != null &&
//                       widget.chat.isGroup == false)
//                     IconButton(
//                       icon: const Icon(Icons.videocam_outlined),
//                       onPressed: () => _startCall(isVideoCall: true),
//                     ),
//                   // Group call button - opens group profile to select participants
//                   if (widget.chat.isGroup != null &&
//                       widget.chat.isGroup == true)
//                     IconButton(
//                       icon: const Icon(Icons.video_call),
//                       tooltip: 'Start group call',
//                       onPressed: () {
//                         // Navigator.push(
//                         //   context,
//                         //   MaterialPageRoute(
//                         //     builder:
//                         //         (context) => GroupProfileScreen(
//                         //           groupName: widget.chat.name ?? 'Group',
//                         //           groupMembers: widget.chat.groupList,
//                         //           chatId: widget.chat.id,
//                         //         ),
//                         //   ),
//                         // );
//                         showModalBottomSheet(
//                           context: context,
//                           isScrollControlled: true,
//                           backgroundColor: Colors.white,
//                           shape: const RoundedRectangleBorder(
//                             borderRadius: BorderRadius.vertical(
//                               top: Radius.circular(20),
//                             ),
//                           ),
//                           builder:
//                               (context) => GroupMemberSelectionBottomSheet(
//                                 groupName: widget.chat.name ?? 'Group Chat',
//                                 groupMembers: widget.chat.groupList,
//                                 chatId: widget.chat.id,
//                               ),
//                         );
//                       },
//                     ),
//                 ],
//               ),
//       body: Column(
//         children: [
//           Expanded(
//             child: Consumer(
//               builder: (context, ref, _) {
//                 final messageState = ref.watch(messageProvider(widget.chat.id));
//                 return switch (messageState) {
//                   Initial() => const Center(child: Text('No messages yet')),
//                   Loading() => const Center(
//                     child: CircularProgressIndicator(color: AppColors.primary),
//                   ),
//                   Error(:final failure) => Center(
//                     child: Center(
//                       child: Padding(
//                         padding: const EdgeInsets.all(30.0),
//                         child: Text(failure.message.toString()),
//                       ),
//                     ),
//                   ),
//                   Loaded(:final messages, :final canLoadMore) =>
//                     _buildMessageList(messages),
//                   MessageState() => throw UnimplementedError(),
//                 };
//               },
//             ),
//           ),
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     controller: _messageController,
//                     decoration: InputDecoration(
//                       hintText: 'Type a message',
//                       hintStyle: TextStyle(color: Colors.grey[500]),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(24),
//                         borderSide: BorderSide.none,
//                       ),
//                       filled: true,
//                       fillColor: Colors.grey[200],
//                       contentPadding: const EdgeInsets.symmetric(
//                         horizontal: 16,
//                         vertical: 10,
//                       ),
//                     ),
//                     minLines: 1,
//                     maxLines: 5,
//                   ),
//                 ),
//                 const SizedBox(width: 8),
//                 ValueListenableBuilder<bool>(
//                   valueListenable: _isSendingVN,
//                   builder: (context, isSending, _) {
//                     return CircleAvatar(
//                       backgroundColor:
//                           isSending ? Colors.grey : AppColors.primary,
//                       child: IconButton(
//                         icon: const Icon(Icons.send, color: Colors.white),
//                         onPressed: isSending ? null : _sendMessage,
//                       ),
//                     );
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildMessageList(List<ChatMessageDetail> messages) {
//     final widgets = <Widget>[];
//     for (final m in messages) {
//       widgets.add(_buildMessageBubble(m));
//     }
//     return ListView(
//       controller: _scrollController,
//       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//       reverse: true,
//       children: widgets,
//     );
//   }

//   @override
//   void dispose() {
//     WidgetsBinding.instance.removeObserver(this);
//     _messageController.dispose();
//     _scrollController.dispose();
//     super.dispose();
//   }
// }

import 'dart:async';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:livekit_client/livekit_client.dart';
import 'package:navicare/core/constants/base_url.dart';
import 'package:navicare/core/notification/notification_service.dart';
import 'package:navicare/core/providers/socket_provider.dart';
import 'package:navicare/core/providers/user_status_provider.dart';
import 'package:navicare/core/theme/app_colors.dart';
import 'package:navicare/core/util/avatar_util.dart';
import 'package:navicare/feature/auth/data/models/auth_models.dart';
import 'package:navicare/feature/call/exts.dart';
import 'package:navicare/feature/call/pages/prejoin.dart';
import 'package:navicare/feature/call/pages/room.dart';
import 'package:navicare/feature/chat/data/models/chat_models.dart';
import 'package:navicare/feature/chat/domain/repositories/chat_repository.dart';
import 'package:navicare/feature/chat/presentation/pages/chat_list_screen.dart';
import 'package:navicare/feature/chat/presentation/pages/group_profile_screen.dart';
import 'package:navicare/feature/chat/presentation/pages/user_profile_screen.dart';
import 'package:navicare/feature/chat/presentation/providers/chat_provider.dart'
    show chatProvider;
import 'package:navicare/feature/chat/presentation/providers/message_provider.dart';
import 'package:navicare/feature/therapy/presentation/pages/bottom_sheet_for_group.dart';
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
  bool _busy = false;
  bool _isSelectionMode = false;
  final Set<String> _selectedMessageIds = {};

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

  void _toggleSelectionMode(String messageId) {
    setState(() {
      if (_isSelectionMode) {
        if (_selectedMessageIds.contains(messageId)) {
          _selectedMessageIds.remove(messageId);
          if (_selectedMessageIds.isEmpty) {
            _isSelectionMode = false;
          }
        } else {
          _selectedMessageIds.add(messageId);
        }
      } else {
        _isSelectionMode = true;
        _selectedMessageIds.add(messageId);
      }
    });
  }

  void _exitSelectionMode() {
    setState(() {
      _isSelectionMode = false;
      _selectedMessageIds.clear();
    });
  }

  Future<void> _deleteSelectedMessages() async {
    final idsToDelete = _selectedMessageIds.toList();

    final confirmed = await showDialog<bool>(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Delete Messages'),
            content: Text(
              'Are you sure you want to delete ${idsToDelete.length} messages?',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                style: TextButton.styleFrom(foregroundColor: Colors.red),
                child: const Text('Delete'),
              ),
            ],
          ),
    );

    if (confirmed == true) {
      final notifier = ref.read(messageProvider(widget.chat.id).notifier);
      for (final id in idsToDelete) {
        notifier.deleteMessage(id);
      }
      _exitSelectionMode();
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

  _join(
    String url,
    String token,
    BuildContext context, {
    required bool isVideoCall,
    VoidCallback? onBeforeNavigate,
  }) async {
    _busy = true;
    setState(() {});

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
            videoCodec: "VP8",
            videoEncoding: cameraEncoding,
            screenShareEncoding: screenEncoding,
          ),
        ),
      );
      // Create a Listener before connecting
      final listener = room.createListener();

      await room.prepareConnection(url, token);

      // Try to connect to the room
      await room.connect(
        url,
        token,
        fastConnectOptions: FastConnectOptions(
          microphone: TrackOption(enabled: true),
          camera: TrackOption(enabled: isVideoCall),
        ),
      );

      if (!context.mounted) return;

      onBeforeNavigate?.call(); // Call the callback before navigation

      await Navigator.push<void>(
        context,
        MaterialPageRoute(
          builder:
              (_) => RoomPage(
                room,
                listener,
                showVideoControl: isVideoCall,
                chatId: widget.chat.id,
                isGroup: widget.chat.isGroup!,
              ),
        ),
      );
    } catch (error) {
      print('Could not connect $error');
      if (!context.mounted) return;
      await context.showErrorDialog(error);
    } finally {
      setState(() {
        _busy = false;
      });
    }
  }
  // Future<void> _startCall({bool isVideoCall = false}) async {
  //   final sharedPreferences = await SharedPreferences.getInstance();

  //   final accessToken = sharedPreferences.getString('access_token');
  //   final roomName = _generateRandomRoomName();

  //   try {
  //     final dio = Dio();
  //     dio.options.headers['Authorization'] = 'Bearer $accessToken';

  //     final response = await dio.post(
  //       '${base_url_dev}/chat/call/${widget.chat.id}',
  //       data: {'room': roomName, 'isVideoCall': isVideoCall},
  //     );

  //     // if (response.statusCode == 201) {
  //     //   if (!mounted) return;
  //     //   Navigator.push(
  //     //     context,
  //     //     MaterialPageRoute(
  //     //       builder:
  //     //           (context) => CallScreen(
  //     //             roomName: roomName,
  //     //             participantName: widget.chat.name ?? "Unknown",
  //     //             isVideoCall: isVideoCall,
  //     //             chatId: widget.chat.id,
  //     //             //   isGroupCall: widget.chat.isGroup ?? false,
  //     //           ),
  //     //     ),
  //     //   );
  //     // } else {
  //     //   if (!mounted) return;
  //     //   ScaffoldMessenger.of(context).showSnackBar(
  //     //     SnackBar(
  //     //       content: Text('Failed to start call'),
  //     //       backgroundColor: Colors.red,
  //     //     ),
  //     //   );
  //     // }
  //     if (response.statusCode == 201) {
  //       final responseData = response.data['data'];
  //       final String token = responseData['token'];

  //       if (token == null || token.isEmpty) {
  //         if (!mounted) return;
  //         ScaffoldMessenger.of(context).showSnackBar(
  //           const SnackBar(
  //             content: Text('Failed to start call'),
  //             backgroundColor: Colors.red,
  //           ),
  //         );
  //         return;
  //       }
  //       // _joinRoomDirectly(context);
  //       // return;
  //       // Navigate to CallScreen with the generated room name
  //       if (!mounted) return;
  //       print("token ${token}");
  //       // _join(
  //       //   "wss://navicare-dmw0dh3w.livekit.cloud",
  //       //   token,
  //       //   context,
  //       // );
  //       final token2 =
  //           "eyJhbGciOiJIUzI1NiJ9.eyJ2aWRlbyI6eyJyb29tSm9pbiI6dHJ1ZSwicm9vbSI6InF1aWNrc3RhcnQtcm9vbSJ9LCJpc3MiOiJBUEkzclBhWnVHcWIyODgiLCJleHAiOjE3NjQyMzU0MzYsIm5iZiI6MCwic3ViIjoibWVtZS11c2VybmFtZSJ9.MonNLbSa1SibeZh6M51kWCX5jmuesbg06psBD7ykSbE";

  //       _join(
  //         "wss://livekit.navigo.et",
  //         token,
  //         context,
  //         isVideoCall: isVideoCall,
  //       );
  //       // Navigator.push(
  //       //   context,
  //       //   MaterialPageRoute(
  //       //     builder:
  //       //         (context) =>
  //       //         // CallScreen(
  //       //         //   roomName: roomName,
  //       //         //   participantName: widget.chat.name ?? "Unknown",
  //       //         //   isVideoCall: isVideoCall,
  //       //         //   chatId: widget.chat.id,
  //       //         // ),
  //       //         PreJoinPage(
  //       //           args: JoinArgs(
  //       //             url: "wss://livekit.navigo.et", // Your known URL
  //       //             token: token, // Your known token
  //       //             adaptiveStream: true,
  //       //             dynacast: true,
  //       //             simulcast: false,
  //       //             e2ee: false,
  //       //             preferredCodec: 'VP8',
  //       //             enableBackupVideoCodec: true,
  //       //           ),
  //       //         ),
  //       //   ),
  //       // );
  //     } else {
  //       if (!mounted) return;
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //           content: Text(
  //             'Failed to start call: ${response.data['message'] ?? 'Unknown error'}',
  //           ),
  //           backgroundColor: Colors.red,
  //         ),
  //       );
  //     }
  //   } on DioException catch (e) {
  //     if (!mounted) return;
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text('Error: ${e.response?.data['message'] ?? e.message}'),
  //         backgroundColor: Colors.red,
  //       ),
  //     );
  //   } catch (e) {
  //     if (!mounted) return;
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(
  //         content: Text('An unexpected error occurred'),
  //         backgroundColor: Colors.red,
  //       ),
  //     );
  //   }
  // }

  Future<void> _startCall({bool isVideoCall = false}) async {
    // Show calling overlay
    OverlayEntry? overlayEntry;
    bool isCallCancelled = false;
    String? callId; // Store call ID for cancellation

    void removeOverlay() {
      overlayEntry?.remove();
      overlayEntry = null;
      setState(() {
        _busy = false;
      });
    }

    Future<void> cancelCall() async {
      if (isCallCancelled) return;

      isCallCancelled = true;
      removeOverlay();

      // Only cancel if we haven't initiated the call yet
      if (callId != null) {
        await _sendCallCancelNotification(callId!);
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Call cancelled'),
            backgroundColor: Colors.orange,
          ),
        );
      }
    }

    // Create and show the overlay
    overlayEntry = OverlayEntry(
      builder:
          (context) => CallingOverlay(
            userName: widget.chat.name ?? 'Unknown',
            isVideoCall: isVideoCall,
            onCancel: () async {
              await cancelCall();
            },
          ),
    );

    Overlay.of(context).insert(overlayEntry!);
    setState(() {
      _busy = true;
    });

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
        final responseData = response.data['data'];
        final String token = responseData['token'];

        // Store the call ID if your backend returns one
        callId = responseData['callId'] ?? roomName;

        if (token == null || token.isEmpty) {
          removeOverlay();
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Failed to start call'),
              backgroundColor: Colors.red,
            ),
          );
          return;
        }

        // Check if user cancelled before proceeding
        if (isCallCancelled) {
          await _sendCallCancelNotification(callId!);
          return;
        }

        // Wait a moment for user to see the calling screen
        // await Future.delayed(const Duration(milliseconds: 500));

        // Check again if user cancelled
        if (isCallCancelled) {
          await _sendCallCancelNotification(callId!);
          return;
        }

        // Remove overlay before navigation
        // removeOverlay();

        // Join the call
        if (!mounted) return;

        await _join(
          "wss://livekit.navigo.et",
          token,
          context,
          isVideoCall: isVideoCall,
          onBeforeNavigate: () {
            removeOverlay();
          },
        );
      } else {
        removeOverlay();
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Failed to start call: ${response.data['message'] ?? 'Unknown error'}',
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    } on DioException catch (e) {
      removeOverlay();
      print("DioException: ${e.toString()}");
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: ${e.response?.data['message'] ?? e.message}'),
          backgroundColor: Colors.red,
        ),
      );
    } catch (e) {
      removeOverlay();
      print("Unexpected error: $e");
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('An unexpected error occurred'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      // Ensure overlay is removed
      if (!isCallCancelled) {
        removeOverlay();
      }
    }
  }

  // Add this helper method to notify backend about call cancellation
  Future<void> _sendCallCancelNotification(String callId) async {
    try {
      final sharedPreferences = await SharedPreferences.getInstance();
      final accessToken = sharedPreferences.getString('access_token');

      final dio = Dio();
      dio.options.headers['Authorization'] = 'Bearer ${accessToken}';

      await dio.post(
        '${base_url_dev}/chat/call/cancel',
        data: {
          'callId': callId,
          'chatId': widget.chat.id,
          'reason': 'cancelled_by_caller',
        },
      );

      print('Call cancellation notification sent for call: $callId');
    } catch (e) {
      print('Failed to send call cancellation: $e');
      // Continue anyway - the other user will timeout waiting for the call
    }
  }

  // Optional: Add this method if you want to notify backend when call is answered
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

  // Widget _buildMessageBubble(ChatMessageDetail message) {
  //   final isMe = message.client == null;

  //   return Row(
  //     crossAxisAlignment: CrossAxisAlignment.end,
  //     mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
  //     children: [
  //       if (!isMe)
  //         Padding(
  //           padding: const EdgeInsets.only(right: 8.0),
  //           child: Container(
  //             width: 40,
  //             height: 40,
  //             decoration: BoxDecoration(
  //               shape: BoxShape.circle,
  //               gradient: LinearGradient(
  //                 colors: getRandomGradient(),
  //                 begin: Alignment.topLeft,
  //                 end: Alignment.bottomRight,
  //               ),
  //             ),
  //             child: Center(
  //               child: Text(
  //                 initials(message.client?.firstName ?? 'G'),
  //                 style: const TextStyle(
  //                   color: Colors.white,
  //                   fontSize: 18,
  //                   fontWeight: FontWeight.bold,
  //                 ),
  //               ),
  //             ),
  //           ),
  //         ),
  //       Flexible(
  //         child: Align(
  //           alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
  //           child: Row(
  //             mainAxisSize: MainAxisSize.min,
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               // Three dots menu (only for user's own messages)
  //               if (isMe)
  //                 PopupMenuButton<String>(
  //                   icon: Icon(
  //                     Icons.more_vert,
  //                     size: 16,
  //                     color: Colors.grey[400],
  //                   ),
  //                   onSelected: (value) {
  //                     if (value == 'delete') {
  //                       _showDeleteDialog(message);
  //                     }
  //                   },
  //                   itemBuilder:
  //                       (BuildContext context) => [
  //                         const PopupMenuItem<String>(
  //                           value: 'delete',
  //                           child: Row(
  //                             children: [
  //                               Icon(Icons.delete, color: Colors.red, size: 16),
  //                               SizedBox(width: 8),
  //                               Text(
  //                                 'Delete',
  //                                 style: TextStyle(color: Colors.red),
  //                               ),
  //                             ],
  //                           ),
  //                         ),
  //                       ],
  //                   padding: EdgeInsets.zero,
  //                   offset: const Offset(-10, 20),
  //                 ),

  //               // Message bubble
  //               Container(
  //                 margin: const EdgeInsets.symmetric(vertical: 4),
  //                 constraints: BoxConstraints(
  //                   maxWidth: MediaQuery.of(context).size.width * 0.65,
  //                 ),
  //                 decoration: BoxDecoration(
  //                   color: isMe ? AppColors.primary : Colors.grey[200],
  //                   borderRadius: BorderRadius.circular(16),
  //                 ),
  //                 padding: const EdgeInsets.symmetric(
  //                   horizontal: 16,
  //                   vertical: 10,
  //                 ),
  //                 child: Column(
  //                   crossAxisAlignment:
  //                       isMe
  //                           ? CrossAxisAlignment.end
  //                           : CrossAxisAlignment.start,
  //                   children: [
  //                     Text(
  //                       message.content,
  //                       style: TextStyle(
  //                         color: isMe ? Colors.white : AppColors.primary,
  //                         fontSize: 16,
  //                       ),
  //                     ),
  //                     const SizedBox(height: 4),
  //                     Row(
  //                       mainAxisSize: MainAxisSize.min,
  //                       children: [
  //                         Text(
  //                           _formatMessageTime(message.createdAt),
  //                           style: TextStyle(
  //                             color: isMe ? Colors.white70 : Colors.grey[600],
  //                             fontSize: 10,
  //                           ),
  //                         ),
  //                         const SizedBox(width: 6),
  //                         Icon(
  //                           message.isRead == true && isMe
  //                               ? Icons.done_all
  //                               : message.isRead == false && isMe
  //                               ? Icons.done
  //                               : null,
  //                           size: 12,
  //                           color: isMe ? Colors.white70 : Colors.grey[600],
  //                         ),
  //                         if (message.isPending) ...[
  //                           const SizedBox(width: 6),
  //                           Icon(
  //                             Icons.access_time,
  //                             size: 12,
  //                             color: isMe ? Colors.white70 : Colors.grey[600],
  //                           ),
  //                         ] else if (message.isFailed) ...[
  //                           const SizedBox(width: 6),
  //                           const Icon(
  //                             Icons.error,
  //                             size: 12,
  //                             color: Colors.red,
  //                           ),
  //                         ],
  //                       ],
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }

  Widget _buildMessageBubble(ChatMessageDetail message) {
    final isMe = message.client == null;
    final isSelected = _selectedMessageIds.contains(message.id);

    Widget bubbleContent = Row(
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
                // Remove the PopupMenuButton and replace with message bubble only
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

    return GestureDetector(
      onLongPress: () {
        _toggleSelectionMode(message.id);
      },
      onTap: () {
        if (_isSelectionMode) {
          _toggleSelectionMode(message.id);
        }
      },
      child: Container(
        color:
            _isSelectionMode && isSelected
                ? AppColors.primary.withOpacity(0.1)
                : Colors.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        child: Row(
          children: [
            if (_isSelectionMode)
              Padding(
                padding: const EdgeInsets.only(right: 12.0),
                child: Container(
                  width: 22,
                  height: 22,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isSelected ? AppColors.primary : Colors.transparent,
                    border: Border.all(
                      color: isSelected ? AppColors.primary : Colors.grey[400]!,
                      width: 2,
                    ),
                  ),
                  child:
                      isSelected
                          ? const Icon(
                            Icons.check,
                            size: 16,
                            color: Colors.white,
                          )
                          : null,
                ),
              ),
            Expanded(child: bubbleContent),
          ],
        ),
      ),
    );
  }

  // void _showDeleteDialog(ChatMessageDetail message) {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: const Text('Delete Message'),
  //         content: const Text('Are you sure you want to delete this message?'),
  //         actions: [
  //           TextButton(
  //             onPressed: () => Navigator.of(context).pop(),
  //             child: const Text('Cancel'),
  //           ),
  //           TextButton(
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //               ref
  //                   .read(messageProvider(widget.chat.id).notifier)
  //                   .deleteMessage(message.id);
  //             },
  //             style: TextButton.styleFrom(foregroundColor: Colors.red),
  //             child: const Text('Delete'),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

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
      // appBar:
      appBar:
          _isSelectionMode
              ? AppBar(
                backgroundColor: Colors.white,
                elevation: 1,
                leading: IconButton(
                  icon: const Icon(Icons.close, color: Colors.black),
                  onPressed: _exitSelectionMode,
                ),
                title: Text(
                  '${_selectedMessageIds.length}',
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.black),
                    onPressed: _deleteSelectedMessages,
                  ),
                ],
              )
              : AppBar(
                backgroundColor: Colors.white,
                leadingWidth: 30,
                title: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        print("Tapped avatar ${widget.chat.groupList}");
                        if (widget.chat.isGroup != null &&
                            widget.chat.isGroup == true) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) => GroupProfileScreen(
                                    groupName: widget.chat.name ?? 'Group Chat',
                                    groupMembers: widget.chat.groupList,
                                    chatId: widget.chat.id,
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
                          (widget.chat.isGroup != null &&
                                  widget.chat.isGroup == false)
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
                                          errorBuilder: (
                                            context,
                                            error,
                                            stackTrace,
                                          ) {
                                            return Image(
                                              image: AssetImage(
                                                getAvatarImage(
                                                  widget.chat.avatar ?? 0,
                                                ),
                                              ),
                                              width: 50,
                                              height: 50,
                                            );
                                          },
                                        )
                                        : Image.asset(
                                          getAvatarImage(
                                            widget.chat.avatar ?? 0,
                                          ),
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
                  // Individual call buttons
                  if (widget.chat.isGroup != null &&
                      widget.chat.isGroup == false)
                    IconButton(
                      icon: const Icon(Icons.phone),
                      onPressed: () => _startCall(isVideoCall: false),
                    ),
                  if (widget.chat.isGroup != null &&
                      widget.chat.isGroup == false)
                    IconButton(
                      icon: const Icon(Icons.videocam_outlined),
                      onPressed: () => _startCall(isVideoCall: true),
                    ),
                  // Group call button - opens group profile to select participants
                  if (widget.chat.isGroup != null &&
                      widget.chat.isGroup == true)
                    IconButton(
                      icon: const Icon(Icons.video_call),
                      tooltip: 'Start group call',
                      onPressed: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder:
                        //         (context) => GroupProfileScreen(
                        //           groupName: widget.chat.name ?? 'Group',
                        //           groupMembers: widget.chat.groupList,
                        //           chatId: widget.chat.id,
                        //         ),
                        //   ),
                        // );
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.white,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(20),
                            ),
                          ),
                          builder:
                              (context) => GroupMemberSelectionBottomSheet(
                                groupName: widget.chat.name ?? 'Group Chat',
                                groupMembers: widget.chat.groupList,
                                chatId: widget.chat.id,
                              ),
                        );
                      },
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

class CallingOverlay extends StatefulWidget {
  final String userName;
  final bool isVideoCall;
  final VoidCallback onCancel;
  final bool? isCancelling;

  const CallingOverlay({
    super.key,
    required this.userName,
    required this.isVideoCall,
    required this.onCancel,
    this.isCancelling = false,
  });

  @override
  State<CallingOverlay> createState() => _CallingOverlayState();
}

class _CallingOverlayState extends State<CallingOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(
      begin: 0.8,
      end: 1.2,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black.withOpacity(0.85),
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Animated avatar
            ScaleTransition(
              scale: _animation,
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient:
                      widget.isCancelling == true
                          ? LinearGradient(
                            colors: [Colors.grey[600]!, Colors.grey[400]!],
                          )
                          : LinearGradient(
                            colors: [
                              AppColors.primary,
                              AppColors.primary.withOpacity(0.7),
                            ],
                          ),
                  boxShadow: [
                    BoxShadow(
                      color:
                          widget.isCancelling == true
                              ? Colors.grey.withOpacity(0.4)
                              : AppColors.primary.withOpacity(0.4),
                      blurRadius: 20,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    getInitials(widget.userName),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 40),

            // User name
            Text(
              widget.userName,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 8),

            // Call type and status
            Text(
              widget.isCancelling == true
                  ? 'Cancelling call...'
                  : widget.isVideoCall
                  ? 'Video Call'
                  : 'Voice Call',
              style: const TextStyle(color: Colors.white70, fontSize: 16),
            ),

            const SizedBox(height: 20),

            // Calling text with animated dots
            widget.isCancelling == true
                ? const Text(
                  'Cancelling...',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                )
                : _buildCallingText(),

            const SizedBox(height: 60),

            // Cancel button
            // ElevatedButton(
            //   onPressed: widget.isCancelling == true ? null : widget.onCancel,
            //   style: ElevatedButton.styleFrom(
            //     backgroundColor:
            //         widget.isCancelling == true ? Colors.grey : Colors.red,
            //     foregroundColor: Colors.white,
            //     padding: const EdgeInsets.symmetric(
            //       horizontal: 32,
            //       vertical: 12,
            //     ),
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(25),
            //     ),
            //   ),
            //   child: widget.isCancelling == true
            //       ? const Row(
            //           mainAxisSize: MainAxisSize.min,
            //           children: [
            //             SizedBox(
            //               width: 20,
            //               height: 20,
            //               child: CircularProgressIndicator(
            //                 strokeWidth: 2,
            //                 valueColor:
            //                     AlwaysStoppedAnimation<Color>(Colors.white),
            //               ),
            //             ),
            //             SizedBox(width: 8),
            //             Text('Cancelling...', style: TextStyle(fontSize: 16)),
            //           ],
            //         )
            //       : const Row(
            //           mainAxisSize: MainAxisSize.min,
            //           children: [
            //             Icon(Icons.close, size: 20),
            //             SizedBox(width: 8),
            //             Text('Cancel Call', style: TextStyle(fontSize: 16)),
            //           ],
            //         ),
            // ),
            if (widget.isCancelling != true) ...[
              const SizedBox(height: 30),
              // Spinning indicator
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                strokeWidth: 3,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildCallingText() {
    return TweenAnimationBuilder<int>(
      tween: IntTween(begin: 0, end: 3),
      duration: const Duration(milliseconds: 1200),
      builder: (context, value, child) {
        String dots = '.' * value;
        return Text(
          'Calling$dots',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

// Helper function for initials
String getInitials(String name) {
  final parts = name.split(' ');
  if (parts.length >= 2) {
    return '${parts[0][0]}${parts[1][0]}';
  } else if (name.isNotEmpty) {
    return name[0];
  }
  return 'U';
}
