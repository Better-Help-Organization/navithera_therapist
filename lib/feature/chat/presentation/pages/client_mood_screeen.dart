import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:navicare/core/constants/base_url.dart';
import 'package:navicare/core/theme/app_colors.dart';
import 'package:navicare/main.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Provider for mood data
final moodProvider =
    StateNotifierProvider<MoodNotifier, AsyncValue<List<MoodEntry>>>((ref) {
      return MoodNotifier();
    });

class MoodNotifier extends StateNotifier<AsyncValue<List<MoodEntry>>> {
  MoodNotifier() : super(const AsyncValue.loading());

  final Dio _dio = Dio();

  Future<void> loadMoods(String clientId) async {
    state = const AsyncValue.loading();

    try {
      await _attachAuthHeader();
      final response = await _dio
          .get('${base_url_dev}/mood?filters=client.id%3D$clientId&take=100')
          .timeout(const Duration(seconds: 30));

      if (response.data != null && response.data['data'] != null) {
        final moodsData = (response.data['data'] as List);
        final moods = moodsData.map((e) => MoodEntry.fromMap(e)).toList();
        state = AsyncValue.data(moods);
      } else {
        state = AsyncValue.data([]);
      }
    } catch (e, stackTrace) {
      print('Error loading moods: $e');
      state = AsyncValue.error(e, stackTrace);
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

class MoodEntry {
  final String id;
  final DateTime createdAt;
  final String mood;
  final String? notes;
  final Client client;

  MoodEntry({
    required this.id,
    required this.createdAt,
    required this.mood,
    this.notes,
    required this.client,
  });

  factory MoodEntry.fromMap(Map<String, dynamic> map) {
    return MoodEntry(
      id: map['id']?.toString() ?? '',
      createdAt: DateTime.parse(map['createdAt']?.toString() ?? ''),
      mood: map['mood']?.toString() ?? 'neutral',
      notes: map['notes']?.toString(),
      client: Client.fromMap(map['client'] as Map<String, dynamic>),
    );
  }
}

class Client {
  final String id;
  final String name;

  Client({required this.id, required this.name});

  factory Client.fromMap(Map<String, dynamic> map) {
    return Client(
      id: map['id']?.toString() ?? '',
      name: map['name']?.toString() ?? '',
    );
  }
}

class MoodCalendarScreen extends StatefulWidget {
  final String clientId;
  final String clientName;

  const MoodCalendarScreen({
    super.key,
    required this.clientId,
    required this.clientName,
  });

  @override
  State<MoodCalendarScreen> createState() => _MoodCalendarScreenState();
}

class _MoodCalendarScreenState extends State<MoodCalendarScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;

    // Load moods using provider
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final context = navigatorKey.currentContext;
      if (context != null) {
        final ref = ProviderScope.containerOf(context);
        ref.read(moodProvider.notifier).loadMoods(widget.clientId);
      }
    });
  }

  String _getMoodEmoji(String mood) {
    switch (mood) {
      case 'happy':
        return '😊';
      case 'sad':
        return '😢';
      case 'angry':
        return '😠';
      case 'anxious':
        return '😰';
      case 'tired':
        return '😴';
      case 'excited':
        return '🤩';
      default:
        return '😐'; // neutral
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final moodAsync = ref.watch(moodProvider);

        return moodAsync.when(
          loading:
              () => Scaffold(
                backgroundColor: Colors.white,
                appBar: AppBar(
                  surfaceTintColor: Colors.transparent,
                  backgroundColor: Colors.white,
                  title: Text(
                    '${widget.clientName}\'s Mood Calendar',
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  centerTitle: true,
                  elevation: 0,
                ),
                body: const Center(child: CircularProgressIndicator()),
              ),
          error:
              (error, stackTrace) => Scaffold(
                backgroundColor: Colors.white,
                appBar: AppBar(
                  surfaceTintColor: Colors.transparent,
                  backgroundColor: Colors.white,
                  title: Text(
                    '${widget.clientName}\'s Mood Calendar',
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  centerTitle: true,
                  elevation: 0,
                ),
                body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.error_outline,
                        size: 64,
                        color: Colors.red,
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Failed to load moods',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        error.toString(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed:
                            () => ref
                                .read(moodProvider.notifier)
                                .loadMoods(widget.clientId),
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                ),
              ),
          data: (moods) {
            return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                surfaceTintColor: Colors.transparent,
                backgroundColor: Colors.white,
                title: Text(
                  '${widget.clientName}\'s Mood Calendar',
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                centerTitle: true,
                elevation: 0,
              ),
              body: RefreshIndicator(
                onRefresh:
                    () => ref
                        .read(moodProvider.notifier)
                        .loadMoods(widget.clientId),
                child: ListView(
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
                        child: TableCalendar<MoodEntry>(
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
                          eventLoader: (day) => _getMoodsForDay(day, moods),
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
                              color: AppColors.primary.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: AppColors.primary),
                            ),
                            todayDecoration: BoxDecoration(
                              color: AppColors.primary.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: AppColors.primary.withOpacity(0.3),
                              ),
                            ),
                            markerDecoration: const BoxDecoration(
                              color: Colors.transparent,
                            ),
                            defaultTextStyle: const TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.w500,
                            ),
                            weekendTextStyle: const TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.w500,
                            ),
                            selectedTextStyle: TextStyle(
                              color: AppColors.primary,
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
                            defaultBuilder: (context, date, _) {
                              final dayMoods = _getMoodsForDay(date, moods);
                              return Container(
                                margin: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                alignment: Alignment.center,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '${date.day}',
                                      style: TextStyle(
                                        color: Colors.black87,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    if (dayMoods.isNotEmpty)
                                      Text(
                                        _getMoodEmoji(dayMoods.first.mood),
                                        style: const TextStyle(fontSize: 12),
                                      ),
                                  ],
                                ),
                              );
                            },
                            todayBuilder: (context, date, _) {
                              final dayMoods = _getMoodsForDay(date, moods);
                              return Container(
                                margin: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: AppColors.primary.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: AppColors.primary.withOpacity(0.3),
                                  ),
                                ),
                                alignment: Alignment.center,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '${date.day}',
                                      style: TextStyle(
                                        color: AppColors.primary,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    if (dayMoods.isNotEmpty)
                                      Text(
                                        _getMoodEmoji(dayMoods.first.mood),
                                        style: const TextStyle(fontSize: 12),
                                      ),
                                  ],
                                ),
                              );
                            },
                            selectedBuilder: (context, date, _) {
                              final dayMoods = _getMoodsForDay(date, moods);
                              return Container(
                                margin: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: AppColors.primary.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: AppColors.primary),
                                ),
                                alignment: Alignment.center,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '${date.day}',
                                      style: TextStyle(
                                        color: AppColors.primary,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    if (dayMoods.isNotEmpty)
                                      Text(
                                        _getMoodEmoji(dayMoods.first.mood),
                                        style: const TextStyle(fontSize: 12),
                                      ),
                                  ],
                                ),
                              );
                            },
                          ),
                          onDaySelected: (selectedDay, focusedDay) {
                            setState(() {
                              _selectedDay = selectedDay;
                              _focusedDay = focusedDay;
                            });
                          },
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

                    const SizedBox(height: 16),

                    // Selected day mood details
                    if (_selectedDay != null)
                      _buildSelectedDayMoodDetails(_selectedDay!, moods),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  List<MoodEntry> _getMoodsForDay(DateTime day, List<MoodEntry> moods) {
    return moods.where((mood) {
      final localDate = mood.createdAt.toLocal();
      return isSameDay(localDate, day);
    }).toList();
  }

  Widget _buildSelectedDayMoodDetails(DateTime day, List<MoodEntry> moods) {
    final dayMoods = _getMoodsForDay(day, moods);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _formatDate(day),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),

              if (dayMoods.isEmpty)
                const Center(
                  child: Text(
                    'No mood recorded for this day',
                    style: TextStyle(color: Colors.grey),
                  ),
                )
              else
                ...dayMoods.map((mood) => _buildMoodDetail(mood)).toList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMoodDetail(MoodEntry mood) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              _getMoodEmoji(mood.mood),
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(width: 12),
            Text(
              mood.mood.toUpperCase(),
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.darkCyan,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        if (mood.notes != null && mood.notes!.isNotEmpty)
          Text(mood.notes!, style: const TextStyle(fontSize: 14)),
        const SizedBox(height: 16),
        Text(
          'Recorded at ${_formatTime(mood.createdAt.toLocal())}',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
      ],
    );
  }

  String _formatDate(DateTime date) {
    final localTime = date.toLocal();
    return '${localTime.day} ${_getMonthName(localTime.month)} ${localTime.year}';
  }

  String _formatTime(DateTime date) {
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
}
