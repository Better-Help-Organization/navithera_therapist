// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ChatListResponse _$ChatListResponseFromJson(Map<String, dynamic> json) {
  return _ChatListResponse.fromJson(json);
}

/// @nodoc
mixin _$ChatListResponse {
  List<ChatThread> get data => throw _privateConstructorUsedError;
  Pagination get pagination => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  int get statusCode => throw _privateConstructorUsedError;

  /// Serializes this ChatListResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ChatListResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChatListResponseCopyWith<ChatListResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatListResponseCopyWith<$Res> {
  factory $ChatListResponseCopyWith(
    ChatListResponse value,
    $Res Function(ChatListResponse) then,
  ) = _$ChatListResponseCopyWithImpl<$Res, ChatListResponse>;
  @useResult
  $Res call({
    List<ChatThread> data,
    Pagination pagination,
    String message,
    int statusCode,
  });

  $PaginationCopyWith<$Res> get pagination;
}

/// @nodoc
class _$ChatListResponseCopyWithImpl<$Res, $Val extends ChatListResponse>
    implements $ChatListResponseCopyWith<$Res> {
  _$ChatListResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChatListResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
    Object? pagination = null,
    Object? message = null,
    Object? statusCode = null,
  }) {
    return _then(
      _value.copyWith(
            data:
                null == data
                    ? _value.data
                    : data // ignore: cast_nullable_to_non_nullable
                        as List<ChatThread>,
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
          )
          as $Val,
    );
  }

  /// Create a copy of ChatListResponse
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
abstract class _$$ChatListResponseImplCopyWith<$Res>
    implements $ChatListResponseCopyWith<$Res> {
  factory _$$ChatListResponseImplCopyWith(
    _$ChatListResponseImpl value,
    $Res Function(_$ChatListResponseImpl) then,
  ) = __$$ChatListResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<ChatThread> data,
    Pagination pagination,
    String message,
    int statusCode,
  });

  @override
  $PaginationCopyWith<$Res> get pagination;
}

/// @nodoc
class __$$ChatListResponseImplCopyWithImpl<$Res>
    extends _$ChatListResponseCopyWithImpl<$Res, _$ChatListResponseImpl>
    implements _$$ChatListResponseImplCopyWith<$Res> {
  __$$ChatListResponseImplCopyWithImpl(
    _$ChatListResponseImpl _value,
    $Res Function(_$ChatListResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ChatListResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
    Object? pagination = null,
    Object? message = null,
    Object? statusCode = null,
  }) {
    return _then(
      _$ChatListResponseImpl(
        data:
            null == data
                ? _value._data
                : data // ignore: cast_nullable_to_non_nullable
                    as List<ChatThread>,
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
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ChatListResponseImpl implements _ChatListResponse {
  const _$ChatListResponseImpl({
    required final List<ChatThread> data,
    required this.pagination,
    required this.message,
    required this.statusCode,
  }) : _data = data;

  factory _$ChatListResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChatListResponseImplFromJson(json);

  final List<ChatThread> _data;
  @override
  List<ChatThread> get data {
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
  String toString() {
    return 'ChatListResponse(data: $data, pagination: $pagination, message: $message, statusCode: $statusCode)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatListResponseImpl &&
            const DeepCollectionEquality().equals(other._data, _data) &&
            (identical(other.pagination, pagination) ||
                other.pagination == pagination) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.statusCode, statusCode) ||
                other.statusCode == statusCode));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_data),
    pagination,
    message,
    statusCode,
  );

  /// Create a copy of ChatListResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatListResponseImplCopyWith<_$ChatListResponseImpl> get copyWith =>
      __$$ChatListResponseImplCopyWithImpl<_$ChatListResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ChatListResponseImplToJson(this);
  }
}

abstract class _ChatListResponse implements ChatListResponse {
  const factory _ChatListResponse({
    required final List<ChatThread> data,
    required final Pagination pagination,
    required final String message,
    required final int statusCode,
  }) = _$ChatListResponseImpl;

  factory _ChatListResponse.fromJson(Map<String, dynamic> json) =
      _$ChatListResponseImpl.fromJson;

  @override
  List<ChatThread> get data;
  @override
  Pagination get pagination;
  @override
  String get message;
  @override
  int get statusCode;

  /// Create a copy of ChatListResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChatListResponseImplCopyWith<_$ChatListResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ChatThread _$ChatThreadFromJson(Map<String, dynamic> json) {
  return _ChatThread.fromJson(json);
}

/// @nodoc
mixin _$ChatThread {
  String get id =>
      throw _privateConstructorUsedError; // required DateTime createdAt,
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  UserModel? get client =>
      throw _privateConstructorUsedError; // Make client nullable
  List<UserModel> get group =>
      throw _privateConstructorUsedError; // Add group list
  UserModel get therapist => throw _privateConstructorUsedError;
  List<ChatMessage>? get message => throw _privateConstructorUsedError;
  ChatMessage? get lastMessage => throw _privateConstructorUsedError;
  int? get unreadCount => throw _privateConstructorUsedError;
  String? get groupName => throw _privateConstructorUsedError;

  /// Serializes this ChatThread to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ChatThread
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChatThreadCopyWith<ChatThread> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatThreadCopyWith<$Res> {
  factory $ChatThreadCopyWith(
    ChatThread value,
    $Res Function(ChatThread) then,
  ) = _$ChatThreadCopyWithImpl<$Res, ChatThread>;
  @useResult
  $Res call({
    String id,
    DateTime? updatedAt,
    UserModel? client,
    List<UserModel> group,
    UserModel therapist,
    List<ChatMessage>? message,
    ChatMessage? lastMessage,
    int? unreadCount,
    String? groupName,
  });

  $UserModelCopyWith<$Res>? get client;
  $UserModelCopyWith<$Res> get therapist;
  $ChatMessageCopyWith<$Res>? get lastMessage;
}

/// @nodoc
class _$ChatThreadCopyWithImpl<$Res, $Val extends ChatThread>
    implements $ChatThreadCopyWith<$Res> {
  _$ChatThreadCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChatThread
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? updatedAt = freezed,
    Object? client = freezed,
    Object? group = null,
    Object? therapist = null,
    Object? message = freezed,
    Object? lastMessage = freezed,
    Object? unreadCount = freezed,
    Object? groupName = freezed,
  }) {
    return _then(
      _value.copyWith(
            id:
                null == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as String,
            updatedAt:
                freezed == updatedAt
                    ? _value.updatedAt
                    : updatedAt // ignore: cast_nullable_to_non_nullable
                        as DateTime?,
            client:
                freezed == client
                    ? _value.client
                    : client // ignore: cast_nullable_to_non_nullable
                        as UserModel?,
            group:
                null == group
                    ? _value.group
                    : group // ignore: cast_nullable_to_non_nullable
                        as List<UserModel>,
            therapist:
                null == therapist
                    ? _value.therapist
                    : therapist // ignore: cast_nullable_to_non_nullable
                        as UserModel,
            message:
                freezed == message
                    ? _value.message
                    : message // ignore: cast_nullable_to_non_nullable
                        as List<ChatMessage>?,
            lastMessage:
                freezed == lastMessage
                    ? _value.lastMessage
                    : lastMessage // ignore: cast_nullable_to_non_nullable
                        as ChatMessage?,
            unreadCount:
                freezed == unreadCount
                    ? _value.unreadCount
                    : unreadCount // ignore: cast_nullable_to_non_nullable
                        as int?,
            groupName:
                freezed == groupName
                    ? _value.groupName
                    : groupName // ignore: cast_nullable_to_non_nullable
                        as String?,
          )
          as $Val,
    );
  }

  /// Create a copy of ChatThread
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserModelCopyWith<$Res>? get client {
    if (_value.client == null) {
      return null;
    }

    return $UserModelCopyWith<$Res>(_value.client!, (value) {
      return _then(_value.copyWith(client: value) as $Val);
    });
  }

  /// Create a copy of ChatThread
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserModelCopyWith<$Res> get therapist {
    return $UserModelCopyWith<$Res>(_value.therapist, (value) {
      return _then(_value.copyWith(therapist: value) as $Val);
    });
  }

  /// Create a copy of ChatThread
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ChatMessageCopyWith<$Res>? get lastMessage {
    if (_value.lastMessage == null) {
      return null;
    }

    return $ChatMessageCopyWith<$Res>(_value.lastMessage!, (value) {
      return _then(_value.copyWith(lastMessage: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ChatThreadImplCopyWith<$Res>
    implements $ChatThreadCopyWith<$Res> {
  factory _$$ChatThreadImplCopyWith(
    _$ChatThreadImpl value,
    $Res Function(_$ChatThreadImpl) then,
  ) = __$$ChatThreadImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    DateTime? updatedAt,
    UserModel? client,
    List<UserModel> group,
    UserModel therapist,
    List<ChatMessage>? message,
    ChatMessage? lastMessage,
    int? unreadCount,
    String? groupName,
  });

  @override
  $UserModelCopyWith<$Res>? get client;
  @override
  $UserModelCopyWith<$Res> get therapist;
  @override
  $ChatMessageCopyWith<$Res>? get lastMessage;
}

/// @nodoc
class __$$ChatThreadImplCopyWithImpl<$Res>
    extends _$ChatThreadCopyWithImpl<$Res, _$ChatThreadImpl>
    implements _$$ChatThreadImplCopyWith<$Res> {
  __$$ChatThreadImplCopyWithImpl(
    _$ChatThreadImpl _value,
    $Res Function(_$ChatThreadImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ChatThread
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? updatedAt = freezed,
    Object? client = freezed,
    Object? group = null,
    Object? therapist = null,
    Object? message = freezed,
    Object? lastMessage = freezed,
    Object? unreadCount = freezed,
    Object? groupName = freezed,
  }) {
    return _then(
      _$ChatThreadImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as String,
        updatedAt:
            freezed == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                    as DateTime?,
        client:
            freezed == client
                ? _value.client
                : client // ignore: cast_nullable_to_non_nullable
                    as UserModel?,
        group:
            null == group
                ? _value._group
                : group // ignore: cast_nullable_to_non_nullable
                    as List<UserModel>,
        therapist:
            null == therapist
                ? _value.therapist
                : therapist // ignore: cast_nullable_to_non_nullable
                    as UserModel,
        message:
            freezed == message
                ? _value._message
                : message // ignore: cast_nullable_to_non_nullable
                    as List<ChatMessage>?,
        lastMessage:
            freezed == lastMessage
                ? _value.lastMessage
                : lastMessage // ignore: cast_nullable_to_non_nullable
                    as ChatMessage?,
        unreadCount:
            freezed == unreadCount
                ? _value.unreadCount
                : unreadCount // ignore: cast_nullable_to_non_nullable
                    as int?,
        groupName:
            freezed == groupName
                ? _value.groupName
                : groupName // ignore: cast_nullable_to_non_nullable
                    as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ChatThreadImpl implements _ChatThread {
  const _$ChatThreadImpl({
    required this.id,
    this.updatedAt,
    required this.client,
    required final List<UserModel> group,
    required this.therapist,
    final List<ChatMessage>? message,
    this.lastMessage,
    this.unreadCount,
    this.groupName,
  }) : _group = group,
       _message = message;

  factory _$ChatThreadImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChatThreadImplFromJson(json);

  @override
  final String id;
  // required DateTime createdAt,
  @override
  final DateTime? updatedAt;
  @override
  final UserModel? client;
  // Make client nullable
  final List<UserModel> _group;
  // Make client nullable
  @override
  List<UserModel> get group {
    if (_group is EqualUnmodifiableListView) return _group;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_group);
  }

  // Add group list
  @override
  final UserModel therapist;
  final List<ChatMessage>? _message;
  @override
  List<ChatMessage>? get message {
    final value = _message;
    if (value == null) return null;
    if (_message is EqualUnmodifiableListView) return _message;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final ChatMessage? lastMessage;
  @override
  final int? unreadCount;
  @override
  final String? groupName;

  @override
  String toString() {
    return 'ChatThread(id: $id, updatedAt: $updatedAt, client: $client, group: $group, therapist: $therapist, message: $message, lastMessage: $lastMessage, unreadCount: $unreadCount, groupName: $groupName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatThreadImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.client, client) || other.client == client) &&
            const DeepCollectionEquality().equals(other._group, _group) &&
            (identical(other.therapist, therapist) ||
                other.therapist == therapist) &&
            const DeepCollectionEquality().equals(other._message, _message) &&
            (identical(other.lastMessage, lastMessage) ||
                other.lastMessage == lastMessage) &&
            (identical(other.unreadCount, unreadCount) ||
                other.unreadCount == unreadCount) &&
            (identical(other.groupName, groupName) ||
                other.groupName == groupName));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    updatedAt,
    client,
    const DeepCollectionEquality().hash(_group),
    therapist,
    const DeepCollectionEquality().hash(_message),
    lastMessage,
    unreadCount,
    groupName,
  );

  /// Create a copy of ChatThread
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatThreadImplCopyWith<_$ChatThreadImpl> get copyWith =>
      __$$ChatThreadImplCopyWithImpl<_$ChatThreadImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChatThreadImplToJson(this);
  }
}

abstract class _ChatThread implements ChatThread {
  const factory _ChatThread({
    required final String id,
    final DateTime? updatedAt,
    required final UserModel? client,
    required final List<UserModel> group,
    required final UserModel therapist,
    final List<ChatMessage>? message,
    final ChatMessage? lastMessage,
    final int? unreadCount,
    final String? groupName,
  }) = _$ChatThreadImpl;

  factory _ChatThread.fromJson(Map<String, dynamic> json) =
      _$ChatThreadImpl.fromJson;

  @override
  String get id; // required DateTime createdAt,
  @override
  DateTime? get updatedAt;
  @override
  UserModel? get client; // Make client nullable
  @override
  List<UserModel> get group; // Add group list
  @override
  UserModel get therapist;
  @override
  List<ChatMessage>? get message;
  @override
  ChatMessage? get lastMessage;
  @override
  int? get unreadCount;
  @override
  String? get groupName;

  /// Create a copy of ChatThread
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChatThreadImplCopyWith<_$ChatThreadImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ChatMessageResponse _$ChatMessageResponseFromJson(Map<String, dynamic> json) {
  return _ChatMessageResponse.fromJson(json);
}

/// @nodoc
mixin _$ChatMessageResponse {
  List<ChatMessageDetail> get data => throw _privateConstructorUsedError;
  Pagination get pagination => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  int get statusCode => throw _privateConstructorUsedError;

  /// Serializes this ChatMessageResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ChatMessageResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChatMessageResponseCopyWith<ChatMessageResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatMessageResponseCopyWith<$Res> {
  factory $ChatMessageResponseCopyWith(
    ChatMessageResponse value,
    $Res Function(ChatMessageResponse) then,
  ) = _$ChatMessageResponseCopyWithImpl<$Res, ChatMessageResponse>;
  @useResult
  $Res call({
    List<ChatMessageDetail> data,
    Pagination pagination,
    String message,
    int statusCode,
  });

  $PaginationCopyWith<$Res> get pagination;
}

/// @nodoc
class _$ChatMessageResponseCopyWithImpl<$Res, $Val extends ChatMessageResponse>
    implements $ChatMessageResponseCopyWith<$Res> {
  _$ChatMessageResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChatMessageResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
    Object? pagination = null,
    Object? message = null,
    Object? statusCode = null,
  }) {
    return _then(
      _value.copyWith(
            data:
                null == data
                    ? _value.data
                    : data // ignore: cast_nullable_to_non_nullable
                        as List<ChatMessageDetail>,
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
          )
          as $Val,
    );
  }

  /// Create a copy of ChatMessageResponse
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
abstract class _$$ChatMessageResponseImplCopyWith<$Res>
    implements $ChatMessageResponseCopyWith<$Res> {
  factory _$$ChatMessageResponseImplCopyWith(
    _$ChatMessageResponseImpl value,
    $Res Function(_$ChatMessageResponseImpl) then,
  ) = __$$ChatMessageResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<ChatMessageDetail> data,
    Pagination pagination,
    String message,
    int statusCode,
  });

  @override
  $PaginationCopyWith<$Res> get pagination;
}

/// @nodoc
class __$$ChatMessageResponseImplCopyWithImpl<$Res>
    extends _$ChatMessageResponseCopyWithImpl<$Res, _$ChatMessageResponseImpl>
    implements _$$ChatMessageResponseImplCopyWith<$Res> {
  __$$ChatMessageResponseImplCopyWithImpl(
    _$ChatMessageResponseImpl _value,
    $Res Function(_$ChatMessageResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ChatMessageResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
    Object? pagination = null,
    Object? message = null,
    Object? statusCode = null,
  }) {
    return _then(
      _$ChatMessageResponseImpl(
        data:
            null == data
                ? _value._data
                : data // ignore: cast_nullable_to_non_nullable
                    as List<ChatMessageDetail>,
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
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ChatMessageResponseImpl implements _ChatMessageResponse {
  const _$ChatMessageResponseImpl({
    required final List<ChatMessageDetail> data,
    required this.pagination,
    required this.message,
    required this.statusCode,
  }) : _data = data;

  factory _$ChatMessageResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChatMessageResponseImplFromJson(json);

  final List<ChatMessageDetail> _data;
  @override
  List<ChatMessageDetail> get data {
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
  String toString() {
    return 'ChatMessageResponse(data: $data, pagination: $pagination, message: $message, statusCode: $statusCode)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatMessageResponseImpl &&
            const DeepCollectionEquality().equals(other._data, _data) &&
            (identical(other.pagination, pagination) ||
                other.pagination == pagination) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.statusCode, statusCode) ||
                other.statusCode == statusCode));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_data),
    pagination,
    message,
    statusCode,
  );

  /// Create a copy of ChatMessageResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatMessageResponseImplCopyWith<_$ChatMessageResponseImpl> get copyWith =>
      __$$ChatMessageResponseImplCopyWithImpl<_$ChatMessageResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ChatMessageResponseImplToJson(this);
  }
}

abstract class _ChatMessageResponse implements ChatMessageResponse {
  const factory _ChatMessageResponse({
    required final List<ChatMessageDetail> data,
    required final Pagination pagination,
    required final String message,
    required final int statusCode,
  }) = _$ChatMessageResponseImpl;

  factory _ChatMessageResponse.fromJson(Map<String, dynamic> json) =
      _$ChatMessageResponseImpl.fromJson;

  @override
  List<ChatMessageDetail> get data;
  @override
  Pagination get pagination;
  @override
  String get message;
  @override
  int get statusCode;

  /// Create a copy of ChatMessageResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChatMessageResponseImplCopyWith<_$ChatMessageResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ChatMessageDetail _$ChatMessageDetailFromJson(Map<String, dynamic> json) {
  return _ChatMessageDetail.fromJson(json);
}

/// @nodoc
mixin _$ChatMessageDetail {
  String get id => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  UserModel? get therapist => throw _privateConstructorUsedError;
  UserModel? get client => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  ChatMessage? get lastMessage => throw _privateConstructorUsedError;
  bool? get isRead =>
      throw _privateConstructorUsedError; // UI-only fields (ignored by JSON)
  @JsonKey(ignore: true)
  bool get isPending => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  bool get isFailed => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  String? get localId => throw _privateConstructorUsedError;

  /// Serializes this ChatMessageDetail to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ChatMessageDetail
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChatMessageDetailCopyWith<ChatMessageDetail> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatMessageDetailCopyWith<$Res> {
  factory $ChatMessageDetailCopyWith(
    ChatMessageDetail value,
    $Res Function(ChatMessageDetail) then,
  ) = _$ChatMessageDetailCopyWithImpl<$Res, ChatMessageDetail>;
  @useResult
  $Res call({
    String id,
    String content,
    DateTime createdAt,
    UserModel? therapist,
    UserModel? client,
    DateTime? updatedAt,
    ChatMessage? lastMessage,
    bool? isRead,
    @JsonKey(ignore: true) bool isPending,
    @JsonKey(ignore: true) bool isFailed,
    @JsonKey(ignore: true) String? localId,
  });

  $UserModelCopyWith<$Res>? get therapist;
  $UserModelCopyWith<$Res>? get client;
  $ChatMessageCopyWith<$Res>? get lastMessage;
}

/// @nodoc
class _$ChatMessageDetailCopyWithImpl<$Res, $Val extends ChatMessageDetail>
    implements $ChatMessageDetailCopyWith<$Res> {
  _$ChatMessageDetailCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChatMessageDetail
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? content = null,
    Object? createdAt = null,
    Object? therapist = freezed,
    Object? client = freezed,
    Object? updatedAt = freezed,
    Object? lastMessage = freezed,
    Object? isRead = freezed,
    Object? isPending = null,
    Object? isFailed = null,
    Object? localId = freezed,
  }) {
    return _then(
      _value.copyWith(
            id:
                null == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as String,
            content:
                null == content
                    ? _value.content
                    : content // ignore: cast_nullable_to_non_nullable
                        as String,
            createdAt:
                null == createdAt
                    ? _value.createdAt
                    : createdAt // ignore: cast_nullable_to_non_nullable
                        as DateTime,
            therapist:
                freezed == therapist
                    ? _value.therapist
                    : therapist // ignore: cast_nullable_to_non_nullable
                        as UserModel?,
            client:
                freezed == client
                    ? _value.client
                    : client // ignore: cast_nullable_to_non_nullable
                        as UserModel?,
            updatedAt:
                freezed == updatedAt
                    ? _value.updatedAt
                    : updatedAt // ignore: cast_nullable_to_non_nullable
                        as DateTime?,
            lastMessage:
                freezed == lastMessage
                    ? _value.lastMessage
                    : lastMessage // ignore: cast_nullable_to_non_nullable
                        as ChatMessage?,
            isRead:
                freezed == isRead
                    ? _value.isRead
                    : isRead // ignore: cast_nullable_to_non_nullable
                        as bool?,
            isPending:
                null == isPending
                    ? _value.isPending
                    : isPending // ignore: cast_nullable_to_non_nullable
                        as bool,
            isFailed:
                null == isFailed
                    ? _value.isFailed
                    : isFailed // ignore: cast_nullable_to_non_nullable
                        as bool,
            localId:
                freezed == localId
                    ? _value.localId
                    : localId // ignore: cast_nullable_to_non_nullable
                        as String?,
          )
          as $Val,
    );
  }

  /// Create a copy of ChatMessageDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserModelCopyWith<$Res>? get therapist {
    if (_value.therapist == null) {
      return null;
    }

    return $UserModelCopyWith<$Res>(_value.therapist!, (value) {
      return _then(_value.copyWith(therapist: value) as $Val);
    });
  }

  /// Create a copy of ChatMessageDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserModelCopyWith<$Res>? get client {
    if (_value.client == null) {
      return null;
    }

    return $UserModelCopyWith<$Res>(_value.client!, (value) {
      return _then(_value.copyWith(client: value) as $Val);
    });
  }

  /// Create a copy of ChatMessageDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ChatMessageCopyWith<$Res>? get lastMessage {
    if (_value.lastMessage == null) {
      return null;
    }

    return $ChatMessageCopyWith<$Res>(_value.lastMessage!, (value) {
      return _then(_value.copyWith(lastMessage: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ChatMessageDetailImplCopyWith<$Res>
    implements $ChatMessageDetailCopyWith<$Res> {
  factory _$$ChatMessageDetailImplCopyWith(
    _$ChatMessageDetailImpl value,
    $Res Function(_$ChatMessageDetailImpl) then,
  ) = __$$ChatMessageDetailImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String content,
    DateTime createdAt,
    UserModel? therapist,
    UserModel? client,
    DateTime? updatedAt,
    ChatMessage? lastMessage,
    bool? isRead,
    @JsonKey(ignore: true) bool isPending,
    @JsonKey(ignore: true) bool isFailed,
    @JsonKey(ignore: true) String? localId,
  });

  @override
  $UserModelCopyWith<$Res>? get therapist;
  @override
  $UserModelCopyWith<$Res>? get client;
  @override
  $ChatMessageCopyWith<$Res>? get lastMessage;
}

/// @nodoc
class __$$ChatMessageDetailImplCopyWithImpl<$Res>
    extends _$ChatMessageDetailCopyWithImpl<$Res, _$ChatMessageDetailImpl>
    implements _$$ChatMessageDetailImplCopyWith<$Res> {
  __$$ChatMessageDetailImplCopyWithImpl(
    _$ChatMessageDetailImpl _value,
    $Res Function(_$ChatMessageDetailImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ChatMessageDetail
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? content = null,
    Object? createdAt = null,
    Object? therapist = freezed,
    Object? client = freezed,
    Object? updatedAt = freezed,
    Object? lastMessage = freezed,
    Object? isRead = freezed,
    Object? isPending = null,
    Object? isFailed = null,
    Object? localId = freezed,
  }) {
    return _then(
      _$ChatMessageDetailImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as String,
        content:
            null == content
                ? _value.content
                : content // ignore: cast_nullable_to_non_nullable
                    as String,
        createdAt:
            null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                    as DateTime,
        therapist:
            freezed == therapist
                ? _value.therapist
                : therapist // ignore: cast_nullable_to_non_nullable
                    as UserModel?,
        client:
            freezed == client
                ? _value.client
                : client // ignore: cast_nullable_to_non_nullable
                    as UserModel?,
        updatedAt:
            freezed == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                    as DateTime?,
        lastMessage:
            freezed == lastMessage
                ? _value.lastMessage
                : lastMessage // ignore: cast_nullable_to_non_nullable
                    as ChatMessage?,
        isRead:
            freezed == isRead
                ? _value.isRead
                : isRead // ignore: cast_nullable_to_non_nullable
                    as bool?,
        isPending:
            null == isPending
                ? _value.isPending
                : isPending // ignore: cast_nullable_to_non_nullable
                    as bool,
        isFailed:
            null == isFailed
                ? _value.isFailed
                : isFailed // ignore: cast_nullable_to_non_nullable
                    as bool,
        localId:
            freezed == localId
                ? _value.localId
                : localId // ignore: cast_nullable_to_non_nullable
                    as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ChatMessageDetailImpl implements _ChatMessageDetail {
  const _$ChatMessageDetailImpl({
    required this.id,
    required this.content,
    required this.createdAt,
    required this.therapist,
    required this.client,
    this.updatedAt,
    this.lastMessage,
    this.isRead,
    @JsonKey(ignore: true) this.isPending = false,
    @JsonKey(ignore: true) this.isFailed = false,
    @JsonKey(ignore: true) this.localId,
  });

  factory _$ChatMessageDetailImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChatMessageDetailImplFromJson(json);

  @override
  final String id;
  @override
  final String content;
  @override
  final DateTime createdAt;
  @override
  final UserModel? therapist;
  @override
  final UserModel? client;
  @override
  final DateTime? updatedAt;
  @override
  final ChatMessage? lastMessage;
  @override
  final bool? isRead;
  // UI-only fields (ignored by JSON)
  @override
  @JsonKey(ignore: true)
  final bool isPending;
  @override
  @JsonKey(ignore: true)
  final bool isFailed;
  @override
  @JsonKey(ignore: true)
  final String? localId;

  @override
  String toString() {
    return 'ChatMessageDetail(id: $id, content: $content, createdAt: $createdAt, therapist: $therapist, client: $client, updatedAt: $updatedAt, lastMessage: $lastMessage, isRead: $isRead, isPending: $isPending, isFailed: $isFailed, localId: $localId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatMessageDetailImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.therapist, therapist) ||
                other.therapist == therapist) &&
            (identical(other.client, client) || other.client == client) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.lastMessage, lastMessage) ||
                other.lastMessage == lastMessage) &&
            (identical(other.isRead, isRead) || other.isRead == isRead) &&
            (identical(other.isPending, isPending) ||
                other.isPending == isPending) &&
            (identical(other.isFailed, isFailed) ||
                other.isFailed == isFailed) &&
            (identical(other.localId, localId) || other.localId == localId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    content,
    createdAt,
    therapist,
    client,
    updatedAt,
    lastMessage,
    isRead,
    isPending,
    isFailed,
    localId,
  );

  /// Create a copy of ChatMessageDetail
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatMessageDetailImplCopyWith<_$ChatMessageDetailImpl> get copyWith =>
      __$$ChatMessageDetailImplCopyWithImpl<_$ChatMessageDetailImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ChatMessageDetailImplToJson(this);
  }
}

abstract class _ChatMessageDetail implements ChatMessageDetail {
  const factory _ChatMessageDetail({
    required final String id,
    required final String content,
    required final DateTime createdAt,
    required final UserModel? therapist,
    required final UserModel? client,
    final DateTime? updatedAt,
    final ChatMessage? lastMessage,
    final bool? isRead,
    @JsonKey(ignore: true) final bool isPending,
    @JsonKey(ignore: true) final bool isFailed,
    @JsonKey(ignore: true) final String? localId,
  }) = _$ChatMessageDetailImpl;

  factory _ChatMessageDetail.fromJson(Map<String, dynamic> json) =
      _$ChatMessageDetailImpl.fromJson;

  @override
  String get id;
  @override
  String get content;
  @override
  DateTime get createdAt;
  @override
  UserModel? get therapist;
  @override
  UserModel? get client;
  @override
  DateTime? get updatedAt;
  @override
  ChatMessage? get lastMessage;
  @override
  bool? get isRead; // UI-only fields (ignored by JSON)
  @override
  @JsonKey(ignore: true)
  bool get isPending;
  @override
  @JsonKey(ignore: true)
  bool get isFailed;
  @override
  @JsonKey(ignore: true)
  String? get localId;

  /// Create a copy of ChatMessageDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChatMessageDetailImplCopyWith<_$ChatMessageDetailImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ChatMessage _$ChatMessageFromJson(Map<String, dynamic> json) {
  return _ChatMessage.fromJson(json);
}

/// @nodoc
mixin _$ChatMessage {
  String get id => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  DateTime get createdAt =>
      throw _privateConstructorUsedError; // required String senderId,
  bool? get isRead => throw _privateConstructorUsedError;

  /// Serializes this ChatMessage to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ChatMessage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChatMessageCopyWith<ChatMessage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatMessageCopyWith<$Res> {
  factory $ChatMessageCopyWith(
    ChatMessage value,
    $Res Function(ChatMessage) then,
  ) = _$ChatMessageCopyWithImpl<$Res, ChatMessage>;
  @useResult
  $Res call({String id, String content, DateTime createdAt, bool? isRead});
}

/// @nodoc
class _$ChatMessageCopyWithImpl<$Res, $Val extends ChatMessage>
    implements $ChatMessageCopyWith<$Res> {
  _$ChatMessageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChatMessage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? content = null,
    Object? createdAt = null,
    Object? isRead = freezed,
  }) {
    return _then(
      _value.copyWith(
            id:
                null == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as String,
            content:
                null == content
                    ? _value.content
                    : content // ignore: cast_nullable_to_non_nullable
                        as String,
            createdAt:
                null == createdAt
                    ? _value.createdAt
                    : createdAt // ignore: cast_nullable_to_non_nullable
                        as DateTime,
            isRead:
                freezed == isRead
                    ? _value.isRead
                    : isRead // ignore: cast_nullable_to_non_nullable
                        as bool?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ChatMessageImplCopyWith<$Res>
    implements $ChatMessageCopyWith<$Res> {
  factory _$$ChatMessageImplCopyWith(
    _$ChatMessageImpl value,
    $Res Function(_$ChatMessageImpl) then,
  ) = __$$ChatMessageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String content, DateTime createdAt, bool? isRead});
}

/// @nodoc
class __$$ChatMessageImplCopyWithImpl<$Res>
    extends _$ChatMessageCopyWithImpl<$Res, _$ChatMessageImpl>
    implements _$$ChatMessageImplCopyWith<$Res> {
  __$$ChatMessageImplCopyWithImpl(
    _$ChatMessageImpl _value,
    $Res Function(_$ChatMessageImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ChatMessage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? content = null,
    Object? createdAt = null,
    Object? isRead = freezed,
  }) {
    return _then(
      _$ChatMessageImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as String,
        content:
            null == content
                ? _value.content
                : content // ignore: cast_nullable_to_non_nullable
                    as String,
        createdAt:
            null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                    as DateTime,
        isRead:
            freezed == isRead
                ? _value.isRead
                : isRead // ignore: cast_nullable_to_non_nullable
                    as bool?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ChatMessageImpl implements _ChatMessage {
  const _$ChatMessageImpl({
    required this.id,
    required this.content,
    required this.createdAt,
    this.isRead,
  });

  factory _$ChatMessageImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChatMessageImplFromJson(json);

  @override
  final String id;
  @override
  final String content;
  @override
  final DateTime createdAt;
  // required String senderId,
  @override
  final bool? isRead;

  @override
  String toString() {
    return 'ChatMessage(id: $id, content: $content, createdAt: $createdAt, isRead: $isRead)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatMessageImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.isRead, isRead) || other.isRead == isRead));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, content, createdAt, isRead);

  /// Create a copy of ChatMessage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatMessageImplCopyWith<_$ChatMessageImpl> get copyWith =>
      __$$ChatMessageImplCopyWithImpl<_$ChatMessageImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChatMessageImplToJson(this);
  }
}

abstract class _ChatMessage implements ChatMessage {
  const factory _ChatMessage({
    required final String id,
    required final String content,
    required final DateTime createdAt,
    final bool? isRead,
  }) = _$ChatMessageImpl;

  factory _ChatMessage.fromJson(Map<String, dynamic> json) =
      _$ChatMessageImpl.fromJson;

  @override
  String get id;
  @override
  String get content;
  @override
  DateTime get createdAt; // required String senderId,
  @override
  bool? get isRead;

  /// Create a copy of ChatMessage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChatMessageImplCopyWith<_$ChatMessageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MessageSendResponse _$MessageSendResponseFromJson(Map<String, dynamic> json) {
  return _MessageSendResponse.fromJson(json);
}

/// @nodoc
mixin _$MessageSendResponse {
  String get message => throw _privateConstructorUsedError;
  int get statusCode => throw _privateConstructorUsedError;
  String get method => throw _privateConstructorUsedError;
  String get path => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;

  /// Serializes this MessageSendResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MessageSendResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MessageSendResponseCopyWith<MessageSendResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MessageSendResponseCopyWith<$Res> {
  factory $MessageSendResponseCopyWith(
    MessageSendResponse value,
    $Res Function(MessageSendResponse) then,
  ) = _$MessageSendResponseCopyWithImpl<$Res, MessageSendResponse>;
  @useResult
  $Res call({
    String message,
    int statusCode,
    String method,
    String path,
    DateTime timestamp,
  });
}

/// @nodoc
class _$MessageSendResponseCopyWithImpl<$Res, $Val extends MessageSendResponse>
    implements $MessageSendResponseCopyWith<$Res> {
  _$MessageSendResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MessageSendResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? statusCode = null,
    Object? method = null,
    Object? path = null,
    Object? timestamp = null,
  }) {
    return _then(
      _value.copyWith(
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
                null == method
                    ? _value.method
                    : method // ignore: cast_nullable_to_non_nullable
                        as String,
            path:
                null == path
                    ? _value.path
                    : path // ignore: cast_nullable_to_non_nullable
                        as String,
            timestamp:
                null == timestamp
                    ? _value.timestamp
                    : timestamp // ignore: cast_nullable_to_non_nullable
                        as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$MessageSendResponseImplCopyWith<$Res>
    implements $MessageSendResponseCopyWith<$Res> {
  factory _$$MessageSendResponseImplCopyWith(
    _$MessageSendResponseImpl value,
    $Res Function(_$MessageSendResponseImpl) then,
  ) = __$$MessageSendResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String message,
    int statusCode,
    String method,
    String path,
    DateTime timestamp,
  });
}

/// @nodoc
class __$$MessageSendResponseImplCopyWithImpl<$Res>
    extends _$MessageSendResponseCopyWithImpl<$Res, _$MessageSendResponseImpl>
    implements _$$MessageSendResponseImplCopyWith<$Res> {
  __$$MessageSendResponseImplCopyWithImpl(
    _$MessageSendResponseImpl _value,
    $Res Function(_$MessageSendResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MessageSendResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? statusCode = null,
    Object? method = null,
    Object? path = null,
    Object? timestamp = null,
  }) {
    return _then(
      _$MessageSendResponseImpl(
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
            null == method
                ? _value.method
                : method // ignore: cast_nullable_to_non_nullable
                    as String,
        path:
            null == path
                ? _value.path
                : path // ignore: cast_nullable_to_non_nullable
                    as String,
        timestamp:
            null == timestamp
                ? _value.timestamp
                : timestamp // ignore: cast_nullable_to_non_nullable
                    as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$MessageSendResponseImpl implements _MessageSendResponse {
  const _$MessageSendResponseImpl({
    required this.message,
    required this.statusCode,
    required this.method,
    required this.path,
    required this.timestamp,
  });

  factory _$MessageSendResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$MessageSendResponseImplFromJson(json);

  @override
  final String message;
  @override
  final int statusCode;
  @override
  final String method;
  @override
  final String path;
  @override
  final DateTime timestamp;

  @override
  String toString() {
    return 'MessageSendResponse(message: $message, statusCode: $statusCode, method: $method, path: $path, timestamp: $timestamp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MessageSendResponseImpl &&
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
  int get hashCode =>
      Object.hash(runtimeType, message, statusCode, method, path, timestamp);

  /// Create a copy of MessageSendResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MessageSendResponseImplCopyWith<_$MessageSendResponseImpl> get copyWith =>
      __$$MessageSendResponseImplCopyWithImpl<_$MessageSendResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$MessageSendResponseImplToJson(this);
  }
}

abstract class _MessageSendResponse implements MessageSendResponse {
  const factory _MessageSendResponse({
    required final String message,
    required final int statusCode,
    required final String method,
    required final String path,
    required final DateTime timestamp,
  }) = _$MessageSendResponseImpl;

  factory _MessageSendResponse.fromJson(Map<String, dynamic> json) =
      _$MessageSendResponseImpl.fromJson;

  @override
  String get message;
  @override
  int get statusCode;
  @override
  String get method;
  @override
  String get path;
  @override
  DateTime get timestamp;

  /// Create a copy of MessageSendResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MessageSendResponseImplCopyWith<_$MessageSendResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

GroupChatCreateResponse _$GroupChatCreateResponseFromJson(
  Map<String, dynamic> json,
) {
  return _GroupChatCreateResponse.fromJson(json);
}

/// @nodoc
mixin _$GroupChatCreateResponse {
  GroupChatData get data => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  int get statusCode => throw _privateConstructorUsedError;
  String get method => throw _privateConstructorUsedError;
  String get path => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;

  /// Serializes this GroupChatCreateResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GroupChatCreateResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GroupChatCreateResponseCopyWith<GroupChatCreateResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GroupChatCreateResponseCopyWith<$Res> {
  factory $GroupChatCreateResponseCopyWith(
    GroupChatCreateResponse value,
    $Res Function(GroupChatCreateResponse) then,
  ) = _$GroupChatCreateResponseCopyWithImpl<$Res, GroupChatCreateResponse>;
  @useResult
  $Res call({
    GroupChatData data,
    String message,
    int statusCode,
    String method,
    String path,
    DateTime timestamp,
  });

  $GroupChatDataCopyWith<$Res> get data;
}

/// @nodoc
class _$GroupChatCreateResponseCopyWithImpl<
  $Res,
  $Val extends GroupChatCreateResponse
>
    implements $GroupChatCreateResponseCopyWith<$Res> {
  _$GroupChatCreateResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GroupChatCreateResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
    Object? message = null,
    Object? statusCode = null,
    Object? method = null,
    Object? path = null,
    Object? timestamp = null,
  }) {
    return _then(
      _value.copyWith(
            data:
                null == data
                    ? _value.data
                    : data // ignore: cast_nullable_to_non_nullable
                        as GroupChatData,
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
                null == method
                    ? _value.method
                    : method // ignore: cast_nullable_to_non_nullable
                        as String,
            path:
                null == path
                    ? _value.path
                    : path // ignore: cast_nullable_to_non_nullable
                        as String,
            timestamp:
                null == timestamp
                    ? _value.timestamp
                    : timestamp // ignore: cast_nullable_to_non_nullable
                        as DateTime,
          )
          as $Val,
    );
  }

  /// Create a copy of GroupChatCreateResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GroupChatDataCopyWith<$Res> get data {
    return $GroupChatDataCopyWith<$Res>(_value.data, (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$GroupChatCreateResponseImplCopyWith<$Res>
    implements $GroupChatCreateResponseCopyWith<$Res> {
  factory _$$GroupChatCreateResponseImplCopyWith(
    _$GroupChatCreateResponseImpl value,
    $Res Function(_$GroupChatCreateResponseImpl) then,
  ) = __$$GroupChatCreateResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    GroupChatData data,
    String message,
    int statusCode,
    String method,
    String path,
    DateTime timestamp,
  });

  @override
  $GroupChatDataCopyWith<$Res> get data;
}

/// @nodoc
class __$$GroupChatCreateResponseImplCopyWithImpl<$Res>
    extends
        _$GroupChatCreateResponseCopyWithImpl<
          $Res,
          _$GroupChatCreateResponseImpl
        >
    implements _$$GroupChatCreateResponseImplCopyWith<$Res> {
  __$$GroupChatCreateResponseImplCopyWithImpl(
    _$GroupChatCreateResponseImpl _value,
    $Res Function(_$GroupChatCreateResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of GroupChatCreateResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
    Object? message = null,
    Object? statusCode = null,
    Object? method = null,
    Object? path = null,
    Object? timestamp = null,
  }) {
    return _then(
      _$GroupChatCreateResponseImpl(
        data:
            null == data
                ? _value.data
                : data // ignore: cast_nullable_to_non_nullable
                    as GroupChatData,
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
            null == method
                ? _value.method
                : method // ignore: cast_nullable_to_non_nullable
                    as String,
        path:
            null == path
                ? _value.path
                : path // ignore: cast_nullable_to_non_nullable
                    as String,
        timestamp:
            null == timestamp
                ? _value.timestamp
                : timestamp // ignore: cast_nullable_to_non_nullable
                    as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$GroupChatCreateResponseImpl implements _GroupChatCreateResponse {
  const _$GroupChatCreateResponseImpl({
    required this.data,
    required this.message,
    required this.statusCode,
    required this.method,
    required this.path,
    required this.timestamp,
  });

  factory _$GroupChatCreateResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$GroupChatCreateResponseImplFromJson(json);

  @override
  final GroupChatData data;
  @override
  final String message;
  @override
  final int statusCode;
  @override
  final String method;
  @override
  final String path;
  @override
  final DateTime timestamp;

  @override
  String toString() {
    return 'GroupChatCreateResponse(data: $data, message: $message, statusCode: $statusCode, method: $method, path: $path, timestamp: $timestamp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GroupChatCreateResponseImpl &&
            (identical(other.data, data) || other.data == data) &&
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
    message,
    statusCode,
    method,
    path,
    timestamp,
  );

  /// Create a copy of GroupChatCreateResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GroupChatCreateResponseImplCopyWith<_$GroupChatCreateResponseImpl>
  get copyWith => __$$GroupChatCreateResponseImplCopyWithImpl<
    _$GroupChatCreateResponseImpl
  >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GroupChatCreateResponseImplToJson(this);
  }
}

abstract class _GroupChatCreateResponse implements GroupChatCreateResponse {
  const factory _GroupChatCreateResponse({
    required final GroupChatData data,
    required final String message,
    required final int statusCode,
    required final String method,
    required final String path,
    required final DateTime timestamp,
  }) = _$GroupChatCreateResponseImpl;

  factory _GroupChatCreateResponse.fromJson(Map<String, dynamic> json) =
      _$GroupChatCreateResponseImpl.fromJson;

  @override
  GroupChatData get data;
  @override
  String get message;
  @override
  int get statusCode;
  @override
  String get method;
  @override
  String get path;
  @override
  DateTime get timestamp;

  /// Create a copy of GroupChatCreateResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GroupChatCreateResponseImplCopyWith<_$GroupChatCreateResponseImpl>
  get copyWith => throw _privateConstructorUsedError;
}

GroupChatData _$GroupChatDataFromJson(Map<String, dynamic> json) {
  return _GroupChatData.fromJson(json);
}

/// @nodoc
mixin _$GroupChatData {
  List<UserModel>? get group => throw _privateConstructorUsedError;
  UserModel? get client => throw _privateConstructorUsedError;
  UserModel? get therapist => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  String get id => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime? get deletedAt => throw _privateConstructorUsedError;
  ChatMessage? get lastMessage => throw _privateConstructorUsedError;

  /// Serializes this GroupChatData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GroupChatData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GroupChatDataCopyWith<GroupChatData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GroupChatDataCopyWith<$Res> {
  factory $GroupChatDataCopyWith(
    GroupChatData value,
    $Res Function(GroupChatData) then,
  ) = _$GroupChatDataCopyWithImpl<$Res, GroupChatData>;
  @useResult
  $Res call({
    List<UserModel>? group,
    UserModel? client,
    UserModel? therapist,
    DateTime? updatedAt,
    String id,
    DateTime createdAt,
    DateTime? deletedAt,
    ChatMessage? lastMessage,
  });

  $UserModelCopyWith<$Res>? get client;
  $UserModelCopyWith<$Res>? get therapist;
  $ChatMessageCopyWith<$Res>? get lastMessage;
}

/// @nodoc
class _$GroupChatDataCopyWithImpl<$Res, $Val extends GroupChatData>
    implements $GroupChatDataCopyWith<$Res> {
  _$GroupChatDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GroupChatData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? group = freezed,
    Object? client = freezed,
    Object? therapist = freezed,
    Object? updatedAt = freezed,
    Object? id = null,
    Object? createdAt = null,
    Object? deletedAt = freezed,
    Object? lastMessage = freezed,
  }) {
    return _then(
      _value.copyWith(
            group:
                freezed == group
                    ? _value.group
                    : group // ignore: cast_nullable_to_non_nullable
                        as List<UserModel>?,
            client:
                freezed == client
                    ? _value.client
                    : client // ignore: cast_nullable_to_non_nullable
                        as UserModel?,
            therapist:
                freezed == therapist
                    ? _value.therapist
                    : therapist // ignore: cast_nullable_to_non_nullable
                        as UserModel?,
            updatedAt:
                freezed == updatedAt
                    ? _value.updatedAt
                    : updatedAt // ignore: cast_nullable_to_non_nullable
                        as DateTime?,
            id:
                null == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as String,
            createdAt:
                null == createdAt
                    ? _value.createdAt
                    : createdAt // ignore: cast_nullable_to_non_nullable
                        as DateTime,
            deletedAt:
                freezed == deletedAt
                    ? _value.deletedAt
                    : deletedAt // ignore: cast_nullable_to_non_nullable
                        as DateTime?,
            lastMessage:
                freezed == lastMessage
                    ? _value.lastMessage
                    : lastMessage // ignore: cast_nullable_to_non_nullable
                        as ChatMessage?,
          )
          as $Val,
    );
  }

  /// Create a copy of GroupChatData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserModelCopyWith<$Res>? get client {
    if (_value.client == null) {
      return null;
    }

    return $UserModelCopyWith<$Res>(_value.client!, (value) {
      return _then(_value.copyWith(client: value) as $Val);
    });
  }

  /// Create a copy of GroupChatData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserModelCopyWith<$Res>? get therapist {
    if (_value.therapist == null) {
      return null;
    }

    return $UserModelCopyWith<$Res>(_value.therapist!, (value) {
      return _then(_value.copyWith(therapist: value) as $Val);
    });
  }

  /// Create a copy of GroupChatData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ChatMessageCopyWith<$Res>? get lastMessage {
    if (_value.lastMessage == null) {
      return null;
    }

    return $ChatMessageCopyWith<$Res>(_value.lastMessage!, (value) {
      return _then(_value.copyWith(lastMessage: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$GroupChatDataImplCopyWith<$Res>
    implements $GroupChatDataCopyWith<$Res> {
  factory _$$GroupChatDataImplCopyWith(
    _$GroupChatDataImpl value,
    $Res Function(_$GroupChatDataImpl) then,
  ) = __$$GroupChatDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<UserModel>? group,
    UserModel? client,
    UserModel? therapist,
    DateTime? updatedAt,
    String id,
    DateTime createdAt,
    DateTime? deletedAt,
    ChatMessage? lastMessage,
  });

  @override
  $UserModelCopyWith<$Res>? get client;
  @override
  $UserModelCopyWith<$Res>? get therapist;
  @override
  $ChatMessageCopyWith<$Res>? get lastMessage;
}

/// @nodoc
class __$$GroupChatDataImplCopyWithImpl<$Res>
    extends _$GroupChatDataCopyWithImpl<$Res, _$GroupChatDataImpl>
    implements _$$GroupChatDataImplCopyWith<$Res> {
  __$$GroupChatDataImplCopyWithImpl(
    _$GroupChatDataImpl _value,
    $Res Function(_$GroupChatDataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of GroupChatData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? group = freezed,
    Object? client = freezed,
    Object? therapist = freezed,
    Object? updatedAt = freezed,
    Object? id = null,
    Object? createdAt = null,
    Object? deletedAt = freezed,
    Object? lastMessage = freezed,
  }) {
    return _then(
      _$GroupChatDataImpl(
        group:
            freezed == group
                ? _value._group
                : group // ignore: cast_nullable_to_non_nullable
                    as List<UserModel>?,
        client:
            freezed == client
                ? _value.client
                : client // ignore: cast_nullable_to_non_nullable
                    as UserModel?,
        therapist:
            freezed == therapist
                ? _value.therapist
                : therapist // ignore: cast_nullable_to_non_nullable
                    as UserModel?,
        updatedAt:
            freezed == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                    as DateTime?,
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as String,
        createdAt:
            null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                    as DateTime,
        deletedAt:
            freezed == deletedAt
                ? _value.deletedAt
                : deletedAt // ignore: cast_nullable_to_non_nullable
                    as DateTime?,
        lastMessage:
            freezed == lastMessage
                ? _value.lastMessage
                : lastMessage // ignore: cast_nullable_to_non_nullable
                    as ChatMessage?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$GroupChatDataImpl implements _GroupChatData {
  const _$GroupChatDataImpl({
    required final List<UserModel>? group,
    required this.client,
    required this.therapist,
    required this.updatedAt,
    required this.id,
    required this.createdAt,
    required this.deletedAt,
    this.lastMessage,
  }) : _group = group;

  factory _$GroupChatDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$GroupChatDataImplFromJson(json);

  final List<UserModel>? _group;
  @override
  List<UserModel>? get group {
    final value = _group;
    if (value == null) return null;
    if (_group is EqualUnmodifiableListView) return _group;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final UserModel? client;
  @override
  final UserModel? therapist;
  @override
  final DateTime? updatedAt;
  @override
  final String id;
  @override
  final DateTime createdAt;
  @override
  final DateTime? deletedAt;
  @override
  final ChatMessage? lastMessage;

  @override
  String toString() {
    return 'GroupChatData(group: $group, client: $client, therapist: $therapist, updatedAt: $updatedAt, id: $id, createdAt: $createdAt, deletedAt: $deletedAt, lastMessage: $lastMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GroupChatDataImpl &&
            const DeepCollectionEquality().equals(other._group, _group) &&
            (identical(other.client, client) || other.client == client) &&
            (identical(other.therapist, therapist) ||
                other.therapist == therapist) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.deletedAt, deletedAt) ||
                other.deletedAt == deletedAt) &&
            (identical(other.lastMessage, lastMessage) ||
                other.lastMessage == lastMessage));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_group),
    client,
    therapist,
    updatedAt,
    id,
    createdAt,
    deletedAt,
    lastMessage,
  );

  /// Create a copy of GroupChatData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GroupChatDataImplCopyWith<_$GroupChatDataImpl> get copyWith =>
      __$$GroupChatDataImplCopyWithImpl<_$GroupChatDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GroupChatDataImplToJson(this);
  }
}

abstract class _GroupChatData implements GroupChatData {
  const factory _GroupChatData({
    required final List<UserModel>? group,
    required final UserModel? client,
    required final UserModel? therapist,
    required final DateTime? updatedAt,
    required final String id,
    required final DateTime createdAt,
    required final DateTime? deletedAt,
    final ChatMessage? lastMessage,
  }) = _$GroupChatDataImpl;

  factory _GroupChatData.fromJson(Map<String, dynamic> json) =
      _$GroupChatDataImpl.fromJson;

  @override
  List<UserModel>? get group;
  @override
  UserModel? get client;
  @override
  UserModel? get therapist;
  @override
  DateTime? get updatedAt;
  @override
  String get id;
  @override
  DateTime get createdAt;
  @override
  DateTime? get deletedAt;
  @override
  ChatMessage? get lastMessage;

  /// Create a copy of GroupChatData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GroupChatDataImplCopyWith<_$GroupChatDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ClientInfoResponse _$ClientInfoResponseFromJson(Map<String, dynamic> json) {
  return _ClientInfoResponse.fromJson(json);
}

/// @nodoc
mixin _$ClientInfoResponse {
  UserModel get data => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  int get statusCode => throw _privateConstructorUsedError;
  String get method => throw _privateConstructorUsedError;
  String get path => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;

  /// Serializes this ClientInfoResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ClientInfoResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ClientInfoResponseCopyWith<ClientInfoResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClientInfoResponseCopyWith<$Res> {
  factory $ClientInfoResponseCopyWith(
    ClientInfoResponse value,
    $Res Function(ClientInfoResponse) then,
  ) = _$ClientInfoResponseCopyWithImpl<$Res, ClientInfoResponse>;
  @useResult
  $Res call({
    UserModel data,
    String message,
    int statusCode,
    String method,
    String path,
    DateTime timestamp,
  });

  $UserModelCopyWith<$Res> get data;
}

/// @nodoc
class _$ClientInfoResponseCopyWithImpl<$Res, $Val extends ClientInfoResponse>
    implements $ClientInfoResponseCopyWith<$Res> {
  _$ClientInfoResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ClientInfoResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
    Object? message = null,
    Object? statusCode = null,
    Object? method = null,
    Object? path = null,
    Object? timestamp = null,
  }) {
    return _then(
      _value.copyWith(
            data:
                null == data
                    ? _value.data
                    : data // ignore: cast_nullable_to_non_nullable
                        as UserModel,
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
                null == method
                    ? _value.method
                    : method // ignore: cast_nullable_to_non_nullable
                        as String,
            path:
                null == path
                    ? _value.path
                    : path // ignore: cast_nullable_to_non_nullable
                        as String,
            timestamp:
                null == timestamp
                    ? _value.timestamp
                    : timestamp // ignore: cast_nullable_to_non_nullable
                        as DateTime,
          )
          as $Val,
    );
  }

  /// Create a copy of ClientInfoResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserModelCopyWith<$Res> get data {
    return $UserModelCopyWith<$Res>(_value.data, (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ClientInfoResponseImplCopyWith<$Res>
    implements $ClientInfoResponseCopyWith<$Res> {
  factory _$$ClientInfoResponseImplCopyWith(
    _$ClientInfoResponseImpl value,
    $Res Function(_$ClientInfoResponseImpl) then,
  ) = __$$ClientInfoResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    UserModel data,
    String message,
    int statusCode,
    String method,
    String path,
    DateTime timestamp,
  });

  @override
  $UserModelCopyWith<$Res> get data;
}

/// @nodoc
class __$$ClientInfoResponseImplCopyWithImpl<$Res>
    extends _$ClientInfoResponseCopyWithImpl<$Res, _$ClientInfoResponseImpl>
    implements _$$ClientInfoResponseImplCopyWith<$Res> {
  __$$ClientInfoResponseImplCopyWithImpl(
    _$ClientInfoResponseImpl _value,
    $Res Function(_$ClientInfoResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ClientInfoResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
    Object? message = null,
    Object? statusCode = null,
    Object? method = null,
    Object? path = null,
    Object? timestamp = null,
  }) {
    return _then(
      _$ClientInfoResponseImpl(
        data:
            null == data
                ? _value.data
                : data // ignore: cast_nullable_to_non_nullable
                    as UserModel,
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
            null == method
                ? _value.method
                : method // ignore: cast_nullable_to_non_nullable
                    as String,
        path:
            null == path
                ? _value.path
                : path // ignore: cast_nullable_to_non_nullable
                    as String,
        timestamp:
            null == timestamp
                ? _value.timestamp
                : timestamp // ignore: cast_nullable_to_non_nullable
                    as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ClientInfoResponseImpl implements _ClientInfoResponse {
  const _$ClientInfoResponseImpl({
    required this.data,
    required this.message,
    required this.statusCode,
    required this.method,
    required this.path,
    required this.timestamp,
  });

  factory _$ClientInfoResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$ClientInfoResponseImplFromJson(json);

  @override
  final UserModel data;
  @override
  final String message;
  @override
  final int statusCode;
  @override
  final String method;
  @override
  final String path;
  @override
  final DateTime timestamp;

  @override
  String toString() {
    return 'ClientInfoResponse(data: $data, message: $message, statusCode: $statusCode, method: $method, path: $path, timestamp: $timestamp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClientInfoResponseImpl &&
            (identical(other.data, data) || other.data == data) &&
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
    message,
    statusCode,
    method,
    path,
    timestamp,
  );

  /// Create a copy of ClientInfoResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ClientInfoResponseImplCopyWith<_$ClientInfoResponseImpl> get copyWith =>
      __$$ClientInfoResponseImplCopyWithImpl<_$ClientInfoResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ClientInfoResponseImplToJson(this);
  }
}

abstract class _ClientInfoResponse implements ClientInfoResponse {
  const factory _ClientInfoResponse({
    required final UserModel data,
    required final String message,
    required final int statusCode,
    required final String method,
    required final String path,
    required final DateTime timestamp,
  }) = _$ClientInfoResponseImpl;

  factory _ClientInfoResponse.fromJson(Map<String, dynamic> json) =
      _$ClientInfoResponseImpl.fromJson;

  @override
  UserModel get data;
  @override
  String get message;
  @override
  int get statusCode;
  @override
  String get method;
  @override
  String get path;
  @override
  DateTime get timestamp;

  /// Create a copy of ClientInfoResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ClientInfoResponseImplCopyWith<_$ClientInfoResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MarkAsReadResponse _$MarkAsReadResponseFromJson(Map<String, dynamic> json) {
  return _MarkAsReadResponse.fromJson(json);
}

/// @nodoc
mixin _$MarkAsReadResponse {
  MarkAsReadData get data => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  int get statusCode => throw _privateConstructorUsedError;
  String get method => throw _privateConstructorUsedError;
  String get path => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;

  /// Serializes this MarkAsReadResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MarkAsReadResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MarkAsReadResponseCopyWith<MarkAsReadResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MarkAsReadResponseCopyWith<$Res> {
  factory $MarkAsReadResponseCopyWith(
    MarkAsReadResponse value,
    $Res Function(MarkAsReadResponse) then,
  ) = _$MarkAsReadResponseCopyWithImpl<$Res, MarkAsReadResponse>;
  @useResult
  $Res call({
    MarkAsReadData data,
    String message,
    int statusCode,
    String method,
    String path,
    DateTime timestamp,
  });

  $MarkAsReadDataCopyWith<$Res> get data;
}

/// @nodoc
class _$MarkAsReadResponseCopyWithImpl<$Res, $Val extends MarkAsReadResponse>
    implements $MarkAsReadResponseCopyWith<$Res> {
  _$MarkAsReadResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MarkAsReadResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
    Object? message = null,
    Object? statusCode = null,
    Object? method = null,
    Object? path = null,
    Object? timestamp = null,
  }) {
    return _then(
      _value.copyWith(
            data:
                null == data
                    ? _value.data
                    : data // ignore: cast_nullable_to_non_nullable
                        as MarkAsReadData,
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
                null == method
                    ? _value.method
                    : method // ignore: cast_nullable_to_non_nullable
                        as String,
            path:
                null == path
                    ? _value.path
                    : path // ignore: cast_nullable_to_non_nullable
                        as String,
            timestamp:
                null == timestamp
                    ? _value.timestamp
                    : timestamp // ignore: cast_nullable_to_non_nullable
                        as DateTime,
          )
          as $Val,
    );
  }

  /// Create a copy of MarkAsReadResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MarkAsReadDataCopyWith<$Res> get data {
    return $MarkAsReadDataCopyWith<$Res>(_value.data, (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$MarkAsReadResponseImplCopyWith<$Res>
    implements $MarkAsReadResponseCopyWith<$Res> {
  factory _$$MarkAsReadResponseImplCopyWith(
    _$MarkAsReadResponseImpl value,
    $Res Function(_$MarkAsReadResponseImpl) then,
  ) = __$$MarkAsReadResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    MarkAsReadData data,
    String message,
    int statusCode,
    String method,
    String path,
    DateTime timestamp,
  });

  @override
  $MarkAsReadDataCopyWith<$Res> get data;
}

/// @nodoc
class __$$MarkAsReadResponseImplCopyWithImpl<$Res>
    extends _$MarkAsReadResponseCopyWithImpl<$Res, _$MarkAsReadResponseImpl>
    implements _$$MarkAsReadResponseImplCopyWith<$Res> {
  __$$MarkAsReadResponseImplCopyWithImpl(
    _$MarkAsReadResponseImpl _value,
    $Res Function(_$MarkAsReadResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MarkAsReadResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
    Object? message = null,
    Object? statusCode = null,
    Object? method = null,
    Object? path = null,
    Object? timestamp = null,
  }) {
    return _then(
      _$MarkAsReadResponseImpl(
        data:
            null == data
                ? _value.data
                : data // ignore: cast_nullable_to_non_nullable
                    as MarkAsReadData,
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
            null == method
                ? _value.method
                : method // ignore: cast_nullable_to_non_nullable
                    as String,
        path:
            null == path
                ? _value.path
                : path // ignore: cast_nullable_to_non_nullable
                    as String,
        timestamp:
            null == timestamp
                ? _value.timestamp
                : timestamp // ignore: cast_nullable_to_non_nullable
                    as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$MarkAsReadResponseImpl implements _MarkAsReadResponse {
  const _$MarkAsReadResponseImpl({
    required this.data,
    required this.message,
    required this.statusCode,
    required this.method,
    required this.path,
    required this.timestamp,
  });

  factory _$MarkAsReadResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$MarkAsReadResponseImplFromJson(json);

  @override
  final MarkAsReadData data;
  @override
  final String message;
  @override
  final int statusCode;
  @override
  final String method;
  @override
  final String path;
  @override
  final DateTime timestamp;

  @override
  String toString() {
    return 'MarkAsReadResponse(data: $data, message: $message, statusCode: $statusCode, method: $method, path: $path, timestamp: $timestamp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MarkAsReadResponseImpl &&
            (identical(other.data, data) || other.data == data) &&
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
    message,
    statusCode,
    method,
    path,
    timestamp,
  );

  /// Create a copy of MarkAsReadResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MarkAsReadResponseImplCopyWith<_$MarkAsReadResponseImpl> get copyWith =>
      __$$MarkAsReadResponseImplCopyWithImpl<_$MarkAsReadResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$MarkAsReadResponseImplToJson(this);
  }
}

abstract class _MarkAsReadResponse implements MarkAsReadResponse {
  const factory _MarkAsReadResponse({
    required final MarkAsReadData data,
    required final String message,
    required final int statusCode,
    required final String method,
    required final String path,
    required final DateTime timestamp,
  }) = _$MarkAsReadResponseImpl;

  factory _MarkAsReadResponse.fromJson(Map<String, dynamic> json) =
      _$MarkAsReadResponseImpl.fromJson;

  @override
  MarkAsReadData get data;
  @override
  String get message;
  @override
  int get statusCode;
  @override
  String get method;
  @override
  String get path;
  @override
  DateTime get timestamp;

  /// Create a copy of MarkAsReadResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MarkAsReadResponseImplCopyWith<_$MarkAsReadResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MarkAsReadData _$MarkAsReadDataFromJson(Map<String, dynamic> json) {
  return _MarkAsReadData.fromJson(json);
}

/// @nodoc
mixin _$MarkAsReadData {
  bool get success => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;

  /// Serializes this MarkAsReadData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MarkAsReadData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MarkAsReadDataCopyWith<MarkAsReadData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MarkAsReadDataCopyWith<$Res> {
  factory $MarkAsReadDataCopyWith(
    MarkAsReadData value,
    $Res Function(MarkAsReadData) then,
  ) = _$MarkAsReadDataCopyWithImpl<$Res, MarkAsReadData>;
  @useResult
  $Res call({bool success, String message});
}

/// @nodoc
class _$MarkAsReadDataCopyWithImpl<$Res, $Val extends MarkAsReadData>
    implements $MarkAsReadDataCopyWith<$Res> {
  _$MarkAsReadDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MarkAsReadData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? success = null, Object? message = null}) {
    return _then(
      _value.copyWith(
            success:
                null == success
                    ? _value.success
                    : success // ignore: cast_nullable_to_non_nullable
                        as bool,
            message:
                null == message
                    ? _value.message
                    : message // ignore: cast_nullable_to_non_nullable
                        as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$MarkAsReadDataImplCopyWith<$Res>
    implements $MarkAsReadDataCopyWith<$Res> {
  factory _$$MarkAsReadDataImplCopyWith(
    _$MarkAsReadDataImpl value,
    $Res Function(_$MarkAsReadDataImpl) then,
  ) = __$$MarkAsReadDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool success, String message});
}

/// @nodoc
class __$$MarkAsReadDataImplCopyWithImpl<$Res>
    extends _$MarkAsReadDataCopyWithImpl<$Res, _$MarkAsReadDataImpl>
    implements _$$MarkAsReadDataImplCopyWith<$Res> {
  __$$MarkAsReadDataImplCopyWithImpl(
    _$MarkAsReadDataImpl _value,
    $Res Function(_$MarkAsReadDataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MarkAsReadData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? success = null, Object? message = null}) {
    return _then(
      _$MarkAsReadDataImpl(
        success:
            null == success
                ? _value.success
                : success // ignore: cast_nullable_to_non_nullable
                    as bool,
        message:
            null == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$MarkAsReadDataImpl implements _MarkAsReadData {
  const _$MarkAsReadDataImpl({required this.success, required this.message});

  factory _$MarkAsReadDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$MarkAsReadDataImplFromJson(json);

  @override
  final bool success;
  @override
  final String message;

  @override
  String toString() {
    return 'MarkAsReadData(success: $success, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MarkAsReadDataImpl &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, success, message);

  /// Create a copy of MarkAsReadData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MarkAsReadDataImplCopyWith<_$MarkAsReadDataImpl> get copyWith =>
      __$$MarkAsReadDataImplCopyWithImpl<_$MarkAsReadDataImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$MarkAsReadDataImplToJson(this);
  }
}

abstract class _MarkAsReadData implements MarkAsReadData {
  const factory _MarkAsReadData({
    required final bool success,
    required final String message,
  }) = _$MarkAsReadDataImpl;

  factory _MarkAsReadData.fromJson(Map<String, dynamic> json) =
      _$MarkAsReadDataImpl.fromJson;

  @override
  bool get success;
  @override
  String get message;

  /// Create a copy of MarkAsReadData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MarkAsReadDataImplCopyWith<_$MarkAsReadDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SessionListResponse _$SessionListResponseFromJson(Map<String, dynamic> json) {
  return _SessionListResponse.fromJson(json);
}

/// @nodoc
mixin _$SessionListResponse {
  List<Session> get data => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  int get statusCode => throw _privateConstructorUsedError;
  String get method => throw _privateConstructorUsedError;
  String get path => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;

  /// Serializes this SessionListResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SessionListResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SessionListResponseCopyWith<SessionListResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SessionListResponseCopyWith<$Res> {
  factory $SessionListResponseCopyWith(
    SessionListResponse value,
    $Res Function(SessionListResponse) then,
  ) = _$SessionListResponseCopyWithImpl<$Res, SessionListResponse>;
  @useResult
  $Res call({
    List<Session> data,
    String message,
    int statusCode,
    String method,
    String path,
    DateTime timestamp,
  });
}

/// @nodoc
class _$SessionListResponseCopyWithImpl<$Res, $Val extends SessionListResponse>
    implements $SessionListResponseCopyWith<$Res> {
  _$SessionListResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SessionListResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
    Object? message = null,
    Object? statusCode = null,
    Object? method = null,
    Object? path = null,
    Object? timestamp = null,
  }) {
    return _then(
      _value.copyWith(
            data:
                null == data
                    ? _value.data
                    : data // ignore: cast_nullable_to_non_nullable
                        as List<Session>,
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
                null == method
                    ? _value.method
                    : method // ignore: cast_nullable_to_non_nullable
                        as String,
            path:
                null == path
                    ? _value.path
                    : path // ignore: cast_nullable_to_non_nullable
                        as String,
            timestamp:
                null == timestamp
                    ? _value.timestamp
                    : timestamp // ignore: cast_nullable_to_non_nullable
                        as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SessionListResponseImplCopyWith<$Res>
    implements $SessionListResponseCopyWith<$Res> {
  factory _$$SessionListResponseImplCopyWith(
    _$SessionListResponseImpl value,
    $Res Function(_$SessionListResponseImpl) then,
  ) = __$$SessionListResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<Session> data,
    String message,
    int statusCode,
    String method,
    String path,
    DateTime timestamp,
  });
}

/// @nodoc
class __$$SessionListResponseImplCopyWithImpl<$Res>
    extends _$SessionListResponseCopyWithImpl<$Res, _$SessionListResponseImpl>
    implements _$$SessionListResponseImplCopyWith<$Res> {
  __$$SessionListResponseImplCopyWithImpl(
    _$SessionListResponseImpl _value,
    $Res Function(_$SessionListResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SessionListResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
    Object? message = null,
    Object? statusCode = null,
    Object? method = null,
    Object? path = null,
    Object? timestamp = null,
  }) {
    return _then(
      _$SessionListResponseImpl(
        data:
            null == data
                ? _value._data
                : data // ignore: cast_nullable_to_non_nullable
                    as List<Session>,
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
            null == method
                ? _value.method
                : method // ignore: cast_nullable_to_non_nullable
                    as String,
        path:
            null == path
                ? _value.path
                : path // ignore: cast_nullable_to_non_nullable
                    as String,
        timestamp:
            null == timestamp
                ? _value.timestamp
                : timestamp // ignore: cast_nullable_to_non_nullable
                    as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SessionListResponseImpl implements _SessionListResponse {
  const _$SessionListResponseImpl({
    required final List<Session> data,
    required this.message,
    required this.statusCode,
    required this.method,
    required this.path,
    required this.timestamp,
  }) : _data = data;

  factory _$SessionListResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$SessionListResponseImplFromJson(json);

  final List<Session> _data;
  @override
  List<Session> get data {
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_data);
  }

  @override
  final String message;
  @override
  final int statusCode;
  @override
  final String method;
  @override
  final String path;
  @override
  final DateTime timestamp;

  @override
  String toString() {
    return 'SessionListResponse(data: $data, message: $message, statusCode: $statusCode, method: $method, path: $path, timestamp: $timestamp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SessionListResponseImpl &&
            const DeepCollectionEquality().equals(other._data, _data) &&
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
    message,
    statusCode,
    method,
    path,
    timestamp,
  );

  /// Create a copy of SessionListResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SessionListResponseImplCopyWith<_$SessionListResponseImpl> get copyWith =>
      __$$SessionListResponseImplCopyWithImpl<_$SessionListResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$SessionListResponseImplToJson(this);
  }
}

abstract class _SessionListResponse implements SessionListResponse {
  const factory _SessionListResponse({
    required final List<Session> data,
    required final String message,
    required final int statusCode,
    required final String method,
    required final String path,
    required final DateTime timestamp,
  }) = _$SessionListResponseImpl;

  factory _SessionListResponse.fromJson(Map<String, dynamic> json) =
      _$SessionListResponseImpl.fromJson;

  @override
  List<Session> get data;
  @override
  String get message;
  @override
  int get statusCode;
  @override
  String get method;
  @override
  String get path;
  @override
  DateTime get timestamp;

  /// Create a copy of SessionListResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SessionListResponseImplCopyWith<_$SessionListResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Session _$SessionFromJson(Map<String, dynamic> json) {
  return _Session.fromJson(json);
}

/// @nodoc
mixin _$Session {
  String get id => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get schedule => throw _privateConstructorUsedError;
  int? get duration => throw _privateConstructorUsedError;
  String? get type => throw _privateConstructorUsedError;
  String? get note => throw _privateConstructorUsedError;
  UserModel get therapist => throw _privateConstructorUsedError;

  /// Serializes this Session to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Session
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SessionCopyWith<Session> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SessionCopyWith<$Res> {
  factory $SessionCopyWith(Session value, $Res Function(Session) then) =
      _$SessionCopyWithImpl<$Res, Session>;
  @useResult
  $Res call({
    String id,
    DateTime? createdAt,
    DateTime? schedule,
    int? duration,
    String? type,
    String? note,
    UserModel therapist,
  });

  $UserModelCopyWith<$Res> get therapist;
}

/// @nodoc
class _$SessionCopyWithImpl<$Res, $Val extends Session>
    implements $SessionCopyWith<$Res> {
  _$SessionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Session
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? createdAt = freezed,
    Object? schedule = freezed,
    Object? duration = freezed,
    Object? type = freezed,
    Object? note = freezed,
    Object? therapist = null,
  }) {
    return _then(
      _value.copyWith(
            id:
                null == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as String,
            createdAt:
                freezed == createdAt
                    ? _value.createdAt
                    : createdAt // ignore: cast_nullable_to_non_nullable
                        as DateTime?,
            schedule:
                freezed == schedule
                    ? _value.schedule
                    : schedule // ignore: cast_nullable_to_non_nullable
                        as DateTime?,
            duration:
                freezed == duration
                    ? _value.duration
                    : duration // ignore: cast_nullable_to_non_nullable
                        as int?,
            type:
                freezed == type
                    ? _value.type
                    : type // ignore: cast_nullable_to_non_nullable
                        as String?,
            note:
                freezed == note
                    ? _value.note
                    : note // ignore: cast_nullable_to_non_nullable
                        as String?,
            therapist:
                null == therapist
                    ? _value.therapist
                    : therapist // ignore: cast_nullable_to_non_nullable
                        as UserModel,
          )
          as $Val,
    );
  }

  /// Create a copy of Session
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserModelCopyWith<$Res> get therapist {
    return $UserModelCopyWith<$Res>(_value.therapist, (value) {
      return _then(_value.copyWith(therapist: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SessionImplCopyWith<$Res> implements $SessionCopyWith<$Res> {
  factory _$$SessionImplCopyWith(
    _$SessionImpl value,
    $Res Function(_$SessionImpl) then,
  ) = __$$SessionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    DateTime? createdAt,
    DateTime? schedule,
    int? duration,
    String? type,
    String? note,
    UserModel therapist,
  });

  @override
  $UserModelCopyWith<$Res> get therapist;
}

/// @nodoc
class __$$SessionImplCopyWithImpl<$Res>
    extends _$SessionCopyWithImpl<$Res, _$SessionImpl>
    implements _$$SessionImplCopyWith<$Res> {
  __$$SessionImplCopyWithImpl(
    _$SessionImpl _value,
    $Res Function(_$SessionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Session
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? createdAt = freezed,
    Object? schedule = freezed,
    Object? duration = freezed,
    Object? type = freezed,
    Object? note = freezed,
    Object? therapist = null,
  }) {
    return _then(
      _$SessionImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as String,
        createdAt:
            freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                    as DateTime?,
        schedule:
            freezed == schedule
                ? _value.schedule
                : schedule // ignore: cast_nullable_to_non_nullable
                    as DateTime?,
        duration:
            freezed == duration
                ? _value.duration
                : duration // ignore: cast_nullable_to_non_nullable
                    as int?,
        type:
            freezed == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                    as String?,
        note:
            freezed == note
                ? _value.note
                : note // ignore: cast_nullable_to_non_nullable
                    as String?,
        therapist:
            null == therapist
                ? _value.therapist
                : therapist // ignore: cast_nullable_to_non_nullable
                    as UserModel,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SessionImpl implements _Session {
  const _$SessionImpl({
    required this.id,
    this.createdAt,
    this.schedule,
    this.duration,
    this.type,
    this.note,
    required this.therapist,
  });

  factory _$SessionImpl.fromJson(Map<String, dynamic> json) =>
      _$$SessionImplFromJson(json);

  @override
  final String id;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? schedule;
  @override
  final int? duration;
  @override
  final String? type;
  @override
  final String? note;
  @override
  final UserModel therapist;

  @override
  String toString() {
    return 'Session(id: $id, createdAt: $createdAt, schedule: $schedule, duration: $duration, type: $type, note: $note, therapist: $therapist)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SessionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.schedule, schedule) ||
                other.schedule == schedule) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.note, note) || other.note == note) &&
            (identical(other.therapist, therapist) ||
                other.therapist == therapist));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    createdAt,
    schedule,
    duration,
    type,
    note,
    therapist,
  );

  /// Create a copy of Session
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SessionImplCopyWith<_$SessionImpl> get copyWith =>
      __$$SessionImplCopyWithImpl<_$SessionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SessionImplToJson(this);
  }
}

abstract class _Session implements Session {
  const factory _Session({
    required final String id,
    final DateTime? createdAt,
    final DateTime? schedule,
    final int? duration,
    final String? type,
    final String? note,
    required final UserModel therapist,
  }) = _$SessionImpl;

  factory _Session.fromJson(Map<String, dynamic> json) = _$SessionImpl.fromJson;

  @override
  String get id;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get schedule;
  @override
  int? get duration;
  @override
  String? get type;
  @override
  String? get note;
  @override
  UserModel get therapist;

  /// Create a copy of Session
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SessionImplCopyWith<_$SessionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SessionUpdateResponse _$SessionUpdateResponseFromJson(
  Map<String, dynamic> json,
) {
  return _SessionUpdateResponse.fromJson(json);
}

/// @nodoc
mixin _$SessionUpdateResponse {
  Session get data => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  int get statusCode => throw _privateConstructorUsedError;
  String get method => throw _privateConstructorUsedError;
  String get path => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;

  /// Serializes this SessionUpdateResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SessionUpdateResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SessionUpdateResponseCopyWith<SessionUpdateResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SessionUpdateResponseCopyWith<$Res> {
  factory $SessionUpdateResponseCopyWith(
    SessionUpdateResponse value,
    $Res Function(SessionUpdateResponse) then,
  ) = _$SessionUpdateResponseCopyWithImpl<$Res, SessionUpdateResponse>;
  @useResult
  $Res call({
    Session data,
    String message,
    int statusCode,
    String method,
    String path,
    DateTime timestamp,
  });

  $SessionCopyWith<$Res> get data;
}

/// @nodoc
class _$SessionUpdateResponseCopyWithImpl<
  $Res,
  $Val extends SessionUpdateResponse
>
    implements $SessionUpdateResponseCopyWith<$Res> {
  _$SessionUpdateResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SessionUpdateResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
    Object? message = null,
    Object? statusCode = null,
    Object? method = null,
    Object? path = null,
    Object? timestamp = null,
  }) {
    return _then(
      _value.copyWith(
            data:
                null == data
                    ? _value.data
                    : data // ignore: cast_nullable_to_non_nullable
                        as Session,
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
                null == method
                    ? _value.method
                    : method // ignore: cast_nullable_to_non_nullable
                        as String,
            path:
                null == path
                    ? _value.path
                    : path // ignore: cast_nullable_to_non_nullable
                        as String,
            timestamp:
                null == timestamp
                    ? _value.timestamp
                    : timestamp // ignore: cast_nullable_to_non_nullable
                        as DateTime,
          )
          as $Val,
    );
  }

  /// Create a copy of SessionUpdateResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SessionCopyWith<$Res> get data {
    return $SessionCopyWith<$Res>(_value.data, (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SessionUpdateResponseImplCopyWith<$Res>
    implements $SessionUpdateResponseCopyWith<$Res> {
  factory _$$SessionUpdateResponseImplCopyWith(
    _$SessionUpdateResponseImpl value,
    $Res Function(_$SessionUpdateResponseImpl) then,
  ) = __$$SessionUpdateResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    Session data,
    String message,
    int statusCode,
    String method,
    String path,
    DateTime timestamp,
  });

  @override
  $SessionCopyWith<$Res> get data;
}

/// @nodoc
class __$$SessionUpdateResponseImplCopyWithImpl<$Res>
    extends
        _$SessionUpdateResponseCopyWithImpl<$Res, _$SessionUpdateResponseImpl>
    implements _$$SessionUpdateResponseImplCopyWith<$Res> {
  __$$SessionUpdateResponseImplCopyWithImpl(
    _$SessionUpdateResponseImpl _value,
    $Res Function(_$SessionUpdateResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SessionUpdateResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
    Object? message = null,
    Object? statusCode = null,
    Object? method = null,
    Object? path = null,
    Object? timestamp = null,
  }) {
    return _then(
      _$SessionUpdateResponseImpl(
        data:
            null == data
                ? _value.data
                : data // ignore: cast_nullable_to_non_nullable
                    as Session,
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
            null == method
                ? _value.method
                : method // ignore: cast_nullable_to_non_nullable
                    as String,
        path:
            null == path
                ? _value.path
                : path // ignore: cast_nullable_to_non_nullable
                    as String,
        timestamp:
            null == timestamp
                ? _value.timestamp
                : timestamp // ignore: cast_nullable_to_non_nullable
                    as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SessionUpdateResponseImpl implements _SessionUpdateResponse {
  const _$SessionUpdateResponseImpl({
    required this.data,
    required this.message,
    required this.statusCode,
    required this.method,
    required this.path,
    required this.timestamp,
  });

  factory _$SessionUpdateResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$SessionUpdateResponseImplFromJson(json);

  @override
  final Session data;
  @override
  final String message;
  @override
  final int statusCode;
  @override
  final String method;
  @override
  final String path;
  @override
  final DateTime timestamp;

  @override
  String toString() {
    return 'SessionUpdateResponse(data: $data, message: $message, statusCode: $statusCode, method: $method, path: $path, timestamp: $timestamp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SessionUpdateResponseImpl &&
            (identical(other.data, data) || other.data == data) &&
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
    message,
    statusCode,
    method,
    path,
    timestamp,
  );

  /// Create a copy of SessionUpdateResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SessionUpdateResponseImplCopyWith<_$SessionUpdateResponseImpl>
  get copyWith =>
      __$$SessionUpdateResponseImplCopyWithImpl<_$SessionUpdateResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$SessionUpdateResponseImplToJson(this);
  }
}

abstract class _SessionUpdateResponse implements SessionUpdateResponse {
  const factory _SessionUpdateResponse({
    required final Session data,
    required final String message,
    required final int statusCode,
    required final String method,
    required final String path,
    required final DateTime timestamp,
  }) = _$SessionUpdateResponseImpl;

  factory _SessionUpdateResponse.fromJson(Map<String, dynamic> json) =
      _$SessionUpdateResponseImpl.fromJson;

  @override
  Session get data;
  @override
  String get message;
  @override
  int get statusCode;
  @override
  String get method;
  @override
  String get path;
  @override
  DateTime get timestamp;

  /// Create a copy of SessionUpdateResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SessionUpdateResponseImplCopyWith<_$SessionUpdateResponseImpl>
  get copyWith => throw _privateConstructorUsedError;
}

GroupSessionNoteResponse _$GroupSessionNoteResponseFromJson(
  Map<String, dynamic> json,
) {
  return _GroupSessionNoteResponse.fromJson(json);
}

/// @nodoc
mixin _$GroupSessionNoteResponse {
  List<GroupSessionData> get data => throw _privateConstructorUsedError;
  Pagination get pagination => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  int get statusCode => throw _privateConstructorUsedError;
  String get method => throw _privateConstructorUsedError;
  String get path => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;

  /// Serializes this GroupSessionNoteResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GroupSessionNoteResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GroupSessionNoteResponseCopyWith<GroupSessionNoteResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GroupSessionNoteResponseCopyWith<$Res> {
  factory $GroupSessionNoteResponseCopyWith(
    GroupSessionNoteResponse value,
    $Res Function(GroupSessionNoteResponse) then,
  ) = _$GroupSessionNoteResponseCopyWithImpl<$Res, GroupSessionNoteResponse>;
  @useResult
  $Res call({
    List<GroupSessionData> data,
    Pagination pagination,
    String message,
    int statusCode,
    String method,
    String path,
    DateTime timestamp,
  });

  $PaginationCopyWith<$Res> get pagination;
}

/// @nodoc
class _$GroupSessionNoteResponseCopyWithImpl<
  $Res,
  $Val extends GroupSessionNoteResponse
>
    implements $GroupSessionNoteResponseCopyWith<$Res> {
  _$GroupSessionNoteResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GroupSessionNoteResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
    Object? pagination = null,
    Object? message = null,
    Object? statusCode = null,
    Object? method = null,
    Object? path = null,
    Object? timestamp = null,
  }) {
    return _then(
      _value.copyWith(
            data:
                null == data
                    ? _value.data
                    : data // ignore: cast_nullable_to_non_nullable
                        as List<GroupSessionData>,
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
                null == method
                    ? _value.method
                    : method // ignore: cast_nullable_to_non_nullable
                        as String,
            path:
                null == path
                    ? _value.path
                    : path // ignore: cast_nullable_to_non_nullable
                        as String,
            timestamp:
                null == timestamp
                    ? _value.timestamp
                    : timestamp // ignore: cast_nullable_to_non_nullable
                        as DateTime,
          )
          as $Val,
    );
  }

  /// Create a copy of GroupSessionNoteResponse
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
abstract class _$$GroupSessionNoteResponseImplCopyWith<$Res>
    implements $GroupSessionNoteResponseCopyWith<$Res> {
  factory _$$GroupSessionNoteResponseImplCopyWith(
    _$GroupSessionNoteResponseImpl value,
    $Res Function(_$GroupSessionNoteResponseImpl) then,
  ) = __$$GroupSessionNoteResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<GroupSessionData> data,
    Pagination pagination,
    String message,
    int statusCode,
    String method,
    String path,
    DateTime timestamp,
  });

  @override
  $PaginationCopyWith<$Res> get pagination;
}

/// @nodoc
class __$$GroupSessionNoteResponseImplCopyWithImpl<$Res>
    extends
        _$GroupSessionNoteResponseCopyWithImpl<
          $Res,
          _$GroupSessionNoteResponseImpl
        >
    implements _$$GroupSessionNoteResponseImplCopyWith<$Res> {
  __$$GroupSessionNoteResponseImplCopyWithImpl(
    _$GroupSessionNoteResponseImpl _value,
    $Res Function(_$GroupSessionNoteResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of GroupSessionNoteResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
    Object? pagination = null,
    Object? message = null,
    Object? statusCode = null,
    Object? method = null,
    Object? path = null,
    Object? timestamp = null,
  }) {
    return _then(
      _$GroupSessionNoteResponseImpl(
        data:
            null == data
                ? _value._data
                : data // ignore: cast_nullable_to_non_nullable
                    as List<GroupSessionData>,
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
            null == method
                ? _value.method
                : method // ignore: cast_nullable_to_non_nullable
                    as String,
        path:
            null == path
                ? _value.path
                : path // ignore: cast_nullable_to_non_nullable
                    as String,
        timestamp:
            null == timestamp
                ? _value.timestamp
                : timestamp // ignore: cast_nullable_to_non_nullable
                    as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$GroupSessionNoteResponseImpl implements _GroupSessionNoteResponse {
  const _$GroupSessionNoteResponseImpl({
    required final List<GroupSessionData> data,
    required this.pagination,
    required this.message,
    required this.statusCode,
    required this.method,
    required this.path,
    required this.timestamp,
  }) : _data = data;

  factory _$GroupSessionNoteResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$GroupSessionNoteResponseImplFromJson(json);

  final List<GroupSessionData> _data;
  @override
  List<GroupSessionData> get data {
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
  final String method;
  @override
  final String path;
  @override
  final DateTime timestamp;

  @override
  String toString() {
    return 'GroupSessionNoteResponse(data: $data, pagination: $pagination, message: $message, statusCode: $statusCode, method: $method, path: $path, timestamp: $timestamp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GroupSessionNoteResponseImpl &&
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

  /// Create a copy of GroupSessionNoteResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GroupSessionNoteResponseImplCopyWith<_$GroupSessionNoteResponseImpl>
  get copyWith => __$$GroupSessionNoteResponseImplCopyWithImpl<
    _$GroupSessionNoteResponseImpl
  >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GroupSessionNoteResponseImplToJson(this);
  }
}

abstract class _GroupSessionNoteResponse implements GroupSessionNoteResponse {
  const factory _GroupSessionNoteResponse({
    required final List<GroupSessionData> data,
    required final Pagination pagination,
    required final String message,
    required final int statusCode,
    required final String method,
    required final String path,
    required final DateTime timestamp,
  }) = _$GroupSessionNoteResponseImpl;

  factory _GroupSessionNoteResponse.fromJson(Map<String, dynamic> json) =
      _$GroupSessionNoteResponseImpl.fromJson;

  @override
  List<GroupSessionData> get data;
  @override
  Pagination get pagination;
  @override
  String get message;
  @override
  int get statusCode;
  @override
  String get method;
  @override
  String get path;
  @override
  DateTime get timestamp;

  /// Create a copy of GroupSessionNoteResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GroupSessionNoteResponseImplCopyWith<_$GroupSessionNoteResponseImpl>
  get copyWith => throw _privateConstructorUsedError;
}

GroupSessionData _$GroupSessionDataFromJson(Map<String, dynamic> json) {
  return _GroupSessionData.fromJson(json);
}

/// @nodoc
mixin _$GroupSessionData {
  String get id => throw _privateConstructorUsedError;
  List<ClientNote>? get clientNotes => throw _privateConstructorUsedError;
  UserModel get therapist => throw _privateConstructorUsedError;
  dynamic get paymentPeriod => throw _privateConstructorUsedError;

  /// Serializes this GroupSessionData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GroupSessionData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GroupSessionDataCopyWith<GroupSessionData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GroupSessionDataCopyWith<$Res> {
  factory $GroupSessionDataCopyWith(
    GroupSessionData value,
    $Res Function(GroupSessionData) then,
  ) = _$GroupSessionDataCopyWithImpl<$Res, GroupSessionData>;
  @useResult
  $Res call({
    String id,
    List<ClientNote>? clientNotes,
    UserModel therapist,
    dynamic paymentPeriod,
  });

  $UserModelCopyWith<$Res> get therapist;
}

/// @nodoc
class _$GroupSessionDataCopyWithImpl<$Res, $Val extends GroupSessionData>
    implements $GroupSessionDataCopyWith<$Res> {
  _$GroupSessionDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GroupSessionData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? clientNotes = freezed,
    Object? therapist = null,
    Object? paymentPeriod = freezed,
  }) {
    return _then(
      _value.copyWith(
            id:
                null == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as String,
            clientNotes:
                freezed == clientNotes
                    ? _value.clientNotes
                    : clientNotes // ignore: cast_nullable_to_non_nullable
                        as List<ClientNote>?,
            therapist:
                null == therapist
                    ? _value.therapist
                    : therapist // ignore: cast_nullable_to_non_nullable
                        as UserModel,
            paymentPeriod:
                freezed == paymentPeriod
                    ? _value.paymentPeriod
                    : paymentPeriod // ignore: cast_nullable_to_non_nullable
                        as dynamic,
          )
          as $Val,
    );
  }

  /// Create a copy of GroupSessionData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserModelCopyWith<$Res> get therapist {
    return $UserModelCopyWith<$Res>(_value.therapist, (value) {
      return _then(_value.copyWith(therapist: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$GroupSessionDataImplCopyWith<$Res>
    implements $GroupSessionDataCopyWith<$Res> {
  factory _$$GroupSessionDataImplCopyWith(
    _$GroupSessionDataImpl value,
    $Res Function(_$GroupSessionDataImpl) then,
  ) = __$$GroupSessionDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    List<ClientNote>? clientNotes,
    UserModel therapist,
    dynamic paymentPeriod,
  });

  @override
  $UserModelCopyWith<$Res> get therapist;
}

/// @nodoc
class __$$GroupSessionDataImplCopyWithImpl<$Res>
    extends _$GroupSessionDataCopyWithImpl<$Res, _$GroupSessionDataImpl>
    implements _$$GroupSessionDataImplCopyWith<$Res> {
  __$$GroupSessionDataImplCopyWithImpl(
    _$GroupSessionDataImpl _value,
    $Res Function(_$GroupSessionDataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of GroupSessionData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? clientNotes = freezed,
    Object? therapist = null,
    Object? paymentPeriod = freezed,
  }) {
    return _then(
      _$GroupSessionDataImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as String,
        clientNotes:
            freezed == clientNotes
                ? _value._clientNotes
                : clientNotes // ignore: cast_nullable_to_non_nullable
                    as List<ClientNote>?,
        therapist:
            null == therapist
                ? _value.therapist
                : therapist // ignore: cast_nullable_to_non_nullable
                    as UserModel,
        paymentPeriod:
            freezed == paymentPeriod
                ? _value.paymentPeriod
                : paymentPeriod // ignore: cast_nullable_to_non_nullable
                    as dynamic,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$GroupSessionDataImpl implements _GroupSessionData {
  const _$GroupSessionDataImpl({
    required this.id,
    required final List<ClientNote>? clientNotes,
    required this.therapist,
    required this.paymentPeriod,
  }) : _clientNotes = clientNotes;

  factory _$GroupSessionDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$GroupSessionDataImplFromJson(json);

  @override
  final String id;
  final List<ClientNote>? _clientNotes;
  @override
  List<ClientNote>? get clientNotes {
    final value = _clientNotes;
    if (value == null) return null;
    if (_clientNotes is EqualUnmodifiableListView) return _clientNotes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final UserModel therapist;
  @override
  final dynamic paymentPeriod;

  @override
  String toString() {
    return 'GroupSessionData(id: $id, clientNotes: $clientNotes, therapist: $therapist, paymentPeriod: $paymentPeriod)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GroupSessionDataImpl &&
            (identical(other.id, id) || other.id == id) &&
            const DeepCollectionEquality().equals(
              other._clientNotes,
              _clientNotes,
            ) &&
            (identical(other.therapist, therapist) ||
                other.therapist == therapist) &&
            const DeepCollectionEquality().equals(
              other.paymentPeriod,
              paymentPeriod,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    const DeepCollectionEquality().hash(_clientNotes),
    therapist,
    const DeepCollectionEquality().hash(paymentPeriod),
  );

  /// Create a copy of GroupSessionData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GroupSessionDataImplCopyWith<_$GroupSessionDataImpl> get copyWith =>
      __$$GroupSessionDataImplCopyWithImpl<_$GroupSessionDataImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$GroupSessionDataImplToJson(this);
  }
}

abstract class _GroupSessionData implements GroupSessionData {
  const factory _GroupSessionData({
    required final String id,
    required final List<ClientNote>? clientNotes,
    required final UserModel therapist,
    required final dynamic paymentPeriod,
  }) = _$GroupSessionDataImpl;

  factory _GroupSessionData.fromJson(Map<String, dynamic> json) =
      _$GroupSessionDataImpl.fromJson;

  @override
  String get id;
  @override
  List<ClientNote>? get clientNotes;
  @override
  UserModel get therapist;
  @override
  dynamic get paymentPeriod;

  /// Create a copy of GroupSessionData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GroupSessionDataImplCopyWith<_$GroupSessionDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ClientNote _$ClientNoteFromJson(Map<String, dynamic> json) {
  return _ClientNote.fromJson(json);
}

/// @nodoc
mixin _$ClientNote {
  String get id => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  String get note => throw _privateConstructorUsedError;
  UserModel get client => throw _privateConstructorUsedError;

  /// Serializes this ClientNote to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ClientNote
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ClientNoteCopyWith<ClientNote> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClientNoteCopyWith<$Res> {
  factory $ClientNoteCopyWith(
    ClientNote value,
    $Res Function(ClientNote) then,
  ) = _$ClientNoteCopyWithImpl<$Res, ClientNote>;
  @useResult
  $Res call({
    String id,
    DateTime? updatedAt,
    DateTime? createdAt,
    String note,
    UserModel client,
  });

  $UserModelCopyWith<$Res> get client;
}

/// @nodoc
class _$ClientNoteCopyWithImpl<$Res, $Val extends ClientNote>
    implements $ClientNoteCopyWith<$Res> {
  _$ClientNoteCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ClientNote
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? updatedAt = freezed,
    Object? createdAt = freezed,
    Object? note = null,
    Object? client = null,
  }) {
    return _then(
      _value.copyWith(
            id:
                null == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as String,
            updatedAt:
                freezed == updatedAt
                    ? _value.updatedAt
                    : updatedAt // ignore: cast_nullable_to_non_nullable
                        as DateTime?,
            createdAt:
                freezed == createdAt
                    ? _value.createdAt
                    : createdAt // ignore: cast_nullable_to_non_nullable
                        as DateTime?,
            note:
                null == note
                    ? _value.note
                    : note // ignore: cast_nullable_to_non_nullable
                        as String,
            client:
                null == client
                    ? _value.client
                    : client // ignore: cast_nullable_to_non_nullable
                        as UserModel,
          )
          as $Val,
    );
  }

  /// Create a copy of ClientNote
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserModelCopyWith<$Res> get client {
    return $UserModelCopyWith<$Res>(_value.client, (value) {
      return _then(_value.copyWith(client: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ClientNoteImplCopyWith<$Res>
    implements $ClientNoteCopyWith<$Res> {
  factory _$$ClientNoteImplCopyWith(
    _$ClientNoteImpl value,
    $Res Function(_$ClientNoteImpl) then,
  ) = __$$ClientNoteImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    DateTime? updatedAt,
    DateTime? createdAt,
    String note,
    UserModel client,
  });

  @override
  $UserModelCopyWith<$Res> get client;
}

/// @nodoc
class __$$ClientNoteImplCopyWithImpl<$Res>
    extends _$ClientNoteCopyWithImpl<$Res, _$ClientNoteImpl>
    implements _$$ClientNoteImplCopyWith<$Res> {
  __$$ClientNoteImplCopyWithImpl(
    _$ClientNoteImpl _value,
    $Res Function(_$ClientNoteImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ClientNote
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? updatedAt = freezed,
    Object? createdAt = freezed,
    Object? note = null,
    Object? client = null,
  }) {
    return _then(
      _$ClientNoteImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as String,
        updatedAt:
            freezed == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                    as DateTime?,
        createdAt:
            freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                    as DateTime?,
        note:
            null == note
                ? _value.note
                : note // ignore: cast_nullable_to_non_nullable
                    as String,
        client:
            null == client
                ? _value.client
                : client // ignore: cast_nullable_to_non_nullable
                    as UserModel,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ClientNoteImpl implements _ClientNote {
  const _$ClientNoteImpl({
    required this.id,
    required this.updatedAt,
    required this.createdAt,
    required this.note,
    required this.client,
  });

  factory _$ClientNoteImpl.fromJson(Map<String, dynamic> json) =>
      _$$ClientNoteImplFromJson(json);

  @override
  final String id;
  @override
  final DateTime? updatedAt;
  @override
  final DateTime? createdAt;
  @override
  final String note;
  @override
  final UserModel client;

  @override
  String toString() {
    return 'ClientNote(id: $id, updatedAt: $updatedAt, createdAt: $createdAt, note: $note, client: $client)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClientNoteImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.note, note) || other.note == note) &&
            (identical(other.client, client) || other.client == client));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, updatedAt, createdAt, note, client);

  /// Create a copy of ClientNote
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ClientNoteImplCopyWith<_$ClientNoteImpl> get copyWith =>
      __$$ClientNoteImplCopyWithImpl<_$ClientNoteImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ClientNoteImplToJson(this);
  }
}

abstract class _ClientNote implements ClientNote {
  const factory _ClientNote({
    required final String id,
    required final DateTime? updatedAt,
    required final DateTime? createdAt,
    required final String note,
    required final UserModel client,
  }) = _$ClientNoteImpl;

  factory _ClientNote.fromJson(Map<String, dynamic> json) =
      _$ClientNoteImpl.fromJson;

  @override
  String get id;
  @override
  DateTime? get updatedAt;
  @override
  DateTime? get createdAt;
  @override
  String get note;
  @override
  UserModel get client;

  /// Create a copy of ClientNote
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ClientNoteImplCopyWith<_$ClientNoteImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SessionGroupNoteUpdateResponse _$SessionGroupNoteUpdateResponseFromJson(
  Map<String, dynamic> json,
) {
  return _SessionGroupNoteUpdateResponse.fromJson(json);
}

/// @nodoc
mixin _$SessionGroupNoteUpdateResponse {
  GroupNoteUpdateData get data => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  int get statusCode => throw _privateConstructorUsedError;
  String get method => throw _privateConstructorUsedError;
  String get path => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;

  /// Serializes this SessionGroupNoteUpdateResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SessionGroupNoteUpdateResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SessionGroupNoteUpdateResponseCopyWith<SessionGroupNoteUpdateResponse>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SessionGroupNoteUpdateResponseCopyWith<$Res> {
  factory $SessionGroupNoteUpdateResponseCopyWith(
    SessionGroupNoteUpdateResponse value,
    $Res Function(SessionGroupNoteUpdateResponse) then,
  ) =
      _$SessionGroupNoteUpdateResponseCopyWithImpl<
        $Res,
        SessionGroupNoteUpdateResponse
      >;
  @useResult
  $Res call({
    GroupNoteUpdateData data,
    String message,
    int statusCode,
    String method,
    String path,
    DateTime timestamp,
  });

  $GroupNoteUpdateDataCopyWith<$Res> get data;
}

/// @nodoc
class _$SessionGroupNoteUpdateResponseCopyWithImpl<
  $Res,
  $Val extends SessionGroupNoteUpdateResponse
>
    implements $SessionGroupNoteUpdateResponseCopyWith<$Res> {
  _$SessionGroupNoteUpdateResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SessionGroupNoteUpdateResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
    Object? message = null,
    Object? statusCode = null,
    Object? method = null,
    Object? path = null,
    Object? timestamp = null,
  }) {
    return _then(
      _value.copyWith(
            data:
                null == data
                    ? _value.data
                    : data // ignore: cast_nullable_to_non_nullable
                        as GroupNoteUpdateData,
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
                null == method
                    ? _value.method
                    : method // ignore: cast_nullable_to_non_nullable
                        as String,
            path:
                null == path
                    ? _value.path
                    : path // ignore: cast_nullable_to_non_nullable
                        as String,
            timestamp:
                null == timestamp
                    ? _value.timestamp
                    : timestamp // ignore: cast_nullable_to_non_nullable
                        as DateTime,
          )
          as $Val,
    );
  }

  /// Create a copy of SessionGroupNoteUpdateResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GroupNoteUpdateDataCopyWith<$Res> get data {
    return $GroupNoteUpdateDataCopyWith<$Res>(_value.data, (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SessionGroupNoteUpdateResponseImplCopyWith<$Res>
    implements $SessionGroupNoteUpdateResponseCopyWith<$Res> {
  factory _$$SessionGroupNoteUpdateResponseImplCopyWith(
    _$SessionGroupNoteUpdateResponseImpl value,
    $Res Function(_$SessionGroupNoteUpdateResponseImpl) then,
  ) = __$$SessionGroupNoteUpdateResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    GroupNoteUpdateData data,
    String message,
    int statusCode,
    String method,
    String path,
    DateTime timestamp,
  });

  @override
  $GroupNoteUpdateDataCopyWith<$Res> get data;
}

/// @nodoc
class __$$SessionGroupNoteUpdateResponseImplCopyWithImpl<$Res>
    extends
        _$SessionGroupNoteUpdateResponseCopyWithImpl<
          $Res,
          _$SessionGroupNoteUpdateResponseImpl
        >
    implements _$$SessionGroupNoteUpdateResponseImplCopyWith<$Res> {
  __$$SessionGroupNoteUpdateResponseImplCopyWithImpl(
    _$SessionGroupNoteUpdateResponseImpl _value,
    $Res Function(_$SessionGroupNoteUpdateResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SessionGroupNoteUpdateResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
    Object? message = null,
    Object? statusCode = null,
    Object? method = null,
    Object? path = null,
    Object? timestamp = null,
  }) {
    return _then(
      _$SessionGroupNoteUpdateResponseImpl(
        data:
            null == data
                ? _value.data
                : data // ignore: cast_nullable_to_non_nullable
                    as GroupNoteUpdateData,
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
            null == method
                ? _value.method
                : method // ignore: cast_nullable_to_non_nullable
                    as String,
        path:
            null == path
                ? _value.path
                : path // ignore: cast_nullable_to_non_nullable
                    as String,
        timestamp:
            null == timestamp
                ? _value.timestamp
                : timestamp // ignore: cast_nullable_to_non_nullable
                    as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SessionGroupNoteUpdateResponseImpl
    implements _SessionGroupNoteUpdateResponse {
  const _$SessionGroupNoteUpdateResponseImpl({
    required this.data,
    required this.message,
    required this.statusCode,
    required this.method,
    required this.path,
    required this.timestamp,
  });

  factory _$SessionGroupNoteUpdateResponseImpl.fromJson(
    Map<String, dynamic> json,
  ) => _$$SessionGroupNoteUpdateResponseImplFromJson(json);

  @override
  final GroupNoteUpdateData data;
  @override
  final String message;
  @override
  final int statusCode;
  @override
  final String method;
  @override
  final String path;
  @override
  final DateTime timestamp;

  @override
  String toString() {
    return 'SessionGroupNoteUpdateResponse(data: $data, message: $message, statusCode: $statusCode, method: $method, path: $path, timestamp: $timestamp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SessionGroupNoteUpdateResponseImpl &&
            (identical(other.data, data) || other.data == data) &&
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
    message,
    statusCode,
    method,
    path,
    timestamp,
  );

  /// Create a copy of SessionGroupNoteUpdateResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SessionGroupNoteUpdateResponseImplCopyWith<
    _$SessionGroupNoteUpdateResponseImpl
  >
  get copyWith => __$$SessionGroupNoteUpdateResponseImplCopyWithImpl<
    _$SessionGroupNoteUpdateResponseImpl
  >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SessionGroupNoteUpdateResponseImplToJson(this);
  }
}

abstract class _SessionGroupNoteUpdateResponse
    implements SessionGroupNoteUpdateResponse {
  const factory _SessionGroupNoteUpdateResponse({
    required final GroupNoteUpdateData data,
    required final String message,
    required final int statusCode,
    required final String method,
    required final String path,
    required final DateTime timestamp,
  }) = _$SessionGroupNoteUpdateResponseImpl;

  factory _SessionGroupNoteUpdateResponse.fromJson(Map<String, dynamic> json) =
      _$SessionGroupNoteUpdateResponseImpl.fromJson;

  @override
  GroupNoteUpdateData get data;
  @override
  String get message;
  @override
  int get statusCode;
  @override
  String get method;
  @override
  String get path;
  @override
  DateTime get timestamp;

  /// Create a copy of SessionGroupNoteUpdateResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SessionGroupNoteUpdateResponseImplCopyWith<
    _$SessionGroupNoteUpdateResponseImpl
  >
  get copyWith => throw _privateConstructorUsedError;
}

GroupNoteUpdateData _$GroupNoteUpdateDataFromJson(Map<String, dynamic> json) {
  return _GroupNoteUpdateData.fromJson(json);
}

/// @nodoc
mixin _$GroupNoteUpdateData {
  String get message => throw _privateConstructorUsedError;

  /// Serializes this GroupNoteUpdateData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GroupNoteUpdateData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GroupNoteUpdateDataCopyWith<GroupNoteUpdateData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GroupNoteUpdateDataCopyWith<$Res> {
  factory $GroupNoteUpdateDataCopyWith(
    GroupNoteUpdateData value,
    $Res Function(GroupNoteUpdateData) then,
  ) = _$GroupNoteUpdateDataCopyWithImpl<$Res, GroupNoteUpdateData>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class _$GroupNoteUpdateDataCopyWithImpl<$Res, $Val extends GroupNoteUpdateData>
    implements $GroupNoteUpdateDataCopyWith<$Res> {
  _$GroupNoteUpdateDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GroupNoteUpdateData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null}) {
    return _then(
      _value.copyWith(
            message:
                null == message
                    ? _value.message
                    : message // ignore: cast_nullable_to_non_nullable
                        as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$GroupNoteUpdateDataImplCopyWith<$Res>
    implements $GroupNoteUpdateDataCopyWith<$Res> {
  factory _$$GroupNoteUpdateDataImplCopyWith(
    _$GroupNoteUpdateDataImpl value,
    $Res Function(_$GroupNoteUpdateDataImpl) then,
  ) = __$$GroupNoteUpdateDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$GroupNoteUpdateDataImplCopyWithImpl<$Res>
    extends _$GroupNoteUpdateDataCopyWithImpl<$Res, _$GroupNoteUpdateDataImpl>
    implements _$$GroupNoteUpdateDataImplCopyWith<$Res> {
  __$$GroupNoteUpdateDataImplCopyWithImpl(
    _$GroupNoteUpdateDataImpl _value,
    $Res Function(_$GroupNoteUpdateDataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of GroupNoteUpdateData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null}) {
    return _then(
      _$GroupNoteUpdateDataImpl(
        message:
            null == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$GroupNoteUpdateDataImpl implements _GroupNoteUpdateData {
  const _$GroupNoteUpdateDataImpl({required this.message});

  factory _$GroupNoteUpdateDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$GroupNoteUpdateDataImplFromJson(json);

  @override
  final String message;

  @override
  String toString() {
    return 'GroupNoteUpdateData(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GroupNoteUpdateDataImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of GroupNoteUpdateData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GroupNoteUpdateDataImplCopyWith<_$GroupNoteUpdateDataImpl> get copyWith =>
      __$$GroupNoteUpdateDataImplCopyWithImpl<_$GroupNoteUpdateDataImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$GroupNoteUpdateDataImplToJson(this);
  }
}

abstract class _GroupNoteUpdateData implements GroupNoteUpdateData {
  const factory _GroupNoteUpdateData({required final String message}) =
      _$GroupNoteUpdateDataImpl;

  factory _GroupNoteUpdateData.fromJson(Map<String, dynamic> json) =
      _$GroupNoteUpdateDataImpl.fromJson;

  @override
  String get message;

  /// Create a copy of GroupNoteUpdateData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GroupNoteUpdateDataImplCopyWith<_$GroupNoteUpdateDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
