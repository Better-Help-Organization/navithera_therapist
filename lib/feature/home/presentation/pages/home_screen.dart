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
//import "package:flutter_gen/gen_l10n/app_localizations.dart";
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:navicare/feature/notification/presentation/pages/notification_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:navicare/feature/home/presentation/providers/chart_data_provider.dart';

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

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final NumberFormat _currency = NumberFormat.currency(
    locale: 'en_US',
    symbol: 'ETB ',
    decimalDigits: 0,
  );

  @override
  void initState() {
    super.initState();
    _loadUnreadCount();
    // Load chart data using provider
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(chartDataProvider.notifier).load();
    });
  }

  Future<void> _loadUnreadCount() async {
    final notificationService = ref.read(notificationServiceProvider);
    final unreadCount = await notificationService.fetchUnreadCount();

    if (mounted) {
      ref.read(notificationCountProvider.notifier).setCount(unreadCount ?? 0);
    }
  }

  Future<void> _refreshAll() async {
    await _loadUnreadCount();
    // Refresh chart data using provider
    ref.read(chartDataProvider.notifier).load();
  }

  Widget _buildNotificationIcon() {
    final unreadCount = ref.watch(notificationCountProvider);

    return GestureDetector(
      onTap: () {
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

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(currentUserProvider);
    final chartState = ref.watch(chartDataProvider);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Colors.white,
      body: RefreshIndicator(
        onRefresh: _refreshAll,
        color: AppColors.primary,
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
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
                          const SizedBox(width: 8),
                          _buildNotificationIcon(),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Stats Section using provider
                  _buildStatsSection(chartState),

                  const SizedBox(height: 20),

                  // Charts Section using provider
                  _buildChartsSection(chartState),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatsSection(ChartDataState chartState) {
    return switch (chartState) {
      ChartDataInitial() => const _StatsSkeleton(),
      ChartDataLoading() => const _StatsSkeleton(),
      ChartDataError(:final failure) => _InfoBanner(
        icon: Icons.error_outline,
        text: failure.message,
        color: Colors.red,
      ),
      ChartDataLoaded(:final weeklyStats) => Column(
        children: [
          // First row: Total Sessions and Total Users
          _FirstRowSection(
            totalSessions: weeklyStats.totalSessions,
            totalUsers: weeklyStats.totalUsers,
          ),
          const SizedBox(height: 20),
          // Second row: Hours this week and Revenue/week
          _SecondRowSection(
            totalHours: weeklyStats.totalHours,
            totalRevenueFormatted: _currency.format(weeklyStats.totalRevenue),
          ),
        ],
      ),
      // TODO: Handle this case.
      ChartDataState() => throw UnimplementedError(),
    };
  }

  Widget _buildChartsSection(ChartDataState chartState) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Weekly Analytics', style: AppTypography.heading2),
        const SizedBox(height: 12),
        switch (chartState) {
          ChartDataInitial() => const _ChartSkeleton(),
          ChartDataLoading() => const _ChartSkeleton(),
          ChartDataError(:final failure) => _InfoBanner(
            icon: Icons.error_outline,
            text: failure.message,
            color: Colors.red,
          ),
          ChartDataLoaded(:final weeklyStats) => Column(
            children: [
              _ModernLineChartCard(
                title: 'Sessions This Week',
                spots: weeklyStats.chartData.sessionSpots,
                color: AppColors.primary,
                backgroundTint: Colors.white,
              ),
              //  const SizedBox(height: 16),
              // _ModernLineChartCard(
              //   title: 'Clients This Week',
              //   spots: weeklyStats.chartData.clientSpots,
              //   color: Colors.orange,
              //   backgroundTint: Colors.white,
              // ),
            ],
          ),
          // TODO: Handle this case.
          ChartDataState() => throw UnimplementedError(),
        },
      ],
    );
  }
}

class _FirstRowSection extends StatelessWidget {
  final int totalSessions;
  final int totalUsers;

  const _FirstRowSection({
    Key? key,
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
              child: _MetricCard(
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
              child: _MetricCard(
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

class _SecondRowSection extends StatelessWidget {
  final double totalHours;
  final String totalRevenueFormatted;

  const _SecondRowSection({
    Key? key,
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
              child: _MetricCard(
                title: 'Hours this week',
                value: '${totalHours.toStringAsFixed(2)} h',
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
              child: _MetricCard(
                title: 'Revenue per week',
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
                Text(
                  title,
                  style: AppTypography.bodySmall?.copyWith(
                    color: Colors.grey.shade700,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                    fontSize: 16,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
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
                    tooltipPadding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    getTooltipItems: (touchedSpots) {
                      return touchedSpots.map((ts) {
                        return LineTooltipItem(
                          '${_weekday(ts.x)}\n${ts.y.toInt()}',
                          const TextStyle(
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
                                fontSize: 10,
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
                            fontSize: 10,
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

// Skeleton and Helper Widgets
class _StatsSkeleton extends StatelessWidget {
  const _StatsSkeleton();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: _MetricSkeleton()),
            const SizedBox(width: 12),
            Expanded(child: _MetricSkeleton()),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(child: _MetricSkeleton()),
            const SizedBox(width: 12),
            Expanded(child: _MetricSkeleton()),
          ],
        ),
      ],
    );
  }
}

class _MetricSkeleton extends StatelessWidget {
  const _MetricSkeleton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
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

class _ChartSkeleton extends StatelessWidget {
  const _ChartSkeleton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
  }
}

class _InfoBanner extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color color;

  const _InfoBanner({
    required this.icon,
    required this.text,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.06),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Icon(icon, color: color),
          const SizedBox(width: 10),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}
