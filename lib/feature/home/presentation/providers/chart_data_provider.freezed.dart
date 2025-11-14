// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chart_data_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$ChartDataState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(WeeklyStats weeklyStats) loaded,
    required TResult Function(Failure failure) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(WeeklyStats weeklyStats)? loaded,
    TResult? Function(Failure failure)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(WeeklyStats weeklyStats)? loaded,
    TResult Function(Failure failure)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ChartDataInitial value) initial,
    required TResult Function(ChartDataLoading value) loading,
    required TResult Function(ChartDataLoaded value) loaded,
    required TResult Function(ChartDataError value) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ChartDataInitial value)? initial,
    TResult? Function(ChartDataLoading value)? loading,
    TResult? Function(ChartDataLoaded value)? loaded,
    TResult? Function(ChartDataError value)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ChartDataInitial value)? initial,
    TResult Function(ChartDataLoading value)? loading,
    TResult Function(ChartDataLoaded value)? loaded,
    TResult Function(ChartDataError value)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChartDataStateCopyWith<$Res> {
  factory $ChartDataStateCopyWith(
    ChartDataState value,
    $Res Function(ChartDataState) then,
  ) = _$ChartDataStateCopyWithImpl<$Res, ChartDataState>;
}

/// @nodoc
class _$ChartDataStateCopyWithImpl<$Res, $Val extends ChartDataState>
    implements $ChartDataStateCopyWith<$Res> {
  _$ChartDataStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChartDataState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$ChartDataInitialImplCopyWith<$Res> {
  factory _$$ChartDataInitialImplCopyWith(
    _$ChartDataInitialImpl value,
    $Res Function(_$ChartDataInitialImpl) then,
  ) = __$$ChartDataInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ChartDataInitialImplCopyWithImpl<$Res>
    extends _$ChartDataStateCopyWithImpl<$Res, _$ChartDataInitialImpl>
    implements _$$ChartDataInitialImplCopyWith<$Res> {
  __$$ChartDataInitialImplCopyWithImpl(
    _$ChartDataInitialImpl _value,
    $Res Function(_$ChartDataInitialImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ChartDataState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ChartDataInitialImpl implements ChartDataInitial {
  const _$ChartDataInitialImpl();

  @override
  String toString() {
    return 'ChartDataState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ChartDataInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(WeeklyStats weeklyStats) loaded,
    required TResult Function(Failure failure) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(WeeklyStats weeklyStats)? loaded,
    TResult? Function(Failure failure)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(WeeklyStats weeklyStats)? loaded,
    TResult Function(Failure failure)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ChartDataInitial value) initial,
    required TResult Function(ChartDataLoading value) loading,
    required TResult Function(ChartDataLoaded value) loaded,
    required TResult Function(ChartDataError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ChartDataInitial value)? initial,
    TResult? Function(ChartDataLoading value)? loading,
    TResult? Function(ChartDataLoaded value)? loaded,
    TResult? Function(ChartDataError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ChartDataInitial value)? initial,
    TResult Function(ChartDataLoading value)? loading,
    TResult Function(ChartDataLoaded value)? loaded,
    TResult Function(ChartDataError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class ChartDataInitial implements ChartDataState {
  const factory ChartDataInitial() = _$ChartDataInitialImpl;
}

/// @nodoc
abstract class _$$ChartDataLoadingImplCopyWith<$Res> {
  factory _$$ChartDataLoadingImplCopyWith(
    _$ChartDataLoadingImpl value,
    $Res Function(_$ChartDataLoadingImpl) then,
  ) = __$$ChartDataLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ChartDataLoadingImplCopyWithImpl<$Res>
    extends _$ChartDataStateCopyWithImpl<$Res, _$ChartDataLoadingImpl>
    implements _$$ChartDataLoadingImplCopyWith<$Res> {
  __$$ChartDataLoadingImplCopyWithImpl(
    _$ChartDataLoadingImpl _value,
    $Res Function(_$ChartDataLoadingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ChartDataState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ChartDataLoadingImpl implements ChartDataLoading {
  const _$ChartDataLoadingImpl();

  @override
  String toString() {
    return 'ChartDataState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ChartDataLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(WeeklyStats weeklyStats) loaded,
    required TResult Function(Failure failure) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(WeeklyStats weeklyStats)? loaded,
    TResult? Function(Failure failure)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(WeeklyStats weeklyStats)? loaded,
    TResult Function(Failure failure)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ChartDataInitial value) initial,
    required TResult Function(ChartDataLoading value) loading,
    required TResult Function(ChartDataLoaded value) loaded,
    required TResult Function(ChartDataError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ChartDataInitial value)? initial,
    TResult? Function(ChartDataLoading value)? loading,
    TResult? Function(ChartDataLoaded value)? loaded,
    TResult? Function(ChartDataError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ChartDataInitial value)? initial,
    TResult Function(ChartDataLoading value)? loading,
    TResult Function(ChartDataLoaded value)? loaded,
    TResult Function(ChartDataError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class ChartDataLoading implements ChartDataState {
  const factory ChartDataLoading() = _$ChartDataLoadingImpl;
}

/// @nodoc
abstract class _$$ChartDataLoadedImplCopyWith<$Res> {
  factory _$$ChartDataLoadedImplCopyWith(
    _$ChartDataLoadedImpl value,
    $Res Function(_$ChartDataLoadedImpl) then,
  ) = __$$ChartDataLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({WeeklyStats weeklyStats});

  $WeeklyStatsCopyWith<$Res> get weeklyStats;
}

/// @nodoc
class __$$ChartDataLoadedImplCopyWithImpl<$Res>
    extends _$ChartDataStateCopyWithImpl<$Res, _$ChartDataLoadedImpl>
    implements _$$ChartDataLoadedImplCopyWith<$Res> {
  __$$ChartDataLoadedImplCopyWithImpl(
    _$ChartDataLoadedImpl _value,
    $Res Function(_$ChartDataLoadedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ChartDataState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? weeklyStats = null}) {
    return _then(
      _$ChartDataLoadedImpl(
        null == weeklyStats
            ? _value.weeklyStats
            : weeklyStats // ignore: cast_nullable_to_non_nullable
                as WeeklyStats,
      ),
    );
  }

  /// Create a copy of ChartDataState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $WeeklyStatsCopyWith<$Res> get weeklyStats {
    return $WeeklyStatsCopyWith<$Res>(_value.weeklyStats, (value) {
      return _then(_value.copyWith(weeklyStats: value));
    });
  }
}

/// @nodoc

class _$ChartDataLoadedImpl implements ChartDataLoaded {
  const _$ChartDataLoadedImpl(this.weeklyStats);

  @override
  final WeeklyStats weeklyStats;

  @override
  String toString() {
    return 'ChartDataState.loaded(weeklyStats: $weeklyStats)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChartDataLoadedImpl &&
            (identical(other.weeklyStats, weeklyStats) ||
                other.weeklyStats == weeklyStats));
  }

  @override
  int get hashCode => Object.hash(runtimeType, weeklyStats);

  /// Create a copy of ChartDataState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChartDataLoadedImplCopyWith<_$ChartDataLoadedImpl> get copyWith =>
      __$$ChartDataLoadedImplCopyWithImpl<_$ChartDataLoadedImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(WeeklyStats weeklyStats) loaded,
    required TResult Function(Failure failure) error,
  }) {
    return loaded(weeklyStats);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(WeeklyStats weeklyStats)? loaded,
    TResult? Function(Failure failure)? error,
  }) {
    return loaded?.call(weeklyStats);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(WeeklyStats weeklyStats)? loaded,
    TResult Function(Failure failure)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(weeklyStats);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ChartDataInitial value) initial,
    required TResult Function(ChartDataLoading value) loading,
    required TResult Function(ChartDataLoaded value) loaded,
    required TResult Function(ChartDataError value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ChartDataInitial value)? initial,
    TResult? Function(ChartDataLoading value)? loading,
    TResult? Function(ChartDataLoaded value)? loaded,
    TResult? Function(ChartDataError value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ChartDataInitial value)? initial,
    TResult Function(ChartDataLoading value)? loading,
    TResult Function(ChartDataLoaded value)? loaded,
    TResult Function(ChartDataError value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class ChartDataLoaded implements ChartDataState {
  const factory ChartDataLoaded(final WeeklyStats weeklyStats) =
      _$ChartDataLoadedImpl;

  WeeklyStats get weeklyStats;

  /// Create a copy of ChartDataState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChartDataLoadedImplCopyWith<_$ChartDataLoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ChartDataErrorImplCopyWith<$Res> {
  factory _$$ChartDataErrorImplCopyWith(
    _$ChartDataErrorImpl value,
    $Res Function(_$ChartDataErrorImpl) then,
  ) = __$$ChartDataErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Failure failure});

  $FailureCopyWith<$Res> get failure;
}

/// @nodoc
class __$$ChartDataErrorImplCopyWithImpl<$Res>
    extends _$ChartDataStateCopyWithImpl<$Res, _$ChartDataErrorImpl>
    implements _$$ChartDataErrorImplCopyWith<$Res> {
  __$$ChartDataErrorImplCopyWithImpl(
    _$ChartDataErrorImpl _value,
    $Res Function(_$ChartDataErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ChartDataState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? failure = null}) {
    return _then(
      _$ChartDataErrorImpl(
        null == failure
            ? _value.failure
            : failure // ignore: cast_nullable_to_non_nullable
                as Failure,
      ),
    );
  }

  /// Create a copy of ChartDataState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $FailureCopyWith<$Res> get failure {
    return $FailureCopyWith<$Res>(_value.failure, (value) {
      return _then(_value.copyWith(failure: value));
    });
  }
}

/// @nodoc

class _$ChartDataErrorImpl implements ChartDataError {
  const _$ChartDataErrorImpl(this.failure);

  @override
  final Failure failure;

  @override
  String toString() {
    return 'ChartDataState.error(failure: $failure)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChartDataErrorImpl &&
            (identical(other.failure, failure) || other.failure == failure));
  }

  @override
  int get hashCode => Object.hash(runtimeType, failure);

  /// Create a copy of ChartDataState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChartDataErrorImplCopyWith<_$ChartDataErrorImpl> get copyWith =>
      __$$ChartDataErrorImplCopyWithImpl<_$ChartDataErrorImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(WeeklyStats weeklyStats) loaded,
    required TResult Function(Failure failure) error,
  }) {
    return error(failure);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(WeeklyStats weeklyStats)? loaded,
    TResult? Function(Failure failure)? error,
  }) {
    return error?.call(failure);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(WeeklyStats weeklyStats)? loaded,
    TResult Function(Failure failure)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(failure);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ChartDataInitial value) initial,
    required TResult Function(ChartDataLoading value) loading,
    required TResult Function(ChartDataLoaded value) loaded,
    required TResult Function(ChartDataError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ChartDataInitial value)? initial,
    TResult? Function(ChartDataLoading value)? loading,
    TResult? Function(ChartDataLoaded value)? loaded,
    TResult? Function(ChartDataError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ChartDataInitial value)? initial,
    TResult Function(ChartDataLoading value)? loading,
    TResult Function(ChartDataLoaded value)? loaded,
    TResult Function(ChartDataError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class ChartDataError implements ChartDataState {
  const factory ChartDataError(final Failure failure) = _$ChartDataErrorImpl;

  Failure get failure;

  /// Create a copy of ChartDataState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChartDataErrorImplCopyWith<_$ChartDataErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
