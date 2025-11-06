import 'dart:developer';
import 'dart:ui';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:navicare/core/constants/base_url.dart';
import 'package:navicare/core/notification/notification_service.dart';
import 'package:navicare/core/theme/app_colors.dart';
import 'package:navicare/feature/auth/presentation/providers/user_provider.dart';
import 'package:navicare/feature/chat/domain/repositories/chat_repository.dart';
import 'package:navicare/feature/chat/presentation/providers/chat_provider.dart';
import 'package:navicare/feature/questionnaire/domain/entities/answer_models.dart';
import 'package:navicare/feature/questionnaire/presentation/providers/answer_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MatchRequest {
  final int? code;
  final MatchData matchData;
  final ClientData clientData;
  final List<String> answerData;
  final List<Availability> availability;
  final ModalData modalData;

  MatchRequest({
    required this.code,
    required this.matchData,
    required this.clientData,
    required this.answerData,
    required this.availability,
    required this.modalData,
  });

  factory MatchRequest.fromMap(Map<String, dynamic> map) {
    return MatchRequest(
      code:
          map['code'] is int
              ? map['code'] as int
              : int.tryParse('${map['code'] ?? ''}'),
      matchData: MatchData.fromMap(map['matchData'] as Map<String, dynamic>),
      clientData: ClientData.fromMap(map['clientData'] as Map<String, dynamic>),
      answerData: List<String>.from(map['answerData'] ?? []),
      availability:
          map['availability'] != null
              ? List<Availability>.from(
                (map['availability'] as List).map(
                  (item) => Availability.fromMap(item),
                ),
              )
              : [],
      modalData: ModalData.fromMap(map['modal'] as Map<String, dynamic>),
    );
  }
}

class MatchData {
  final String? id;
  final DateTime? expiresAt;
  final String? status;

  MatchData({this.id, this.expiresAt, this.status});

  factory MatchData.fromMap(Map<String, dynamic> map) {
    return MatchData(
      id: map['id']?.toString(),
      expiresAt:
          map['expiresAt'] != null
              ? DateTime.tryParse(map['expiresAt'].toString())
              : null,
      status: map['status']?.toString(),
    );
  }
}

class ModalData {
  final String? id;

  ModalData({this.id});

  factory ModalData.fromMap(Map<String, dynamic> map) {
    return ModalData(id: map['id']?.toString());
  }
}

class ClientData {
  final String id;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? phoneNumber;
  final String? gender;
  final DateTime? dob;
  final bool? isEmailAuthenticated;
  final bool? isPhoneNumberAuthenticated;
  final String? status;
  final DateTime? createdAt;

  ClientData({
    required this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.phoneNumber,
    this.gender,
    this.dob,
    this.isEmailAuthenticated,
    this.isPhoneNumberAuthenticated,
    this.status,
    this.createdAt,
  });

  factory ClientData.fromMap(Map<String, dynamic> map) {
    return ClientData(
      id: map['id']?.toString() ?? '',
      firstName: map['firstName']?.toString(),
      lastName: map['lastName']?.toString(),
      email: map['email']?.toString(),
      phoneNumber: map['phoneNumber']?.toString(),
      gender: map['gender']?.toString(),
      dob: map['dob'] != null ? DateTime.tryParse(map['dob'].toString()) : null,
      isEmailAuthenticated:
          map['isEmailAuthenticated'] is bool
              ? map['isEmailAuthenticated'] as bool
              : (map['isEmailAuthenticated']?.toString().toLowerCase() ==
                  'true'),
      isPhoneNumberAuthenticated:
          map['isPhoneNumberAuthenticated'] is bool
              ? map['isPhoneNumberAuthenticated'] as bool
              : (map['isPhoneNumberAuthenticated']?.toString().toLowerCase() ==
                  'true'),
      status: map['status']?.toString(),
      createdAt:
          map['createdAt'] != null
              ? DateTime.tryParse(map['createdAt'].toString())
              : null,
    );
  }

  String get fullName =>
      [firstName, lastName].where((s) => (s ?? '').isNotEmpty).join(' ').trim();
}

class Availability {
  final String id;
  final DateTime? createdAt;
  final String day;
  final String dayPeriod;

  Availability({
    required this.id,
    this.createdAt,
    required this.day,
    required this.dayPeriod,
  });

  factory Availability.fromMap(Map<String, dynamic> map) {
    return Availability(
      id: map['id']?.toString() ?? '',
      createdAt:
          map['createdAt'] != null
              ? DateTime.tryParse(map['createdAt'].toString())
              : null,
      day: map['day']?.toString() ?? '',
      dayPeriod: map['day_period']?.toString() ?? '',
    );
  }

  String get displayText {
    return '${_capitalize(day)} - ${_capitalize(dayPeriod)}';
  }

  static String _capitalize(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1).toLowerCase();
  }
}

class MatchRequestScreen extends ConsumerStatefulWidget {
  final MatchRequest request;

  const MatchRequestScreen({super.key, required this.request});

  @override
  ConsumerState<MatchRequestScreen> createState() => _MatchRequestScreenState();
}

class _MatchRequestScreenState extends ConsumerState<MatchRequestScreen> {
  // NEW: multiple date and time selection
  static const int maxTimeSelections = 25;
  final Set<String> selectedDates = {}; // format: YYYY-MM-DD
  final Map<String, Set<String>> selectedTimesByDate =
      {}; // e.g., {"2024-01-15": {"09:00", "11:00"}}
  String? currentViewingDate; // Currently viewing date for time selection
  Map<String, bool> expandedAvailability = {};
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(answersProvider(widget.request.answerData).future);
      // Ensure ringtone is playing when the match screen is opened
      // ref.read(fcmServiceProvider).startMatchRequestRingtone();
    });
  }

  @override
  Widget build(BuildContext context) {
    final client = widget.request.clientData;
    log("payload client: ${client.createdAt}");
    final match = widget.request.matchData;
    final name = client.fullName.isEmpty ? 'Client' : client.fullName;
    final initials = _initials(name);
    final age = _calculateAge(client.createdAt);
    final expiresText =
        match.expiresAt != null
            ? 'Expires in ${_timeUntil(match.expiresAt!)}'
            : null;
    final answersAsync = ref.watch(answersProvider(widget.request.answerData));

    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        titleSpacing: 16,
        title: const Text('Match Request', style: TextStyle(fontSize: 16)),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppColors.primary.withOpacity(0.12),
                    AppColors.primary.withOpacity(0.10),
                    AppColors.primary,
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: -120,
            right: -60,
            child: _GlowCircle(
              color: AppColors.primary.withOpacity(0.25),
              size: 240,
            ),
          ),
          Positioned(
            bottom: -140,
            left: -100,
            child: _GlowCircle(
              color: AppColors.primary.withOpacity(0.22),
              size: 320,
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                  child: _GlassCard(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                      child: Row(
                        children: [
                          _AvatarWithRing(
                            initials: initials,
                            ringColor: AppColors.primary,
                            background: AppColors.primary,
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Wrap(
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  spacing: 8,
                                  runSpacing: 6,
                                  children: [Text(name)],
                                ),
                                const SizedBox(height: 8),
                                Wrap(
                                  spacing: 8,
                                  runSpacing: 8,
                                  children: [
                                    if (client.gender != null &&
                                        client.gender!.isNotEmpty)
                                      _Chip(
                                        text: _capitalize(client.gender!),
                                        icon: Icons.person_rounded,
                                      ),
                                    if (age != null)
                                      _Chip(
                                        text: 'Signed up $age years ago',
                                        icon: Icons.schedule,
                                      ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                if (expiresText != null)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                    child: _InfoPill(
                      icon: Icons.timer_outlined,
                      child: Text(expiresText),
                    ),
                  ),
                const SizedBox(height: 16),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(0, 8, 0, 100),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: _buildAvailabilitySection(),
                        ),
                        const SizedBox(height: 14),
                        answersAsync.when(
                          loading: () => _buildAnswersLoading(),
                          error: (error, stack) => _buildAnswersError(error),
                          data:
                              (answerResponse) =>
                                  _buildAnswersSection(answerResponse),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                child: _BottomBar(
                  left: OutlinedButton.icon(
                    icon: const Icon(
                      Icons.close_rounded,
                      color: AppColors.error,
                    ),
                    label: const Text(
                      'Reject',
                      style: TextStyle(color: AppColors.error),
                    ),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: const StadiumBorder(),
                    ),
                    onPressed:
                        isLoading
                            ? null
                            : () async {
                              // Stop ringtone on reject
                              // await ref
                              //     .read(fcmServiceProvider)
                              //     .stopMatchRequestRingtone();
                              await _reject(context, widget.request);
                            },
                  ),
                  right:
                      isLoading
                          ? Container(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(999),
                            ),
                            child: const Center(
                              child: SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    AppColors.darkCyan,
                                  ),
                                ),
                              ),
                            ),
                          )
                          : ElevatedButton.icon(
                            icon: const Icon(
                              Icons.check_rounded,
                              color: AppColors.darkCyan,
                            ),
                            label: const Text(
                              'Accept',
                              style: TextStyle(color: AppColors.darkCyan),
                            ),
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: const StadiumBorder(),
                              elevation: 2,
                            ),
                            onPressed: () async {
                              // Stop ringtone on accept
                              // await ref
                              //     .read(fcmServiceProvider)
                              //     .stopMatchRequestRingtone();
                              await _accept(context, widget.request);
                            },
                          ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onToggleTime(String time) {
    if (currentViewingDate == null) return;

    setState(() {
      final currentTimes =
          selectedTimesByDate[currentViewingDate!] ?? <String>{};
      final totalSelectedTimes = selectedTimesByDate.values.fold<int>(
        0,
        (sum, times) => sum + times.length,
      );

      if (currentTimes.contains(time)) {
        currentTimes.remove(time);
        if (currentTimes.isEmpty) {
          selectedTimesByDate.remove(currentViewingDate!);
          selectedDates.remove(currentViewingDate!);
        }
      } else if (totalSelectedTimes < maxTimeSelections) {
        selectedTimesByDate[currentViewingDate!] = currentTimes..add(time);
        selectedDates.add(currentViewingDate!);
      } else {
        // Show a message when trying to select more than max times
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Maximum $maxTimeSelections time slots allowed across all dates',
            ),
            duration: const Duration(seconds: 2),
            backgroundColor: Colors.red,
          ),
        );
      }
    });
  }

  Widget _buildAvailabilitySection() {
    final availabilities = widget.request.availability;
    if (availabilities.isEmpty) {
      return const SizedBox.shrink();
    }

    return _SectionCard(
      title: 'Select Appointment Date & Times',
      children: [
        const SizedBox(height: 8),
        Text(
          'Select multiple dates and times. Tap dates to select them, then choose times for each selected date.',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 12),

        // Dates section from availability
        _SectionTitle('Available Dates'),
        const SizedBox(height: 8),
        _DateChips(
          availabilities: availabilities,
          selectedDates: selectedDates,
          currentViewingDate: currentViewingDate,
          onDateSelected: (date) {
            setState(() {
              if (selectedDates.contains(date)) {
                // If date is already selected, make it the current viewing date
                currentViewingDate = date;
              } else {
                // If date is not selected, select it and make it current viewing date
                selectedDates.add(date);
                selectedTimesByDate[date] = <String>{};
                currentViewingDate = date;
              }
            });
          },
          onDateDeselected: (date) {
            setState(() {
              selectedDates.remove(date);
              selectedTimesByDate.remove(date);
              if (currentViewingDate == date) {
                currentViewingDate =
                    selectedDates.isNotEmpty ? selectedDates.first : null;
              }
            });
          },
        ),

        const SizedBox(height: 16),
        _SectionTitle('Available Times'),

        // Time selection grid based on current viewing date
        if (currentViewingDate == null)
          _InfoPill(
            icon: Icons.info_outline,
            child: Text('Select a date above to see available times'),
          )
        else
          _TimesForSelectedDate(
            availabilities: availabilities,
            selectedDate: currentViewingDate!,
            selectedTimes:
                selectedTimesByDate[currentViewingDate!] ?? <String>{},
            onToggleTime: _onToggleTime,
            maxSelections: maxTimeSelections,
            totalSelectedTimes: selectedTimesByDate.values.fold<int>(
              0,
              (sum, times) => sum + times.length,
            ),
          ),

        // Show all selected dates and times summary
        if (selectedDates.isNotEmpty) ...[
          const SizedBox(height: 16),
          _SectionTitle('Selected Appointments'),
          const SizedBox(height: 8),
          _SelectedAppointmentsSummary(
            selectedTimesByDate: selectedTimesByDate,
            maxSelections: maxTimeSelections,
            onDateTap: (date) {
              setState(() {
                currentViewingDate = date;
              });
            },
            onRemoveDate: (date) {
              setState(() {
                selectedDates.remove(date);
                selectedTimesByDate.remove(date);
                if (currentViewingDate == date) {
                  currentViewingDate =
                      selectedDates.isNotEmpty ? selectedDates.first : null;
                }
              });
            },
          ),
        ],
      ],
    );
  }

  // Accept: uses new session shape with date + startTimes
  // Update the _accept method to use the new data structure
  Future<void> _accept(BuildContext context, MatchRequest request) async {
    if (isPast(request.matchData.expiresAt)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('This match request has expired'),
          backgroundColor: Colors.red,
        ),
      );
      Navigator.of(context).maybePop();
      return;
    }

    if (selectedDates.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select at least one appointment date'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final totalSelectedTimes = selectedTimesByDate.values.fold<int>(
      0,
      (sum, times) => sum + times.length,
    );

    if (totalSelectedTimes == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select at least one appointment time'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    final sharedPreferences = await SharedPreferences.getInstance();
    final accessToken = sharedPreferences.getString('access_token');

    try {
      final dio = Dio();
      dio.options.headers['Authorization'] = 'Bearer $accessToken';

      final matchId = widget.request.matchData.id;

      // 1. First accept the match
      final response_2 = await dio.post(
        '${base_url_dev}/match/accept/',
        data: {'matchId': matchId},
      );

      if (response_2.statusCode != 201) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Failed to accept match: ${response_2.data is Map && response_2.data['message'] != null ? response_2.data['message'] : 'Unknown error'}',
            ),
            backgroundColor: Colors.red,
          ),
        );
        // return;
      }

      final currentUser = ref.read(currentUserProvider);
      final client = widget.request.clientData;
      if (currentUser == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Unable to get current user'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      final modalId = widget.request.modalData.id;
      final clientId = widget.request.clientData.id;

      // NEW: Create the data structure matching your backend
      final requestData = {
        "note": "",
        "groupName": "Individual Therapy Session",
        "dates": _buildDatesArray(),
        "duration": 60,
        "type": "video",
        "modal": modalId,
        "client": clientId,
      };

      print("Request data: ${requestData}");

      final response = await dio.post(
        '${base_url_dev}/session',
        data: requestData,
      );

      print("Response: ${response}");

      if (response.statusCode == 201) {
        if (!mounted) return;

        final chatRepository = ref.read(chatRepositoryProvider);

        await chatRepository.createChat(
          clientId: client.id,
          therapistId: currentUser.id,
        );

        await ref.read(chatProvider.notifier).getChatThreads(silent: true);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Match accepted successfully!'),
            backgroundColor: Colors.green,
          ),
        );

        Navigator.of(context).maybePop();
      } else {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Failed to create session: ${response.data is Map && response.data['message'] != null ? response.data['message'] : 'Unknown error'}',
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    } on DioException catch (e) {
      if (!mounted) return;
      final msg =
          e.response?.data is Map && e.response?.data['message'] != null
              ? e.response?.data['message']
              : e.message;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $msg'), backgroundColor: Colors.red),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('An unexpected error occurred'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  // NEW: Helper method to build the dates array in the required format
  List<Map<String, dynamic>> _buildDatesArray() {
    final List<Map<String, dynamic>> datesArray = [];

    // Group selected dates by weekday name
    final Map<String, Set<String>> datesByWeekday = {};

    for (final dateStr in selectedDates) {
      final date = DateTime.parse('${dateStr}T12:00:00');
      final weekday = _getWeekdayName(date.weekday);
      final times = selectedTimesByDate[dateStr] ?? <String>{};

      if (times.isNotEmpty) {
        if (!datesByWeekday.containsKey(weekday)) {
          datesByWeekday[weekday] = Set<String>();
        }
        datesByWeekday[weekday]!.addAll(times);
      }
    }

    // Convert to the required format
    for (final entry in datesByWeekday.entries) {
      datesArray.add({
        "date": entry.key, // "Monday", "Tuesday", etc.
        "startTimes": entry.value.toList()..sort(), // ["09:00", "11:00"]
      });
    }

    return datesArray;
  }

  // NEW: Helper method to get weekday name from index
  String _getWeekdayName(int weekdayIndex) {
    final weekdays = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday',
    ];
    return weekdays[weekdayIndex - 1];
  }

  Future<void> _reject(BuildContext context, MatchRequest request) async {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Match rejected'),
        backgroundColor: Colors.red,
      ),
    );
    Navigator.of(context).maybePop();
  }

  // Helpers and other sections
  Widget _buildAnswersLoading() {
    return _SectionCard(
      title: 'Questionnaire Answers',
      children: [
        for (int i = 0; i < 3; i++)
          Column(
            children: [if (i > 0) _DividerThin(), const _AnswerSkeleton()],
          ),
      ],
    );
  }

  Widget _buildAnswersError(Object error) {
    return _SectionCard(
      title: 'Questionnaire Answers',
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const Icon(Icons.error_outline, color: Colors.red, size: 32),
              const SizedBox(height: 8),
              Text(
                'Failed to load answers',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 4),
              Text(
                error.toString(),
                style: Theme.of(context).textTheme.bodySmall,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAnswersSection(AnswerResponse answerResponse) {
    final answers = answerResponse.data;

    if (answers.isEmpty) {
      return _SectionCard(
        title: 'Questionnaire Answers',
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'No questionnaire answers available',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      );
    }

    return Padding(
      //padding: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      child: Container(
        width: double.infinity,
        child: _SectionCard(
          title: 'Questionnaire Answers',
          children: [
            for (int i = 0; i < answers.length; i++)
              Column(
                children: [
                  _AnswerTile(answer: answers[i]),
                  const SizedBox(height: 16),
                ],
              ),
          ],
        ),
      ),
    );
  }

  String _initials(String name) {
    final parts =
        name.trim().split(RegExp(r'\s+')).where((p) => p.isNotEmpty).toList();
    if (parts.isEmpty) return '?';
    if (parts.length == 1) return parts.first[0].toUpperCase();
    return (parts[0][0] + parts[1][0]).toUpperCase();
  }

  String _timeUntil(DateTime dt) {
    final now = DateTime.now();
    final difference = dt.difference(now);

    if (difference.isNegative) {
      return "Expired";
    }

    final days = difference.inDays;
    final hours = difference.inHours % 24;
    final parts = <String>[];
    if (days > 0) parts.add("$days day${days > 1 ? 's' : ''}");
    if (hours > 0) parts.add("$hours hour${hours > 1 ? 's' : ''}");
    return " ${parts.join(' and ')}";
  }

  bool isPast(DateTime? dt) {
    if (dt == null) return false;
    return dt.isBefore(DateTime.now());
  }

  int? _calculateAge(DateTime? dob) {
    if (dob == null) return null;
    final now = DateTime.now();
    int age = now.year - dob.year;
    if (now.month < dob.month ||
        (now.month == dob.month && now.day < dob.day)) {
      age--;
    }
    return age;
  }

  static String _capitalize(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1).toLowerCase();
  }
}

// UI pieces reused

class _SectionCard extends StatelessWidget {
  final String title;
  final List<Widget> children;
  const _SectionCard({required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return _GlassCard(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 14, 16, 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w800,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 10),
            ...children,
          ],
        ),
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Widget? trailing;

  const _InfoTile({
    required this.icon,
    required this.label,
    required this.value,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            color: cs.primaryContainer.withOpacity(0.35),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: cs.outlineVariant.withOpacity(0.25)),
          ),
          child: Icon(icon, size: 22, color: AppColors.darkCyan),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: textTheme.labelSmall?.copyWith(
                    color: textTheme.bodySmall?.color?.withOpacity(0.7),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
        if (trailing != null) trailing!,
      ],
    );
  }
}

class _Chip extends StatelessWidget {
  final String text;
  final IconData? icon;
  final double iconSize;

  const _Chip({required this.text, this.icon, this.iconSize = 14});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: cs.surfaceVariant.withOpacity(0.45),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: cs.outlineVariant.withOpacity(0.35)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: iconSize, color: AppColors.darkCyan),
            const SizedBox(width: 6),
          ],
          Text(
            text,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              fontWeight: FontWeight.w700,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String text;
  const _SectionTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, top: 8),
      child: Text(
        text,
        style: Theme.of(
          context,
        ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
      ),
    );
  }
}

class _DividerThin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Divider(
      height: 16,
      thickness: 1,
      color: cs.outlineVariant.withOpacity(0.25),
    );
  }
}

class _GlassCard extends StatelessWidget {
  final Widget child;
  const _GlassCard({required this.child});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: cs.surface.withOpacity(0.65),
            border: Border.all(color: cs.outlineVariant.withOpacity(0.25)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 14,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: child,
        ),
      ),
    );
  }
}

class _AvatarWithRing extends StatelessWidget {
  final String initials;
  final Color ringColor;
  final Color background;

  const _AvatarWithRing({
    required this.initials,
    required this.ringColor,
    required this.background,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        gradient: SweepGradient(
          colors: [
            ringColor.withOpacity(0.0),
            ringColor.withOpacity(0.6),
            ringColor.withOpacity(0.0),
          ],
        ),
        shape: BoxShape.circle,
      ),
      child: CircleAvatar(
        radius: 28,
        backgroundColor: background,
        child: Text(
          initials,
          style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
        ),
      ),
    );
  }
}

class _GlowCircle extends StatelessWidget {
  final Color color;
  final double size;

  const _GlowCircle({required this.color, required this.size});

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
          boxShadow: [
            BoxShadow(
              color: color,
              blurRadius: size * 0.6,
              spreadRadius: size * 0.2,
            ),
          ],
        ),
      ),
    );
  }
}

class _BottomBar extends StatelessWidget {
  final Widget left;
  final Widget right;

  const _BottomBar({required this.left, required this.right});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
          decoration: BoxDecoration(
            color: cs.surface.withOpacity(0.75),
            border: Border.all(color: cs.outlineVariant.withOpacity(0.25)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.07),
                blurRadius: 18,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(child: left),
              const SizedBox(width: 12),
              Expanded(child: right),
            ],
          ),
        ),
      ),
    );
  }
}

// class _InfoPill extends StatelessWidget {
//   final IconData icon;
//   final String text;

//   const _InfoPill({required this.icon, required this.text});

//   @override
//   Widget build(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;
//     final textTheme = Theme.of(context).textTheme;

//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//       decoration: BoxDecoration(
//         color: cs.secondaryContainer.withOpacity(0.35),
//         borderRadius: BorderRadius.circular(999),
//         border: Border.all(color: cs.outlineVariant.withOpacity(0.25)),
//       ),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Icon(icon, size: 18, color: cs.onSecondaryContainer.withOpacity(0.9)),
//           const SizedBox(width: 8),
//           Text(
//             text,
//             style: textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w600),
//           ),
//         ],
//       ),
//     );
//   }
// }

class _InfoPill extends StatelessWidget {
  final IconData icon;
  final Widget child;

  const _InfoPill({required this.icon, required this.child});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: cs.secondaryContainer.withOpacity(0.35),
        borderRadius: BorderRadius.circular(12), // Slightly larger radius
        border: Border.all(color: cs.outlineVariant.withOpacity(0.25)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: cs.onSecondaryContainer.withOpacity(0.9)),
          const SizedBox(width: 8),
          Expanded(
            // Use Expanded instead of Flexible
            child: child,
          ),
        ],
      ),
    );
  }
}

class _AnswerSkeleton extends StatelessWidget {
  const _AnswerSkeleton();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          height: 16,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: 200,
          height: 14,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ],
    );
  }
}

class _AnswerTile extends StatelessWidget {
  final AnswerData answer;

  const _AnswerTile({required this.answer});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          answer.question.text,
          style: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 8),
        _buildAnswerContent(),
      ],
    );
  }

  Widget _buildAnswerContent() {
    switch (answer.question.type) {
      case 'open':
        return _buildOpenAnswer();
      case 'single':
        return _buildSingleAnswer();
      case 'multiple':
        return _buildMultipleAnswer();
      default:
        return const Text('Unknown answer type');
    }
  }

  Widget _buildOpenAnswer() {
    return Text(answer.text ?? 'No answer provided');
  }

  Widget _buildSingleAnswer() {
    if (answer.singleOption == null) {
      return const Text('No answer selected');
    }
    if (answer.singleOption == "other") {
      return Text(answer.text ?? "No answer");
    }
    return Text(answer.singleOption!.text);
  }

  Widget _buildMultipleAnswer() {
    if (answer.multiOption.isEmpty) {
      return const Text('No answers selected');
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:
          answer.multiOption.map((option) {
            return Row(
              children: [
                const Icon(Icons.check_circle_outline, size: 16),
                const SizedBox(width: 8),
                Expanded(child: Text(option.text)),
              ],
            );
          }).toList(),
    );
  }
}

// Date chips built from availability items
// class _DateChips extends StatelessWidget {
//   final List<Availability> availabilities;
//   final String? selectedDate; // YYYY-MM-DD
//   final ValueChanged<String> onDateSelected;
//   final Map<String, bool> expandedAvailability;
//   final void Function(String id, bool expanded) onToggleExpand;

//   const _DateChips({
//     required this.availabilities,
//     required this.selectedDate,
//     required this.onDateSelected,
//     required this.expandedAvailability,
//     required this.onToggleExpand,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;

//     return Column(
//       children: [
//         Wrap(
//           spacing: 8,
//           runSpacing: 8,
//           children:
//               availabilities.map((a) {
//                 final dateStr = _getDateForAvailability(a);
//                 final isSel = selectedDate == dateStr;
//                 return InputChip(
//                   label: Text(_formatDateHuman(dateStr)),
//                   avatar: Icon(
//                     Icons.event,
//                     size: 18,
//                     color: isSel ? cs.onPrimary : cs.onSurfaceVariant,
//                   ),
//                   selected: isSel,
//                   onPressed: () => onDateSelected(dateStr),
//                   selectedColor: cs.primary,
//                   labelStyle: TextStyle(
//                     color: isSel ? cs.onPrimary : cs.onSurface,
//                     fontWeight: FontWeight.w600,
//                   ),
//                   backgroundColor: cs.surfaceVariant.withOpacity(0.45),
//                   shape: StadiumBorder(
//                     side: BorderSide(
//                       color:
//                           isSel
//                               ? cs.primary.withOpacity(0.6)
//                               : cs.outlineVariant.withOpacity(0.35),
//                     ),
//                   ),
//                 );
//               }).toList(),
//         ),
//         const SizedBox(height: 8),
//         // Optional: show the availability item expanded controls per day (if you want)
//         // Here we provide a toggle to peek the period for each date row
//         Column(
//           children:
//               availabilities.map((a) {
//                 final isExpanded = expandedAvailability[a.id] ?? false;
//                 return Column(
//                   children: [
//                     const SizedBox(height: 8),
//                     _GlassCard(
//                       child: ListTile(
//                         title: Text('${a.displayText}'),
//                         subtitle: Text(
//                           'Date: ${_formatDateHuman(_getDateForAvailability(a))}',
//                         ),
//                         trailing: Icon(
//                           isExpanded ? Icons.expand_less : Icons.expand_more,
//                         ),
//                         onTap: () => onToggleExpand(a.id, !isExpanded),
//                       ),
//                     ),
//                     if (isExpanded)
//                       Padding(
//                         padding: const EdgeInsets.symmetric(
//                           horizontal: 8,
//                           vertical: 8,
//                         ),
//                         child: Align(
//                           alignment: Alignment.centerLeft,
//                           child: Text(
//                             'Tap a date chip above, then select times below.',
//                             style: Theme.of(context).textTheme.bodySmall,
//                           ),
//                         ),
//                       ),
//                   ],
//                 );
//               }).toList(),
//         ),
//       ],
//     );
//   }

//   String _getDateForAvailability(Availability availability) {
//     final now = DateTime.now();
//     final dayIndex = _getDayIndex(availability.day);
//     var date = DateTime(now.year, now.month, now.day);

//     // Find the next occurrence of this weekday (today or later)
//     while (date.weekday != dayIndex || date.isBefore(now)) {
//       date = date.add(const Duration(days: 1));
//     }

//     return _formatDateISO(date);
//   }

//   int _getDayIndex(String day) {
//     final days = {
//       'monday': 1,
//       'tuesday': 2,
//       'wednesday': 3,
//       'thursday': 4,
//       'friday': 5,
//       'saturday': 6,
//       'sunday': 7,
//     };
//     return days[day.toLowerCase()] ?? 1;
//   }

//   String _formatDateISO(DateTime dt) {
//     String two(int v) => v.toString().padLeft(2, '0');
//     return '${dt.year}-${two(dt.month)}-${two(dt.day)}';
//   }

//   String _formatDateHuman(String iso) {
//     final dt = DateTime.tryParse('${iso}T12:00:00'); // ensure parse
//     if (dt == null) return iso;
//     final dayName =
//         [
//           'Monday',
//           'Tuesday',
//           'Wednesday',
//           'Thursday',
//           'Friday',
//           'Saturday',
//           'Sunday',
//         ][dt.weekday - 1];
//     return '$dayName, $iso';
//   }
// }
class _DateChips extends StatelessWidget {
  final List<Availability> availabilities;
  final Set<String> selectedDates; // YYYY-MM-DD
  final String? currentViewingDate; // Currently viewing date
  final ValueChanged<String> onDateSelected;
  final ValueChanged<String> onDateDeselected;

  const _DateChips({
    required this.availabilities,
    required this.selectedDates,
    required this.currentViewingDate,
    required this.onDateSelected,
    required this.onDateDeselected,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    // Group availabilities by date to avoid duplicates
    final Map<String, List<Availability>> groupedAvailabilities = {};

    for (final availability in availabilities) {
      final dateStr = _getDateForAvailability(availability);
      if (!groupedAvailabilities.containsKey(dateStr)) {
        groupedAvailabilities[dateStr] = [];
      }
      groupedAvailabilities[dateStr]!.add(availability);
    }

    // Get unique dates
    final uniqueDates = groupedAvailabilities.keys.toList();

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children:
          uniqueDates.map((dateStr) {
            final isSelected = selectedDates.contains(dateStr);
            final isCurrentViewing = currentViewingDate == dateStr;
            final periods =
                groupedAvailabilities[dateStr]!
                    .map((a) => a.dayPeriod)
                    .toSet()
                    .toList();

            return GestureDetector(
              onLongPress: isSelected ? () => onDateDeselected(dateStr) : null,
              child: InputChip(
                label: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(_formatDateHuman(dateStr)),
                    if (isCurrentViewing) ...[
                      const SizedBox(width: 4),
                      Icon(
                        Icons.visibility,
                        size: 16,
                        color: isSelected ? cs.onPrimary : cs.onSurfaceVariant,
                      ),
                    ],
                  ],
                ),
                avatar: Icon(
                  isSelected ? Icons.event : Icons.event_outlined,
                  size: 18,
                  color: isSelected ? cs.onPrimary : cs.onSurfaceVariant,
                ),
                selected: isSelected,
                onPressed: () => onDateSelected(dateStr),
                onDeleted: isSelected ? () => onDateDeselected(dateStr) : null,
                deleteIcon: const Icon(Icons.close, size: 16),
                selectedColor: cs.primary,
                labelStyle: TextStyle(
                  color: isSelected ? cs.onPrimary : cs.onSurface,
                  fontWeight: FontWeight.w600,
                ),
                backgroundColor: cs.surfaceVariant.withOpacity(0.45),
                shape: StadiumBorder(
                  side: BorderSide(
                    color:
                        isSelected
                            ? cs.primary.withOpacity(0.6)
                            : cs.outlineVariant.withOpacity(0.35),
                    width: isCurrentViewing ? 2 : 1,
                  ),
                ),
              ),
            );
          }).toList(),
    );
  }

  String _getDateForAvailability(Availability availability) {
    final now = DateTime.now();
    final dayIndex = _getDayIndex(availability.day);
    var date = DateTime(now.year, now.month, now.day);

    // Find the next occurrence of this weekday (today or later)
    while (date.weekday != dayIndex || date.isBefore(now)) {
      date = date.add(const Duration(days: 1));
    }

    return _formatDateISO(date);
  }

  int _getDayIndex(String day) {
    final days = {
      'monday': 1,
      'tuesday': 2,
      'wednesday': 3,
      'thursday': 4,
      'friday': 5,
      'saturday': 6,
      'sunday': 7,
    };
    return days[day.toLowerCase()] ?? 1;
  }

  String _formatDateISO(DateTime dt) {
    String two(int v) => v.toString().padLeft(2, '0');
    return '${dt.year}-${two(dt.month)}-${two(dt.day)}';
  }

  String _formatDateHuman(String iso) {
    final dt = DateTime.tryParse('${iso}T12:00:00'); // ensure parse
    if (dt == null) return iso;
    final dayName =
        [
          'Monday',
          'Tuesday',
          'Wednesday',
          'Thursday',
          'Friday',
          'Saturday',
          'Sunday',
        ][dt.weekday - 1];
    return '$dayName, $iso';
  }
}

// Times grid for the selected date, using its availability period
class _TimesForSelectedDate extends StatelessWidget {
  final List<Availability> availabilities;
  final String selectedDate;
  final Set<String> selectedTimes;
  final ValueChanged<String> onToggleTime;
  final int maxSelections;
  final int totalSelectedTimes;

  const _TimesForSelectedDate({
    required this.availabilities,
    required this.selectedDate,
    required this.selectedTimes,
    required this.onToggleTime,
    required this.maxSelections,
    required this.totalSelectedTimes,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    // Determine which availability matches this date (by weekday)
    final date = DateTime.parse('${selectedDate}T00:00:00');
    final weekday = date.weekday;

    // Get all periods for this weekday
    final matched =
        availabilities.where((a) => _getDayIndex(a.day) == weekday).toList();

    print("availablity: ${availabilities}");

    if (matched.isEmpty) {
      return _InfoPill(
        icon: Icons.info_outline,
        child: Text('No times available for this date'),
      );
    }

    // Aggregate all times from all matched periods for this day
    final times = <String>{};
    for (final a in matched) {
      times.addAll(_getTimeSlotsForPeriod(a.dayPeriod));
    }
    final sortedTimes = times.toList()..sort();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Show selection counter
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Times for ${_formatDateHuman(selectedDate)}',
                style: Theme.of(
                  context,
                ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 4),
              Text(
                'Selected ${selectedTimes.length} times for this date • Total: $totalSelectedTimes/$maxSelections slots',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color:
                      totalSelectedTimes >= maxSelections
                          ? Colors.orange
                          : null,
                ),
              ),
            ],
          ),
        ),

        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: 2.5,
          ),
          itemCount: sortedTimes.length,
          itemBuilder: (context, index) {
            final t = sortedTimes[index];
            final isSelected = selectedTimes.contains(t);
            final isDisabled =
                !isSelected && totalSelectedTimes >= maxSelections;

            return ElevatedButton(
              onPressed: isDisabled ? null : () => onToggleTime(t),
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    isSelected
                        ? cs.primary
                        : isDisabled
                        ? cs.surface.withOpacity(0.5)
                        : cs.surface,
                foregroundColor:
                    isSelected
                        ? cs.onPrimary
                        : isDisabled
                        ? cs.onSurface.withOpacity(0.5)
                        : cs.onSurface,
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: BorderSide(
                    color:
                        isSelected
                            ? cs.primary.withOpacity(0.6)
                            : isDisabled
                            ? cs.outlineVariant.withOpacity(0.2)
                            : cs.outlineVariant.withOpacity(0.3),
                  ),
                ),
                elevation: isSelected ? 1 : 0,
              ),
              child: Text(
                t,
                style: TextStyle(
                  fontSize: 12,
                  color: isDisabled ? cs.onSurface.withOpacity(0.5) : null,
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  List<String> _getTimeSlotsForPeriod(String period) {
    switch (period.toLowerCase()) {
      case 'morning':
        return ['07:00', '08:00', '09:00', '10:00', '11:00'];
      case 'afternoon':
        return ['12:00', '13:00', '14:00', '15:00', '16:00', '17:00'];
      case 'evening':
        return ['18:00', '19:00', '20:00', '21:00', '22:00', '23:00'];
      default:
        return ['09:00', '10:00', '11:00', '14:00', '15:00', '16:00'];
    }
  }

  int _getDayIndex(String day) {
    final days = {
      'monday': 1,
      'tuesday': 2,
      'wednesday': 3,
      'thursday': 4,
      'friday': 5,
      'saturday': 6,
      'sunday': 7,
    };
    return days[day.toLowerCase()] ?? 1;
  }

  String _formatDateHuman(String iso) {
    final dt = DateTime.tryParse('${iso}T12:00:00'); // ensure parse
    if (dt == null) return iso;
    final dayName =
        [
          'Monday',
          'Tuesday',
          'Wednesday',
          'Thursday',
          'Friday',
          'Saturday',
          'Sunday',
        ][dt.weekday - 1];
    return '$dayName, $iso';
  }
}

// Widget to show summary of all selected appointments
class _SelectedAppointmentsSummary extends StatelessWidget {
  final Map<String, Set<String>> selectedTimesByDate;
  final int maxSelections;
  final ValueChanged<String> onDateTap;
  final ValueChanged<String> onRemoveDate;

  const _SelectedAppointmentsSummary({
    required this.selectedTimesByDate,
    required this.maxSelections,
    required this.onDateTap,
    required this.onRemoveDate,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final totalTimes = selectedTimesByDate.values.fold<int>(
      0,
      (sum, times) => sum + times.length,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Summary header
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: cs.primaryContainer.withOpacity(0.3),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: cs.outlineVariant.withOpacity(0.3)),
          ),
          child: Row(
            children: [
              Icon(Icons.event_available, color: cs.primary, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  '$totalTimes time slots selected across ${selectedTimesByDate.length} dates',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: cs.primary,
                  ),
                ),
              ),
              if (totalTimes >= maxSelections)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.orange.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'MAX',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: Colors.orange.shade700,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 12),

        // List of selected dates and times
        ...selectedTimesByDate.entries.map((entry) {
          final date = entry.key;
          final times = entry.value.toList()..sort();

          return Container(
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: cs.surface.withOpacity(0.8),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: cs.outlineVariant.withOpacity(0.3)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => onDateTap(date),
                        child: Text(
                          _formatDateHuman(date),
                          style: Theme.of(
                            context,
                          ).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: cs.primary,
                          ),
                        ),
                      ),
                    ),
                    Text(
                      '${times.length} slots',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: cs.onSurface.withOpacity(0.7),
                      ),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: () => onRemoveDate(date),
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: cs.errorContainer.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Icon(Icons.close, size: 16, color: cs.error),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 6,
                  runSpacing: 4,
                  children:
                      times
                          .map(
                            (time) => Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: cs.secondaryContainer.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: cs.outlineVariant.withOpacity(0.3),
                                ),
                              ),
                              child: Text(
                                time,
                                style: Theme.of(context).textTheme.bodySmall
                                    ?.copyWith(fontWeight: FontWeight.w600),
                              ),
                            ),
                          )
                          .toList(),
                ),
              ],
            ),
          );
        }).toList(),
      ],
    );
  }

  String _formatDateHuman(String iso) {
    final dt = DateTime.tryParse('${iso}T12:00:00'); // ensure parse
    if (dt == null) return iso;
    final dayName =
        [
          'Monday',
          'Tuesday',
          'Wednesday',
          'Thursday',
          'Friday',
          'Saturday',
          'Sunday',
        ][dt.weekday - 1];
    return '$dayName, $iso';
  }
}
