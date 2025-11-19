// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chart_data_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

WeeklyStatsResponse _$WeeklyStatsResponseFromJson(Map<String, dynamic> json) {
  return _WeeklyStatsResponse.fromJson(json);
}

/// @nodoc
mixin _$WeeklyStatsResponse {
  WeeklyStatsData get data => throw _privateConstructorUsedError;
  Pagination? get pagination => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  int? get statusCode => throw _privateConstructorUsedError;
  String? get method => throw _privateConstructorUsedError;
  String? get path => throw _privateConstructorUsedError;
  DateTime? get timestamp => throw _privateConstructorUsedError;

  /// Serializes this WeeklyStatsResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of WeeklyStatsResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WeeklyStatsResponseCopyWith<WeeklyStatsResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WeeklyStatsResponseCopyWith<$Res> {
  factory $WeeklyStatsResponseCopyWith(
    WeeklyStatsResponse value,
    $Res Function(WeeklyStatsResponse) then,
  ) = _$WeeklyStatsResponseCopyWithImpl<$Res, WeeklyStatsResponse>;
  @useResult
  $Res call({
    WeeklyStatsData data,
    Pagination? pagination,
    String? message,
    int? statusCode,
    String? method,
    String? path,
    DateTime? timestamp,
  });

  $WeeklyStatsDataCopyWith<$Res> get data;
  $PaginationCopyWith<$Res>? get pagination;
}

/// @nodoc
class _$WeeklyStatsResponseCopyWithImpl<$Res, $Val extends WeeklyStatsResponse>
    implements $WeeklyStatsResponseCopyWith<$Res> {
  _$WeeklyStatsResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WeeklyStatsResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
    Object? pagination = freezed,
    Object? message = freezed,
    Object? statusCode = freezed,
    Object? method = freezed,
    Object? path = freezed,
    Object? timestamp = freezed,
  }) {
    return _then(
      _value.copyWith(
            data:
                null == data
                    ? _value.data
                    : data // ignore: cast_nullable_to_non_nullable
                        as WeeklyStatsData,
            pagination:
                freezed == pagination
                    ? _value.pagination
                    : pagination // ignore: cast_nullable_to_non_nullable
                        as Pagination?,
            message:
                freezed == message
                    ? _value.message
                    : message // ignore: cast_nullable_to_non_nullable
                        as String?,
            statusCode:
                freezed == statusCode
                    ? _value.statusCode
                    : statusCode // ignore: cast_nullable_to_non_nullable
                        as int?,
            method:
                freezed == method
                    ? _value.method
                    : method // ignore: cast_nullable_to_non_nullable
                        as String?,
            path:
                freezed == path
                    ? _value.path
                    : path // ignore: cast_nullable_to_non_nullable
                        as String?,
            timestamp:
                freezed == timestamp
                    ? _value.timestamp
                    : timestamp // ignore: cast_nullable_to_non_nullable
                        as DateTime?,
          )
          as $Val,
    );
  }

  /// Create a copy of WeeklyStatsResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $WeeklyStatsDataCopyWith<$Res> get data {
    return $WeeklyStatsDataCopyWith<$Res>(_value.data, (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }

  /// Create a copy of WeeklyStatsResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PaginationCopyWith<$Res>? get pagination {
    if (_value.pagination == null) {
      return null;
    }

    return $PaginationCopyWith<$Res>(_value.pagination!, (value) {
      return _then(_value.copyWith(pagination: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$WeeklyStatsResponseImplCopyWith<$Res>
    implements $WeeklyStatsResponseCopyWith<$Res> {
  factory _$$WeeklyStatsResponseImplCopyWith(
    _$WeeklyStatsResponseImpl value,
    $Res Function(_$WeeklyStatsResponseImpl) then,
  ) = __$$WeeklyStatsResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    WeeklyStatsData data,
    Pagination? pagination,
    String? message,
    int? statusCode,
    String? method,
    String? path,
    DateTime? timestamp,
  });

  @override
  $WeeklyStatsDataCopyWith<$Res> get data;
  @override
  $PaginationCopyWith<$Res>? get pagination;
}

/// @nodoc
class __$$WeeklyStatsResponseImplCopyWithImpl<$Res>
    extends _$WeeklyStatsResponseCopyWithImpl<$Res, _$WeeklyStatsResponseImpl>
    implements _$$WeeklyStatsResponseImplCopyWith<$Res> {
  __$$WeeklyStatsResponseImplCopyWithImpl(
    _$WeeklyStatsResponseImpl _value,
    $Res Function(_$WeeklyStatsResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WeeklyStatsResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
    Object? pagination = freezed,
    Object? message = freezed,
    Object? statusCode = freezed,
    Object? method = freezed,
    Object? path = freezed,
    Object? timestamp = freezed,
  }) {
    return _then(
      _$WeeklyStatsResponseImpl(
        data:
            null == data
                ? _value.data
                : data // ignore: cast_nullable_to_non_nullable
                    as WeeklyStatsData,
        pagination:
            freezed == pagination
                ? _value.pagination
                : pagination // ignore: cast_nullable_to_non_nullable
                    as Pagination?,
        message:
            freezed == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                    as String?,
        statusCode:
            freezed == statusCode
                ? _value.statusCode
                : statusCode // ignore: cast_nullable_to_non_nullable
                    as int?,
        method:
            freezed == method
                ? _value.method
                : method // ignore: cast_nullable_to_non_nullable
                    as String?,
        path:
            freezed == path
                ? _value.path
                : path // ignore: cast_nullable_to_non_nullable
                    as String?,
        timestamp:
            freezed == timestamp
                ? _value.timestamp
                : timestamp // ignore: cast_nullable_to_non_nullable
                    as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$WeeklyStatsResponseImpl implements _WeeklyStatsResponse {
  const _$WeeklyStatsResponseImpl({
    required this.data,
    this.pagination,
    this.message,
    this.statusCode,
    this.method,
    this.path,
    this.timestamp,
  });

  factory _$WeeklyStatsResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$WeeklyStatsResponseImplFromJson(json);

  @override
  final WeeklyStatsData data;
  @override
  final Pagination? pagination;
  @override
  final String? message;
  @override
  final int? statusCode;
  @override
  final String? method;
  @override
  final String? path;
  @override
  final DateTime? timestamp;

  @override
  String toString() {
    return 'WeeklyStatsResponse(data: $data, pagination: $pagination, message: $message, statusCode: $statusCode, method: $method, path: $path, timestamp: $timestamp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WeeklyStatsResponseImpl &&
            (identical(other.data, data) || other.data == data) &&
            (identical(other.pagination, pagination) ||
                other.pagination == pagination) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.statusCode, statusCode) ||
                other.statusCode == statusCode) &&
            (identical(other.method, method) || other.method == method) &&
            (identical(other.path, path) || other.path == path) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    data,
    pagination,
    message,
    statusCode,
    method,
    path,
    timestamp,
  );

  /// Create a copy of WeeklyStatsResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WeeklyStatsResponseImplCopyWith<_$WeeklyStatsResponseImpl> get copyWith =>
      __$$WeeklyStatsResponseImplCopyWithImpl<_$WeeklyStatsResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$WeeklyStatsResponseImplToJson(this);
  }
}

abstract class _WeeklyStatsResponse implements WeeklyStatsResponse {
  const factory _WeeklyStatsResponse({
    required final WeeklyStatsData data,
    final Pagination? pagination,
    final String? message,
    final int? statusCode,
    final String? method,
    final String? path,
    final DateTime? timestamp,
  }) = _$WeeklyStatsResponseImpl;

  factory _WeeklyStatsResponse.fromJson(Map<String, dynamic> json) =
      _$WeeklyStatsResponseImpl.fromJson;

  @override
  WeeklyStatsData get data;
  @override
  Pagination? get pagination;
  @override
  String? get message;
  @override
  int? get statusCode;
  @override
  String? get method;
  @override
  String? get path;
  @override
  DateTime? get timestamp;

  /// Create a copy of WeeklyStatsResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WeeklyStatsResponseImplCopyWith<_$WeeklyStatsResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

WeeklyStatsData _$WeeklyStatsDataFromJson(Map<String, dynamic> json) {
  return _WeeklyStatsData.fromJson(json);
}

/// @nodoc
mixin _$WeeklyStatsData {
  @JsonKey(fromJson: _parseIntSafely)
  int get totalSessions => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _parseDoubleSafely)
  double get totalHours => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _parseIntSafely)
  int get totalRevenue => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _parseIntSafely)
  int get totalUsers => throw _privateConstructorUsedError;
  List<SessionOverTime> get sessionsOverTime =>
      throw _privateConstructorUsedError;
  List<UsersTreatedOverTime> get usersTreatedOverTime =>
      throw _privateConstructorUsedError;
  List<RevenueOverTime> get revenueOverTime =>
      throw _privateConstructorUsedError; // Add this
  List<TherapistHoursPerWeek> get therapistHoursPerWeek =>
      throw _privateConstructorUsedError;

  /// Serializes this WeeklyStatsData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of WeeklyStatsData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WeeklyStatsDataCopyWith<WeeklyStatsData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WeeklyStatsDataCopyWith<$Res> {
  factory $WeeklyStatsDataCopyWith(
    WeeklyStatsData value,
    $Res Function(WeeklyStatsData) then,
  ) = _$WeeklyStatsDataCopyWithImpl<$Res, WeeklyStatsData>;
  @useResult
  $Res call({
    @JsonKey(fromJson: _parseIntSafely) int totalSessions,
    @JsonKey(fromJson: _parseDoubleSafely) double totalHours,
    @JsonKey(fromJson: _parseIntSafely) int totalRevenue,
    @JsonKey(fromJson: _parseIntSafely) int totalUsers,
    List<SessionOverTime> sessionsOverTime,
    List<UsersTreatedOverTime> usersTreatedOverTime,
    List<RevenueOverTime> revenueOverTime,
    List<TherapistHoursPerWeek> therapistHoursPerWeek,
  });
}

/// @nodoc
class _$WeeklyStatsDataCopyWithImpl<$Res, $Val extends WeeklyStatsData>
    implements $WeeklyStatsDataCopyWith<$Res> {
  _$WeeklyStatsDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WeeklyStatsData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalSessions = null,
    Object? totalHours = null,
    Object? totalRevenue = null,
    Object? totalUsers = null,
    Object? sessionsOverTime = null,
    Object? usersTreatedOverTime = null,
    Object? revenueOverTime = null,
    Object? therapistHoursPerWeek = null,
  }) {
    return _then(
      _value.copyWith(
            totalSessions:
                null == totalSessions
                    ? _value.totalSessions
                    : totalSessions // ignore: cast_nullable_to_non_nullable
                        as int,
            totalHours:
                null == totalHours
                    ? _value.totalHours
                    : totalHours // ignore: cast_nullable_to_non_nullable
                        as double,
            totalRevenue:
                null == totalRevenue
                    ? _value.totalRevenue
                    : totalRevenue // ignore: cast_nullable_to_non_nullable
                        as int,
            totalUsers:
                null == totalUsers
                    ? _value.totalUsers
                    : totalUsers // ignore: cast_nullable_to_non_nullable
                        as int,
            sessionsOverTime:
                null == sessionsOverTime
                    ? _value.sessionsOverTime
                    : sessionsOverTime // ignore: cast_nullable_to_non_nullable
                        as List<SessionOverTime>,
            usersTreatedOverTime:
                null == usersTreatedOverTime
                    ? _value.usersTreatedOverTime
                    : usersTreatedOverTime // ignore: cast_nullable_to_non_nullable
                        as List<UsersTreatedOverTime>,
            revenueOverTime:
                null == revenueOverTime
                    ? _value.revenueOverTime
                    : revenueOverTime // ignore: cast_nullable_to_non_nullable
                        as List<RevenueOverTime>,
            therapistHoursPerWeek:
                null == therapistHoursPerWeek
                    ? _value.therapistHoursPerWeek
                    : therapistHoursPerWeek // ignore: cast_nullable_to_non_nullable
                        as List<TherapistHoursPerWeek>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$WeeklyStatsDataImplCopyWith<$Res>
    implements $WeeklyStatsDataCopyWith<$Res> {
  factory _$$WeeklyStatsDataImplCopyWith(
    _$WeeklyStatsDataImpl value,
    $Res Function(_$WeeklyStatsDataImpl) then,
  ) = __$$WeeklyStatsDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(fromJson: _parseIntSafely) int totalSessions,
    @JsonKey(fromJson: _parseDoubleSafely) double totalHours,
    @JsonKey(fromJson: _parseIntSafely) int totalRevenue,
    @JsonKey(fromJson: _parseIntSafely) int totalUsers,
    List<SessionOverTime> sessionsOverTime,
    List<UsersTreatedOverTime> usersTreatedOverTime,
    List<RevenueOverTime> revenueOverTime,
    List<TherapistHoursPerWeek> therapistHoursPerWeek,
  });
}

/// @nodoc
class __$$WeeklyStatsDataImplCopyWithImpl<$Res>
    extends _$WeeklyStatsDataCopyWithImpl<$Res, _$WeeklyStatsDataImpl>
    implements _$$WeeklyStatsDataImplCopyWith<$Res> {
  __$$WeeklyStatsDataImplCopyWithImpl(
    _$WeeklyStatsDataImpl _value,
    $Res Function(_$WeeklyStatsDataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WeeklyStatsData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalSessions = null,
    Object? totalHours = null,
    Object? totalRevenue = null,
    Object? totalUsers = null,
    Object? sessionsOverTime = null,
    Object? usersTreatedOverTime = null,
    Object? revenueOverTime = null,
    Object? therapistHoursPerWeek = null,
  }) {
    return _then(
      _$WeeklyStatsDataImpl(
        totalSessions:
            null == totalSessions
                ? _value.totalSessions
                : totalSessions // ignore: cast_nullable_to_non_nullable
                    as int,
        totalHours:
            null == totalHours
                ? _value.totalHours
                : totalHours // ignore: cast_nullable_to_non_nullable
                    as double,
        totalRevenue:
            null == totalRevenue
                ? _value.totalRevenue
                : totalRevenue // ignore: cast_nullable_to_non_nullable
                    as int,
        totalUsers:
            null == totalUsers
                ? _value.totalUsers
                : totalUsers // ignore: cast_nullable_to_non_nullable
                    as int,
        sessionsOverTime:
            null == sessionsOverTime
                ? _value._sessionsOverTime
                : sessionsOverTime // ignore: cast_nullable_to_non_nullable
                    as List<SessionOverTime>,
        usersTreatedOverTime:
            null == usersTreatedOverTime
                ? _value._usersTreatedOverTime
                : usersTreatedOverTime // ignore: cast_nullable_to_non_nullable
                    as List<UsersTreatedOverTime>,
        revenueOverTime:
            null == revenueOverTime
                ? _value._revenueOverTime
                : revenueOverTime // ignore: cast_nullable_to_non_nullable
                    as List<RevenueOverTime>,
        therapistHoursPerWeek:
            null == therapistHoursPerWeek
                ? _value._therapistHoursPerWeek
                : therapistHoursPerWeek // ignore: cast_nullable_to_non_nullable
                    as List<TherapistHoursPerWeek>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$WeeklyStatsDataImpl implements _WeeklyStatsData {
  const _$WeeklyStatsDataImpl({
    @JsonKey(fromJson: _parseIntSafely) required this.totalSessions,
    @JsonKey(fromJson: _parseDoubleSafely) required this.totalHours,
    @JsonKey(fromJson: _parseIntSafely) required this.totalRevenue,
    @JsonKey(fromJson: _parseIntSafely) required this.totalUsers,
    required final List<SessionOverTime> sessionsOverTime,
    required final List<UsersTreatedOverTime> usersTreatedOverTime,
    required final List<RevenueOverTime> revenueOverTime,
    required final List<TherapistHoursPerWeek> therapistHoursPerWeek,
  }) : _sessionsOverTime = sessionsOverTime,
       _usersTreatedOverTime = usersTreatedOverTime,
       _revenueOverTime = revenueOverTime,
       _therapistHoursPerWeek = therapistHoursPerWeek;

  factory _$WeeklyStatsDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$WeeklyStatsDataImplFromJson(json);

  @override
  @JsonKey(fromJson: _parseIntSafely)
  final int totalSessions;
  @override
  @JsonKey(fromJson: _parseDoubleSafely)
  final double totalHours;
  @override
  @JsonKey(fromJson: _parseIntSafely)
  final int totalRevenue;
  @override
  @JsonKey(fromJson: _parseIntSafely)
  final int totalUsers;
  final List<SessionOverTime> _sessionsOverTime;
  @override
  List<SessionOverTime> get sessionsOverTime {
    if (_sessionsOverTime is EqualUnmodifiableListView)
      return _sessionsOverTime;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_sessionsOverTime);
  }

  final List<UsersTreatedOverTime> _usersTreatedOverTime;
  @override
  List<UsersTreatedOverTime> get usersTreatedOverTime {
    if (_usersTreatedOverTime is EqualUnmodifiableListView)
      return _usersTreatedOverTime;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_usersTreatedOverTime);
  }

  final List<RevenueOverTime> _revenueOverTime;
  @override
  List<RevenueOverTime> get revenueOverTime {
    if (_revenueOverTime is EqualUnmodifiableListView) return _revenueOverTime;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_revenueOverTime);
  }

  // Add this
  final List<TherapistHoursPerWeek> _therapistHoursPerWeek;
  // Add this
  @override
  List<TherapistHoursPerWeek> get therapistHoursPerWeek {
    if (_therapistHoursPerWeek is EqualUnmodifiableListView)
      return _therapistHoursPerWeek;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_therapistHoursPerWeek);
  }

  @override
  String toString() {
    return 'WeeklyStatsData(totalSessions: $totalSessions, totalHours: $totalHours, totalRevenue: $totalRevenue, totalUsers: $totalUsers, sessionsOverTime: $sessionsOverTime, usersTreatedOverTime: $usersTreatedOverTime, revenueOverTime: $revenueOverTime, therapistHoursPerWeek: $therapistHoursPerWeek)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WeeklyStatsDataImpl &&
            (identical(other.totalSessions, totalSessions) ||
                other.totalSessions == totalSessions) &&
            (identical(other.totalHours, totalHours) ||
                other.totalHours == totalHours) &&
            (identical(other.totalRevenue, totalRevenue) ||
                other.totalRevenue == totalRevenue) &&
            (identical(other.totalUsers, totalUsers) ||
                other.totalUsers == totalUsers) &&
            const DeepCollectionEquality().equals(
              other._sessionsOverTime,
              _sessionsOverTime,
            ) &&
            const DeepCollectionEquality().equals(
              other._usersTreatedOverTime,
              _usersTreatedOverTime,
            ) &&
            const DeepCollectionEquality().equals(
              other._revenueOverTime,
              _revenueOverTime,
            ) &&
            const DeepCollectionEquality().equals(
              other._therapistHoursPerWeek,
              _therapistHoursPerWeek,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    totalSessions,
    totalHours,
    totalRevenue,
    totalUsers,
    const DeepCollectionEquality().hash(_sessionsOverTime),
    const DeepCollectionEquality().hash(_usersTreatedOverTime),
    const DeepCollectionEquality().hash(_revenueOverTime),
    const DeepCollectionEquality().hash(_therapistHoursPerWeek),
  );

  /// Create a copy of WeeklyStatsData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WeeklyStatsDataImplCopyWith<_$WeeklyStatsDataImpl> get copyWith =>
      __$$WeeklyStatsDataImplCopyWithImpl<_$WeeklyStatsDataImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$WeeklyStatsDataImplToJson(this);
  }
}

abstract class _WeeklyStatsData implements WeeklyStatsData {
  const factory _WeeklyStatsData({
    @JsonKey(fromJson: _parseIntSafely) required final int totalSessions,
    @JsonKey(fromJson: _parseDoubleSafely) required final double totalHours,
    @JsonKey(fromJson: _parseIntSafely) required final int totalRevenue,
    @JsonKey(fromJson: _parseIntSafely) required final int totalUsers,
    required final List<SessionOverTime> sessionsOverTime,
    required final List<UsersTreatedOverTime> usersTreatedOverTime,
    required final List<RevenueOverTime> revenueOverTime,
    required final List<TherapistHoursPerWeek> therapistHoursPerWeek,
  }) = _$WeeklyStatsDataImpl;

  factory _WeeklyStatsData.fromJson(Map<String, dynamic> json) =
      _$WeeklyStatsDataImpl.fromJson;

  @override
  @JsonKey(fromJson: _parseIntSafely)
  int get totalSessions;
  @override
  @JsonKey(fromJson: _parseDoubleSafely)
  double get totalHours;
  @override
  @JsonKey(fromJson: _parseIntSafely)
  int get totalRevenue;
  @override
  @JsonKey(fromJson: _parseIntSafely)
  int get totalUsers;
  @override
  List<SessionOverTime> get sessionsOverTime;
  @override
  List<UsersTreatedOverTime> get usersTreatedOverTime;
  @override
  List<RevenueOverTime> get revenueOverTime; // Add this
  @override
  List<TherapistHoursPerWeek> get therapistHoursPerWeek;

  /// Create a copy of WeeklyStatsData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WeeklyStatsDataImplCopyWith<_$WeeklyStatsDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RevenueOverTime _$RevenueOverTimeFromJson(Map<String, dynamic> json) {
  return _RevenueOverTime.fromJson(json);
}

/// @nodoc
mixin _$RevenueOverTime {
  String get date => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _parseDoubleSafely)
  double get revenueOverTime => throw _privateConstructorUsedError;

  /// Serializes this RevenueOverTime to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RevenueOverTime
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RevenueOverTimeCopyWith<RevenueOverTime> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RevenueOverTimeCopyWith<$Res> {
  factory $RevenueOverTimeCopyWith(
    RevenueOverTime value,
    $Res Function(RevenueOverTime) then,
  ) = _$RevenueOverTimeCopyWithImpl<$Res, RevenueOverTime>;
  @useResult
  $Res call({
    String date,
    @JsonKey(fromJson: _parseDoubleSafely) double revenueOverTime,
  });
}

/// @nodoc
class _$RevenueOverTimeCopyWithImpl<$Res, $Val extends RevenueOverTime>
    implements $RevenueOverTimeCopyWith<$Res> {
  _$RevenueOverTimeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RevenueOverTime
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? date = null, Object? revenueOverTime = null}) {
    return _then(
      _value.copyWith(
            date:
                null == date
                    ? _value.date
                    : date // ignore: cast_nullable_to_non_nullable
                        as String,
            revenueOverTime:
                null == revenueOverTime
                    ? _value.revenueOverTime
                    : revenueOverTime // ignore: cast_nullable_to_non_nullable
                        as double,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$RevenueOverTimeImplCopyWith<$Res>
    implements $RevenueOverTimeCopyWith<$Res> {
  factory _$$RevenueOverTimeImplCopyWith(
    _$RevenueOverTimeImpl value,
    $Res Function(_$RevenueOverTimeImpl) then,
  ) = __$$RevenueOverTimeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String date,
    @JsonKey(fromJson: _parseDoubleSafely) double revenueOverTime,
  });
}

/// @nodoc
class __$$RevenueOverTimeImplCopyWithImpl<$Res>
    extends _$RevenueOverTimeCopyWithImpl<$Res, _$RevenueOverTimeImpl>
    implements _$$RevenueOverTimeImplCopyWith<$Res> {
  __$$RevenueOverTimeImplCopyWithImpl(
    _$RevenueOverTimeImpl _value,
    $Res Function(_$RevenueOverTimeImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RevenueOverTime
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? date = null, Object? revenueOverTime = null}) {
    return _then(
      _$RevenueOverTimeImpl(
        date:
            null == date
                ? _value.date
                : date // ignore: cast_nullable_to_non_nullable
                    as String,
        revenueOverTime:
            null == revenueOverTime
                ? _value.revenueOverTime
                : revenueOverTime // ignore: cast_nullable_to_non_nullable
                    as double,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$RevenueOverTimeImpl implements _RevenueOverTime {
  const _$RevenueOverTimeImpl({
    required this.date,
    @JsonKey(fromJson: _parseDoubleSafely) required this.revenueOverTime,
  });

  factory _$RevenueOverTimeImpl.fromJson(Map<String, dynamic> json) =>
      _$$RevenueOverTimeImplFromJson(json);

  @override
  final String date;
  @override
  @JsonKey(fromJson: _parseDoubleSafely)
  final double revenueOverTime;

  @override
  String toString() {
    return 'RevenueOverTime(date: $date, revenueOverTime: $revenueOverTime)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RevenueOverTimeImpl &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.revenueOverTime, revenueOverTime) ||
                other.revenueOverTime == revenueOverTime));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, date, revenueOverTime);

  /// Create a copy of RevenueOverTime
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RevenueOverTimeImplCopyWith<_$RevenueOverTimeImpl> get copyWith =>
      __$$RevenueOverTimeImplCopyWithImpl<_$RevenueOverTimeImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$RevenueOverTimeImplToJson(this);
  }
}

abstract class _RevenueOverTime implements RevenueOverTime {
  const factory _RevenueOverTime({
    required final String date,
    @JsonKey(fromJson: _parseDoubleSafely)
    required final double revenueOverTime,
  }) = _$RevenueOverTimeImpl;

  factory _RevenueOverTime.fromJson(Map<String, dynamic> json) =
      _$RevenueOverTimeImpl.fromJson;

  @override
  String get date;
  @override
  @JsonKey(fromJson: _parseDoubleSafely)
  double get revenueOverTime;

  /// Create a copy of RevenueOverTime
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RevenueOverTimeImplCopyWith<_$RevenueOverTimeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TherapistHoursPerWeek _$TherapistHoursPerWeekFromJson(
  Map<String, dynamic> json,
) {
  return _TherapistHoursPerWeek.fromJson(json);
}

/// @nodoc
mixin _$TherapistHoursPerWeek {
  @JsonKey(fromJson: _parseIntSafely)
  int get year => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _parseIntSafely)
  int get week => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _parseDoubleSafely)
  double get totalHours => throw _privateConstructorUsedError;

  /// Serializes this TherapistHoursPerWeek to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TherapistHoursPerWeek
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TherapistHoursPerWeekCopyWith<TherapistHoursPerWeek> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TherapistHoursPerWeekCopyWith<$Res> {
  factory $TherapistHoursPerWeekCopyWith(
    TherapistHoursPerWeek value,
    $Res Function(TherapistHoursPerWeek) then,
  ) = _$TherapistHoursPerWeekCopyWithImpl<$Res, TherapistHoursPerWeek>;
  @useResult
  $Res call({
    @JsonKey(fromJson: _parseIntSafely) int year,
    @JsonKey(fromJson: _parseIntSafely) int week,
    @JsonKey(fromJson: _parseDoubleSafely) double totalHours,
  });
}

/// @nodoc
class _$TherapistHoursPerWeekCopyWithImpl<
  $Res,
  $Val extends TherapistHoursPerWeek
>
    implements $TherapistHoursPerWeekCopyWith<$Res> {
  _$TherapistHoursPerWeekCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TherapistHoursPerWeek
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? year = null,
    Object? week = null,
    Object? totalHours = null,
  }) {
    return _then(
      _value.copyWith(
            year:
                null == year
                    ? _value.year
                    : year // ignore: cast_nullable_to_non_nullable
                        as int,
            week:
                null == week
                    ? _value.week
                    : week // ignore: cast_nullable_to_non_nullable
                        as int,
            totalHours:
                null == totalHours
                    ? _value.totalHours
                    : totalHours // ignore: cast_nullable_to_non_nullable
                        as double,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TherapistHoursPerWeekImplCopyWith<$Res>
    implements $TherapistHoursPerWeekCopyWith<$Res> {
  factory _$$TherapistHoursPerWeekImplCopyWith(
    _$TherapistHoursPerWeekImpl value,
    $Res Function(_$TherapistHoursPerWeekImpl) then,
  ) = __$$TherapistHoursPerWeekImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(fromJson: _parseIntSafely) int year,
    @JsonKey(fromJson: _parseIntSafely) int week,
    @JsonKey(fromJson: _parseDoubleSafely) double totalHours,
  });
}

/// @nodoc
class __$$TherapistHoursPerWeekImplCopyWithImpl<$Res>
    extends
        _$TherapistHoursPerWeekCopyWithImpl<$Res, _$TherapistHoursPerWeekImpl>
    implements _$$TherapistHoursPerWeekImplCopyWith<$Res> {
  __$$TherapistHoursPerWeekImplCopyWithImpl(
    _$TherapistHoursPerWeekImpl _value,
    $Res Function(_$TherapistHoursPerWeekImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TherapistHoursPerWeek
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? year = null,
    Object? week = null,
    Object? totalHours = null,
  }) {
    return _then(
      _$TherapistHoursPerWeekImpl(
        year:
            null == year
                ? _value.year
                : year // ignore: cast_nullable_to_non_nullable
                    as int,
        week:
            null == week
                ? _value.week
                : week // ignore: cast_nullable_to_non_nullable
                    as int,
        totalHours:
            null == totalHours
                ? _value.totalHours
                : totalHours // ignore: cast_nullable_to_non_nullable
                    as double,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TherapistHoursPerWeekImpl implements _TherapistHoursPerWeek {
  const _$TherapistHoursPerWeekImpl({
    @JsonKey(fromJson: _parseIntSafely) required this.year,
    @JsonKey(fromJson: _parseIntSafely) required this.week,
    @JsonKey(fromJson: _parseDoubleSafely) required this.totalHours,
  });

  factory _$TherapistHoursPerWeekImpl.fromJson(Map<String, dynamic> json) =>
      _$$TherapistHoursPerWeekImplFromJson(json);

  @override
  @JsonKey(fromJson: _parseIntSafely)
  final int year;
  @override
  @JsonKey(fromJson: _parseIntSafely)
  final int week;
  @override
  @JsonKey(fromJson: _parseDoubleSafely)
  final double totalHours;

  @override
  String toString() {
    return 'TherapistHoursPerWeek(year: $year, week: $week, totalHours: $totalHours)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TherapistHoursPerWeekImpl &&
            (identical(other.year, year) || other.year == year) &&
            (identical(other.week, week) || other.week == week) &&
            (identical(other.totalHours, totalHours) ||
                other.totalHours == totalHours));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, year, week, totalHours);

  /// Create a copy of TherapistHoursPerWeek
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TherapistHoursPerWeekImplCopyWith<_$TherapistHoursPerWeekImpl>
  get copyWith =>
      __$$TherapistHoursPerWeekImplCopyWithImpl<_$TherapistHoursPerWeekImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$TherapistHoursPerWeekImplToJson(this);
  }
}

abstract class _TherapistHoursPerWeek implements TherapistHoursPerWeek {
  const factory _TherapistHoursPerWeek({
    @JsonKey(fromJson: _parseIntSafely) required final int year,
    @JsonKey(fromJson: _parseIntSafely) required final int week,
    @JsonKey(fromJson: _parseDoubleSafely) required final double totalHours,
  }) = _$TherapistHoursPerWeekImpl;

  factory _TherapistHoursPerWeek.fromJson(Map<String, dynamic> json) =
      _$TherapistHoursPerWeekImpl.fromJson;

  @override
  @JsonKey(fromJson: _parseIntSafely)
  int get year;
  @override
  @JsonKey(fromJson: _parseIntSafely)
  int get week;
  @override
  @JsonKey(fromJson: _parseDoubleSafely)
  double get totalHours;

  /// Create a copy of TherapistHoursPerWeek
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TherapistHoursPerWeekImplCopyWith<_$TherapistHoursPerWeekImpl>
  get copyWith => throw _privateConstructorUsedError;
}

SessionOverTime _$SessionOverTimeFromJson(Map<String, dynamic> json) {
  return _SessionOverTime.fromJson(json);
}

/// @nodoc
mixin _$SessionOverTime {
  String get date => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _parseIntSafely)
  int get count => throw _privateConstructorUsedError;

  /// Serializes this SessionOverTime to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SessionOverTime
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SessionOverTimeCopyWith<SessionOverTime> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SessionOverTimeCopyWith<$Res> {
  factory $SessionOverTimeCopyWith(
    SessionOverTime value,
    $Res Function(SessionOverTime) then,
  ) = _$SessionOverTimeCopyWithImpl<$Res, SessionOverTime>;
  @useResult
  $Res call({String date, @JsonKey(fromJson: _parseIntSafely) int count});
}

/// @nodoc
class _$SessionOverTimeCopyWithImpl<$Res, $Val extends SessionOverTime>
    implements $SessionOverTimeCopyWith<$Res> {
  _$SessionOverTimeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SessionOverTime
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? date = null, Object? count = null}) {
    return _then(
      _value.copyWith(
            date:
                null == date
                    ? _value.date
                    : date // ignore: cast_nullable_to_non_nullable
                        as String,
            count:
                null == count
                    ? _value.count
                    : count // ignore: cast_nullable_to_non_nullable
                        as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SessionOverTimeImplCopyWith<$Res>
    implements $SessionOverTimeCopyWith<$Res> {
  factory _$$SessionOverTimeImplCopyWith(
    _$SessionOverTimeImpl value,
    $Res Function(_$SessionOverTimeImpl) then,
  ) = __$$SessionOverTimeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String date, @JsonKey(fromJson: _parseIntSafely) int count});
}

/// @nodoc
class __$$SessionOverTimeImplCopyWithImpl<$Res>
    extends _$SessionOverTimeCopyWithImpl<$Res, _$SessionOverTimeImpl>
    implements _$$SessionOverTimeImplCopyWith<$Res> {
  __$$SessionOverTimeImplCopyWithImpl(
    _$SessionOverTimeImpl _value,
    $Res Function(_$SessionOverTimeImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SessionOverTime
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? date = null, Object? count = null}) {
    return _then(
      _$SessionOverTimeImpl(
        date:
            null == date
                ? _value.date
                : date // ignore: cast_nullable_to_non_nullable
                    as String,
        count:
            null == count
                ? _value.count
                : count // ignore: cast_nullable_to_non_nullable
                    as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SessionOverTimeImpl implements _SessionOverTime {
  const _$SessionOverTimeImpl({
    required this.date,
    @JsonKey(fromJson: _parseIntSafely) required this.count,
  });

  factory _$SessionOverTimeImpl.fromJson(Map<String, dynamic> json) =>
      _$$SessionOverTimeImplFromJson(json);

  @override
  final String date;
  @override
  @JsonKey(fromJson: _parseIntSafely)
  final int count;

  @override
  String toString() {
    return 'SessionOverTime(date: $date, count: $count)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SessionOverTimeImpl &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.count, count) || other.count == count));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, date, count);

  /// Create a copy of SessionOverTime
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SessionOverTimeImplCopyWith<_$SessionOverTimeImpl> get copyWith =>
      __$$SessionOverTimeImplCopyWithImpl<_$SessionOverTimeImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$SessionOverTimeImplToJson(this);
  }
}

abstract class _SessionOverTime implements SessionOverTime {
  const factory _SessionOverTime({
    required final String date,
    @JsonKey(fromJson: _parseIntSafely) required final int count,
  }) = _$SessionOverTimeImpl;

  factory _SessionOverTime.fromJson(Map<String, dynamic> json) =
      _$SessionOverTimeImpl.fromJson;

  @override
  String get date;
  @override
  @JsonKey(fromJson: _parseIntSafely)
  int get count;

  /// Create a copy of SessionOverTime
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SessionOverTimeImplCopyWith<_$SessionOverTimeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UsersTreatedOverTime _$UsersTreatedOverTimeFromJson(Map<String, dynamic> json) {
  return _UsersTreatedOverTime.fromJson(json);
}

/// @nodoc
mixin _$UsersTreatedOverTime {
  String get date => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _parseIntSafely)
  int get treatedUsers => throw _privateConstructorUsedError;

  /// Serializes this UsersTreatedOverTime to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UsersTreatedOverTime
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UsersTreatedOverTimeCopyWith<UsersTreatedOverTime> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UsersTreatedOverTimeCopyWith<$Res> {
  factory $UsersTreatedOverTimeCopyWith(
    UsersTreatedOverTime value,
    $Res Function(UsersTreatedOverTime) then,
  ) = _$UsersTreatedOverTimeCopyWithImpl<$Res, UsersTreatedOverTime>;
  @useResult
  $Res call({
    String date,
    @JsonKey(fromJson: _parseIntSafely) int treatedUsers,
  });
}

/// @nodoc
class _$UsersTreatedOverTimeCopyWithImpl<
  $Res,
  $Val extends UsersTreatedOverTime
>
    implements $UsersTreatedOverTimeCopyWith<$Res> {
  _$UsersTreatedOverTimeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UsersTreatedOverTime
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? date = null, Object? treatedUsers = null}) {
    return _then(
      _value.copyWith(
            date:
                null == date
                    ? _value.date
                    : date // ignore: cast_nullable_to_non_nullable
                        as String,
            treatedUsers:
                null == treatedUsers
                    ? _value.treatedUsers
                    : treatedUsers // ignore: cast_nullable_to_non_nullable
                        as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$UsersTreatedOverTimeImplCopyWith<$Res>
    implements $UsersTreatedOverTimeCopyWith<$Res> {
  factory _$$UsersTreatedOverTimeImplCopyWith(
    _$UsersTreatedOverTimeImpl value,
    $Res Function(_$UsersTreatedOverTimeImpl) then,
  ) = __$$UsersTreatedOverTimeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String date,
    @JsonKey(fromJson: _parseIntSafely) int treatedUsers,
  });
}

/// @nodoc
class __$$UsersTreatedOverTimeImplCopyWithImpl<$Res>
    extends _$UsersTreatedOverTimeCopyWithImpl<$Res, _$UsersTreatedOverTimeImpl>
    implements _$$UsersTreatedOverTimeImplCopyWith<$Res> {
  __$$UsersTreatedOverTimeImplCopyWithImpl(
    _$UsersTreatedOverTimeImpl _value,
    $Res Function(_$UsersTreatedOverTimeImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UsersTreatedOverTime
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? date = null, Object? treatedUsers = null}) {
    return _then(
      _$UsersTreatedOverTimeImpl(
        date:
            null == date
                ? _value.date
                : date // ignore: cast_nullable_to_non_nullable
                    as String,
        treatedUsers:
            null == treatedUsers
                ? _value.treatedUsers
                : treatedUsers // ignore: cast_nullable_to_non_nullable
                    as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UsersTreatedOverTimeImpl implements _UsersTreatedOverTime {
  const _$UsersTreatedOverTimeImpl({
    required this.date,
    @JsonKey(fromJson: _parseIntSafely) required this.treatedUsers,
  });

  factory _$UsersTreatedOverTimeImpl.fromJson(Map<String, dynamic> json) =>
      _$$UsersTreatedOverTimeImplFromJson(json);

  @override
  final String date;
  @override
  @JsonKey(fromJson: _parseIntSafely)
  final int treatedUsers;

  @override
  String toString() {
    return 'UsersTreatedOverTime(date: $date, treatedUsers: $treatedUsers)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UsersTreatedOverTimeImpl &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.treatedUsers, treatedUsers) ||
                other.treatedUsers == treatedUsers));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, date, treatedUsers);

  /// Create a copy of UsersTreatedOverTime
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UsersTreatedOverTimeImplCopyWith<_$UsersTreatedOverTimeImpl>
  get copyWith =>
      __$$UsersTreatedOverTimeImplCopyWithImpl<_$UsersTreatedOverTimeImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$UsersTreatedOverTimeImplToJson(this);
  }
}

abstract class _UsersTreatedOverTime implements UsersTreatedOverTime {
  const factory _UsersTreatedOverTime({
    required final String date,
    @JsonKey(fromJson: _parseIntSafely) required final int treatedUsers,
  }) = _$UsersTreatedOverTimeImpl;

  factory _UsersTreatedOverTime.fromJson(Map<String, dynamic> json) =
      _$UsersTreatedOverTimeImpl.fromJson;

  @override
  String get date;
  @override
  @JsonKey(fromJson: _parseIntSafely)
  int get treatedUsers;

  /// Create a copy of UsersTreatedOverTime
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UsersTreatedOverTimeImplCopyWith<_$UsersTreatedOverTimeImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ChartData {
  List<FlSpot> get sessionSpots => throw _privateConstructorUsedError;
  List<FlSpot> get clientSpots => throw _privateConstructorUsedError;
  DateTime get weekStart => throw _privateConstructorUsedError;
  DateTime get weekEnd => throw _privateConstructorUsedError;

  /// Create a copy of ChartData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChartDataCopyWith<ChartData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChartDataCopyWith<$Res> {
  factory $ChartDataCopyWith(ChartData value, $Res Function(ChartData) then) =
      _$ChartDataCopyWithImpl<$Res, ChartData>;
  @useResult
  $Res call({
    List<FlSpot> sessionSpots,
    List<FlSpot> clientSpots,
    DateTime weekStart,
    DateTime weekEnd,
  });
}

/// @nodoc
class _$ChartDataCopyWithImpl<$Res, $Val extends ChartData>
    implements $ChartDataCopyWith<$Res> {
  _$ChartDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChartData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sessionSpots = null,
    Object? clientSpots = null,
    Object? weekStart = null,
    Object? weekEnd = null,
  }) {
    return _then(
      _value.copyWith(
            sessionSpots:
                null == sessionSpots
                    ? _value.sessionSpots
                    : sessionSpots // ignore: cast_nullable_to_non_nullable
                        as List<FlSpot>,
            clientSpots:
                null == clientSpots
                    ? _value.clientSpots
                    : clientSpots // ignore: cast_nullable_to_non_nullable
                        as List<FlSpot>,
            weekStart:
                null == weekStart
                    ? _value.weekStart
                    : weekStart // ignore: cast_nullable_to_non_nullable
                        as DateTime,
            weekEnd:
                null == weekEnd
                    ? _value.weekEnd
                    : weekEnd // ignore: cast_nullable_to_non_nullable
                        as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ChartDataImplCopyWith<$Res>
    implements $ChartDataCopyWith<$Res> {
  factory _$$ChartDataImplCopyWith(
    _$ChartDataImpl value,
    $Res Function(_$ChartDataImpl) then,
  ) = __$$ChartDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<FlSpot> sessionSpots,
    List<FlSpot> clientSpots,
    DateTime weekStart,
    DateTime weekEnd,
  });
}

/// @nodoc
class __$$ChartDataImplCopyWithImpl<$Res>
    extends _$ChartDataCopyWithImpl<$Res, _$ChartDataImpl>
    implements _$$ChartDataImplCopyWith<$Res> {
  __$$ChartDataImplCopyWithImpl(
    _$ChartDataImpl _value,
    $Res Function(_$ChartDataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ChartData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sessionSpots = null,
    Object? clientSpots = null,
    Object? weekStart = null,
    Object? weekEnd = null,
  }) {
    return _then(
      _$ChartDataImpl(
        sessionSpots:
            null == sessionSpots
                ? _value._sessionSpots
                : sessionSpots // ignore: cast_nullable_to_non_nullable
                    as List<FlSpot>,
        clientSpots:
            null == clientSpots
                ? _value._clientSpots
                : clientSpots // ignore: cast_nullable_to_non_nullable
                    as List<FlSpot>,
        weekStart:
            null == weekStart
                ? _value.weekStart
                : weekStart // ignore: cast_nullable_to_non_nullable
                    as DateTime,
        weekEnd:
            null == weekEnd
                ? _value.weekEnd
                : weekEnd // ignore: cast_nullable_to_non_nullable
                    as DateTime,
      ),
    );
  }
}

/// @nodoc

class _$ChartDataImpl implements _ChartData {
  const _$ChartDataImpl({
    required final List<FlSpot> sessionSpots,
    required final List<FlSpot> clientSpots,
    required this.weekStart,
    required this.weekEnd,
  }) : _sessionSpots = sessionSpots,
       _clientSpots = clientSpots;

  final List<FlSpot> _sessionSpots;
  @override
  List<FlSpot> get sessionSpots {
    if (_sessionSpots is EqualUnmodifiableListView) return _sessionSpots;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_sessionSpots);
  }

  final List<FlSpot> _clientSpots;
  @override
  List<FlSpot> get clientSpots {
    if (_clientSpots is EqualUnmodifiableListView) return _clientSpots;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_clientSpots);
  }

  @override
  final DateTime weekStart;
  @override
  final DateTime weekEnd;

  @override
  String toString() {
    return 'ChartData(sessionSpots: $sessionSpots, clientSpots: $clientSpots, weekStart: $weekStart, weekEnd: $weekEnd)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChartDataImpl &&
            const DeepCollectionEquality().equals(
              other._sessionSpots,
              _sessionSpots,
            ) &&
            const DeepCollectionEquality().equals(
              other._clientSpots,
              _clientSpots,
            ) &&
            (identical(other.weekStart, weekStart) ||
                other.weekStart == weekStart) &&
            (identical(other.weekEnd, weekEnd) || other.weekEnd == weekEnd));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_sessionSpots),
    const DeepCollectionEquality().hash(_clientSpots),
    weekStart,
    weekEnd,
  );

  /// Create a copy of ChartData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChartDataImplCopyWith<_$ChartDataImpl> get copyWith =>
      __$$ChartDataImplCopyWithImpl<_$ChartDataImpl>(this, _$identity);
}

abstract class _ChartData implements ChartData {
  const factory _ChartData({
    required final List<FlSpot> sessionSpots,
    required final List<FlSpot> clientSpots,
    required final DateTime weekStart,
    required final DateTime weekEnd,
  }) = _$ChartDataImpl;

  @override
  List<FlSpot> get sessionSpots;
  @override
  List<FlSpot> get clientSpots;
  @override
  DateTime get weekStart;
  @override
  DateTime get weekEnd;

  /// Create a copy of ChartData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChartDataImplCopyWith<_$ChartDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$WeeklyStats {
  int get totalSessions => throw _privateConstructorUsedError;
  int get totalRevenue => throw _privateConstructorUsedError;
  double get totalHours => throw _privateConstructorUsedError;
  int get totalUsers => throw _privateConstructorUsedError;
  ChartData get chartData => throw _privateConstructorUsedError;

  /// Create a copy of WeeklyStats
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WeeklyStatsCopyWith<WeeklyStats> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WeeklyStatsCopyWith<$Res> {
  factory $WeeklyStatsCopyWith(
    WeeklyStats value,
    $Res Function(WeeklyStats) then,
  ) = _$WeeklyStatsCopyWithImpl<$Res, WeeklyStats>;
  @useResult
  $Res call({
    int totalSessions,
    int totalRevenue,
    double totalHours,
    int totalUsers,
    ChartData chartData,
  });

  $ChartDataCopyWith<$Res> get chartData;
}

/// @nodoc
class _$WeeklyStatsCopyWithImpl<$Res, $Val extends WeeklyStats>
    implements $WeeklyStatsCopyWith<$Res> {
  _$WeeklyStatsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WeeklyStats
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalSessions = null,
    Object? totalRevenue = null,
    Object? totalHours = null,
    Object? totalUsers = null,
    Object? chartData = null,
  }) {
    return _then(
      _value.copyWith(
            totalSessions:
                null == totalSessions
                    ? _value.totalSessions
                    : totalSessions // ignore: cast_nullable_to_non_nullable
                        as int,
            totalRevenue:
                null == totalRevenue
                    ? _value.totalRevenue
                    : totalRevenue // ignore: cast_nullable_to_non_nullable
                        as int,
            totalHours:
                null == totalHours
                    ? _value.totalHours
                    : totalHours // ignore: cast_nullable_to_non_nullable
                        as double,
            totalUsers:
                null == totalUsers
                    ? _value.totalUsers
                    : totalUsers // ignore: cast_nullable_to_non_nullable
                        as int,
            chartData:
                null == chartData
                    ? _value.chartData
                    : chartData // ignore: cast_nullable_to_non_nullable
                        as ChartData,
          )
          as $Val,
    );
  }

  /// Create a copy of WeeklyStats
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ChartDataCopyWith<$Res> get chartData {
    return $ChartDataCopyWith<$Res>(_value.chartData, (value) {
      return _then(_value.copyWith(chartData: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$WeeklyStatsImplCopyWith<$Res>
    implements $WeeklyStatsCopyWith<$Res> {
  factory _$$WeeklyStatsImplCopyWith(
    _$WeeklyStatsImpl value,
    $Res Function(_$WeeklyStatsImpl) then,
  ) = __$$WeeklyStatsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int totalSessions,
    int totalRevenue,
    double totalHours,
    int totalUsers,
    ChartData chartData,
  });

  @override
  $ChartDataCopyWith<$Res> get chartData;
}

/// @nodoc
class __$$WeeklyStatsImplCopyWithImpl<$Res>
    extends _$WeeklyStatsCopyWithImpl<$Res, _$WeeklyStatsImpl>
    implements _$$WeeklyStatsImplCopyWith<$Res> {
  __$$WeeklyStatsImplCopyWithImpl(
    _$WeeklyStatsImpl _value,
    $Res Function(_$WeeklyStatsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WeeklyStats
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalSessions = null,
    Object? totalRevenue = null,
    Object? totalHours = null,
    Object? totalUsers = null,
    Object? chartData = null,
  }) {
    return _then(
      _$WeeklyStatsImpl(
        totalSessions:
            null == totalSessions
                ? _value.totalSessions
                : totalSessions // ignore: cast_nullable_to_non_nullable
                    as int,
        totalRevenue:
            null == totalRevenue
                ? _value.totalRevenue
                : totalRevenue // ignore: cast_nullable_to_non_nullable
                    as int,
        totalHours:
            null == totalHours
                ? _value.totalHours
                : totalHours // ignore: cast_nullable_to_non_nullable
                    as double,
        totalUsers:
            null == totalUsers
                ? _value.totalUsers
                : totalUsers // ignore: cast_nullable_to_non_nullable
                    as int,
        chartData:
            null == chartData
                ? _value.chartData
                : chartData // ignore: cast_nullable_to_non_nullable
                    as ChartData,
      ),
    );
  }
}

/// @nodoc

class _$WeeklyStatsImpl implements _WeeklyStats {
  const _$WeeklyStatsImpl({
    required this.totalSessions,
    required this.totalRevenue,
    required this.totalHours,
    required this.totalUsers,
    required this.chartData,
  });

  @override
  final int totalSessions;
  @override
  final int totalRevenue;
  @override
  final double totalHours;
  @override
  final int totalUsers;
  @override
  final ChartData chartData;

  @override
  String toString() {
    return 'WeeklyStats(totalSessions: $totalSessions, totalRevenue: $totalRevenue, totalHours: $totalHours, totalUsers: $totalUsers, chartData: $chartData)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WeeklyStatsImpl &&
            (identical(other.totalSessions, totalSessions) ||
                other.totalSessions == totalSessions) &&
            (identical(other.totalRevenue, totalRevenue) ||
                other.totalRevenue == totalRevenue) &&
            (identical(other.totalHours, totalHours) ||
                other.totalHours == totalHours) &&
            (identical(other.totalUsers, totalUsers) ||
                other.totalUsers == totalUsers) &&
            (identical(other.chartData, chartData) ||
                other.chartData == chartData));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    totalSessions,
    totalRevenue,
    totalHours,
    totalUsers,
    chartData,
  );

  /// Create a copy of WeeklyStats
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WeeklyStatsImplCopyWith<_$WeeklyStatsImpl> get copyWith =>
      __$$WeeklyStatsImplCopyWithImpl<_$WeeklyStatsImpl>(this, _$identity);
}

abstract class _WeeklyStats implements WeeklyStats {
  const factory _WeeklyStats({
    required final int totalSessions,
    required final int totalRevenue,
    required final double totalHours,
    required final int totalUsers,
    required final ChartData chartData,
  }) = _$WeeklyStatsImpl;

  @override
  int get totalSessions;
  @override
  int get totalRevenue;
  @override
  double get totalHours;
  @override
  int get totalUsers;
  @override
  ChartData get chartData;

  /// Create a copy of WeeklyStats
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WeeklyStatsImplCopyWith<_$WeeklyStatsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
