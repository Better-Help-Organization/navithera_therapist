// chart_data_models.dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:navicare/feature/questionnaire/domain/entities/answer_models.dart';

part 'chart_data_models.freezed.dart';
part 'chart_data_models.g.dart';

@freezed
class WeeklyStatsResponse with _$WeeklyStatsResponse {
  const factory WeeklyStatsResponse({
    required WeeklyStatsData data,
    Pagination? pagination,
    String? message,
    int? statusCode,
    String? method,
    String? path,
    DateTime? timestamp,
  }) = _WeeklyStatsResponse;

  factory WeeklyStatsResponse.fromJson(Map<String, dynamic> json) =>
      _$WeeklyStatsResponseFromJson(json);
}

@freezed
class WeeklyStatsData with _$WeeklyStatsData {
  const factory WeeklyStatsData({
    @JsonKey(fromJson: _parseIntSafely) required int totalSessions,
    @JsonKey(fromJson: _parseDoubleSafely) required double totalHours,
    @JsonKey(fromJson: _parseIntSafely) required int totalRevenue,
    @JsonKey(fromJson: _parseIntSafely) required int totalUsers,
    required List<SessionOverTime> sessionsOverTime,
    required List<UsersTreatedOverTime> usersTreatedOverTime,
  }) = _WeeklyStatsData;

  factory WeeklyStatsData.fromJson(Map<String, dynamic> json) =>
      _$WeeklyStatsDataFromJson(json);
}

@freezed
class SessionOverTime with _$SessionOverTime {
  const factory SessionOverTime({
    required String date,
    @JsonKey(fromJson: _parseIntSafely) required int count,
  }) = _SessionOverTime;

  factory SessionOverTime.fromJson(Map<String, dynamic> json) =>
      _$SessionOverTimeFromJson(json);
}

@freezed
class UsersTreatedOverTime with _$UsersTreatedOverTime {
  const factory UsersTreatedOverTime({
    required String date,
    @JsonKey(fromJson: _parseIntSafely) required int treatedUsers,
  }) = _UsersTreatedOverTime;

  factory UsersTreatedOverTime.fromJson(Map<String, dynamic> json) =>
      _$UsersTreatedOverTimeFromJson(json);
}

@freezed
class ChartData with _$ChartData {
  const factory ChartData({
    required List<FlSpot> sessionSpots,
    required List<FlSpot> clientSpots,
    required DateTime weekStart,
    required DateTime weekEnd,
  }) = _ChartData;

  factory ChartData.empty() => ChartData(
    sessionSpots: const [],
    clientSpots: const [],
    weekStart: DateTime.now(),
    weekEnd: DateTime.now(),
  );
}

@freezed
class WeeklyStats with _$WeeklyStats {
  const factory WeeklyStats({
    required int totalSessions,
    required int totalRevenue,
    required double totalHours,
    required int totalUsers,
    required ChartData chartData,
  }) = _WeeklyStats;

  factory WeeklyStats.empty() => WeeklyStats(
    totalSessions: 0,
    totalRevenue: 0,
    totalHours: 0.0,
    totalUsers: 0,
    chartData: ChartData.empty(),
  );
}

// JSON conversion helpers
int _parseIntSafely(dynamic value) {
  if (value == null) return 0;
  if (value is num) return value.toInt();
  if (value is String) {
    if (value == "N/A" || value.isEmpty) return 0;
    return int.tryParse(value) ?? 0;
  }
  return 0;
}

double _parseDoubleSafely(dynamic value) {
  if (value == null) return 0.0;
  if (value is num) return value.toDouble();
  if (value is String) {
    if (value == "N/A" || value.isEmpty) return 0.0;
    return double.tryParse(value) ?? 0.0;
  }
  return 0.0;
}
