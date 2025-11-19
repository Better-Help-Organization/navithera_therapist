// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chart_data_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WeeklyStatsResponseImpl _$$WeeklyStatsResponseImplFromJson(
  Map<String, dynamic> json,
) => _$WeeklyStatsResponseImpl(
  data: WeeklyStatsData.fromJson(json['data'] as Map<String, dynamic>),
  pagination:
      json['pagination'] == null
          ? null
          : Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
  message: json['message'] as String?,
  statusCode: (json['statusCode'] as num?)?.toInt(),
  method: json['method'] as String?,
  path: json['path'] as String?,
  timestamp:
      json['timestamp'] == null
          ? null
          : DateTime.parse(json['timestamp'] as String),
);

Map<String, dynamic> _$$WeeklyStatsResponseImplToJson(
  _$WeeklyStatsResponseImpl instance,
) => <String, dynamic>{
  'data': instance.data,
  'pagination': instance.pagination,
  'message': instance.message,
  'statusCode': instance.statusCode,
  'method': instance.method,
  'path': instance.path,
  'timestamp': instance.timestamp?.toIso8601String(),
};

_$WeeklyStatsDataImpl _$$WeeklyStatsDataImplFromJson(
  Map<String, dynamic> json,
) => _$WeeklyStatsDataImpl(
  totalSessions: _parseIntSafely(json['totalSessions']),
  totalHours: _parseDoubleSafely(json['totalHours']),
  totalRevenue: _parseIntSafely(json['totalRevenue']),
  totalUsers: _parseIntSafely(json['totalUsers']),
  sessionsOverTime:
      (json['sessionsOverTime'] as List<dynamic>)
          .map((e) => SessionOverTime.fromJson(e as Map<String, dynamic>))
          .toList(),
  usersTreatedOverTime:
      (json['usersTreatedOverTime'] as List<dynamic>)
          .map((e) => UsersTreatedOverTime.fromJson(e as Map<String, dynamic>))
          .toList(),
  revenueOverTime:
      (json['revenueOverTime'] as List<dynamic>)
          .map((e) => RevenueOverTime.fromJson(e as Map<String, dynamic>))
          .toList(),
  therapistHoursPerWeek:
      (json['therapistHoursPerWeek'] as List<dynamic>)
          .map((e) => TherapistHoursPerWeek.fromJson(e as Map<String, dynamic>))
          .toList(),
);

Map<String, dynamic> _$$WeeklyStatsDataImplToJson(
  _$WeeklyStatsDataImpl instance,
) => <String, dynamic>{
  'totalSessions': instance.totalSessions,
  'totalHours': instance.totalHours,
  'totalRevenue': instance.totalRevenue,
  'totalUsers': instance.totalUsers,
  'sessionsOverTime': instance.sessionsOverTime,
  'usersTreatedOverTime': instance.usersTreatedOverTime,
  'revenueOverTime': instance.revenueOverTime,
  'therapistHoursPerWeek': instance.therapistHoursPerWeek,
};

_$RevenueOverTimeImpl _$$RevenueOverTimeImplFromJson(
  Map<String, dynamic> json,
) => _$RevenueOverTimeImpl(
  date: json['date'] as String,
  revenueOverTime: _parseDoubleSafely(json['revenueOverTime']),
);

Map<String, dynamic> _$$RevenueOverTimeImplToJson(
  _$RevenueOverTimeImpl instance,
) => <String, dynamic>{
  'date': instance.date,
  'revenueOverTime': instance.revenueOverTime,
};

_$TherapistHoursPerWeekImpl _$$TherapistHoursPerWeekImplFromJson(
  Map<String, dynamic> json,
) => _$TherapistHoursPerWeekImpl(
  year: _parseIntSafely(json['year']),
  week: _parseIntSafely(json['week']),
  totalHours: _parseDoubleSafely(json['totalHours']),
);

Map<String, dynamic> _$$TherapistHoursPerWeekImplToJson(
  _$TherapistHoursPerWeekImpl instance,
) => <String, dynamic>{
  'year': instance.year,
  'week': instance.week,
  'totalHours': instance.totalHours,
};

_$SessionOverTimeImpl _$$SessionOverTimeImplFromJson(
  Map<String, dynamic> json,
) => _$SessionOverTimeImpl(
  date: json['date'] as String,
  count: _parseIntSafely(json['count']),
);

Map<String, dynamic> _$$SessionOverTimeImplToJson(
  _$SessionOverTimeImpl instance,
) => <String, dynamic>{'date': instance.date, 'count': instance.count};

_$UsersTreatedOverTimeImpl _$$UsersTreatedOverTimeImplFromJson(
  Map<String, dynamic> json,
) => _$UsersTreatedOverTimeImpl(
  date: json['date'] as String,
  treatedUsers: _parseIntSafely(json['treatedUsers']),
);

Map<String, dynamic> _$$UsersTreatedOverTimeImplToJson(
  _$UsersTreatedOverTimeImpl instance,
) => <String, dynamic>{
  'date': instance.date,
  'treatedUsers': instance.treatedUsers,
};
