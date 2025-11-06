import 'package:flutter/material.dart';
import 'package:navicare/core/theme/app_colors.dart';
import 'package:navicare/feature/journal/presentation/pages/add_edit_journal.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class JournalEntry {
  String id;
  String title;
  String description;
  DateTime date;

  JournalEntry({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
  });
}

class MyJournalScreen extends StatefulWidget {
  @override
  _MyJournalScreenState createState() => _MyJournalScreenState();
}

class _MyJournalScreenState extends State<MyJournalScreen> {
  List<JournalEntry> journalEntries = [];

  void _navigateToAddEntry() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddEditJournalScreen()),
    );

    if (result != null && result is JournalEntry) {
      setState(() {
        journalEntries.add(result);
      });
    }
  }

  void _navigateToEditEntry(JournalEntry entry) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddEditJournalScreen(entry: entry),
      ),
    );

    if (result != null && result is JournalEntry) {
      setState(() {
        int index = journalEntries.indexWhere((e) => e.id == entry.id);
        if (index != -1) {
          journalEntries[index] = result;
        }
      });
    }
  }

  void _deleteEntry(String id) {
    setState(() {
      journalEntries.removeWhere((entry) => entry.id == id);
    });
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Journal entry deleted'),         backgroundColor: Colors.red,));
  }

  void _showDeleteDialog(JournalEntry entry) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text('Delete Entry'),
          content: Text('Are you sure you want to delete "${entry.title}"?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _deleteEntry(entry.id);
              },
              child: Text('Delete', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          AppLocalizations.of(context)!.myJournal,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          // IconButton(
          //   icon: Icon(Icons.search, color: Colors.white),
          //   onPressed: () {
          //     // Implement search functionality
          //   },
          // ),
          // IconButton(
          //   icon: Icon(Icons.grid_view, color: Colors.white),
          //   onPressed: () {
          //     // Implement grid view toggle
          //   },
          // ),
        ],
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child:
            journalEntries.isEmpty
                ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.book_outlined,
                        size: 64,
                        color: Colors.grey[400],
                      ),
                      SizedBox(height: 16),
                      Text(
                        AppLocalizations.of(context)!.noJournalEntries,
                        style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                      ),
                      SizedBox(height: 8),
                      Text(
                        AppLocalizations.of(context)!.addFirstEntry,
                        style: TextStyle(fontSize: 14, color: Colors.grey[500]),
                      ),
                    ],
                  ),
                )
                : ListView.builder(
                  itemCount: journalEntries.length,
                  itemBuilder: (context, index) {
                    final entry = journalEntries[index];
                    final isYellow = index % 2 == 0;

                    return Container(
                      margin: EdgeInsets.only(bottom: 12),
                      child: Card(
                        color: isYellow ? Color(0xFFFFF3CD) : Color(0xFFE2E3E5),
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: InkWell(
                          onTap: () => _navigateToEditEntry(entry),
                          borderRadius: BorderRadius.circular(12),
                          child: Padding(
                            padding: EdgeInsets.all(16),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        entry.title,
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black87,
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        entry.description,
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black54,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        _formatDate(entry.date),
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.black45,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(
                                    Icons.delete_outline,
                                    color: Colors.black54,
                                    size: 20,
                                  ),
                                  onPressed: () => _showDeleteDialog(entry),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToAddEntry,
        backgroundColor: AppColors.secondary,
        child: Icon(Icons.add, color: Colors.white, size: 28),
        shape: CircleBorder(),
      ),
    );
  }
}
