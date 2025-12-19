// group_session_note_editor.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:navicare/core/theme/app_colors.dart';
import 'package:navicare/feature/chat/domain/repositories/chat_repository.dart';

class GroupSessionNoteEditor extends ConsumerStatefulWidget {
  final String sessionId;
  final String clientId;
  final String clientName;
  final DateTime sessionDate;
  final String? initialNote;
  final VoidCallback? onNoteUpdated;

  const GroupSessionNoteEditor({
    super.key,
    required this.sessionId,
    required this.clientId,
    required this.clientName,
    required this.sessionDate,
    this.initialNote,
    this.onNoteUpdated,
  });

  @override
  ConsumerState<GroupSessionNoteEditor> createState() =>
      _GroupSessionNoteEditorState();
}

class _GroupSessionNoteEditorState
    extends ConsumerState<GroupSessionNoteEditor> {
  late TextEditingController _noteController;
  bool _isLoading = false;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _noteController = TextEditingController(text: widget.initialNote ?? '');
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  Future<void> _saveNote() async {
    if (_isSaving) return;

    final note = _noteController.text.trim();
    if (note.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a note'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    setState(() => _isSaving = true);

    final result = await ref
        .read(chatRepositoryProvider)
        .updateGroupSessionNote(
          sessionId: widget.sessionId,
          clientId: widget.clientId,
          note: note,
        );

    result.fold(
      (failure) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to save note: ${failure.message}'),
            backgroundColor: Colors.red,
          ),
        );
      },
      (_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Note saved successfully'),
            backgroundColor: Colors.green,
          ),
        );
        widget.onNoteUpdated?.call();
        Navigator.pop(context);
      },
    );

    setState(() => _isSaving = false);
  }

  String _formatDateTime(DateTime dateTime) {
    final localTime = dateTime.toLocal();
    final month = localTime.month.toString().padLeft(2, '0');
    final day = localTime.day.toString().padLeft(2, '0');
    final year = localTime.year.toString();
    final hour = localTime.hour.toString().padLeft(2, '0');
    final minute = localTime.minute.toString().padLeft(2, '0');

    return '$month/$day/$year $hour:$minute';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black54),
          onPressed: _isSaving ? null : () => Navigator.pop(context),
        ),
        title: Text(
          'Session Note for ${widget.clientName}',
          style: const TextStyle(
            color: Colors.black54,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          if (_isSaving)
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            )
          else
            TextButton(
              onPressed: _saveNote,
              child: const Text(
                'Save',
                style: TextStyle(
                  color: Colors.black45,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
        ],
      ),
      body:
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _formatDateTime(widget.sessionDate),
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Divider(),
                    const SizedBox(height: 20),
                    const Text(
                      'Session Notes:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Expanded(
                      child: TextFormField(
                        controller: _noteController,
                        decoration: InputDecoration(
                          hintText:
                              'Enter session notes for ${widget.clientName}...',
                          hintStyle: const TextStyle(color: Colors.black38),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.zero,
                        ),
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                          height: 1.5,
                        ),
                        maxLines: null,
                        expands: true,
                        textAlignVertical: TextAlignVertical.top,
                        autofocus:
                            widget.initialNote == null ||
                            widget.initialNote!.isEmpty,
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _isSaving ? null : _saveNote,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          elevation: 2,
                        ),
                        child:
                            _isSaving
                                ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                )
                                : const Text(
                                  'Save Note',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                      ),
                    ),
                  ],
                ),
              ),
    );
  }
}
