import 'package:flutter/material.dart';
import 'package:navicare/core/theme/app_colors.dart';
import 'package:navicare/feature/journal/presentation/pages/my_journal.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class AddEditJournalScreen extends StatefulWidget {
  final JournalEntry? entry;

  AddEditJournalScreen({this.entry});

  @override
  _AddEditJournalScreenState createState() => _AddEditJournalScreenState();
}

class _AddEditJournalScreenState extends State<AddEditJournalScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool get isEditing => widget.entry != null;

  @override
  void initState() {
    super.initState();
    if (isEditing) {
      _titleController.text = widget.entry!.title;
      _descriptionController.text = widget.entry!.description;
    } else {
      _descriptionController.text = '';
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _saveEntry() {
    if (_formKey.currentState!.validate()) {
      final entry = JournalEntry(
        id:
            isEditing
                ? widget.entry!.id
                : DateTime.now().millisecondsSinceEpoch.toString(),
        title: _titleController.text.trim(),
        description: _descriptionController.text.trim(),
        date: isEditing ? widget.entry!.date : DateTime.now(),
      );

      Navigator.pop(context, entry);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black54),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          isEditing ? 'Edit Entry' : AppLocalizations.of(context)!.todaysMusing,
          style: TextStyle(
            color: Colors.black54,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          TextButton(
            onPressed: _saveEntry,
            child: Text(
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
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: [
              // Title Input
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)!.enterTitle,
                  hintStyle: TextStyle(color: Colors.black38),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                ),
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),

              SizedBox(height: 20),

              // Description Input
              Expanded(
                child: TextFormField(
                  controller: _descriptionController,

                  decoration: InputDecoration(
                    hintText: AppLocalizations.of(context)!.letItPour,
                    hintStyle: TextStyle(color: Colors.black38),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                  ),
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                    height: 1.5,
                  ),
                  maxLines: null,
                  expands: true,
                  textAlignVertical: TextAlignVertical.top,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter some content';
                    }
                    return null;
                  },
                ),
              ),

              SizedBox(height: 20),

              // Save Button
              Container(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _saveEntry,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 2,
                  ),
                  child: Text(
                    isEditing
                        ? 'Update Note'
                        : AppLocalizations.of(context)!.saveNote,
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
      ),
    );
  }
}
