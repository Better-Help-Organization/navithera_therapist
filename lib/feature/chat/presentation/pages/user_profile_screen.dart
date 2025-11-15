import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:navicare/core/theme/app_colors.dart';
import 'package:navicare/core/util/avatar_util.dart';
import 'package:navicare/core/util/photo_viewer.dart';
import 'package:navicare/feature/auth/data/models/auth_models.dart';
import 'package:navicare/feature/auth/presentation/providers/user_provider.dart';
import 'package:navicare/feature/chat/domain/repositories/chat_repository.dart';
import 'package:navicare/feature/chat/data/models/chat_models.dart';
import 'package:navicare/feature/chat/presentation/pages/client_mood_screeen.dart';
import 'package:navicare/feature/questionnaire/presentation/providers/questions_provider.dart';

class ContactDetailPage extends ConsumerStatefulWidget {
  final String clientId;
  final String clientName;
  final String? avatarUrl;
  final int? avatar;

  const ContactDetailPage({
    super.key,
    required this.clientId,
    required this.clientName,
    this.avatarUrl,
    this.avatar,
  });

  @override
  ConsumerState<ContactDetailPage> createState() => _ContactDetailPageState();
}

class _ContactDetailPageState extends ConsumerState<ContactDetailPage> {
  List<Session> sessions = [];
  bool isLoading = true;
  String? errorMessage;
  Map<String, TextEditingController> noteControllers = {};

  @override
  void initState() {
    super.initState();
    _fetchClientSessions();
  }

  @override
  void dispose() {
    // Dispose all text controllers
    noteControllers.forEach((_, controller) => controller.dispose());
    super.dispose();
  }

  Future<void> _fetchClientSessions() async {
    try {
      final response = await ref
          .read(chatRepositoryProvider)
          .getClientSessions(clientId: widget.clientId);

      log("Fetch sessions response: $response");
      response.fold(
        (failure) {
          setState(() {
            errorMessage = failure.toString();
            isLoading = false;
          });
        },
        (sessionResponse) {
          setState(() {
            // Convert to modifiable list using .toList()
            sessions = sessionResponse.data.toList();
            // Initialize text controllers for each session
            for (var session in sessions) {
              noteControllers[session.id] = TextEditingController(
                text: session.note,
              );
            }
            isLoading = false;
          });
        },
      );
    } catch (e) {
      setState(() {
        errorMessage = 'Failed to load sessions';
        isLoading = false;
      });
    }
  }

  Future<void> _updateSessionNote(
    String sessionId,
    String therapistId,
    String newNote,
  ) async {
    try {
      final response = await ref
          .read(chatRepositoryProvider)
          .updateSessionNote(
            sessionId: sessionId,
            therapistId: therapistId,
            note: newNote,
          );

      print("Update note response: $response");

      response.fold(
        (failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to update note: ${failure.toString()}'),
              backgroundColor: Colors.red,
            ),
          );
        },
        (updatedSession) async {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Note updated successfully'),
              backgroundColor: Colors.green,
            ),
          );

          setState(() {
            final index = sessions.indexWhere((s) => s.id == sessionId);
            if (index != -1) {
              // Create a new session object with the updated note
              sessions[index] = sessions[index].copyWith(note: newNote);

              // Also update the controller text to match the new note
              noteControllers[sessionId]?.text = newNote;
            }
          });
          //
        },
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error updating note'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  // String _formatDateTime(DateTime dateTime) {
  //   return '${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}';
  // }

  // String _getSessionTypeIcon(String type) {
  //   switch (type.toLowerCase()) {
  //     case 'video':
  //       return '🎥';
  //     case 'audio':
  //       return '🎧';
  //     case 'in-person':
  //       return '👥';
  //     default:
  //       return '📅';
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (errorMessage != null) {
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: Center(child: Text("Error: ${errorMessage!}")),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverAppBar(
                elevation: 0,
                pinned: true,
                expandedHeight: 170,
                surfaceTintColor: Colors.transparent,
                backgroundColor: Colors.white,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => Navigator.pop(context),
                ),
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    padding: const EdgeInsets.only(
                      left: 16,
                      right: 16,
                      top: 70,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (widget.avatarUrl != null &&
                                widget.avatarUrl!.isNotEmpty) {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder:
                                      (context) => FullScreenImageViewer(
                                        imageUrl: widget.avatarUrl!,
                                        heroTag:
                                            'userprofile-avatar-${widget.clientId}',
                                      ),
                                ),
                              );
                            }
                          },
                          child: Hero(
                            tag: 'userprofile-avatar-${widget.clientId}',
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(25),
                              child:
                                  widget.avatarUrl != null &&
                                          widget.avatarUrl!.isNotEmpty
                                      ? Image(
                                        image: NetworkImage(
                                          '${widget.avatarUrl}',
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
                                                widget.avatar ?? 0,
                                              ),
                                            ),
                                            width: 50,
                                            height: 50,
                                          );
                                        },
                                      )
                                      : Image.asset(
                                        getAvatarImage(widget.avatar ?? 0),
                                        width: 50,
                                        height: 50,
                                        fit: BoxFit.cover,
                                      ),
                            ),
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.clientName,
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 4),
                              // Text(
                              //   '${sessions.length} session(s)',
                              //   style: const TextStyle(
                              //     fontSize: 14,
                              //     color: Colors.grey,
                              //   ),
                              // ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (context) => MoodCalendarScreen(
                                            clientId: widget.clientId,
                                            clientName: widget.clientName,
                                          ),
                                    ),
                                  );
                                },
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "${widget.clientName}'s mood tracker",
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: AppColors.primary,
                                      ),
                                    ),
                                    Icon(
                                      // Optional: chevron or indicator
                                      Icons.chevron_right,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimaryContainer
                                          .withOpacity(0.6),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // "Sessions" label
              SliverToBoxAdapter(
                child: Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      // top: BorderSide(color: Colors.grey),
                      // bottom: BorderSide(color: Colors.grey),
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  child: const Text(
                    'Sessions',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),

              // Sessions list
              if (sessions.isEmpty)
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Center(
                      child: Text(
                        'No sessions found for this client',
                        style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                      ),
                    ),
                  ),
                )
              else
                SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final session = sessions[index];
                    final controller = noteControllers[session.id]!;
                    final user = ref.read(currentUserProvider);

                    return _SessionTile(
                      session: session,
                      controller: controller,
                      onSaveNote:
                          () => _updateSessionNote(
                            session.id,
                            user?.id ?? "",
                            controller.text,
                          ),
                    );
                  }, childCount: sessions.length),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SessionTile extends StatefulWidget {
  final Session session;
  final TextEditingController controller;
  final VoidCallback onSaveNote;

  const _SessionTile({
    required this.session,
    required this.controller,
    required this.onSaveNote,
  });

  @override
  State<_SessionTile> createState() => _SessionTileState();
}

class _SessionTileState extends State<_SessionTile> {
  bool isEditing = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _formatDateTime(widget.session.schedule!),
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 16),
            const Text(
              'Session Notes:',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            ),
            const SizedBox(height: 8),
            if (isEditing)
              TextField(
                controller: widget.controller,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: 'Enter session notes...',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey.shade300,
                    ), // default border
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey.shade300,
                    ), // unfocused border
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey.shade500,
                    ), // focused border
                  ),
                ),
              )
            else
              Text(
                (widget.session.note ?? '').isEmpty
                    ? 'No notes available'
                    : (widget.session.note ?? ''),
                style: TextStyle(
                  color:
                      (widget.session.note?.isEmpty ?? true)
                          ? Colors.grey
                          : null,
                ),
              ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (isEditing)
                  TextButton(
                    onPressed: () {
                      setState(() => isEditing = false);
                      // Reset controller to the current session note
                      widget.controller.text = widget.session.note ?? '';
                    },
                    child: const Text('Cancel'),
                  ),
                if (isEditing) const SizedBox(width: 8),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                  ),
                  onPressed:
                      isEditing
                          ? () {
                            // Call the update function with the new note
                            widget.onSaveNote();
                            setState(() => isEditing = false);
                          }
                          : () => setState(() => isEditing = true),
                  child: Text(
                    isEditing ? 'Save' : 'Edit Notes',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatDateTime(DateTime dateTime) {
    final localTime = dateTime;
    return '${localTime.day}/${localTime.month}/${localTime.year} ${localTime.hour}:${localTime.minute.toString().padLeft(2, '0')}';
  }
}
