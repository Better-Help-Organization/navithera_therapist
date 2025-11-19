// chart_data_repository.dart
import 'package:dartz/dartz.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

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
      final monday = _getMondayOfWeek(now);
      final sunday = monday.add(const Duration(days: 6));

      final DateFormat formatter = DateFormat('yyyy-MM-dd');
      final String start = formatter.format(monday);
      final String end = formatter.format(sunday);

      // Fetch stats data using the remote data source
      final response = await remote.getWeeklyStats(
        startDate: start,
        endDate: end,
      );

      final statsData = response.data;

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

      for (var session in sessionsOverTime) {
        final dateStr = session.date;
        if (dateStr.isNotEmpty) {
          final date = DateTime.parse(dateStr);
          final dayIndex = weekDays.indexWhere(
            (day) => formatter.format(day) == formatter.format(date),
          );
          if (dayIndex != -1) {
            sessionData[dayIndex] = session.count;
          }
        }
      }

      for (var user in usersTreatedOverTime) {
        final dateStr = user.date;
        if (dateStr.isNotEmpty) {
          final date = DateTime.parse(dateStr);
          final dayIndex = weekDays.indexWhere(
            (day) => formatter.format(day) == formatter.format(date),
          );
          if (dayIndex != -1) {
            clientData[dayIndex] = user.treatedUsers;
          }
        }
      }

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
