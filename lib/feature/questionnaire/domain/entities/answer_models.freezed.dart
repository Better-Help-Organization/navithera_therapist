// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'answer_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

AnswerResponse _$AnswerResponseFromJson(Map<String, dynamic> json) {
  return _AnswerResponse.fromJson(json);
}

/// @nodoc
mixin _$AnswerResponse {
  List<AnswerData> get data => throw _privateConstructorUsedError;
  Pagination get pagination => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  int get statusCode => throw _privateConstructorUsedError;
  String? get method => throw _privateConstructorUsedError;
  String? get path => throw _privateConstructorUsedError;
  String? get timestamp => throw _privateConstructorUsedError;

  /// Serializes this AnswerResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AnswerResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AnswerResponseCopyWith<AnswerResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AnswerResponseCopyWith<$Res> {
  factory $AnswerResponseCopyWith(
    AnswerResponse value,
    $Res Function(AnswerResponse) then,
  ) = _$AnswerResponseCopyWithImpl<$Res, AnswerResponse>;
  @useResult
  $Res call({
    List<AnswerData> data,
    Pagination pagination,
    String message,
    int statusCode,
    String? method,
    String? path,
    String? timestamp,
  });

  $PaginationCopyWith<$Res> get pagination;
}

/// @nodoc
class _$AnswerResponseCopyWithImpl<$Res, $Val extends AnswerResponse>
    implements $AnswerResponseCopyWith<$Res> {
  _$AnswerResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AnswerResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
    Object? pagination = null,
    Object? message = null,
    Object? statusCode = null,
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
                        as List<AnswerData>,
            pagination:
                null == pagination
                    ? _value.pagination
                    : pagination // ignore: cast_nullable_to_non_nullable
                        as Pagination,
            message:
                null == message
                    ? _value.message
                    : message // ignore: cast_nullable_to_non_nullable
                        as String,
            statusCode:
                null == statusCode
                    ? _value.statusCode
                    : statusCode // ignore: cast_nullable_to_non_nullable
                        as int,
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
                        as String?,
          )
          as $Val,
    );
  }

  /// Create a copy of AnswerResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PaginationCopyWith<$Res> get pagination {
    return $PaginationCopyWith<$Res>(_value.pagination, (value) {
      return _then(_value.copyWith(pagination: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AnswerResponseImplCopyWith<$Res>
    implements $AnswerResponseCopyWith<$Res> {
  factory _$$AnswerResponseImplCopyWith(
    _$AnswerResponseImpl value,
    $Res Function(_$AnswerResponseImpl) then,
  ) = __$$AnswerResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<AnswerData> data,
    Pagination pagination,
    String message,
    int statusCode,
    String? method,
    String? path,
    String? timestamp,
  });

  @override
  $PaginationCopyWith<$Res> get pagination;
}

/// @nodoc
class __$$AnswerResponseImplCopyWithImpl<$Res>
    extends _$AnswerResponseCopyWithImpl<$Res, _$AnswerResponseImpl>
    implements _$$AnswerResponseImplCopyWith<$Res> {
  __$$AnswerResponseImplCopyWithImpl(
    _$AnswerResponseImpl _value,
    $Res Function(_$AnswerResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AnswerResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
    Object? pagination = null,
    Object? message = null,
    Object? statusCode = null,
    Object? method = freezed,
    Object? path = freezed,
    Object? timestamp = freezed,
  }) {
    return _then(
      _$AnswerResponseImpl(
        data:
            null == data
                ? _value._data
                : data // ignore: cast_nullable_to_non_nullable
                    as List<AnswerData>,
        pagination:
            null == pagination
                ? _value.pagination
                : pagination // ignore: cast_nullable_to_non_nullable
                    as Pagination,
        message:
            null == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                    as String,
        statusCode:
            null == statusCode
                ? _value.statusCode
                : statusCode // ignore: cast_nullable_to_non_nullable
                    as int,
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
                    as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AnswerResponseImpl implements _AnswerResponse {
  const _$AnswerResponseImpl({
    required final List<AnswerData> data,
    required this.pagination,
    required this.message,
    required this.statusCode,
    this.method,
    this.path,
    this.timestamp,
  }) : _data = data;

  factory _$AnswerResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$AnswerResponseImplFromJson(json);

  final List<AnswerData> _data;
  @override
  List<AnswerData> get data {
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_data);
  }

  @override
  final Pagination pagination;
  @override
  final String message;
  @override
  final int statusCode;
  @override
  final String? method;
  @override
  final String? path;
  @override
  final String? timestamp;

  @override
  String toString() {
    return 'AnswerResponse(data: $data, pagination: $pagination, message: $message, statusCode: $statusCode, method: $method, path: $path, timestamp: $timestamp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AnswerResponseImpl &&
            const DeepCollectionEquality().equals(other._data, _data) &&
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
    const DeepCollectionEquality().hash(_data),
    pagination,
    message,
    statusCode,
    method,
    path,
    timestamp,
  );

  /// Create a copy of AnswerResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AnswerResponseImplCopyWith<_$AnswerResponseImpl> get copyWith =>
      __$$AnswerResponseImplCopyWithImpl<_$AnswerResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$AnswerResponseImplToJson(this);
  }
}

abstract class _AnswerResponse implements AnswerResponse {
  const factory _AnswerResponse({
    required final List<AnswerData> data,
    required final Pagination pagination,
    required final String message,
    required final int statusCode,
    final String? method,
    final String? path,
    final String? timestamp,
  }) = _$AnswerResponseImpl;

  factory _AnswerResponse.fromJson(Map<String, dynamic> json) =
      _$AnswerResponseImpl.fromJson;

  @override
  List<AnswerData> get data;
  @override
  Pagination get pagination;
  @override
  String get message;
  @override
  int get statusCode;
  @override
  String? get method;
  @override
  String? get path;
  @override
  String? get timestamp;

  /// Create a copy of AnswerResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AnswerResponseImplCopyWith<_$AnswerResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AnswerData _$AnswerDataFromJson(Map<String, dynamic> json) {
  return _AnswerData.fromJson(json);
}

/// @nodoc
mixin _$AnswerData {
  String get id => throw _privateConstructorUsedError;
  String? get text => throw _privateConstructorUsedError;
  Question get question => throw _privateConstructorUsedError;
  QuestionOption? get singleOption => throw _privateConstructorUsedError;
  List<QuestionOption> get multiOption => throw _privateConstructorUsedError;

  /// Serializes this AnswerData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AnswerData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AnswerDataCopyWith<AnswerData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AnswerDataCopyWith<$Res> {
  factory $AnswerDataCopyWith(
    AnswerData value,
    $Res Function(AnswerData) then,
  ) = _$AnswerDataCopyWithImpl<$Res, AnswerData>;
  @useResult
  $Res call({
    String id,
    String? text,
    Question question,
    QuestionOption? singleOption,
    List<QuestionOption> multiOption,
  });

  $QuestionCopyWith<$Res> get question;
  $QuestionOptionCopyWith<$Res>? get singleOption;
}

/// @nodoc
class _$AnswerDataCopyWithImpl<$Res, $Val extends AnswerData>
    implements $AnswerDataCopyWith<$Res> {
  _$AnswerDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AnswerData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? text = freezed,
    Object? question = null,
    Object? singleOption = freezed,
    Object? multiOption = null,
  }) {
    return _then(
      _value.copyWith(
            id:
                null == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as String,
            text:
                freezed == text
                    ? _value.text
                    : text // ignore: cast_nullable_to_non_nullable
                        as String?,
            question:
                null == question
                    ? _value.question
                    : question // ignore: cast_nullable_to_non_nullable
                        as Question,
            singleOption:
                freezed == singleOption
                    ? _value.singleOption
                    : singleOption // ignore: cast_nullable_to_non_nullable
                        as QuestionOption?,
            multiOption:
                null == multiOption
                    ? _value.multiOption
                    : multiOption // ignore: cast_nullable_to_non_nullable
                        as List<QuestionOption>,
          )
          as $Val,
    );
  }

  /// Create a copy of AnswerData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $QuestionCopyWith<$Res> get question {
    return $QuestionCopyWith<$Res>(_value.question, (value) {
      return _then(_value.copyWith(question: value) as $Val);
    });
  }

  /// Create a copy of AnswerData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $QuestionOptionCopyWith<$Res>? get singleOption {
    if (_value.singleOption == null) {
      return null;
    }

    return $QuestionOptionCopyWith<$Res>(_value.singleOption!, (value) {
      return _then(_value.copyWith(singleOption: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AnswerDataImplCopyWith<$Res>
    implements $AnswerDataCopyWith<$Res> {
  factory _$$AnswerDataImplCopyWith(
    _$AnswerDataImpl value,
    $Res Function(_$AnswerDataImpl) then,
  ) = __$$AnswerDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String? text,
    Question question,
    QuestionOption? singleOption,
    List<QuestionOption> multiOption,
  });

  @override
  $QuestionCopyWith<$Res> get question;
  @override
  $QuestionOptionCopyWith<$Res>? get singleOption;
}

/// @nodoc
class __$$AnswerDataImplCopyWithImpl<$Res>
    extends _$AnswerDataCopyWithImpl<$Res, _$AnswerDataImpl>
    implements _$$AnswerDataImplCopyWith<$Res> {
  __$$AnswerDataImplCopyWithImpl(
    _$AnswerDataImpl _value,
    $Res Function(_$AnswerDataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AnswerData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? text = freezed,
    Object? question = null,
    Object? singleOption = freezed,
    Object? multiOption = null,
  }) {
    return _then(
      _$AnswerDataImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as String,
        text:
            freezed == text
                ? _value.text
                : text // ignore: cast_nullable_to_non_nullable
                    as String?,
        question:
            null == question
                ? _value.question
                : question // ignore: cast_nullable_to_non_nullable
                    as Question,
        singleOption:
            freezed == singleOption
                ? _value.singleOption
                : singleOption // ignore: cast_nullable_to_non_nullable
                    as QuestionOption?,
        multiOption:
            null == multiOption
                ? _value._multiOption
                : multiOption // ignore: cast_nullable_to_non_nullable
                    as List<QuestionOption>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AnswerDataImpl implements _AnswerData {
  const _$AnswerDataImpl({
    required this.id,
    this.text,
    required this.question,
    this.singleOption,
    required final List<QuestionOption> multiOption,
  }) : _multiOption = multiOption;

  factory _$AnswerDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$AnswerDataImplFromJson(json);

  @override
  final String id;
  @override
  final String? text;
  @override
  final Question question;
  @override
  final QuestionOption? singleOption;
  final List<QuestionOption> _multiOption;
  @override
  List<QuestionOption> get multiOption {
    if (_multiOption is EqualUnmodifiableListView) return _multiOption;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_multiOption);
  }

  @override
  String toString() {
    return 'AnswerData(id: $id, text: $text, question: $question, singleOption: $singleOption, multiOption: $multiOption)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AnswerDataImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.question, question) ||
                other.question == question) &&
            (identical(other.singleOption, singleOption) ||
                other.singleOption == singleOption) &&
            const DeepCollectionEquality().equals(
              other._multiOption,
              _multiOption,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    text,
    question,
    singleOption,
    const DeepCollectionEquality().hash(_multiOption),
  );

  /// Create a copy of AnswerData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AnswerDataImplCopyWith<_$AnswerDataImpl> get copyWith =>
      __$$AnswerDataImplCopyWithImpl<_$AnswerDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AnswerDataImplToJson(this);
  }
}

abstract class _AnswerData implements AnswerData {
  const factory _AnswerData({
    required final String id,
    final String? text,
    required final Question question,
    final QuestionOption? singleOption,
    required final List<QuestionOption> multiOption,
  }) = _$AnswerDataImpl;

  factory _AnswerData.fromJson(Map<String, dynamic> json) =
      _$AnswerDataImpl.fromJson;

  @override
  String get id;
  @override
  String? get text;
  @override
  Question get question;
  @override
  QuestionOption? get singleOption;
  @override
  List<QuestionOption> get multiOption;

  /// Create a copy of AnswerData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AnswerDataImplCopyWith<_$AnswerDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Question _$QuestionFromJson(Map<String, dynamic> json) {
  return _Question.fromJson(json);
}

/// @nodoc
mixin _$Question {
  String get id => throw _privateConstructorUsedError;
  String get createdAt => throw _privateConstructorUsedError;
  String get text => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;

  /// Serializes this Question to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Question
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $QuestionCopyWith<Question> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QuestionCopyWith<$Res> {
  factory $QuestionCopyWith(Question value, $Res Function(Question) then) =
      _$QuestionCopyWithImpl<$Res, Question>;
  @useResult
  $Res call({String id, String createdAt, String text, String type});
}

/// @nodoc
class _$QuestionCopyWithImpl<$Res, $Val extends Question>
    implements $QuestionCopyWith<$Res> {
  _$QuestionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Question
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? createdAt = null,
    Object? text = null,
    Object? type = null,
  }) {
    return _then(
      _value.copyWith(
            id:
                null == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as String,
            createdAt:
                null == createdAt
                    ? _value.createdAt
                    : createdAt // ignore: cast_nullable_to_non_nullable
                        as String,
            text:
                null == text
                    ? _value.text
                    : text // ignore: cast_nullable_to_non_nullable
                        as String,
            type:
                null == type
                    ? _value.type
                    : type // ignore: cast_nullable_to_non_nullable
                        as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$QuestionImplCopyWith<$Res>
    implements $QuestionCopyWith<$Res> {
  factory _$$QuestionImplCopyWith(
    _$QuestionImpl value,
    $Res Function(_$QuestionImpl) then,
  ) = __$$QuestionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String createdAt, String text, String type});
}

/// @nodoc
class __$$QuestionImplCopyWithImpl<$Res>
    extends _$QuestionCopyWithImpl<$Res, _$QuestionImpl>
    implements _$$QuestionImplCopyWith<$Res> {
  __$$QuestionImplCopyWithImpl(
    _$QuestionImpl _value,
    $Res Function(_$QuestionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Question
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? createdAt = null,
    Object? text = null,
    Object? type = null,
  }) {
    return _then(
      _$QuestionImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as String,
        createdAt:
            null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                    as String,
        text:
            null == text
                ? _value.text
                : text // ignore: cast_nullable_to_non_nullable
                    as String,
        type:
            null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$QuestionImpl implements _Question {
  const _$QuestionImpl({
    required this.id,
    required this.createdAt,
    required this.text,
    required this.type,
  });

  factory _$QuestionImpl.fromJson(Map<String, dynamic> json) =>
      _$$QuestionImplFromJson(json);

  @override
  final String id;
  @override
  final String createdAt;
  @override
  final String text;
  @override
  final String type;

  @override
  String toString() {
    return 'Question(id: $id, createdAt: $createdAt, text: $text, type: $type)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QuestionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, createdAt, text, type);

  /// Create a copy of Question
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QuestionImplCopyWith<_$QuestionImpl> get copyWith =>
      __$$QuestionImplCopyWithImpl<_$QuestionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$QuestionImplToJson(this);
  }
}

abstract class _Question implements Question {
  const factory _Question({
    required final String id,
    required final String createdAt,
    required final String text,
    required final String type,
  }) = _$QuestionImpl;

  factory _Question.fromJson(Map<String, dynamic> json) =
      _$QuestionImpl.fromJson;

  @override
  String get id;
  @override
  String get createdAt;
  @override
  String get text;
  @override
  String get type;

  /// Create a copy of Question
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QuestionImplCopyWith<_$QuestionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

QuestionOption _$QuestionOptionFromJson(Map<String, dynamic> json) {
  return _QuestionOption.fromJson(json);
}

/// @nodoc
mixin _$QuestionOption {
  String get id => throw _privateConstructorUsedError;
  String get createdAt => throw _privateConstructorUsedError;
  String get text => throw _privateConstructorUsedError;

  /// Serializes this QuestionOption to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of QuestionOption
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $QuestionOptionCopyWith<QuestionOption> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QuestionOptionCopyWith<$Res> {
  factory $QuestionOptionCopyWith(
    QuestionOption value,
    $Res Function(QuestionOption) then,
  ) = _$QuestionOptionCopyWithImpl<$Res, QuestionOption>;
  @useResult
  $Res call({String id, String createdAt, String text});
}

/// @nodoc
class _$QuestionOptionCopyWithImpl<$Res, $Val extends QuestionOption>
    implements $QuestionOptionCopyWith<$Res> {
  _$QuestionOptionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of QuestionOption
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? createdAt = null,
    Object? text = null,
  }) {
    return _then(
      _value.copyWith(
            id:
                null == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as String,
            createdAt:
                null == createdAt
                    ? _value.createdAt
                    : createdAt // ignore: cast_nullable_to_non_nullable
                        as String,
            text:
                null == text
                    ? _value.text
                    : text // ignore: cast_nullable_to_non_nullable
                        as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$QuestionOptionImplCopyWith<$Res>
    implements $QuestionOptionCopyWith<$Res> {
  factory _$$QuestionOptionImplCopyWith(
    _$QuestionOptionImpl value,
    $Res Function(_$QuestionOptionImpl) then,
  ) = __$$QuestionOptionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String createdAt, String text});
}

/// @nodoc
class __$$QuestionOptionImplCopyWithImpl<$Res>
    extends _$QuestionOptionCopyWithImpl<$Res, _$QuestionOptionImpl>
    implements _$$QuestionOptionImplCopyWith<$Res> {
  __$$QuestionOptionImplCopyWithImpl(
    _$QuestionOptionImpl _value,
    $Res Function(_$QuestionOptionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of QuestionOption
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? createdAt = null,
    Object? text = null,
  }) {
    return _then(
      _$QuestionOptionImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as String,
        createdAt:
            null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                    as String,
        text:
            null == text
                ? _value.text
                : text // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$QuestionOptionImpl implements _QuestionOption {
  const _$QuestionOptionImpl({
    required this.id,
    required this.createdAt,
    required this.text,
  });

  factory _$QuestionOptionImpl.fromJson(Map<String, dynamic> json) =>
      _$$QuestionOptionImplFromJson(json);

  @override
  final String id;
  @override
  final String createdAt;
  @override
  final String text;

  @override
  String toString() {
    return 'QuestionOption(id: $id, createdAt: $createdAt, text: $text)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QuestionOptionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.text, text) || other.text == text));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, createdAt, text);

  /// Create a copy of QuestionOption
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QuestionOptionImplCopyWith<_$QuestionOptionImpl> get copyWith =>
      __$$QuestionOptionImplCopyWithImpl<_$QuestionOptionImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$QuestionOptionImplToJson(this);
  }
}

abstract class _QuestionOption implements QuestionOption {
  const factory _QuestionOption({
    required final String id,
    required final String createdAt,
    required final String text,
  }) = _$QuestionOptionImpl;

  factory _QuestionOption.fromJson(Map<String, dynamic> json) =
      _$QuestionOptionImpl.fromJson;

  @override
  String get id;
  @override
  String get createdAt;
  @override
  String get text;

  /// Create a copy of QuestionOption
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QuestionOptionImplCopyWith<_$QuestionOptionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Pagination _$PaginationFromJson(Map<String, dynamic> json) {
  return _Pagination.fromJson(json);
}

/// @nodoc
mixin _$Pagination {
  int get totalItems => throw _privateConstructorUsedError;
  int get totalPages => throw _privateConstructorUsedError;
  int get currentPage => throw _privateConstructorUsedError;
  int get pageSize => throw _privateConstructorUsedError;

  /// Serializes this Pagination to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Pagination
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PaginationCopyWith<Pagination> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaginationCopyWith<$Res> {
  factory $PaginationCopyWith(
    Pagination value,
    $Res Function(Pagination) then,
  ) = _$PaginationCopyWithImpl<$Res, Pagination>;
  @useResult
  $Res call({int totalItems, int totalPages, int currentPage, int pageSize});
}

/// @nodoc
class _$PaginationCopyWithImpl<$Res, $Val extends Pagination>
    implements $PaginationCopyWith<$Res> {
  _$PaginationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Pagination
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalItems = null,
    Object? totalPages = null,
    Object? currentPage = null,
    Object? pageSize = null,
  }) {
    return _then(
      _value.copyWith(
            totalItems:
                null == totalItems
                    ? _value.totalItems
                    : totalItems // ignore: cast_nullable_to_non_nullable
                        as int,
            totalPages:
                null == totalPages
                    ? _value.totalPages
                    : totalPages // ignore: cast_nullable_to_non_nullable
                        as int,
            currentPage:
                null == currentPage
                    ? _value.currentPage
                    : currentPage // ignore: cast_nullable_to_non_nullable
                        as int,
            pageSize:
                null == pageSize
                    ? _value.pageSize
                    : pageSize // ignore: cast_nullable_to_non_nullable
                        as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PaginationImplCopyWith<$Res>
    implements $PaginationCopyWith<$Res> {
  factory _$$PaginationImplCopyWith(
    _$PaginationImpl value,
    $Res Function(_$PaginationImpl) then,
  ) = __$$PaginationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int totalItems, int totalPages, int currentPage, int pageSize});
}

/// @nodoc
class __$$PaginationImplCopyWithImpl<$Res>
    extends _$PaginationCopyWithImpl<$Res, _$PaginationImpl>
    implements _$$PaginationImplCopyWith<$Res> {
  __$$PaginationImplCopyWithImpl(
    _$PaginationImpl _value,
    $Res Function(_$PaginationImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Pagination
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalItems = null,
    Object? totalPages = null,
    Object? currentPage = null,
    Object? pageSize = null,
  }) {
    return _then(
      _$PaginationImpl(
        totalItems:
            null == totalItems
                ? _value.totalItems
                : totalItems // ignore: cast_nullable_to_non_nullable
                    as int,
        totalPages:
            null == totalPages
                ? _value.totalPages
                : totalPages // ignore: cast_nullable_to_non_nullable
                    as int,
        currentPage:
            null == currentPage
                ? _value.currentPage
                : currentPage // ignore: cast_nullable_to_non_nullable
                    as int,
        pageSize:
            null == pageSize
                ? _value.pageSize
                : pageSize // ignore: cast_nullable_to_non_nullable
                    as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PaginationImpl implements _Pagination {
  const _$PaginationImpl({
    required this.totalItems,
    required this.totalPages,
    required this.currentPage,
    required this.pageSize,
  });

  factory _$PaginationImpl.fromJson(Map<String, dynamic> json) =>
      _$$PaginationImplFromJson(json);

  @override
  final int totalItems;
  @override
  final int totalPages;
  @override
  final int currentPage;
  @override
  final int pageSize;

  @override
  String toString() {
    return 'Pagination(totalItems: $totalItems, totalPages: $totalPages, currentPage: $currentPage, pageSize: $pageSize)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PaginationImpl &&
            (identical(other.totalItems, totalItems) ||
                other.totalItems == totalItems) &&
            (identical(other.totalPages, totalPages) ||
                other.totalPages == totalPages) &&
            (identical(other.currentPage, currentPage) ||
                other.currentPage == currentPage) &&
            (identical(other.pageSize, pageSize) ||
                other.pageSize == pageSize));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, totalItems, totalPages, currentPage, pageSize);

  /// Create a copy of Pagination
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PaginationImplCopyWith<_$PaginationImpl> get copyWith =>
      __$$PaginationImplCopyWithImpl<_$PaginationImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PaginationImplToJson(this);
  }
}

abstract class _Pagination implements Pagination {
  const factory _Pagination({
    required final int totalItems,
    required final int totalPages,
    required final int currentPage,
    required final int pageSize,
  }) = _$PaginationImpl;

  factory _Pagination.fromJson(Map<String, dynamic> json) =
      _$PaginationImpl.fromJson;

  @override
  int get totalItems;
  @override
  int get totalPages;
  @override
  int get currentPage;
  @override
  int get pageSize;

  /// Create a copy of Pagination
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PaginationImplCopyWith<_$PaginationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
