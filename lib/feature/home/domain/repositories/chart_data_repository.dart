// chart_data_repository.dart
import 'package:dartz/dartz.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:navicare/core/error/failures.dart';
import 'package:navicare/feature/home/data/data_sources/chart_data_remote_data_source.dart';
import 'package:navicare/feature/home/data/models/chart_data_models.dart';

abstract class ChartDataRepository {
  Future<Either<Failure, WeeklyStats>> getWeeklyStats();
}

class ChartDataRepositoryImpl implements ChartDataRepository {
  final ChartDataRemoteDataSource remote;

  ChartDataRepositoryImpl(this.remote);

  DateTime _getMondayOfWeek(DateTime date) {
    return date.subtract(Duration(days: date.weekday - 1));
  }

  List<DateTime> _getWeekDays(DateTime monday) {
    return List.generate(7, (index) => monday.add(Duration(days: index)));
  }

  @override
  Future<Either<Failure, WeeklyStats>> getWeeklyStats() async {
    try {
      final now = DateTime.now();
      // Get Monday of current week at start of day (00:00:00)
      final monday = _getMondayOfWeek(now);
      final mondayStart = DateTime.utc(
        monday.year,
        monday.month,
        monday.day,
        0,
        0,
        0,
      );

      // Get Sunday of current week at end of day (23:59:59)
      final sunday = monday.add(const Duration(days: 6));
      final sundayEnd = DateTime.utc(
        sunday.year,
        sunday.month,
        sunday.day,
        23,
        59,
        59,
      );

      // Use ISO format with time to ensure full week is captured
      // Without time, backend defaults to 00:00:00 which would miss Sunday sessions
      final String start = mondayStart.toIso8601String();
      final String end = sundayEnd.toIso8601String();

      print('========== WEEKLY STATS REQUEST ==========');
      print('Monday Start (UTC): $start');
      print('Sunday End (UTC): $end');
      print('Current Local Time: ${DateTime.now()}');
      print('==========================================');

      // Fetch stats data using the remote data source
      final response = await remote.getWeeklyStats(
        startDate: start,
        endDate: end,
      );

      final statsData = response.data;

      print('========== WEEKLY STATS RESPONSE ==========');
      print('Total Sessions: ${statsData.totalSessions}');
      print('Sessions Over Time Count: ${statsData.sessionsOverTime.length}');
      for (var i = 0; i < statsData.sessionsOverTime.length; i++) {
        final session = statsData.sessionsOverTime[i];
        print('  [$i] Date: ${session.date}, Count: ${session.count}');
      }
      print('===========================================');

      // Calculate total hours from therapistHoursPerWeek array
      final totalHoursFromArray = statsData.therapistHoursPerWeek.fold<double>(
        0.0,
        (sum, item) => sum + item.totalHours,
      );

      // Calculate total revenue from revenueOverTime array
      final totalRevenueFromArray = statsData.revenueOverTime.fold<double>(
        0.0,
        (sum, item) => sum + item.revenueOverTime,
      );

      // Process chart data
      final sessionsOverTime = statsData.sessionsOverTime;
      final usersTreatedOverTime = statsData.usersTreatedOverTime;

      final weekDays = _getWeekDays(monday);

      // Create session data for the week
      final sessionData = List<int>.filled(7, 0);
      final clientData = List<int>.filled(7, 0);

      // Normalize weekDays to date-only (no time component) for accurate comparison
      final normalizedWeekDays =
          weekDays.map((d) => DateTime(d.year, d.month, d.day)).toList();

      print(
        'Week days: ${normalizedWeekDays.map((d) => "${d.year}-${d.month}-${d.day}").toList()}',
      );

      for (var session in sessionsOverTime) {
        final dateStr = session.date;
        if (dateStr.isNotEmpty) {
          // Parse the UTC date - the backend returns dates like "2026-01-23T21:00:00.000Z"
          // which is 21:00 UTC = midnight in local timezone (+3)
          // We need to extract the date from the UTC string directly
          final utcDate = DateTime.parse(dateStr);

          // Extract just the date portion from the UTC timestamp
          // Don't convert to local - use the UTC date directly
          final normalizedUtcDate = DateTime.utc(
            utcDate.year,
            utcDate.month,
            utcDate.day,
          );

          final dayIndex = normalizedWeekDays.indexWhere(
            (day) =>
                day.year == normalizedUtcDate.year &&
                day.month == normalizedUtcDate.month &&
                day.day == normalizedUtcDate.day,
          );

          print(
            'Session date: $dateStr -> UTC: $utcDate -> normalized: $normalizedUtcDate -> dayIndex: $dayIndex',
          );

          if (dayIndex != -1) {
            sessionData[dayIndex] += session.count;
          }
        }
      }

      for (var user in usersTreatedOverTime) {
        final dateStr = user.date;
        if (dateStr.isNotEmpty) {
          // Use UTC date extraction (same as sessionsOverTime)
          final utcDate = DateTime.parse(dateStr);
          final normalizedUtcDate = DateTime.utc(
            utcDate.year,
            utcDate.month,
            utcDate.day,
          );
          final dayIndex = normalizedWeekDays.indexWhere(
            (day) =>
                day.year == normalizedUtcDate.year &&
                day.month == normalizedUtcDate.month &&
                day.day == normalizedUtcDate.day,
          );
          if (dayIndex != -1) {
            clientData[dayIndex] += user.treatedUsers;
          }
        }
      }

      print('Session data: $sessionData');

      final sessionSpots = List.generate(
        7,
        (index) => FlSpot(index.toDouble(), sessionData[index].toDouble()),
      );

      final clientSpots = List.generate(
        7,
        (index) => FlSpot(index.toDouble(), clientData[index].toDouble()),
      );

      final chartData = ChartData(
        sessionSpots: sessionSpots,
        clientSpots: clientSpots,
        weekStart: monday,
        weekEnd: sunday,
      );

      final weeklyStats = WeeklyStats(
        totalSessions: statsData.totalSessions,
        totalRevenue: totalRevenueFromArray.round(), // Use calculated revenue
        totalHours: totalHoursFromArray, // Use calculated hours
        totalUsers: statsData.totalUsers,
        chartData: chartData,
      );

      return Right(weeklyStats);
    } catch (e) {
      return Left(Failure.unknownFailure(e.toString()));
    }
  }
}

final chartDataRepositoryProvider = Provider<ChartDataRepository>((ref) {
  final remote = ref.read(chartDataRemoteDataSourceProvider);
  return ChartDataRepositoryImpl(remote);
});
