// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

UpdatePersonalDetailsRequest _$UpdatePersonalDetailsRequestFromJson(
  Map<String, dynamic> json,
) {
  return _UpdatePersonalDetailsRequest.fromJson(json);
}

/// @nodoc
mixin _$UpdatePersonalDetailsRequest {
  String get firstName => throw _privateConstructorUsedError;
  String get lastName => throw _privateConstructorUsedError;
  String? get username => throw _privateConstructorUsedError;
  String? get emergencyContact => throw _privateConstructorUsedError;
  String? get gender => throw _privateConstructorUsedError;

  /// Serializes this UpdatePersonalDetailsRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UpdatePersonalDetailsRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UpdatePersonalDetailsRequestCopyWith<UpdatePersonalDetailsRequest>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UpdatePersonalDetailsRequestCopyWith<$Res> {
  factory $UpdatePersonalDetailsRequestCopyWith(
    UpdatePersonalDetailsRequest value,
    $Res Function(UpdatePersonalDetailsRequest) then,
  ) =
      _$UpdatePersonalDetailsRequestCopyWithImpl<
        $Res,
        UpdatePersonalDetailsRequest
      >;
  @useResult
  $Res call({
    String firstName,
    String lastName,
    String? username,
    String? emergencyContact,
    String? gender,
  });
}

/// @nodoc
class _$UpdatePersonalDetailsRequestCopyWithImpl<
  $Res,
  $Val extends UpdatePersonalDetailsRequest
>
    implements $UpdatePersonalDetailsRequestCopyWith<$Res> {
  _$UpdatePersonalDetailsRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UpdatePersonalDetailsRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? firstName = null,
    Object? lastName = null,
    Object? username = freezed,
    Object? emergencyContact = freezed,
    Object? gender = freezed,
  }) {
    return _then(
      _value.copyWith(
            firstName:
                null == firstName
                    ? _value.firstName
                    : firstName // ignore: cast_nullable_to_non_nullable
                        as String,
            lastName:
                null == lastName
                    ? _value.lastName
                    : lastName // ignore: cast_nullable_to_non_nullable
                        as String,
            username:
                freezed == username
                    ? _value.username
                    : username // ignore: cast_nullable_to_non_nullable
                        as String?,
            emergencyContact:
                freezed == emergencyContact
                    ? _value.emergencyContact
                    : emergencyContact // ignore: cast_nullable_to_non_nullable
                        as String?,
            gender:
                freezed == gender
                    ? _value.gender
                    : gender // ignore: cast_nullable_to_non_nullable
                        as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$UpdatePersonalDetailsRequestImplCopyWith<$Res>
    implements $UpdatePersonalDetailsRequestCopyWith<$Res> {
  factory _$$UpdatePersonalDetailsRequestImplCopyWith(
    _$UpdatePersonalDetailsRequestImpl value,
    $Res Function(_$UpdatePersonalDetailsRequestImpl) then,
  ) = __$$UpdatePersonalDetailsRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String firstName,
    String lastName,
    String? username,
    String? emergencyContact,
    String? gender,
  });
}

/// @nodoc
class __$$UpdatePersonalDetailsRequestImplCopyWithImpl<$Res>
    extends
        _$UpdatePersonalDetailsRequestCopyWithImpl<
          $Res,
          _$UpdatePersonalDetailsRequestImpl
        >
    implements _$$UpdatePersonalDetailsRequestImplCopyWith<$Res> {
  __$$UpdatePersonalDetailsRequestImplCopyWithImpl(
    _$UpdatePersonalDetailsRequestImpl _value,
    $Res Function(_$UpdatePersonalDetailsRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UpdatePersonalDetailsRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? firstName = null,
    Object? lastName = null,
    Object? username = freezed,
    Object? emergencyContact = freezed,
    Object? gender = freezed,
  }) {
    return _then(
      _$UpdatePersonalDetailsRequestImpl(
        firstName:
            null == firstName
                ? _value.firstName
                : firstName // ignore: cast_nullable_to_non_nullable
                    as String,
        lastName:
            null == lastName
                ? _value.lastName
                : lastName // ignore: cast_nullable_to_non_nullable
                    as String,
        username:
            freezed == username
                ? _value.username
                : username // ignore: cast_nullable_to_non_nullable
                    as String?,
        emergencyContact:
            freezed == emergencyContact
                ? _value.emergencyContact
                : emergencyContact // ignore: cast_nullable_to_non_nullable
                    as String?,
        gender:
            freezed == gender
                ? _value.gender
                : gender // ignore: cast_nullable_to_non_nullable
                    as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UpdatePersonalDetailsRequestImpl
    implements _UpdatePersonalDetailsRequest {
  const _$UpdatePersonalDetailsRequestImpl({
    required this.firstName,
    required this.lastName,
    this.username,
    this.emergencyContact,
    this.gender,
  });

  factory _$UpdatePersonalDetailsRequestImpl.fromJson(
    Map<String, dynamic> json,
  ) => _$$UpdatePersonalDetailsRequestImplFromJson(json);

  @override
  final String firstName;
  @override
  final String lastName;
  @override
  final String? username;
  @override
  final String? emergencyContact;
  @override
  final String? gender;

  @override
  String toString() {
    return 'UpdatePersonalDetailsRequest(firstName: $firstName, lastName: $lastName, username: $username, emergencyContact: $emergencyContact, gender: $gender)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdatePersonalDetailsRequestImpl &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.emergencyContact, emergencyContact) ||
                other.emergencyContact == emergencyContact) &&
            (identical(other.gender, gender) || other.gender == gender));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    firstName,
    lastName,
    username,
    emergencyContact,
    gender,
  );

  /// Create a copy of UpdatePersonalDetailsRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdatePersonalDetailsRequestImplCopyWith<
    _$UpdatePersonalDetailsRequestImpl
  >
  get copyWith => __$$UpdatePersonalDetailsRequestImplCopyWithImpl<
    _$UpdatePersonalDetailsRequestImpl
  >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UpdatePersonalDetailsRequestImplToJson(this);
  }
}

abstract class _UpdatePersonalDetailsRequest
    implements UpdatePersonalDetailsRequest {
  const factory _UpdatePersonalDetailsRequest({
    required final String firstName,
    required final String lastName,
    final String? username,
    final String? emergencyContact,
    final String? gender,
  }) = _$UpdatePersonalDetailsRequestImpl;

  factory _UpdatePersonalDetailsRequest.fromJson(Map<String, dynamic> json) =
      _$UpdatePersonalDetailsRequestImpl.fromJson;

  @override
  String get firstName;
  @override
  String get lastName;
  @override
  String? get username;
  @override
  String? get emergencyContact;
  @override
  String? get gender;

  /// Create a copy of UpdatePersonalDetailsRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdatePersonalDetailsRequestImplCopyWith<
    _$UpdatePersonalDetailsRequestImpl
  >
  get copyWith => throw _privateConstructorUsedError;
}

UpdatePersonalDetailsResponse _$UpdatePersonalDetailsResponseFromJson(
  Map<String, dynamic> json,
) {
  return _UpdatePersonalDetailsResponse.fromJson(json);
}

/// @nodoc
mixin _$UpdatePersonalDetailsResponse {
  String get id => throw _privateConstructorUsedError;
  String get firstName => throw _privateConstructorUsedError;
  String get lastName => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String? get phoneNumber => throw _privateConstructorUsedError;
  String? get gender => throw _privateConstructorUsedError;
  String? get dateOfBirth => throw _privateConstructorUsedError;
  String? get username => throw _privateConstructorUsedError;
  int? get avatar => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  int? get statusCode => throw _privateConstructorUsedError;

  /// Serializes this UpdatePersonalDetailsResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UpdatePersonalDetailsResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UpdatePersonalDetailsResponseCopyWith<UpdatePersonalDetailsResponse>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UpdatePersonalDetailsResponseCopyWith<$Res> {
  factory $UpdatePersonalDetailsResponseCopyWith(
    UpdatePersonalDetailsResponse value,
    $Res Function(UpdatePersonalDetailsResponse) then,
  ) =
      _$UpdatePersonalDetailsResponseCopyWithImpl<
        $Res,
        UpdatePersonalDetailsResponse
      >;
  @useResult
  $Res call({
    String id,
    String firstName,
    String lastName,
    String email,
    String? phoneNumber,
    String? gender,
    String? dateOfBirth,
    String? username,
    int? avatar,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? message,
    int? statusCode,
  });
}

/// @nodoc
class _$UpdatePersonalDetailsResponseCopyWithImpl<
  $Res,
  $Val extends UpdatePersonalDetailsResponse
>
    implements $UpdatePersonalDetailsResponseCopyWith<$Res> {
  _$UpdatePersonalDetailsResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UpdatePersonalDetailsResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? firstName = null,
    Object? lastName = null,
    Object? email = null,
    Object? phoneNumber = freezed,
    Object? gender = freezed,
    Object? dateOfBirth = freezed,
    Object? username = freezed,
    Object? avatar = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? message = freezed,
    Object? statusCode = freezed,
  }) {
    return _then(
      _value.copyWith(
            id:
                null == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as String,
            firstName:
                null == firstName
                    ? _value.firstName
                    : firstName // ignore: cast_nullable_to_non_nullable
                        as String,
            lastName:
                null == lastName
                    ? _value.lastName
                    : lastName // ignore: cast_nullable_to_non_nullable
                        as String,
            email:
                null == email
                    ? _value.email
                    : email // ignore: cast_nullable_to_non_nullable
                        as String,
            phoneNumber:
                freezed == phoneNumber
                    ? _value.phoneNumber
                    : phoneNumber // ignore: cast_nullable_to_non_nullable
                        as String?,
            gender:
                freezed == gender
                    ? _value.gender
                    : gender // ignore: cast_nullable_to_non_nullable
                        as String?,
            dateOfBirth:
                freezed == dateOfBirth
                    ? _value.dateOfBirth
                    : dateOfBirth // ignore: cast_nullable_to_non_nullable
                        as String?,
            username:
                freezed == username
                    ? _value.username
                    : username // ignore: cast_nullable_to_non_nullable
                        as String?,
            avatar:
                freezed == avatar
                    ? _value.avatar
                    : avatar // ignore: cast_nullable_to_non_nullable
                        as int?,
            createdAt:
                freezed == createdAt
                    ? _value.createdAt
                    : createdAt // ignore: cast_nullable_to_non_nullable
                        as DateTime?,
            updatedAt:
                freezed == updatedAt
                    ? _value.updatedAt
                    : updatedAt // ignore: cast_nullable_to_non_nullable
                        as DateTime?,
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
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$UpdatePersonalDetailsResponseImplCopyWith<$Res>
    implements $UpdatePersonalDetailsResponseCopyWith<$Res> {
  factory _$$UpdatePersonalDetailsResponseImplCopyWith(
    _$UpdatePersonalDetailsResponseImpl value,
    $Res Function(_$UpdatePersonalDetailsResponseImpl) then,
  ) = __$$UpdatePersonalDetailsResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String firstName,
    String lastName,
    String email,
    String? phoneNumber,
    String? gender,
    String? dateOfBirth,
    String? username,
    int? avatar,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? message,
    int? statusCode,
  });
}

/// @nodoc
class __$$UpdatePersonalDetailsResponseImplCopyWithImpl<$Res>
    extends
        _$UpdatePersonalDetailsResponseCopyWithImpl<
          $Res,
          _$UpdatePersonalDetailsResponseImpl
        >
    implements _$$UpdatePersonalDetailsResponseImplCopyWith<$Res> {
  __$$UpdatePersonalDetailsResponseImplCopyWithImpl(
    _$UpdatePersonalDetailsResponseImpl _value,
    $Res Function(_$UpdatePersonalDetailsResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UpdatePersonalDetailsResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? firstName = null,
    Object? lastName = null,
    Object? email = null,
    Object? phoneNumber = freezed,
    Object? gender = freezed,
    Object? dateOfBirth = freezed,
    Object? username = freezed,
    Object? avatar = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? message = freezed,
    Object? statusCode = freezed,
  }) {
    return _then(
      _$UpdatePersonalDetailsResponseImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as String,
        firstName:
            null == firstName
                ? _value.firstName
                : firstName // ignore: cast_nullable_to_non_nullable
                    as String,
        lastName:
            null == lastName
                ? _value.lastName
                : lastName // ignore: cast_nullable_to_non_nullable
                    as String,
        email:
            null == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                    as String,
        phoneNumber:
            freezed == phoneNumber
                ? _value.phoneNumber
                : phoneNumber // ignore: cast_nullable_to_non_nullable
                    as String?,
        gender:
            freezed == gender
                ? _value.gender
                : gender // ignore: cast_nullable_to_non_nullable
                    as String?,
        dateOfBirth:
            freezed == dateOfBirth
                ? _value.dateOfBirth
                : dateOfBirth // ignore: cast_nullable_to_non_nullable
                    as String?,
        username:
            freezed == username
                ? _value.username
                : username // ignore: cast_nullable_to_non_nullable
                    as String?,
        avatar:
            freezed == avatar
                ? _value.avatar
                : avatar // ignore: cast_nullable_to_non_nullable
                    as int?,
        createdAt:
            freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                    as DateTime?,
        updatedAt:
            freezed == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                    as DateTime?,
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
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UpdatePersonalDetailsResponseImpl
    implements _UpdatePersonalDetailsResponse {
  const _$UpdatePersonalDetailsResponseImpl({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    this.phoneNumber,
    this.gender,
    this.dateOfBirth,
    this.username,
    this.avatar,
    this.createdAt,
    this.updatedAt,
    this.message,
    this.statusCode,
  });

  factory _$UpdatePersonalDetailsResponseImpl.fromJson(
    Map<String, dynamic> json,
  ) => _$$UpdatePersonalDetailsResponseImplFromJson(json);

  @override
  final String id;
  @override
  final String firstName;
  @override
  final String lastName;
  @override
  final String email;
  @override
  final String? phoneNumber;
  @override
  final String? gender;
  @override
  final String? dateOfBirth;
  @override
  final String? username;
  @override
  final int? avatar;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;
  @override
  final String? message;
  @override
  final int? statusCode;

  @override
  String toString() {
    return 'UpdatePersonalDetailsResponse(id: $id, firstName: $firstName, lastName: $lastName, email: $email, phoneNumber: $phoneNumber, gender: $gender, dateOfBirth: $dateOfBirth, username: $username, avatar: $avatar, createdAt: $createdAt, updatedAt: $updatedAt, message: $message, statusCode: $statusCode)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdatePersonalDetailsResponseImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.gender, gender) || other.gender == gender) &&
            (identical(other.dateOfBirth, dateOfBirth) ||
                other.dateOfBirth == dateOfBirth) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.avatar, avatar) || other.avatar == avatar) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.statusCode, statusCode) ||
                other.statusCode == statusCode));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    firstName,
    lastName,
    email,
    phoneNumber,
    gender,
    dateOfBirth,
    username,
    avatar,
    createdAt,
    updatedAt,
    message,
    statusCode,
  );

  /// Create a copy of UpdatePersonalDetailsResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdatePersonalDetailsResponseImplCopyWith<
    _$UpdatePersonalDetailsResponseImpl
  >
  get copyWith => __$$UpdatePersonalDetailsResponseImplCopyWithImpl<
    _$UpdatePersonalDetailsResponseImpl
  >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UpdatePersonalDetailsResponseImplToJson(this);
  }
}

abstract class _UpdatePersonalDetailsResponse
    implements UpdatePersonalDetailsResponse {
  const factory _UpdatePersonalDetailsResponse({
    required final String id,
    required final String firstName,
    required final String lastName,
    required final String email,
    final String? phoneNumber,
    final String? gender,
    final String? dateOfBirth,
    final String? username,
    final int? avatar,
    final DateTime? createdAt,
    final DateTime? updatedAt,
    final String? message,
    final int? statusCode,
  }) = _$UpdatePersonalDetailsResponseImpl;

  factory _UpdatePersonalDetailsResponse.fromJson(Map<String, dynamic> json) =
      _$UpdatePersonalDetailsResponseImpl.fromJson;

  @override
  String get id;
  @override
  String get firstName;
  @override
  String get lastName;
  @override
  String get email;
  @override
  String? get phoneNumber;
  @override
  String? get gender;
  @override
  String? get dateOfBirth;
  @override
  String? get username;
  @override
  int? get avatar;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;
  @override
  String? get message;
  @override
  int? get statusCode;

  /// Create a copy of UpdatePersonalDetailsResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdatePersonalDetailsResponseImplCopyWith<
    _$UpdatePersonalDetailsResponseImpl
  >
  get copyWith => throw _privateConstructorUsedError;
}

ProfileModel _$ProfileModelFromJson(Map<String, dynamic> json) {
  return _ProfileModel.fromJson(json);
}

/// @nodoc
mixin _$ProfileModel {
  String get id => throw _privateConstructorUsedError;
  String get firstName => throw _privateConstructorUsedError;
  String get lastName => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String? get phoneNumber => throw _privateConstructorUsedError;
  String? get gender => throw _privateConstructorUsedError;
  String? get dateOfBirth => throw _privateConstructorUsedError;
  String? get username => throw _privateConstructorUsedError;
  int? get avatar => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this ProfileModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ProfileModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProfileModelCopyWith<ProfileModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProfileModelCopyWith<$Res> {
  factory $ProfileModelCopyWith(
    ProfileModel value,
    $Res Function(ProfileModel) then,
  ) = _$ProfileModelCopyWithImpl<$Res, ProfileModel>;
  @useResult
  $Res call({
    String id,
    String firstName,
    String lastName,
    String email,
    String? phoneNumber,
    String? gender,
    String? dateOfBirth,
    String? username,
    int? avatar,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
}

/// @nodoc
class _$ProfileModelCopyWithImpl<$Res, $Val extends ProfileModel>
    implements $ProfileModelCopyWith<$Res> {
  _$ProfileModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProfileModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? firstName = null,
    Object? lastName = null,
    Object? email = null,
    Object? phoneNumber = freezed,
    Object? gender = freezed,
    Object? dateOfBirth = freezed,
    Object? username = freezed,
    Object? avatar = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id:
                null == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as String,
            firstName:
                null == firstName
                    ? _value.firstName
                    : firstName // ignore: cast_nullable_to_non_nullable
                        as String,
            lastName:
                null == lastName
                    ? _value.lastName
                    : lastName // ignore: cast_nullable_to_non_nullable
                        as String,
            email:
                null == email
                    ? _value.email
                    : email // ignore: cast_nullable_to_non_nullable
                        as String,
            phoneNumber:
                freezed == phoneNumber
                    ? _value.phoneNumber
                    : phoneNumber // ignore: cast_nullable_to_non_nullable
                        as String?,
            gender:
                freezed == gender
                    ? _value.gender
                    : gender // ignore: cast_nullable_to_non_nullable
                        as String?,
            dateOfBirth:
                freezed == dateOfBirth
                    ? _value.dateOfBirth
                    : dateOfBirth // ignore: cast_nullable_to_non_nullable
                        as String?,
            username:
                freezed == username
                    ? _value.username
                    : username // ignore: cast_nullable_to_non_nullable
                        as String?,
            avatar:
                freezed == avatar
                    ? _value.avatar
                    : avatar // ignore: cast_nullable_to_non_nullable
                        as int?,
            createdAt:
                freezed == createdAt
                    ? _value.createdAt
                    : createdAt // ignore: cast_nullable_to_non_nullable
                        as DateTime?,
            updatedAt:
                freezed == updatedAt
                    ? _value.updatedAt
                    : updatedAt // ignore: cast_nullable_to_non_nullable
                        as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ProfileModelImplCopyWith<$Res>
    implements $ProfileModelCopyWith<$Res> {
  factory _$$ProfileModelImplCopyWith(
    _$ProfileModelImpl value,
    $Res Function(_$ProfileModelImpl) then,
  ) = __$$ProfileModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String firstName,
    String lastName,
    String email,
    String? phoneNumber,
    String? gender,
    String? dateOfBirth,
    String? username,
    int? avatar,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
}

/// @nodoc
class __$$ProfileModelImplCopyWithImpl<$Res>
    extends _$ProfileModelCopyWithImpl<$Res, _$ProfileModelImpl>
    implements _$$ProfileModelImplCopyWith<$Res> {
  __$$ProfileModelImplCopyWithImpl(
    _$ProfileModelImpl _value,
    $Res Function(_$ProfileModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ProfileModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? firstName = null,
    Object? lastName = null,
    Object? email = null,
    Object? phoneNumber = freezed,
    Object? gender = freezed,
    Object? dateOfBirth = freezed,
    Object? username = freezed,
    Object? avatar = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _$ProfileModelImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as String,
        firstName:
            null == firstName
                ? _value.firstName
                : firstName // ignore: cast_nullable_to_non_nullable
                    as String,
        lastName:
            null == lastName
                ? _value.lastName
                : lastName // ignore: cast_nullable_to_non_nullable
                    as String,
        email:
            null == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                    as String,
        phoneNumber:
            freezed == phoneNumber
                ? _value.phoneNumber
                : phoneNumber // ignore: cast_nullable_to_non_nullable
                    as String?,
        gender:
            freezed == gender
                ? _value.gender
                : gender // ignore: cast_nullable_to_non_nullable
                    as String?,
        dateOfBirth:
            freezed == dateOfBirth
                ? _value.dateOfBirth
                : dateOfBirth // ignore: cast_nullable_to_non_nullable
                    as String?,
        username:
            freezed == username
                ? _value.username
                : username // ignore: cast_nullable_to_non_nullable
                    as String?,
        avatar:
            freezed == avatar
                ? _value.avatar
                : avatar // ignore: cast_nullable_to_non_nullable
                    as int?,
        createdAt:
            freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                    as DateTime?,
        updatedAt:
            freezed == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                    as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ProfileModelImpl implements _ProfileModel {
  const _$ProfileModelImpl({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    this.phoneNumber,
    this.gender,
    this.dateOfBirth,
    this.username,
    this.avatar,
    this.createdAt,
    this.updatedAt,
  });

  factory _$ProfileModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProfileModelImplFromJson(json);

  @override
  final String id;
  @override
  final String firstName;
  @override
  final String lastName;
  @override
  final String email;
  @override
  final String? phoneNumber;
  @override
  final String? gender;
  @override
  final String? dateOfBirth;
  @override
  final String? username;
  @override
  final int? avatar;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'ProfileModel(id: $id, firstName: $firstName, lastName: $lastName, email: $email, phoneNumber: $phoneNumber, gender: $gender, dateOfBirth: $dateOfBirth, username: $username, avatar: $avatar, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProfileModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.gender, gender) || other.gender == gender) &&
            (identical(other.dateOfBirth, dateOfBirth) ||
                other.dateOfBirth == dateOfBirth) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.avatar, avatar) || other.avatar == avatar) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    firstName,
    lastName,
    email,
    phoneNumber,
    gender,
    dateOfBirth,
    username,
    avatar,
    createdAt,
    updatedAt,
  );

  /// Create a copy of ProfileModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProfileModelImplCopyWith<_$ProfileModelImpl> get copyWith =>
      __$$ProfileModelImplCopyWithImpl<_$ProfileModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProfileModelImplToJson(this);
  }
}

abstract class _ProfileModel implements ProfileModel {
  const factory _ProfileModel({
    required final String id,
    required final String firstName,
    required final String lastName,
    required final String email,
    final String? phoneNumber,
    final String? gender,
    final String? dateOfBirth,
    final String? username,
    final int? avatar,
    final DateTime? createdAt,
    final DateTime? updatedAt,
  }) = _$ProfileModelImpl;

  factory _ProfileModel.fromJson(Map<String, dynamic> json) =
      _$ProfileModelImpl.fromJson;

  @override
  String get id;
  @override
  String get firstName;
  @override
  String get lastName;
  @override
  String get email;
  @override
  String? get phoneNumber;
  @override
  String? get gender;
  @override
  String? get dateOfBirth;
  @override
  String? get username;
  @override
  int? get avatar;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;

  /// Create a copy of ProfileModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProfileModelImplCopyWith<_$ProfileModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
