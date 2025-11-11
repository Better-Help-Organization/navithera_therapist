import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:navicare/core/constants/base_url.dart';
import 'package:navicare/core/theme/app_colors.dart';
import 'package:navicare/core/theme/app_typography.dart';
import 'package:navicare/core/util/avatar_util.dart';
import 'package:navicare/core/util/greeting.dart';
import 'package:navicare/feature/auth/presentation/providers/user_provider.dart';
import "package:flutter_gen/gen_l10n/app_localization.dart";
import 'package:navicare/feature/notification/presentation/pages/notification_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fl_chart/fl_chart.dart';

final notificationCountProvider =
    StateNotifierProvider<NotificationCountNotifier, int>((ref) {
      return NotificationCountNotifier();
    });

class NotificationCountNotifier extends StateNotifier<int> {
  NotificationCountNotifier() : super(0);

  void setCount(int count) => state = count;
  void reset() => state = 0;
  void increment() => state = state + 1;
  void decrement() => state = state > 0 ? state - 1 : 0;
}

final notificationServiceProvider = Provider<NotificationService>((ref) {
  return NotificationService();
});

class NotificationService {
  final Dio _dio = Dio();

  NotificationService() {
    _dio.options.connectTimeout = const Duration(seconds: 20);
    _dio.options.receiveTimeout = const Duration(seconds: 20);
  }

  Future<void> _attachAuthHeader() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final accessToken = sharedPreferences.getString('access_token');
    if (accessToken != null && accessToken.isNotEmpty) {
      _dio.options.headers['Authorization'] = 'Bearer $accessToken';
    } else {
      _dio.options.headers.remove('Authorization');
    }
  }

  Future<int?> fetchUnreadCount() async {
    try {
      await _attachAuthHeader();

      final response = await _dio.get(
        '${base_url_dev}/therapist/me/notifications',
      );

      if (response.statusCode == 200) {
        final data = response.data;
        if (data is Map && data.containsKey('unreadCount')) {
          return data['unreadCount'] as int;
        }
      }
      return 0;
    } catch (e) {
      log("Error fetching unread count: $e");
      return 0;
    }
  }
}

// Service Provider
// Service Provider
final sessionServiceProvider = Provider<SessionService>((ref) {
  return SessionService();
});

class SessionService {
  final Dio _dio = Dio();

  SessionService() {
    _dio.options.connectTimeout = const Duration(seconds: 20);
    _dio.options.receiveTimeout = const Duration(seconds: 20);
  }

  Future<void> _attachAuthHeader() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final accessToken = sharedPreferences.getString('access_token');
    if (accessToken != null && accessToken.isNotEmpty) {
      _dio.options.headers['Authorization'] = 'Bearer $accessToken';
    } else {
      _dio.options.headers.remove('Authorization');
    }
  }

  Future<int?> fetchSessions() async {
    try {
      await _attachAuthHeader();
      final response = await _dio.get('${base_url_dev}/therapist/me/sessions');
      if (response.statusCode == 200) {
        final data = response.data;
        final pagination = data['pagination'] as Map<String, dynamic>?;
        if (pagination != null) {
          final totalItems = pagination['totalItems'];
          if (totalItems is int) return totalItems;
          if (totalItems is String) return int.tryParse(totalItems);
        }
      }
      return null;
    } catch (e) {
      log("Error fetching sessions: $e");
      return null;
    }
  }

  Future<Map<String, dynamic>?> fetchStats(
    DateTime startDate,
    DateTime endDate,
  ) async {
    try {
      await _attachAuthHeader();

      final DateFormat formatter = DateFormat('yyyy-MM-dd');
      final String start = formatter.format(startDate);
      final String end = formatter.format(endDate);

      print("start: ${start}, end: ${end}");

      final response = await _dio.get(
        '${base_url_dev}/therapist/stats',
        queryParameters: {'startDate': start, 'endDate': end},
      );

      if (response.statusCode == 200) {
        print("Stats Response: ${response.data}");
        return response.data;
      }
      return null;
    } catch (e) {
      log("Error fetching stats: $e");
      return null;
    }
  }
}

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int? totalSessions;
  int? totalRevenue;
  double? totalHours;
  int? totalUsers;
  bool _isLoadingSessions = false;
  bool _isLoadingCharts = false;
  List<FlSpot>? _clientSpots;
  List<FlSpot>? _sessionSpots;

  final NumberFormat _currency = NumberFormat.currency(
    locale: 'en_US',
    symbol: 'ETB ',
    decimalDigits: 0,
  );

  @override
  void initState() {
    super.initState();
    _loadSession();
    _loadChartData();
    _loadUnreadCount();
  }

  Future<void> _loadUnreadCount() async {
    final notificationService = ref.read(notificationServiceProvider);
    final unreadCount = await notificationService.fetchUnreadCount();

    if (mounted) {
      ref.read(notificationCountProvider.notifier).setCount(unreadCount ?? 0);
    }
  }

  DateTime _getMondayOfWeek(DateTime date) {
    return date.subtract(Duration(days: date.weekday - 1));
  }

  // Helper method to generate all days of the week from Monday to Sunday
  List<DateTime> _getWeekDays(DateTime monday) {
    return List.generate(7, (index) => monday.add(Duration(days: index)));
  }

  // Future<void> _loadSession() async {
  //   setState(() {
  //     _isLoadingSessions = true;
  //   });

  //   final sessionService = ref.read(sessionServiceProvider);

  //   // Fetch this week's stats for all calculations
  //   final now = DateTime.now();
  //   final monday = _getMondayOfWeek(now);
  //   final sunday = monday.add(const Duration(days: 6));
  //   final statsData = await sessionService.fetchStats(monday, sunday);

  //   int weeklySessions = 0;
  //   int weeklyRevenue = 0;
  //   int weeklyUsers = 0;

  //   if (statsData != null && statsData['data'] != null) {
  //     final data = statsData['data'] as Map<String, dynamic>;

  //     print("dataxoxo: ${data}");

  //     weeklySessions = data['totalSessions'];

  //     // Calculate total revenue from revenueOverTime
  //     final revenueOverTime = data['revenueOverTime'] as List<dynamic>? ?? [];
  //     for (var revenue in revenueOverTime) {
  //       final revenueValue = revenue['revenue'];
  //       if (revenueValue != null) {
  //         weeklyRevenue += int.tryParse(revenueValue.toString()) ?? 0;
  //       }
  //     }
  //     // weeklyRevenue = data['total']

  //     // Calculate total users from usersTreatedOverTime
  //     final usersTreatedOverTime =
  //         data['usersTreatedOverTime'] as List<dynamic>? ?? [];
  //     for (var user in usersTreatedOverTime) {
  //       final count =
  //           int.tryParse(user['treatedUsers']?.toString() ?? '0') ?? 0;
  //       weeklyUsers += count;
  //     }

  //     // Also check therapistWorkload as a fallback for total users
  //     final therapistWorkload =
  //         data['therapistWorkload'] as List<dynamic>? ?? [];
  //     if (weeklyUsers == 0 && therapistWorkload.isNotEmpty) {
  //       weeklyUsers =
  //           int.tryParse(
  //             therapistWorkload[0]['sessionCount']?.toString() ?? '0',
  //           ) ??
  //           0;
  //     }

  //     weeklyUsers = data['totalUsers'];
  //   }

  //   // Fallback to session count if no stats data available
  //   if (weeklySessions == 0) {
  //     final count = await sessionService.fetchSessions();
  //     weeklySessions = count ?? 0;
  //   }

  //   // Calculate total hours (45 minutes per session)
  //   final totalMinutes = weeklySessions * 60;
  //   final totalHours = (totalMinutes / 60).toStringAsFixed(
  //     1,
  //   ); // Keep 1 decimal place

  //   setState(() {
  //     totalSessions = weeklySessions;
  //     totalRevenue = weeklyRevenue; // Use actual API data
  //     this.totalHours = double.parse(
  //       totalHours,
  //     ); // Store as double for decimal values
  //     totalUsers = weeklyUsers; // fallback to 128 if no users data

  //     _isLoadingSessions = false;
  //   });
  // } //     _isLoadingCharts = true;
  // //   });

  Future<void> _loadSession() async {
    setState(() {
      _isLoadingSessions = true;
    });

    final sessionService = ref.read(sessionServiceProvider);

    // Fetch this week's stats for all calculations
    final now = DateTime.now();
    final monday = _getMondayOfWeek(now);
    final sunday = monday.add(const Duration(days: 6));
    final statsData = await sessionService.fetchStats(monday, sunday);

    int weeklySessions = 0;
    int weeklyRevenue = 0;
    int weeklyUsers = 0;
    double weeklyHours = 0.0; // Add this variable

    if (statsData != null && statsData['data'] != null) {
      final data = statsData['data'] as Map<String, dynamic>;

      print("dataxoxo: ${data}");

      weeklySessions = data['totalSessions'] ?? 0;
      weeklyHours =
          (data['totalHours'] ?? 0.0).toDouble(); // Get hours from API

      // Calculate total revenue from revenueOverTime
      final revenueOverTime = data['revenueOverTime'] as List<dynamic>? ?? [];
      for (var revenue in revenueOverTime) {
        final revenueValue = revenue['revenue'];
        if (revenueValue != null) {
          weeklyRevenue += int.tryParse(revenueValue.toString()) ?? 0;
        }
      }

      // Calculate total users from usersTreatedOverTime
      final usersTreatedOverTime =
          data['usersTreatedOverTime'] as List<dynamic>? ?? [];
      for (var user in usersTreatedOverTime) {
        final count =
            int.tryParse(user['treatedUsers']?.toString() ?? '0') ?? 0;
        weeklyUsers += count;
      }

      // Also check therapistWorkload as a fallback for total users
      final therapistWorkload =
          data['therapistWorkload'] as List<dynamic>? ?? [];
      if (weeklyUsers == 0 && therapistWorkload.isNotEmpty) {
        weeklyUsers =
            int.tryParse(
              therapistWorkload[0]['sessionCount']?.toString() ?? '0',
            ) ??
            0;
      }

      weeklyUsers = data['totalUsers'] ?? weeklyUsers;
    }

    // Fallback to session count if no stats data available
    if (weeklySessions == 0) {
      final count = await sessionService.fetchSessions();
      weeklySessions = count ?? 0;
    }

    // Remove the manual hours calculation since we get it from API now
    // final totalMinutes = weeklySessions * 60;
    // final totalHours = (totalMinutes / 60).toStringAsFixed(1);

    setState(() {
      totalSessions = weeklySessions;
      totalRevenue = weeklyRevenue;
      totalHours = weeklyHours; // Use the value from API directly
      totalUsers = weeklyUsers;

      _isLoadingSessions = false;
    });
  }

  Widget _buildNotificationIcon() {
    final unreadCount = ref.watch(notificationCountProvider);

    return GestureDetector(
      onTap: () {
        // Reset count to 0 when clicked
        ref.read(notificationCountProvider.notifier).reset();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const NotificationScreen()),
        );
      },
      child: Stack(
        children: [
          const Icon(Icons.notifications_outlined, size: 24),
          if (unreadCount > 0)
            Positioned(
              right: 0,
              top: 0,
              child: Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(8),
                ),
                constraints: const BoxConstraints(minWidth: 12, minHeight: 12),
                child: Text(
                  unreadCount > 99 ? '99+' : unreadCount.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 8,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Future<void> _loadChartData() async {
    setState(() {
      _isLoadingCharts = true;
    });

    final sessionService = ref.read(sessionServiceProvider);
    final now = DateTime.now();
    final monday = _getMondayOfWeek(now);
    final sunday = monday.add(const Duration(days: 6));

    final statsData = await sessionService.fetchStats(monday, sunday);

    if (statsData != null && statsData['data'] != null) {
      final data = statsData['data'] as Map<String, dynamic>;

      // Process sessions over time
      final sessionsOverTime = data['sessionsOverTime'] as List<dynamic>? ?? [];
      print("sessionsOverTime: $sessionsOverTime");
      final usersTreatedOverTime =
          data['usersTreatedOverTime'] as List<dynamic>? ?? [];

      final weekDays = _getWeekDays(monday);
      final DateFormat formatter = DateFormat('yyyy-MM-dd');

      // Create session data for the week
      final sessionData = List<int>.filled(7, 0);
      final clientData = List<int>.filled(7, 0);

      for (var session in sessionsOverTime) {
        final dateStr = session['date'] as String?;
        if (dateStr != null) {
          final date = DateTime.parse(dateStr);
          final dayIndex = weekDays.indexWhere(
            (day) => formatter.format(day) == formatter.format(date),
          );
          if (dayIndex != -1) {
            final count =
                int.tryParse(session['count']?.toString() ?? '0') ?? 0;
            sessionData[dayIndex] = count;
          }
        }
      }

      for (var user in usersTreatedOverTime) {
        final dateStr = user['date'] as String?;
        if (dateStr != null) {
          final date = DateTime.parse(dateStr);
          final dayIndex = weekDays.indexWhere(
            (day) => formatter.format(day) == formatter.format(date),
          );
          if (dayIndex != -1) {
            final count =
                int.tryParse(user['treatedUsers']?.toString() ?? '0') ?? 0;
            clientData[dayIndex] = count;
          }
        }
      }

      setState(() {
        _sessionSpots = List.generate(
          7,
          (index) => FlSpot(index.toDouble(), sessionData[index].toDouble()),
        );
        _clientSpots = List.generate(
          7,
          (index) => FlSpot(index.toDouble(), clientData[index].toDouble()),
        );
        _isLoadingCharts = false;
      });
    } else {
      // Fallback to dummy data if API fails
      final clientData = [3, 2, 4, 5, 7, 6, 4];
      final sessionData = [0, 0, 0, 0, 0, 0, 0];

      setState(() {
        _clientSpots = List.generate(
          7,
          (index) => FlSpot(index.toDouble(), clientData[index].toDouble()),
        );
        _sessionSpots = List.generate(
          7,
          (index) => FlSpot(index.toDouble(), sessionData[index].toDouble()),
        );
        _isLoadingCharts = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(currentUserProvider);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Colors.white,
      body: RefreshIndicator(
        onRefresh: () async {
          await _loadSession();
          await _loadChartData();
          await _loadUnreadCount();
        },
        color: AppColors.primary,
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header (unchanged)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(25),
                            child:
                                (user?.avatar == 7) &&
                                        (user?.profile != null &&
                                            user!.profile!.isNotEmpty)
                                    ? Image(
                                      image: NetworkImage(
                                        '${base_url_for_image}${user.profile}?v=${DateTime.now().millisecondsSinceEpoch}',
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
                                            getAvatarImage(user.avatar ?? 0),
                                          ),
                                          width: 50,
                                          height: 50,
                                        );
                                      },
                                    )
                                    : Image.asset(
                                      getAvatarImage(user?.avatar ?? 0),
                                      width: 50,
                                      height: 50,
                                      fit: BoxFit.cover,
                                    ),
                          ),
                          const SizedBox(width: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                getTimeBasedGreeting(context),
                                style: AppTypography.bodySmall.copyWith(
                                  color: Colors.grey,
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    user?.firstName ?? "",
                                    style: AppTypography.heading2,
                                  ),
                                  const SizedBox(width: 4),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(width: 8),
                          _buildNotificationIcon(),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // First row: Total Sessions and Total Users
                  _FirstRowSection(
                    isLoading: _isLoadingSessions,
                    totalSessions: totalSessions ?? 0,
                    totalUsers: totalUsers ?? 0,
                  ),

                  const SizedBox(height: 20),

                  // Second row: Hours this week and Revenue/week
                  _SecondRowSection(
                    isLoading: _isLoadingSessions,
                    totalHours: totalHours ?? 0.0,
                    totalRevenueFormatted: _currency.format(totalRevenue ?? 0),
                  ),

                  const SizedBox(height: 20),

                  // Charts Section (unchanged)
                  Text('Weekly Analytics'),
                  const SizedBox(height: 12),

                  _isLoadingCharts
                      ? const _ChartSkeleton()
                      : Column(
                        children: [
                          _ModernLineChartCard(
                            title: 'Sessions This Week',
                            spots: _sessionSpots ?? const [],
                            color: AppColors.primary,
                            backgroundTint: Colors.white,
                          ),
                        ],
                      ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _FirstRowSection extends StatelessWidget {
  final bool isLoading;
  final int totalSessions;
  final int totalUsers;

  const _FirstRowSection({
    Key? key,
    required this.isLoading,
    required this.totalSessions,
    required this.totalUsers,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isNarrow = constraints.maxWidth < 380;
        return Row(
          children: [
            Expanded(
              child:
                  isLoading
                      ? const _MetricSkeleton()
                      : _MetricCard(
                        title: 'Total Sessions',
                        value: '$totalSessions',
                        icon: Icons.event_available,
                        gradient: LinearGradient(
                          colors: [
                            AppColors.primary.withOpacity(0.15),
                            AppColors.primary.withOpacity(0.05),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        accentColor: AppColors.primary,
                      ),
            ),
            SizedBox(width: isNarrow ? 8 : 12),
            Expanded(
              child:
                  isLoading
                      ? const _MetricSkeleton()
                      : _MetricCard(
                        title: 'Total Users',
                        value: '$totalUsers',
                        icon: Icons.group_rounded,
                        gradient: LinearGradient(
                          colors: [
                            AppColors.primary.withOpacity(0.15),
                            AppColors.primary.withOpacity(0.05),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        accentColor: AppColors.primary,
                      ),
            ),
          ],
        );
      },
    );
  }
}

// New section for the second row: Hours this week and Revenue/week
class _SecondRowSection extends StatelessWidget {
  final bool isLoading;
  final double totalHours; // Changed from int to double
  final String totalRevenueFormatted;

  const _SecondRowSection({
    Key? key,
    required this.isLoading,
    required this.totalHours,
    required this.totalRevenueFormatted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isNarrow = constraints.maxWidth < 380;
        return Row(
          children: [
            Expanded(
              child:
                  isLoading
                      ? const _MetricSkeleton()
                      : _MetricCard(
                        title: 'Hours this week',
                        value:
                            '${totalHours.toStringAsFixed(1)} h', // Show 1 decimal place
                        icon: Icons.access_time_filled_rounded,
                        gradient: LinearGradient(
                          colors: [
                            AppColors.primary.withOpacity(0.15),
                            AppColors.primary.withOpacity(0.05),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        accentColor: AppColors.primary,
                      ),
            ),
            SizedBox(width: isNarrow ? 8 : 12),
            Expanded(
              child:
                  isLoading
                      ? const _MetricSkeleton()
                      : _MetricCard(
                        title: 'Revenue/week',
                        value: totalRevenueFormatted,
                        icon: Icons.payments_rounded,
                        gradient: LinearGradient(
                          colors: [
                            AppColors.primary.withOpacity(0.15),
                            AppColors.primary.withOpacity(0.05),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        accentColor: AppColors.primary,
                      ),
            ),
          ],
        );
      },
    );
  }
}

class _MiniMetricCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color accentColor;
  final Gradient gradient;

  const _MiniMetricCard({
    Key? key,
    required this.title,
    required this.value,
    required this.icon,
    required this.accentColor,
    required this.gradient,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.black12.withOpacity(0.05)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: accentColor.withOpacity(0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: accentColor, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.bodySmall?.copyWith(
                    color: Colors.grey.shade700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MiniMetricSkeleton extends StatelessWidget {
  const _MiniMetricSkeleton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.black12.withOpacity(0.05)),
      ),
      padding: const EdgeInsets.all(14),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 10,
                  width: 90,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  height: 14,
                  width: 110,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MetricCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Gradient gradient;
  final Color accentColor;

  const _MetricCard({
    Key? key,
    required this.title,
    required this.value,
    required this.icon,
    required this.gradient,
    required this.accentColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = AppTypography;
    return Container(
      height: 100,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.black12.withOpacity(0.05)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: accentColor.withOpacity(0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: accentColor, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(title, maxLines: 2, overflow: TextOverflow.visible),
                const SizedBox(height: 4),
                Text(value, maxLines: 1, overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MetricSkeleton extends StatelessWidget {
  const _MetricSkeleton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.black12.withOpacity(0.05)),
      ),
      padding: const EdgeInsets.all(14),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 10,
                  width: 100,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  height: 14,
                  width: 140,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ModernLineChartCard extends StatelessWidget {
  final String title;
  final List<FlSpot> spots;
  final Color color;
  final Color backgroundTint;

  const _ModernLineChartCard({
    Key? key,
    required this.title,
    required this.spots,
    required this.color,
    required this.backgroundTint,
  }) : super(key: key);

  double _maxY(List<FlSpot> s) {
    if (s.isEmpty) return 10;
    final max = s.map((e) => e.y).reduce((a, b) => a > b ? a : b);
    return (max + 2).clamp(6, 1000).toDouble();
  }

  @override
  Widget build(BuildContext context) {
    final effectiveSpots =
        spots.isEmpty
            ? List.generate(7, (i) => FlSpot(i.toDouble(), 0))
            : spots;
    final maxY = _maxY(effectiveSpots);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            backgroundTint.withOpacity(0.06),
            backgroundTint.withOpacity(0.02),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.black12.withOpacity(0.05)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Text(
            title,
            // Keep original font sizes (no explicit sizing override)
            style: AppTypography.bodyLarge?.copyWith(
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 12),

          // Chart
          SizedBox(
            height: 150,
            child: LineChart(
              LineChartData(
                backgroundColor: Colors.transparent,
                minX: 0,
                maxX: 6,
                minY: 0,
                maxY: maxY,
                lineTouchData: LineTouchData(
                  handleBuiltInTouches: true,
                  touchTooltipData: LineTouchTooltipData(
                    // tooltipBgColor: Colors.black87,
                    // tooltipRoundedRadius: 10,
                    tooltipPadding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    getTooltipItems: (touchedSpots) {
                      return touchedSpots.map((ts) {
                        return LineTooltipItem(
                          '${_weekday(ts.x)}\n${ts.y.toInt()}',
                          TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                        );
                      }).toList();
                    },
                  ),
                ),
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: true,
                  horizontalInterval: (maxY / 3).clamp(2, 20),
                  verticalInterval: 1,
                  getDrawingHorizontalLine: (value) {
                    return FlLine(color: Colors.grey.shade300, strokeWidth: 1);
                  },
                  getDrawingVerticalLine: (value) {
                    return FlLine(color: Colors.grey.shade300, strokeWidth: 1);
                  },
                ),
                titlesData: FlTitlesData(
                  show: true,
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 30,
                      interval: 1,
                      getTitlesWidget: (double value, TitleMeta meta) {
                        const weekDays = [
                          'Mon',
                          'Tue',
                          'Wed',
                          'Thu',
                          'Fri',
                          'Sat',
                          'Sun',
                        ];
                        final index = value.toInt();
                        if (index >= 0 && index < weekDays.length) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              weekDays[index],
                              style: AppTypography.bodySmall?.copyWith(
                                color: Colors.grey.shade600,
                                fontSize: 10, // same as before
                              ),
                            ),
                          );
                        }
                        return const Text('');
                      },
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: (maxY / 3).clamp(2, 20),
                      reservedSize: 40,
                      getTitlesWidget: (double value, TitleMeta meta) {
                        return Text(
                          value.toInt().toString(),
                          style: AppTypography.bodySmall?.copyWith(
                            color: Colors.grey.shade600,
                            fontSize: 10, // same as before
                          ),
                        );
                      },
                    ),
                  ),
                ),
                borderData: FlBorderData(
                  show: true,
                  border: Border.all(color: Colors.grey.shade300, width: 1),
                ),
                lineBarsData: [
                  LineChartBarData(
                    spots: effectiveSpots,
                    isCurved: true,
                    curveSmoothness: 0.32,
                    color: color,
                    barWidth: 3,
                    isStrokeCapRound: true,
                    dotData: FlDotData(
                      show: true,
                      getDotPainter:
                          (spot, percent, barData, index) => FlDotCirclePainter(
                            radius: 3.5,
                            color: Colors.white,
                            strokeWidth: 2.2,
                            strokeColor: color,
                          ),
                    ),
                    belowBarData: BarAreaData(
                      show: true,
                      gradient: LinearGradient(
                        colors: [
                          color.withOpacity(0.22),
                          color.withOpacity(0.08),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                ],
              ),
              // swapAnimationDuration: const Duration(milliseconds: 900),
              //swapAnimationCurve: Curves.easeOutCubic,
            ),
          ),
        ],
      ),
    );
  }

  static String _weekday(double x) {
    const weekDays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    final i = x.toInt();
    if (i >= 0 && i < weekDays.length) return weekDays[i];
    return '';
  }
}

class _ChartSkeleton extends StatelessWidget {
  const _ChartSkeleton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget card() => Container(
      height: 200,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.black12.withOpacity(0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 16,
            width: 150,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );

    return Column(children: [card(), const SizedBox(height: 16), card()]);
  }
}
