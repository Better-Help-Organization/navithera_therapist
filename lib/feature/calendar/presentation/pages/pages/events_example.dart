import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:navicare/core/constants/base_url.dart';
import 'package:navicare/core/theme/app_colors.dart';
import 'package:navicare/feature/auth/presentation/providers/user_provider.dart';
import 'package:navicare/main.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sessionProvider = StateNotifierProvider<SessionNotifier, List<Session>>((
  ref,
) {
  return SessionNotifier();
});

class SessionNotifier extends StateNotifier<List<Session>> {
  SessionNotifier() : super([]);

  final Dio _dio = Dio();
  bool _isLoading = false;

  Future<void> loadSessions() async {
    if (_isLoading) return;

    _isLoading = true;
    try {
      await _attachAuthHeader();
      final response = await _dio.get(
        '${base_url_dev}/therapist/me/sessions?fields=client.*,schedule,duration,hasTherapistAttended,approvalStatus,groupName&take=100',
      );

      log("response data: ${response.data}");

      final sessionsData = (response.data['data'] as List);
      final sessions = sessionsData.map((e) => Session.fromMap(e)).toList();

      state = sessions;
    } catch (e) {
      print('Error loading sessions: $e');
      // Keep existing state on error
    } finally {
      _isLoading = false;
    }
  }

  Future<void> _attachAuthHeader() async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('access_token');
    if (accessToken != null && accessToken.isNotEmpty) {
      _dio.options.headers['Authorization'] = 'Bearer $accessToken';
    } else {
      _dio.options.headers.remove('Authorization');
    }
  }
}

class Session {
  final String id;
  final DateTime schedule;
  final int duration;
  final Client? client; // Make client nullable
  final String? note;
  final bool hasTherapistAttended;
  final String approvalStatus;
  final String? groupName; // Add groupName field

  Session({
    required this.id,
    required this.schedule,
    required this.duration,
    this.client, // Make client optional
    required this.approvalStatus,
    this.note,
    this.hasTherapistAttended = false,
    this.groupName, // Add groupName to constructor
  });

  factory Session.fromMap(Map<String, dynamic> map) {
    log("object: ${map}");

    Client? client;
    if (map['client'] != null && map['client'] is Map<String, dynamic>) {
      client = Client.fromMap(map['client'] as Map<String, dynamic>);
    }

    return Session(
      id: map['id']?.toString() ?? '',
      schedule: DateTime.parse(map['schedule']?.toString() ?? ''),
      duration: map['duration'] is int ? map['duration'] as int : 0,
      client: client, // This can be null now
      approvalStatus: map['approvalStatus']?.toString() ?? 'pending',
      note: map['note']?.toString(),
      hasTherapistAttended:
          map['hasTherapistAttended'] is bool
              ? map['hasTherapistAttended'] as bool
              : false,
      groupName: map['groupName']?.toString(), // Parse groupName
    );
  }

  Session copyWith({
    String? id,
    DateTime? schedule,
    int? duration,
    Client? client,
    String? note,
    bool? hasTherapistAttended,
    String? approvalStatus,
    String? groupName,
  }) {
    return Session(
      id: id ?? this.id,
      schedule: schedule ?? this.schedule,
      duration: duration ?? this.duration,
      client: client ?? this.client,
      note: note ?? this.note,
      hasTherapistAttended: hasTherapistAttended ?? this.hasTherapistAttended,
      approvalStatus: approvalStatus ?? this.approvalStatus,
      groupName: groupName ?? this.groupName,
    );
  }

  DateTime get endTime => schedule.add(Duration(minutes: duration));

  // Helper method to get display name
  String get displayName {
    if (client != null) {
      return client!.fullName;
    } else if (groupName != null && groupName!.isNotEmpty) {
      return groupName!;
    } else {
      return "Group Session";
    }
  }
}

class Client {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final int avatar;
  final String phoneNumber;
  final String status;
  final String gender;

  Client({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.avatar,
    required this.phoneNumber,
    required this.status,
    required this.gender,
  });

  factory Client.fromMap(Map<String, dynamic> map) {
    return Client(
      id: map['id']?.toString() ?? '',
      firstName: map['firstName']?.toString() ?? '',
      lastName: map['lastName']?.toString() ?? '',
      email: map['email']?.toString() ?? '',
      avatar: map['avatar'] is int ? map['avatar'] as int : 1,
      phoneNumber: map['phoneNumber']?.toString() ?? '',
      status: map['status']?.toString() ?? '',
      gender: map['gender']?.toString() ?? '',
    );
  }

  String get fullName => '$firstName $lastName';
}

// class SessionCalendarScreen extends StatefulWidget {
//   const SessionCalendarScreen({super.key});

//   @override
//   State<SessionCalendarScreen> createState() => _SessionCalendarScreenState();
// }

class SessionCalendarScreen extends ConsumerStatefulWidget {
  const SessionCalendarScreen({super.key});

  @override
  ConsumerState<SessionCalendarScreen> createState() =>
      _SessionCalendarScreenState();
}

class _SessionCalendarScreenState extends ConsumerState<SessionCalendarScreen>
    with WidgetsBindingObserver {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  final ValueNotifier<List<Session>> _selectedSessions = ValueNotifier([]);
  bool _isLoading = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;

    // Load sessions using provider
    final context = navigatorKey.currentContext;
    if (context != null) {
      final container = ProviderScope.containerOf(context);
      container.read(sessionProvider.notifier).loadSessions();
    }

    // Add app lifecycle observer
    WidgetsBinding.instance.addObserver(this);
  }

  void _setupSessionListener(WidgetRef ref) {
    // Listen to session changes and update selected sessions
    ref.listen<List<Session>>(sessionProvider, (previous, next) {
      if (_selectedDay != null) {
        _selectedSessions.value = _getSessionsForDay(_selectedDay!, next);
      }
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _selectedSessions.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // App came to foreground - refresh sessions
      final context = navigatorKey.currentContext;
      if (context != null) {
        final container = ProviderScope.containerOf(context);
        container.read(sessionProvider.notifier).loadSessions();
      }
    }
  }

  List<Session> _getSessionsForDay(DateTime day, List<Session> sessions) {
    return sessions.where((session) {
      return isSameDay(session.schedule, day);
    }).toList();
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
      });

      // Update selected sessions
      final context = navigatorKey.currentContext;
      if (context != null) {
        final sessions = ProviderScope.containerOf(
          context,
        ).read(sessionProvider);
        _selectedSessions.value = _getSessionsForDay(_selectedDay!, sessions);
      }
    }
  }

  Future<void> _updateSessionSchedule(
    String sessionId,
    DateTime newSchedule,
  ) async {
    setState(() {
      _isLoading = true;
    });

    try {
      final prefs = await SharedPreferences.getInstance();
      final accessToken = prefs.getString('access_token');

      final dio = Dio();
      if (accessToken != null && accessToken.isNotEmpty) {
        dio.options.headers['Authorization'] = 'Bearer $accessToken';
      }

      // Format the date to the required format
      final formattedDate = newSchedule.toUtc().toIso8601String();
      final therapistId = ref.read(currentUserProvider)?.id;
      print("Access formatted: ${formattedDate}");
      print("Access SessioniD: ${sessionId}");
      print("Access therapist: ${therapistId}");

      // Make the API call
      final response = await dio.patch(
        '${base_url_dev}/session/$sessionId',
        data: {'schedule': formattedDate},
      );

      print("responsexoxo: ${response}");

      if (response.statusCode == 200) {
        // Reload sessions to get updated data
        final context = navigatorKey.currentContext;
        if (context != null) {
          final container = ProviderScope.containerOf(context);
          await container.read(sessionProvider.notifier).loadSessions();

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Session updated successfully'),
              backgroundColor: Colors.green,
            ),
          );
        }
      } else {
        throw Exception('Failed to update session');
      }
    }
    // catch (e) {
    //   print("responsexoxo: ${e}");
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(
    //       content: Text('Failed to update session'),
    //       backgroundColor: Colors.red,
    //     ),
    //   );
    // }
    catch (e) {
      String errMsg = "Failed to update";
      if (e is DioException && e.response != null) {
        // ignore: avoid_print
        print('Server responded with status code: ${e.response?.statusCode}');
        // ignore: avoid_print
        print('Response data: ${e.response?.data}');

        final responseData = e.response?.data;
        errMsg = 'Failed to submit session selection';

        if (responseData is Map) {
          errMsg =
              responseData['message'] ??
              responseData['error'] ??
              'Failed to submit session selection';
        } else if (responseData is String) {
          try {
            final parsed = json.decode(responseData);
            errMsg = parsed['message'] ?? errMsg;
          } catch (_) {
            errMsg = responseData;
          }
        }

        //return {'success': false, 'message': errorMessage};
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errMsg), backgroundColor: Colors.red),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _updateSessionAttendance(
    String sessionId,
    bool hasAttended,
  ) async {
    setState(() {
      _isLoading = true;
    });

    try {
      final prefs = await SharedPreferences.getInstance();
      final accessToken = prefs.getString('access_token');

      final dio = Dio();
      if (accessToken != null && accessToken.isNotEmpty) {
        dio.options.headers['Authorization'] = 'Bearer $accessToken';
      }
      print("response: ${sessionId} ${hasAttended}");

      // Make the API call
      final response = await dio.patch(
        '${base_url_dev}/session/$sessionId',
        data: {'hasTherapistAttended': hasAttended},
      );

      print("response: ${response}");

      if (response.statusCode == 200) {
        // Reload sessions to get updated data
        final context = navigatorKey.currentContext;
        if (context != null) {
          final container = ProviderScope.containerOf(context);
          await container.read(sessionProvider.notifier).loadSessions();

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Attendance ${hasAttended ? 'marked' : 'updated'} successfully',
              ),
              backgroundColor: Colors.green,
            ),
          );
        }
      } else {
        throw Exception('Failed to update attendance');
      }
    } catch (e) {
      print("response: ${e}");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to update attendance: '),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _editSessionSchedule(Session session) async {
    final DateTime initialDate = session.schedule;
    final TimeOfDay initialTime = TimeOfDay.fromDateTime(session.schedule);

    // Select date
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (pickedDate == null) return;

    // Select time - using 24-hour format
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: initialTime,
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            alwaysUse24HourFormat: true, // Force 24-hour format
          ),
          child: child!,
        );
      },
    );

    if (pickedTime == null) return;

    // Combine date and time
    final DateTime newSchedule = DateTime(
      pickedDate.year,
      pickedDate.month,
      pickedDate.day,
      pickedTime.hour,
      pickedTime.minute,
    );

    // Update session schedule
    await _updateSessionSchedule(session.id, newSchedule);
  }

  void _showSessionDetailsPopup(Session session) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Session Details',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.darkCyan,
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit, color: AppColors.primary),
                          onPressed: () {
                            Navigator.of(context).pop(); // Close the dialog
                            _editSessionSchedule(session);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                _buildDetailRow(
                  'Session Type',
                  session.client != null
                      ? 'Individual'
                      : 'Group', // Show session type
                ),
                _buildDetailRow(
                  session.client != null ? 'Client' : 'Group',
                  session.displayName, // Use the new displayName getter
                ),
                _buildDetailRow('Date', _formatDate(session.schedule)),
                _buildDetailRow('Time', _formatTime(session.schedule)),
                _buildDetailRow('Duration', '${session.duration} minutes'),
                _buildDetailRow(
                  'Attendance',
                  session.hasTherapistAttended ? 'Attended' : 'Not Attended',
                ),
                _buildDetailRow('Status', session.approvalStatus),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Close'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              '$label:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade700,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(value, style: TextStyle(color: Colors.grey.shade800)),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    final localTime = date.toLocal();
    return '${localTime.day} ${_getMonthName(localTime.month)} ${localTime.year}';
  }

  String _formatTime(DateTime date) {
    final time = TimeOfDay.fromDateTime(date);
    final localTime = date.toLocal();
    return '${localTime.hour}:${localTime.minute.toString().padLeft(2, '0')}';
  }

  String _getMonthName(int month) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return months[month - 1];
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final sessions = ref.watch(sessionProvider);
        final isLoading = sessions.isEmpty && _isLoading;

        _setupSessionListener(ref);

        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            surfaceTintColor: Colors.transparent,
            backgroundColor: Colors.white,
            title: const Text(
              'Session Calendar',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
            centerTitle: true,
            elevation: 0,
            actions: [
              //if (_searchController.text.isNotEmpty)
              IconButton(
                icon: const Icon(Icons.refresh),
                onPressed:
                    () => ref.read(sessionProvider.notifier).loadSessions(),
              ),
            ],
          ),
          body: RefreshIndicator(
            onRefresh: () => ref.read(sessionProvider.notifier).loadSessions(),
            child: Stack(
              children: [
                ListView(
                  children: [
                    // Calendar Card
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: TableCalendar<Session>(
                          firstDay: DateTime.now().subtract(
                            const Duration(days: 365),
                          ),
                          lastDay: DateTime.now().add(
                            const Duration(days: 365),
                          ),
                          focusedDay: _focusedDay,
                          selectedDayPredicate:
                              (day) => isSameDay(_selectedDay, day),
                          calendarFormat: _calendarFormat,
                          eventLoader:
                              (day) => _getSessionsForDay(day, sessions),
                          startingDayOfWeek: StartingDayOfWeek.monday,
                          calendarStyle: CalendarStyle(
                            defaultDecoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            weekendDecoration: BoxDecoration(
                              color: AppColors.primary.withOpacity(0.05),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            selectedDecoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [AppColors.primary, AppColors.darkCyan],
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            todayDecoration: BoxDecoration(
                              color: AppColors.primary.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: AppColors.primary.withOpacity(0.3),
                              ),
                            ),
                            markerDecoration: BoxDecoration(
                              color: AppColors.darkCyan,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            defaultTextStyle: const TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.w500,
                            ),
                            weekendTextStyle: const TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.w500,
                            ),
                            selectedTextStyle: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                            todayTextStyle: TextStyle(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w700,
                            ),
                            outsideTextStyle: TextStyle(
                              color: Colors.grey.shade400,
                            ),
                          ),
                          headerStyle: HeaderStyle(
                            formatButtonVisible: false,
                            titleCentered: true,
                            titleTextStyle: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                            leftChevronIcon: Icon(
                              Icons.chevron_left,
                              color: AppColors.darkCyan,
                            ),
                            rightChevronIcon: Icon(
                              Icons.chevron_right,
                              color: AppColors.darkCyan,
                            ),
                          ),
                          daysOfWeekStyle: DaysOfWeekStyle(
                            weekdayStyle: TextStyle(
                              color: AppColors.darkCyan,
                              fontWeight: FontWeight.w600,
                            ),
                            weekendStyle: TextStyle(
                              color: AppColors.darkCyan,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          calendarBuilders: CalendarBuilders(
                            markerBuilder: (context, date, events) {
                              if (events.isEmpty) return null;

                              return Positioned(
                                right: 1,
                                top: 1,
                                child: Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    color: AppColors.calendarEvent,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Text(
                                    '${events.length}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              );
                            },
                            defaultBuilder: (context, date, _) {
                              final hasSessions =
                                  _getSessionsForDay(date, sessions).isNotEmpty;
                              return Container(
                                margin: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color:
                                      hasSessions
                                          ? const Color.fromARGB(
                                            255,
                                            96,
                                            102,
                                            101,
                                          )
                                          : Colors.transparent,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  '${date.day}',
                                  style: TextStyle(
                                    color:
                                        hasSessions
                                            ? Colors.white
                                            : Colors.black87,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              );
                            },
                            todayBuilder: (context, date, _) {
                              final hasSessions =
                                  _getSessionsForDay(date, sessions).isNotEmpty;
                              return Container(
                                margin: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color:
                                      hasSessions
                                          ? AppColors.primary
                                          : AppColors.primary.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8),
                                  border:
                                      hasSessions
                                          ? null
                                          : Border.all(
                                            color: AppColors.primary
                                                .withOpacity(0.3),
                                          ),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  '${date.day}',
                                  style: TextStyle(
                                    color:
                                        hasSessions
                                            ? Colors.white
                                            : AppColors.primary,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              );
                            },
                            selectedBuilder: (context, date, _) {
                              final hasSessions =
                                  _getSessionsForDay(date, sessions).isNotEmpty;
                              return Container(
                                margin: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: AppColors.primary,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  '${date.day}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              );
                            },
                          ),

                          onDaySelected: _onDaySelected,
                          onFormatChanged: (format) {
                            if (_calendarFormat != format) {
                              setState(() {
                                _calendarFormat = format;
                              });
                            }
                          },
                          onPageChanged: (focusedDay) {
                            _focusedDay = focusedDay;
                          },
                        ),
                      ),
                    ),

                    const SizedBox(height: 8),

                    // Header
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Row(
                        children: [
                          Text(
                            'Sessions for ${_selectedDay != null ? _formatDate(_selectedDay!) : 'Selected Day'}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 8),

                    // Day Calendar Timeline
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: ValueListenableBuilder<List<Session>>(
                        valueListenable: _selectedSessions,
                        builder: (context, selectedSessions, _) {
                          if (_error != null && sessions.isEmpty) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 60.0,
                              ),
                              child: Center(
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.error_outline,
                                      size: 48,
                                      color: Colors.red.shade300,
                                    ),
                                    const SizedBox(height: 12),
                                    Text(
                                      _error!,
                                      style: TextStyle(
                                        color: Colors.red.shade600,
                                        fontSize: 16,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(height: 12),
                                    OutlinedButton.icon(
                                      onPressed:
                                          () =>
                                              ref
                                                  .read(
                                                    sessionProvider.notifier,
                                                  )
                                                  .loadSessions(),
                                      icon: const Icon(Icons.refresh),
                                      label: const Text('Try Again'),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }

                          return _DayCalendarView(
                            sessions: selectedSessions,
                            onSessionTap: _showSessionDetailsPopup,
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),

                // Full-screen loading overlay
                if (isLoading)
                  Positioned.fill(
                    child: AbsorbPointer(
                      child: Container(
                        color: Colors.white.withOpacity(0.8),
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SizedBox(
                                width: 40,
                                height: 40,
                                child: CircularProgressIndicator(),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                'Loading sessions...',
                                style: TextStyle(color: Colors.grey.shade700),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _DayCalendarView extends StatelessWidget {
  final List<Session> sessions;
  final Function(Session) onSessionTap;

  const _DayCalendarView({required this.sessions, required this.onSessionTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 600, // Fixed height for the day calendar
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Time markers (background)
          _buildTimeMarkers(),

          // Session blocks (overlay)
          ..._buildSessionBlocks(),
        ],
      ),
    );
  }

  Widget _buildTimeMarkers() {
    return Column(
      children: List.generate(24, (hour) {
        return Expanded(
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.grey.shade200, width: 1.0),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  SizedBox(
                    width: 40,
                    child: Text(
                      '${hour.toString().padLeft(2, '0')}:00',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: double.infinity,
                      decoration: BoxDecoration(
                        border: Border(
                          left: BorderSide(
                            color: Colors.grey.shade300,
                            width: 1.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  List<Widget> _buildSessionBlocks() {
    if (sessions.isEmpty) {
      return [
        Positioned.fill(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.event_available,
                  size: 48,
                  color: Colors.grey.shade400,
                ),
                const SizedBox(height: 12),
                Text(
                  'No sessions scheduled',
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      ];
    }

    return sessions.map((session) {
      final localTime = session.schedule.toLocal();
      final startHour = localTime.hour;
      final startMinute = localTime.minute;
      final durationHours = session.duration ~/ 60;
      final durationMinutes = session.duration % 60;

      // Calculate position and height based on time
      final top = (startHour + 0.1 / 60) * (600 / 24);
      final height = (durationHours + durationMinutes / 60) * (600 / 24);

      return Positioned(
        left: 60, // Offset for time markers
        top: top,
        right: 16,
        height: 24,
        child: _SessionTimeBlock(
          session: session,
          onTap: () => onSessionTap(session),
        ),
      );
    }).toList();
  }
}

class _SessionTimeBlock extends StatelessWidget {
  final Session session;
  final VoidCallback onTap;

  const _SessionTimeBlock({required this.session, required this.onTap});

  @override
  Widget build(BuildContext context) {
    // Determine color based on approval status
    final Color primaryColor = AppColors.primary;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors:
                session.approvalStatus == 'pending'
                    ? [Colors.yellow, Colors.yellow.shade700]
                    : [primaryColor, AppColors.darkCyan],
          ),
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                session.displayName, // Use the new displayName getter
                style: TextStyle(
                  color:
                      session.approvalStatus == 'pending'
                          ? Colors.black45
                          : Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              if (session.hasTherapistAttended)
                Row(
                  children: [
                    SizedBox(width: 6),
                    Icon(Icons.check_circle, color: Colors.white, size: 12),
                    SizedBox(width: 2),
                    Text("Attended", style: TextStyle(color: Colors.white)),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
