import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:navicare/feature/profile/presentation/widgets/avatar_screen.dart';
import 'package:navicare/feature/profile/presentation/widgets/student_id.dart';
import 'package:navicare/feature/profile/presentation/widgets/update_personal_detail_widget.dart';
import "package:navicare/l10n/app_localization.dart";

class UpdateProfileWrapperPage extends ConsumerStatefulWidget {
  final int initialIndex;

  const UpdateProfileWrapperPage({super.key, this.initialIndex = 0});

  @override
  ConsumerState<UpdateProfileWrapperPage> createState() =>
      _UpdateProfileWrapperPageState();
}

//class _UpdateProfileWrapperPageState extends State<UpdateProfileWrapperPage> {
// This variable will keep track of the currently selected tab.
class _UpdateProfileWrapperPageState
    extends ConsumerState<UpdateProfileWrapperPage> {
  late int _selectedIndex;

  // A list of the widgets to be displayed for each tab.
  static const List<Widget> _widgetOptions = <Widget>[
    UpdatePersonalDetails(),
    AvatarScreen(),
    // Center(child: Text('Student ID Screen')),
    StudentIdPage(),
  ];

  // This method updates the state when a new tab is selected.
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex; // use passed index or 0
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: Column(
          children: [
            // This Row is our custom TabBar.
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceAround,
            //   children: [
            //     _buildTabItem(index: 0, title: 'Profile'),
            //     _buildTabItem(index: 1, title: 'Avatar'),
            //     _buildTabItem(index: 2, title: 'Student ID'),
            //   ],
            // ),
            _buildLog(), // This is the log widget you provided.
            // The Expanded widget ensures the content below the tabs fills the remaining space.
            Expanded(child: _widgetOptions.elementAt(_selectedIndex)),
          ],
        ),
      ),
    );
  }

  Widget _buildLog() {
    final index = 0;
    //final isSelected = _selectedIndex == index;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
      child: Row(
        children: [
          // First item
          Expanded(
            child: GestureDetector(
              onTap: () {
                _onItemTapped(0);
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    AppLocalizations.of(context)!.profile,
                    style: TextStyle(
                      color:
                          _selectedIndex == 0 ? Colors.teal : Colors.grey[600],
                      fontWeight:
                          _selectedIndex == 0
                              ? FontWeight.bold
                              : FontWeight.normal,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    height: 6,
                    decoration: BoxDecoration(
                      color:
                          _selectedIndex == 0
                              ? Colors.greenAccent
                              : Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(width: 8),

          // Second item
          Expanded(
            child: GestureDetector(
              onTap: () {
                _onItemTapped(1);
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    AppLocalizations.of(context)!.avatar,
                    style: TextStyle(
                      color:
                          _selectedIndex == 1 ? Colors.teal : Colors.grey[600],
                      fontWeight:
                          _selectedIndex == 1
                              ? FontWeight.bold
                              : FontWeight.normal,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    height: 6,
                    decoration: BoxDecoration(
                      color:
                          _selectedIndex == 1
                              ? Colors.greenAccent
                              : Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(width: 8),

          // Third item
          Expanded(
            child: GestureDetector(
              onTap: () {
                _onItemTapped(2);
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    AppLocalizations.of(context)!.studentId,
                    style: TextStyle(
                      color:
                          _selectedIndex == 2 ? Colors.teal : Colors.grey[600],
                      fontWeight:
                          _selectedIndex == 2
                              ? FontWeight.bold
                              : FontWeight.normal,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    height: 6,
                    decoration: BoxDecoration(
                      color:
                          _selectedIndex == 2
                              ? Colors.greenAccent
                              : Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to build each custom tab item.
  // This gives you full control over the styling.
  Widget _buildTabItem({required int index, required String title}) {
    final isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
        decoration: BoxDecoration(
          // The bottom border indicates the selected tab.
          // border: Border(
          //   bottom: BorderSide(
          //     color: isSelected ? Colors.teal : Colors.transparent,
          //     width: 3.0,
          //   ),
          // ),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.teal : Colors.grey[600],
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}

// Widget for the 'Profile' tab content
// This version is based on the user's provided code, without the outer margin.

// Widget for the 'Avatar' tab content
