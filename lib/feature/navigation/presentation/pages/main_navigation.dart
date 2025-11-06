import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:navicare/core/constants/base_url.dart';
import 'package:navicare/feature/calendar/presentation/pages/pages/events_example.dart';
import 'package:navicare/feature/chat/presentation/pages/chat_list_screen.dart';
//import 'package:navicare/feature/chat/presentation/pages/chat_screen.dart';
import 'package:navicare/feature/home/presentation/pages/home_screen.dart';
//import 'package:navicare/feature/therapy/presentation/pages/therapy_screen.dart';
//import 'package:navicare/feature/therapy/presentation/pages/user_list_screen.dart';
import 'package:navicare/feature/tools/presentation/pages/tools_screen.dart';
import 'package:navicare/feature/profile/presentation/pages/profile_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;
  late Future<List<Session>> _sessionsFuture;

  final Dio _dio = Dio();

  Future<List<Session>> _fetchSessions() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final accessToken = sharedPreferences.getString('access_token');

    _dio.options.headers['Authorization'] = 'Bearer $accessToken';
    final response = await _dio.get(
      '${base_url_dev}/therapist/me/sessions?fields=schedule,duration,client.*&take=0',
    );
    final sessionsData = response.data['data'] as List;
    return sessionsData.map((data) => Session.fromMap(data)).toList();
  }

  @override
  void initState() {
    super.initState();
    _sessionsFuture = _fetchSessions(); // preload once when app starts
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (index == 2) {
        _sessionsFuture = _fetchSessions(); // refresh when calendar tab clicked
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _screens = [
      const HomeScreen(),
      const ChatListScreen(),
      const SessionCalendarScreen(),

      const ProfileScreen(),
    ];

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: IndexedStack(index: _selectedIndex, children: _screens),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          child: BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            selectedItemColor: const Color(0xFF66B5A3),
            unselectedItemColor: Colors.grey,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                activeIcon: Icon(Icons.home),
                label: AppLocalizations.of(context)!.home,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.chat_bubble_outline),
                activeIcon: Icon(Icons.chat_bubble),
                label: AppLocalizations.of(context)!.myClients,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.calendar_month_outlined),
                activeIcon: Icon(Icons.calendar_month),
                label:
                    AppLocalizations.of(context)!.calendar, // rename if needed
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline),
                activeIcon: Icon(Icons.person),
                label: AppLocalizations.of(context)!.profile,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
