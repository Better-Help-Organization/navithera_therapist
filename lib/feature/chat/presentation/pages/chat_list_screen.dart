import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:navicare/core/constants/base_url.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:navicare/core/routes/app_router.dart';
import 'package:navicare/core/theme/app_colors.dart';
import 'package:navicare/core/util/avatar_util.dart';
import 'package:navicare/core/util/format_duration.dart';
import 'package:navicare/core/util/photo_viewer.dart';
import 'package:navicare/feature/auth/data/models/auth_models.dart';
import 'package:navicare/feature/calendar/presentation/pages/pages/events_example.dart';
import 'package:navicare/feature/calendar/presentation/pages/pages/range_example.dart';
import 'package:navicare/feature/calendar/presentation/pages/schedule_view.dart';
import 'package:navicare/feature/chat/presentation/pages/chat_search_screen.dart';
import 'package:navicare/feature/chat/presentation/pages/message_screen.dart';
import 'package:navicare/feature/therapy/presentation/pages/user_list_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../providers/chat_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class Chat {
  final String id;
  final String? name;
  final String? lastMessage;
  final String? avatarUrl;
  final int? unreadCount;
  final DateTime? timestamp;
  final bool isOutgoing;
  final bool isRead;
  final bool? isGroup;
  final bool isOnline;
  final List<UserModel>? groupList;
  final UserModel? user;
  final int? avatar;

  Chat({
    required this.id,
    this.name,
    this.lastMessage,
    this.avatarUrl,
    this.unreadCount,
    this.timestamp,
    this.isOnline = false,
    this.isOutgoing = false,
    this.isRead = false,
    this.isGroup = false,
    this.groupList,
    this.user,
    this.avatar = 0,
  });

  Chat copyWith({
    String? id,
    String? name,
    String? lastMessage,
    String? avatarUrl,
    int? unreadCount,
    DateTime? timestamp,
    bool? isOnline,
    bool? isOutgoing,
    bool? isRead,
    bool? isGroup,
    UserModel? user,
  }) {
    return Chat(
      id: id ?? this.id,
      name: name ?? this.name,
      lastMessage: lastMessage ?? this.lastMessage,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      unreadCount: unreadCount ?? this.unreadCount,
      timestamp: timestamp ?? this.timestamp,
      isOnline: isOnline ?? this.isOnline,
      isOutgoing: isOutgoing ?? this.isOutgoing,
      isRead: isRead ?? this.isRead,
      isGroup: isGroup ?? this.isGroup,
      groupList: groupList,
      user: user ?? this.user,
    );
  }
}

class ChatListScreen extends ConsumerStatefulWidget {
  const ChatListScreen({super.key});

  @override
  ConsumerState<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends ConsumerState<ChatListScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Initial load: show spinner
      _loadChatThreads();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _loadChatThreads({
    bool loadMore = false,
    bool silent = false,
  }) async {
    try {
      await ref
          .read(chatProvider.notifier)
          .getChatThreads(loadMore: loadMore, silent: silent);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to load chats:'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      final state = ref.read(chatProvider);
      if (state is Loaded && state.canLoadMore) {
        // Load more is already non-blocking (no global spinner)
        _loadChatThreads(loadMore: true, silent: true);
      }
    }
  }

  Future<void> _handleRefresh() async {
    // Pull-to-refresh handler - silent refresh to keep current list
    await _loadChatThreads(silent: true);
  }

  @override
  Widget build(BuildContext context) {
    final chatState = ref.watch(chatProvider);
    final router = ref.read(routerProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.white,
        title: Text(AppLocalizations.of(context)!.myClients),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ChatSearchScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: _buildBody(chatState),
    );
  }

  Widget _buildBody(ChatState chatState) {
    final router = ref.read(routerProvider);
    return switch (chatState) {
      Initial() => RefreshIndicator(
        onRefresh: _handleRefresh,
        color: AppColors.primary,
        child: const Center(child: Text('No chats available')),
      ),
      Loading() => const Center(
        child: CircularProgressIndicator(color: AppColors.primary),
      ),
      Error(:final failure) => RefreshIndicator(
        onRefresh: _handleRefresh,
        color: AppColors.primary,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.8,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Text(failure.message.toString()),
              ),
            ),
          ),
        ),
      ),
      Loaded(:final threads, :final canLoadMore) => RefreshIndicator(
        onRefresh: _handleRefresh,
        color: AppColors.primary,
        child: ListView.builder(
          controller: _scrollController,
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: threads.length + (canLoadMore ? 1 : 0),
          itemBuilder: (context, index) {
            if (index == threads.length) {
              return const Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Center(
                  child: CircularProgressIndicator(color: AppColors.primary),
                ),
              );
            }
            final thread = threads[index];
            final client = thread.client;
            final unreadCount = thread.unreadCount;

            final lastMessage =
                thread.lastMessage?.content != null
                    ? thread.lastMessage?.content
                    : null;
            final updatedAt = thread.updatedAt;
            final displayTime =
                updatedAt != null ? formatTelegramStyle(updatedAt) : '';

            return ListTile(
              leading: GestureDetector(
                onTap: () {
                  // Check if it's a user with a profile image
                  if (client?.profile != null && client!.profile!.isNotEmpty) {
                    final imageUrl =
                        '${base_url_for_image}${client.profile}?v=${DateTime.now().millisecondsSinceEpoch}';
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder:
                            (context) => FullScreenImageViewer(
                              imageUrl: imageUrl,
                              heroTag: 'chatlist-avatar-${thread.id}',
                            ),
                      ),
                    );
                  }
                },
                child:
                    thread.group.isEmpty
                        ? Hero(
                          tag: 'chatlist-avatar-${thread.id}',
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(
                              thread.group.isNotEmpty ? 12 : 25,
                            ),
                            child:
                                (client?.avatar == 7) &&
                                        (client?.profile != null &&
                                            client!.profile!.isNotEmpty)
                                    ? Image(
                                      image: NetworkImage(
                                        '${base_url_for_image}${client.profile}?v=${DateTime.now().millisecondsSinceEpoch}',
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
                                            getAvatarImage(client.avatar ?? 0),
                                          ),
                                          width: 50,
                                          height: 50,
                                        );
                                      },
                                    )
                                    : Image.asset(
                                      getAvatarImage(client?.avatar ?? 0),
                                      width: 50,
                                      height: 50,
                                      fit: BoxFit.cover,
                                    ),
                          ),
                        )
                        : Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            shape:
                                thread.group.isNotEmpty
                                    ? BoxShape.rectangle
                                    : BoxShape.circle,
                            borderRadius:
                                thread.group.isNotEmpty
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
                                thread.group.isEmpty
                                    ? '${client?.firstName} ${client?.lastName}'
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
              title:
                  client != null
                      ? Text('${client.firstName} ${client.lastName}')
                      : Text('${thread.groupName ?? "Group Chat"}'),
              subtitle: Text(
                lastMessage ?? '',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              // trailing: Column(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     if (lastMessage != null)
              //       Text(
              //         displayTime,
              //         style: Theme.of(context).textTheme.bodySmall,
              //       ),
              //   ],
              // ),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  if (lastMessage != null)
                    Text(
                      //_formatTime(chat.timestamp ?? DateTime.now()),
                      displayTime,
                      style: TextStyle(
                        color:
                            unreadCount! > 0 ? AppColors.primary : Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                  if (unreadCount! > 0)
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        unreadCount.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ),
                ],
              ),
              onTap: () {
                //ref.read(chatProvider.notifier).markChatAsRead(thread.id);
                //ref.read(chatProvider.notifier).getChatThreads(silent: true);
                final chat = Chat(
                  id: thread.id,
                  name:
                      client != null
                          ? '${client.firstName} ${client.lastName}'
                          : "${thread.groupName ?? "Group Chat"}",
                  lastMessage: 'I sent you the design files 📎',
                  avatarUrl:
                      (client?.avatar == 7) &&
                              client?.profile != null &&
                              client!.profile!.isNotEmpty
                          ? '$base_url_for_image${client.profile}?v=${DateTime.now().millisecondsSinceEpoch}'
                          : null,
                  unreadCount: 0,
                  timestamp: DateTime(2025, 4, 2, 14, 15),
                  isOutgoing: true,
                  isRead: true,
                  isGroup: thread.group.isNotEmpty,
                  groupList: thread.group,
                  user: client,
                  avatar: client?.avatar,
                );
                router.push('/chat/${thread.id}', extra: chat);
              },
            );
          },
        ),
      ),
      ChatState() => throw UnimplementedError(),
    };
  }
}
