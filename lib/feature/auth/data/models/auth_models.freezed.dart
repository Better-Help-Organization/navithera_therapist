// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ApiResponse _$ApiResponseFromJson(Map<String, dynamic> json) {
  return _ApiResponse.fromJson(json);
}

/// @nodoc
mixin _$ApiResponse {
  AuthData get data => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  int get statusCode => throw _privateConstructorUsedError;

  /// Serializes this ApiResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ApiResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ApiResponseCopyWith<ApiResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ApiResponseCopyWith<$Res> {
  factory $ApiResponseCopyWith(
    ApiResponse value,
    $Res Function(ApiResponse) then,
  ) = _$ApiResponseCopyWithImpl<$Res, ApiResponse>;
  @useResult
  $Res call({AuthData data, String message, int statusCode});

  $AuthDataCopyWith<$Res> get data;
}

/// @nodoc
class _$ApiResponseCopyWithImpl<$Res, $Val extends ApiResponse>
    implements $ApiResponseCopyWith<$Res> {
  _$ApiResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ApiResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
    Object? message = null,
    Object? statusCode = null,
  }) {
    return _then(
      _value.copyWith(
            data:
                null == data
                    ? _value.data
                    : data // ignore: cast_nullable_to_non_nullable
                        as AuthData,
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

  /// Create a copy of ApiResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AuthDataCopyWith<$Res> get data {
    return $AuthDataCopyWith<$Res>(_value.data, (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ApiResponseImplCopyWith<$Res>
    implements $ApiResponseCopyWith<$Res> {
  factory _$$ApiResponseImplCopyWith(
    _$ApiResponseImpl value,
    $Res Function(_$ApiResponseImpl) then,
  ) = __$$ApiResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({AuthData data, String message, int statusCode});

  @override
  $AuthDataCopyWith<$Res> get data;
}

/// @nodoc
class __$$ApiResponseImplCopyWithImpl<$Res>
    extends _$ApiResponseCopyWithImpl<$Res, _$ApiResponseImpl>
    implements _$$ApiResponseImplCopyWith<$Res> {
  __$$ApiResponseImplCopyWithImpl(
    _$ApiResponseImpl _value,
    $Res Function(_$ApiResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ApiResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
    Object? message = null,
    Object? statusCode = null,
  }) {
    return _then(
      _$ApiResponseImpl(
        data:
            null == data
                ? _value.data
                : data // ignore: cast_nullable_to_non_nullable
                    as AuthData,
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
class _$ApiResponseImpl implements _ApiResponse {
  const _$ApiResponseImpl({
    required this.data,
    required this.message,
    required this.statusCode,
  });

  factory _$ApiResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$ApiResponseImplFromJson(json);

  @override
  final AuthData data;
  @override
  final String message;
  @override
  final int statusCode;

  @override
  String toString() {
    return 'ApiResponse(data: $data, message: $message, statusCode: $statusCode)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ApiResponseImpl &&
            (identical(other.data, data) || other.data == data) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.statusCode, statusCode) ||
                other.statusCode == statusCode));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, data, message, statusCode);

  /// Create a copy of ApiResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ApiResponseImplCopyWith<_$ApiResponseImpl> get copyWith =>
      __$$ApiResponseImplCopyWithImpl<_$ApiResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ApiResponseImplToJson(this);
  }
}

abstract class _ApiResponse implements ApiResponse {
  const factory _ApiResponse({
    required final AuthData data,
    required final String message,
    required final int statusCode,
  }) = _$ApiResponseImpl;

  factory _ApiResponse.fromJson(Map<String, dynamic> json) =
      _$ApiResponseImpl.fromJson;

  @override
  AuthData get data;
  @override
  String get message;
  @override
  int get statusCode;

  /// Create a copy of ApiResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ApiResponseImplCopyWith<_$ApiResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AuthData _$AuthDataFromJson(Map<String, dynamic> json) {
  return _AuthData.fromJson(json);
}

/// @nodoc
mixin _$AuthData {
  UserModel get user => throw _privateConstructorUsedError;
  String get accessToken => throw _privateConstructorUsedError;
  String get refreshToken => throw _privateConstructorUsedError;

  /// Serializes this AuthData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AuthData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AuthDataCopyWith<AuthData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthDataCopyWith<$Res> {
  factory $AuthDataCopyWith(AuthData value, $Res Function(AuthData) then) =
      _$AuthDataCopyWithImpl<$Res, AuthData>;
  @useResult
  $Res call({UserModel user, String accessToken, String refreshToken});

  $UserModelCopyWith<$Res> get user;
}

/// @nodoc
class _$AuthDataCopyWithImpl<$Res, $Val extends AuthData>
    implements $AuthDataCopyWith<$Res> {
  _$AuthDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AuthData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user = null,
    Object? accessToken = null,
    Object? refreshToken = null,
  }) {
    return _then(
      _value.copyWith(
            user:
                null == user
                    ? _value.user
                    : user // ignore: cast_nullable_to_non_nullable
                        as UserModel,
            accessToken:
                null == accessToken
                    ? _value.accessToken
                    : accessToken // ignore: cast_nullable_to_non_nullable
                        as String,
            refreshToken:
                null == refreshToken
                    ? _value.refreshToken
                    : refreshToken // ignore: cast_nullable_to_non_nullable
                        as String,
          )
          as $Val,
    );
  }

  /// Create a copy of AuthData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserModelCopyWith<$Res> get user {
    return $UserModelCopyWith<$Res>(_value.user, (value) {
      return _then(_value.copyWith(user: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AuthDataImplCopyWith<$Res>
    implements $AuthDataCopyWith<$Res> {
  factory _$$AuthDataImplCopyWith(
    _$AuthDataImpl value,
    $Res Function(_$AuthDataImpl) then,
  ) = __$$AuthDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({UserModel user, String accessToken, String refreshToken});

  @override
  $UserModelCopyWith<$Res> get user;
}

/// @nodoc
class __$$AuthDataImplCopyWithImpl<$Res>
    extends _$AuthDataCopyWithImpl<$Res, _$AuthDataImpl>
    implements _$$AuthDataImplCopyWith<$Res> {
  __$$AuthDataImplCopyWithImpl(
    _$AuthDataImpl _value,
    $Res Function(_$AuthDataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user = null,
    Object? accessToken = null,
    Object? refreshToken = null,
  }) {
    return _then(
      _$AuthDataImpl(
        user:
            null == user
                ? _value.user
                : user // ignore: cast_nullable_to_non_nullable
                    as UserModel,
        accessToken:
            null == accessToken
                ? _value.accessToken
                : accessToken // ignore: cast_nullable_to_non_nullable
                    as String,
        refreshToken:
            null == refreshToken
                ? _value.refreshToken
                : refreshToken // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AuthDataImpl implements _AuthData {
  const _$AuthDataImpl({
    required this.user,
    required this.accessToken,
    required this.refreshToken,
  });

  factory _$AuthDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$AuthDataImplFromJson(json);

  @override
  final UserModel user;
  @override
  final String accessToken;
  @override
  final String refreshToken;

  @override
  String toString() {
    return 'AuthData(user: $user, accessToken: $accessToken, refreshToken: $refreshToken)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthDataImpl &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.accessToken, accessToken) ||
                other.accessToken == accessToken) &&
            (identical(other.refreshToken, refreshToken) ||
                other.refreshToken == refreshToken));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, user, accessToken, refreshToken);

  /// Create a copy of AuthData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthDataImplCopyWith<_$AuthDataImpl> get copyWith =>
      __$$AuthDataImplCopyWithImpl<_$AuthDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AuthDataImplToJson(this);
  }
}

abstract class _AuthData implements AuthData {
  const factory _AuthData({
    required final UserModel user,
    required final String accessToken,
    required final String refreshToken,
  }) = _$AuthDataImpl;

  factory _AuthData.fromJson(Map<String, dynamic> json) =
      _$AuthDataImpl.fromJson;

  @override
  UserModel get user;
  @override
  String get accessToken;
  @override
  String get refreshToken;

  /// Create a copy of AuthData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AuthDataImplCopyWith<_$AuthDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

LoginRequest _$LoginRequestFromJson(Map<String, dynamic> json) {
  return _LoginRequest.fromJson(json);
}

/// @nodoc
mixin _$LoginRequest {
  String get phoneNumber => throw _privateConstructorUsedError;
  String get password => throw _privateConstructorUsedError;
  String get firebaseToken => throw _privateConstructorUsedError;

  /// Serializes this LoginRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LoginRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LoginRequestCopyWith<LoginRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoginRequestCopyWith<$Res> {
  factory $LoginRequestCopyWith(
    LoginRequest value,
    $Res Function(LoginRequest) then,
  ) = _$LoginRequestCopyWithImpl<$Res, LoginRequest>;
  @useResult
  $Res call({String phoneNumber, String password, String firebaseToken});
}

/// @nodoc
class _$LoginRequestCopyWithImpl<$Res, $Val extends LoginRequest>
    implements $LoginRequestCopyWith<$Res> {
  _$LoginRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LoginRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? phoneNumber = null,
    Object? password = null,
    Object? firebaseToken = null,
  }) {
    return _then(
      _value.copyWith(
            phoneNumber:
                null == phoneNumber
                    ? _value.phoneNumber
                    : phoneNumber // ignore: cast_nullable_to_non_nullable
                        as String,
            password:
                null == password
                    ? _value.password
                    : password // ignore: cast_nullable_to_non_nullable
                        as String,
            firebaseToken:
                null == firebaseToken
                    ? _value.firebaseToken
                    : firebaseToken // ignore: cast_nullable_to_non_nullable
                        as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$LoginRequestImplCopyWith<$Res>
    implements $LoginRequestCopyWith<$Res> {
  factory _$$LoginRequestImplCopyWith(
    _$LoginRequestImpl value,
    $Res Function(_$LoginRequestImpl) then,
  ) = __$$LoginRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String phoneNumber, String password, String firebaseToken});
}

/// @nodoc
class __$$LoginRequestImplCopyWithImpl<$Res>
    extends _$LoginRequestCopyWithImpl<$Res, _$LoginRequestImpl>
    implements _$$LoginRequestImplCopyWith<$Res> {
  __$$LoginRequestImplCopyWithImpl(
    _$LoginRequestImpl _value,
    $Res Function(_$LoginRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LoginRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? phoneNumber = null,
    Object? password = null,
    Object? firebaseToken = null,
  }) {
    return _then(
      _$LoginRequestImpl(
        phoneNumber:
            null == phoneNumber
                ? _value.phoneNumber
                : phoneNumber // ignore: cast_nullable_to_non_nullable
                    as String,
        password:
            null == password
                ? _value.password
                : password // ignore: cast_nullable_to_non_nullable
                    as String,
        firebaseToken:
            null == firebaseToken
                ? _value.firebaseToken
                : firebaseToken // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$LoginRequestImpl implements _LoginRequest {
  const _$LoginRequestImpl({
    required this.phoneNumber,
    required this.password,
    required this.firebaseToken,
  });

  factory _$LoginRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$LoginRequestImplFromJson(json);

  @override
  final String phoneNumber;
  @override
  final String password;
  @override
  final String firebaseToken;

  @override
  String toString() {
    return 'LoginRequest(phoneNumber: $phoneNumber, password: $password, firebaseToken: $firebaseToken)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoginRequestImpl &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.firebaseToken, firebaseToken) ||
                other.firebaseToken == firebaseToken));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, phoneNumber, password, firebaseToken);

  /// Create a copy of LoginRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoginRequestImplCopyWith<_$LoginRequestImpl> get copyWith =>
      __$$LoginRequestImplCopyWithImpl<_$LoginRequestImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LoginRequestImplToJson(this);
  }
}

abstract class _LoginRequest implements LoginRequest {
  const factory _LoginRequest({
    required final String phoneNumber,
    required final String password,
    required final String firebaseToken,
  }) = _$LoginRequestImpl;

  factory _LoginRequest.fromJson(Map<String, dynamic> json) =
      _$LoginRequestImpl.fromJson;

  @override
  String get phoneNumber;
  @override
  String get password;
  @override
  String get firebaseToken;

  /// Create a copy of LoginRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoginRequestImplCopyWith<_$LoginRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

LoginResponse _$LoginResponseFromJson(Map<String, dynamic> json) {
  return _LoginResponse.fromJson(json);
}

/// @nodoc
mixin _$LoginResponse {
  UserModel get user => throw _privateConstructorUsedError;
  String get accessToken => throw _privateConstructorUsedError;
  String get refreshToken => throw _privateConstructorUsedError;

  /// Serializes this LoginResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LoginResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LoginResponseCopyWith<LoginResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoginResponseCopyWith<$Res> {
  factory $LoginResponseCopyWith(
    LoginResponse value,
    $Res Function(LoginResponse) then,
  ) = _$LoginResponseCopyWithImpl<$Res, LoginResponse>;
  @useResult
  $Res call({UserModel user, String accessToken, String refreshToken});

  $UserModelCopyWith<$Res> get user;
}

/// @nodoc
class _$LoginResponseCopyWithImpl<$Res, $Val extends LoginResponse>
    implements $LoginResponseCopyWith<$Res> {
  _$LoginResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LoginResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user = null,
    Object? accessToken = null,
    Object? refreshToken = null,
  }) {
    return _then(
      _value.copyWith(
            user:
                null == user
                    ? _value.user
                    : user // ignore: cast_nullable_to_non_nullable
                        as UserModel,
            accessToken:
                null == accessToken
                    ? _value.accessToken
                    : accessToken // ignore: cast_nullable_to_non_nullable
                        as String,
            refreshToken:
                null == refreshToken
                    ? _value.refreshToken
                    : refreshToken // ignore: cast_nullable_to_non_nullable
                        as String,
          )
          as $Val,
    );
  }

  /// Create a copy of LoginResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserModelCopyWith<$Res> get user {
    return $UserModelCopyWith<$Res>(_value.user, (value) {
      return _then(_value.copyWith(user: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$LoginResponseImplCopyWith<$Res>
    implements $LoginResponseCopyWith<$Res> {
  factory _$$LoginResponseImplCopyWith(
    _$LoginResponseImpl value,
    $Res Function(_$LoginResponseImpl) then,
  ) = __$$LoginResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({UserModel user, String accessToken, String refreshToken});

  @override
  $UserModelCopyWith<$Res> get user;
}

/// @nodoc
class __$$LoginResponseImplCopyWithImpl<$Res>
    extends _$LoginResponseCopyWithImpl<$Res, _$LoginResponseImpl>
    implements _$$LoginResponseImplCopyWith<$Res> {
  __$$LoginResponseImplCopyWithImpl(
    _$LoginResponseImpl _value,
    $Res Function(_$LoginResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LoginResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user = null,
    Object? accessToken = null,
    Object? refreshToken = null,
  }) {
    return _then(
      _$LoginResponseImpl(
        user:
            null == user
                ? _value.user
                : user // ignore: cast_nullable_to_non_nullable
                    as UserModel,
        accessToken:
            null == accessToken
                ? _value.accessToken
                : accessToken // ignore: cast_nullable_to_non_nullable
                    as String,
        refreshToken:
            null == refreshToken
                ? _value.refreshToken
                : refreshToken // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$LoginResponseImpl implements _LoginResponse {
  const _$LoginResponseImpl({
    required this.user,
    required this.accessToken,
    required this.refreshToken,
  });

  factory _$LoginResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$LoginResponseImplFromJson(json);

  @override
  final UserModel user;
  @override
  final String accessToken;
  @override
  final String refreshToken;

  @override
  String toString() {
    return 'LoginResponse(user: $user, accessToken: $accessToken, refreshToken: $refreshToken)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoginResponseImpl &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.accessToken, accessToken) ||
                other.accessToken == accessToken) &&
            (identical(other.refreshToken, refreshToken) ||
                other.refreshToken == refreshToken));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, user, accessToken, refreshToken);

  /// Create a copy of LoginResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoginResponseImplCopyWith<_$LoginResponseImpl> get copyWith =>
      __$$LoginResponseImplCopyWithImpl<_$LoginResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LoginResponseImplToJson(this);
  }
}

abstract class _LoginResponse implements LoginResponse {
  const factory _LoginResponse({
    required final UserModel user,
    required final String accessToken,
    required final String refreshToken,
  }) = _$LoginResponseImpl;

  factory _LoginResponse.fromJson(Map<String, dynamic> json) =
      _$LoginResponseImpl.fromJson;

  @override
  UserModel get user;
  @override
  String get accessToken;
  @override
  String get refreshToken;

  /// Create a copy of LoginResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoginResponseImplCopyWith<_$LoginResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SignupRequest _$SignupRequestFromJson(Map<String, dynamic> json) {
  return _SignupRequest.fromJson(json);
}

/// @nodoc
mixin _$SignupRequest {
  String get firstName => throw _privateConstructorUsedError;
  String get lastName => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String get password => throw _privateConstructorUsedError;
  String get firebaseToken => throw _privateConstructorUsedError;
  String get gender => throw _privateConstructorUsedError;
  String get dob =>
      throw _privateConstructorUsedError; // required String username,
  String get phoneNumber => throw _privateConstructorUsedError;

  /// Serializes this SignupRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SignupRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SignupRequestCopyWith<SignupRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SignupRequestCopyWith<$Res> {
  factory $SignupRequestCopyWith(
    SignupRequest value,
    $Res Function(SignupRequest) then,
  ) = _$SignupRequestCopyWithImpl<$Res, SignupRequest>;
  @useResult
  $Res call({
    String firstName,
    String lastName,
    String email,
    String password,
    String firebaseToken,
    String gender,
    String dob,
    String phoneNumber,
  });
}

/// @nodoc
class _$SignupRequestCopyWithImpl<$Res, $Val extends SignupRequest>
    implements $SignupRequestCopyWith<$Res> {
  _$SignupRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SignupRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? firstName = null,
    Object? lastName = null,
    Object? email = null,
    Object? password = null,
    Object? firebaseToken = null,
    Object? gender = null,
    Object? dob = null,
    Object? phoneNumber = null,
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
            email:
                null == email
                    ? _value.email
                    : email // ignore: cast_nullable_to_non_nullable
                        as String,
            password:
                null == password
                    ? _value.password
                    : password // ignore: cast_nullable_to_non_nullable
                        as String,
            firebaseToken:
                null == firebaseToken
                    ? _value.firebaseToken
                    : firebaseToken // ignore: cast_nullable_to_non_nullable
                        as String,
            gender:
                null == gender
                    ? _value.gender
                    : gender // ignore: cast_nullable_to_non_nullable
                        as String,
            dob:
                null == dob
                    ? _value.dob
                    : dob // ignore: cast_nullable_to_non_nullable
                        as String,
            phoneNumber:
                null == phoneNumber
                    ? _value.phoneNumber
                    : phoneNumber // ignore: cast_nullable_to_non_nullable
                        as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SignupRequestImplCopyWith<$Res>
    implements $SignupRequestCopyWith<$Res> {
  factory _$$SignupRequestImplCopyWith(
    _$SignupRequestImpl value,
    $Res Function(_$SignupRequestImpl) then,
  ) = __$$SignupRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String firstName,
    String lastName,
    String email,
    String password,
    String firebaseToken,
    String gender,
    String dob,
    String phoneNumber,
  });
}

/// @nodoc
class __$$SignupRequestImplCopyWithImpl<$Res>
    extends _$SignupRequestCopyWithImpl<$Res, _$SignupRequestImpl>
    implements _$$SignupRequestImplCopyWith<$Res> {
  __$$SignupRequestImplCopyWithImpl(
    _$SignupRequestImpl _value,
    $Res Function(_$SignupRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SignupRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? firstName = null,
    Object? lastName = null,
    Object? email = null,
    Object? password = null,
    Object? firebaseToken = null,
    Object? gender = null,
    Object? dob = null,
    Object? phoneNumber = null,
  }) {
    return _then(
      _$SignupRequestImpl(
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
        password:
            null == password
                ? _value.password
                : password // ignore: cast_nullable_to_non_nullable
                    as String,
        firebaseToken:
            null == firebaseToken
                ? _value.firebaseToken
                : firebaseToken // ignore: cast_nullable_to_non_nullable
                    as String,
        gender:
            null == gender
                ? _value.gender
                : gender // ignore: cast_nullable_to_non_nullable
                    as String,
        dob:
            null == dob
                ? _value.dob
                : dob // ignore: cast_nullable_to_non_nullable
                    as String,
        phoneNumber:
            null == phoneNumber
                ? _value.phoneNumber
                : phoneNumber // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SignupRequestImpl implements _SignupRequest {
  const _$SignupRequestImpl({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.firebaseToken,
    required this.gender,
    required this.dob,
    required this.phoneNumber,
  });

  factory _$SignupRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$SignupRequestImplFromJson(json);

  @override
  final String firstName;
  @override
  final String lastName;
  @override
  final String email;
  @override
  final String password;
  @override
  final String firebaseToken;
  @override
  final String gender;
  @override
  final String dob;
  // required String username,
  @override
  final String phoneNumber;

  @override
  String toString() {
    return 'SignupRequest(firstName: $firstName, lastName: $lastName, email: $email, password: $password, firebaseToken: $firebaseToken, gender: $gender, dob: $dob, phoneNumber: $phoneNumber)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SignupRequestImpl &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.firebaseToken, firebaseToken) ||
                other.firebaseToken == firebaseToken) &&
            (identical(other.gender, gender) || other.gender == gender) &&
            (identical(other.dob, dob) || other.dob == dob) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    firstName,
    lastName,
    email,
    password,
    firebaseToken,
    gender,
    dob,
    phoneNumber,
  );

  /// Create a copy of SignupRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SignupRequestImplCopyWith<_$SignupRequestImpl> get copyWith =>
      __$$SignupRequestImplCopyWithImpl<_$SignupRequestImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SignupRequestImplToJson(this);
  }
}

abstract class _SignupRequest implements SignupRequest {
  const factory _SignupRequest({
    required final String firstName,
    required final String lastName,
    required final String email,
    required final String password,
    required final String firebaseToken,
    required final String gender,
    required final String dob,
    required final String phoneNumber,
  }) = _$SignupRequestImpl;

  factory _SignupRequest.fromJson(Map<String, dynamic> json) =
      _$SignupRequestImpl.fromJson;

  @override
  String get firstName;
  @override
  String get lastName;
  @override
  String get email;
  @override
  String get password;
  @override
  String get firebaseToken;
  @override
  String get gender;
  @override
  String get dob; // required String username,
  @override
  String get phoneNumber;

  /// Create a copy of SignupRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SignupRequestImplCopyWith<_$SignupRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SignupResponse _$SignupResponseFromJson(Map<String, dynamic> json) {
  return _SignupResponse.fromJson(json);
}

/// @nodoc
mixin _$SignupResponse {
  String get id => throw _privateConstructorUsedError;
  String get firstName => throw _privateConstructorUsedError;
  String get lastName => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String get phoneNumber => throw _privateConstructorUsedError;
  String get gender => throw _privateConstructorUsedError;
  String get dob =>
      throw _privateConstructorUsedError; // required String username,
  DateTime get createdAt => throw _privateConstructorUsedError;
  bool? get isEmailAuthenticated => throw _privateConstructorUsedError;
  String? get status => throw _privateConstructorUsedError;
  bool? get isVisible => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  dynamic get emergencyContact => throw _privateConstructorUsedError;
  DateTime? get deletedAt => throw _privateConstructorUsedError;
  bool? get isLinked => throw _privateConstructorUsedError;
  bool? get isPhoneNumberAuthenticated => throw _privateConstructorUsedError;
  String? get accessToken => throw _privateConstructorUsedError;
  String? get refreshToken => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  int? get statusCode => throw _privateConstructorUsedError;

  /// Serializes this SignupResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SignupResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SignupResponseCopyWith<SignupResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SignupResponseCopyWith<$Res> {
  factory $SignupResponseCopyWith(
    SignupResponse value,
    $Res Function(SignupResponse) then,
  ) = _$SignupResponseCopyWithImpl<$Res, SignupResponse>;
  @useResult
  $Res call({
    String id,
    String firstName,
    String lastName,
    String email,
    String phoneNumber,
    String gender,
    String dob,
    DateTime createdAt,
    bool? isEmailAuthenticated,
    String? status,
    bool? isVisible,
    DateTime? updatedAt,
    dynamic emergencyContact,
    DateTime? deletedAt,
    bool? isLinked,
    bool? isPhoneNumberAuthenticated,
    String? accessToken,
    String? refreshToken,
    String? message,
    int? statusCode,
  });
}

/// @nodoc
class _$SignupResponseCopyWithImpl<$Res, $Val extends SignupResponse>
    implements $SignupResponseCopyWith<$Res> {
  _$SignupResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SignupResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? firstName = null,
    Object? lastName = null,
    Object? email = null,
    Object? phoneNumber = null,
    Object? gender = null,
    Object? dob = null,
    Object? createdAt = null,
    Object? isEmailAuthenticated = freezed,
    Object? status = freezed,
    Object? isVisible = freezed,
    Object? updatedAt = freezed,
    Object? emergencyContact = freezed,
    Object? deletedAt = freezed,
    Object? isLinked = freezed,
    Object? isPhoneNumberAuthenticated = freezed,
    Object? accessToken = freezed,
    Object? refreshToken = freezed,
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
                null == phoneNumber
                    ? _value.phoneNumber
                    : phoneNumber // ignore: cast_nullable_to_non_nullable
                        as String,
            gender:
                null == gender
                    ? _value.gender
                    : gender // ignore: cast_nullable_to_non_nullable
                        as String,
            dob:
                null == dob
                    ? _value.dob
                    : dob // ignore: cast_nullable_to_non_nullable
                        as String,
            createdAt:
                null == createdAt
                    ? _value.createdAt
                    : createdAt // ignore: cast_nullable_to_non_nullable
                        as DateTime,
            isEmailAuthenticated:
                freezed == isEmailAuthenticated
                    ? _value.isEmailAuthenticated
                    : isEmailAuthenticated // ignore: cast_nullable_to_non_nullable
                        as bool?,
            status:
                freezed == status
                    ? _value.status
                    : status // ignore: cast_nullable_to_non_nullable
                        as String?,
            isVisible:
                freezed == isVisible
                    ? _value.isVisible
                    : isVisible // ignore: cast_nullable_to_non_nullable
                        as bool?,
            updatedAt:
                freezed == updatedAt
                    ? _value.updatedAt
                    : updatedAt // ignore: cast_nullable_to_non_nullable
                        as DateTime?,
            emergencyContact:
                freezed == emergencyContact
                    ? _value.emergencyContact
                    : emergencyContact // ignore: cast_nullable_to_non_nullable
                        as dynamic,
            deletedAt:
                freezed == deletedAt
                    ? _value.deletedAt
                    : deletedAt // ignore: cast_nullable_to_non_nullable
                        as DateTime?,
            isLinked:
                freezed == isLinked
                    ? _value.isLinked
                    : isLinked // ignore: cast_nullable_to_non_nullable
                        as bool?,
            isPhoneNumberAuthenticated:
                freezed == isPhoneNumberAuthenticated
                    ? _value.isPhoneNumberAuthenticated
                    : isPhoneNumberAuthenticated // ignore: cast_nullable_to_non_nullable
                        as bool?,
            accessToken:
                freezed == accessToken
                    ? _value.accessToken
                    : accessToken // ignore: cast_nullable_to_non_nullable
                        as String?,
            refreshToken:
                freezed == refreshToken
                    ? _value.refreshToken
                    : refreshToken // ignore: cast_nullable_to_non_nullable
                        as String?,
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
abstract class _$$SignupResponseImplCopyWith<$Res>
    implements $SignupResponseCopyWith<$Res> {
  factory _$$SignupResponseImplCopyWith(
    _$SignupResponseImpl value,
    $Res Function(_$SignupResponseImpl) then,
  ) = __$$SignupResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String firstName,
    String lastName,
    String email,
    String phoneNumber,
    String gender,
    String dob,
    DateTime createdAt,
    bool? isEmailAuthenticated,
    String? status,
    bool? isVisible,
    DateTime? updatedAt,
    dynamic emergencyContact,
    DateTime? deletedAt,
    bool? isLinked,
    bool? isPhoneNumberAuthenticated,
    String? accessToken,
    String? refreshToken,
    String? message,
    int? statusCode,
  });
}

/// @nodoc
class __$$SignupResponseImplCopyWithImpl<$Res>
    extends _$SignupResponseCopyWithImpl<$Res, _$SignupResponseImpl>
    implements _$$SignupResponseImplCopyWith<$Res> {
  __$$SignupResponseImplCopyWithImpl(
    _$SignupResponseImpl _value,
    $Res Function(_$SignupResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SignupResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? firstName = null,
    Object? lastName = null,
    Object? email = null,
    Object? phoneNumber = null,
    Object? gender = null,
    Object? dob = null,
    Object? createdAt = null,
    Object? isEmailAuthenticated = freezed,
    Object? status = freezed,
    Object? isVisible = freezed,
    Object? updatedAt = freezed,
    Object? emergencyContact = freezed,
    Object? deletedAt = freezed,
    Object? isLinked = freezed,
    Object? isPhoneNumberAuthenticated = freezed,
    Object? accessToken = freezed,
    Object? refreshToken = freezed,
    Object? message = freezed,
    Object? statusCode = freezed,
  }) {
    return _then(
      _$SignupResponseImpl(
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
            null == phoneNumber
                ? _value.phoneNumber
                : phoneNumber // ignore: cast_nullable_to_non_nullable
                    as String,
        gender:
            null == gender
                ? _value.gender
                : gender // ignore: cast_nullable_to_non_nullable
                    as String,
        dob:
            null == dob
                ? _value.dob
                : dob // ignore: cast_nullable_to_non_nullable
                    as String,
        createdAt:
            null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                    as DateTime,
        isEmailAuthenticated:
            freezed == isEmailAuthenticated
                ? _value.isEmailAuthenticated
                : isEmailAuthenticated // ignore: cast_nullable_to_non_nullable
                    as bool?,
        status:
            freezed == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                    as String?,
        isVisible:
            freezed == isVisible
                ? _value.isVisible
                : isVisible // ignore: cast_nullable_to_non_nullable
                    as bool?,
        updatedAt:
            freezed == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                    as DateTime?,
        emergencyContact:
            freezed == emergencyContact
                ? _value.emergencyContact
                : emergencyContact // ignore: cast_nullable_to_non_nullable
                    as dynamic,
        deletedAt:
            freezed == deletedAt
                ? _value.deletedAt
                : deletedAt // ignore: cast_nullable_to_non_nullable
                    as DateTime?,
        isLinked:
            freezed == isLinked
                ? _value.isLinked
                : isLinked // ignore: cast_nullable_to_non_nullable
                    as bool?,
        isPhoneNumberAuthenticated:
            freezed == isPhoneNumberAuthenticated
                ? _value.isPhoneNumberAuthenticated
                : isPhoneNumberAuthenticated // ignore: cast_nullable_to_non_nullable
                    as bool?,
        accessToken:
            freezed == accessToken
                ? _value.accessToken
                : accessToken // ignore: cast_nullable_to_non_nullable
                    as String?,
        refreshToken:
            freezed == refreshToken
                ? _value.refreshToken
                : refreshToken // ignore: cast_nullable_to_non_nullable
                    as String?,
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
class _$SignupResponseImpl implements _SignupResponse {
  const _$SignupResponseImpl({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.gender,
    required this.dob,
    required this.createdAt,
    this.isEmailAuthenticated,
    this.status,
    this.isVisible,
    this.updatedAt,
    this.emergencyContact,
    this.deletedAt,
    this.isLinked,
    this.isPhoneNumberAuthenticated,
    this.accessToken,
    this.refreshToken,
    this.message,
    this.statusCode,
  });

  factory _$SignupResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$SignupResponseImplFromJson(json);

  @override
  final String id;
  @override
  final String firstName;
  @override
  final String lastName;
  @override
  final String email;
  @override
  final String phoneNumber;
  @override
  final String gender;
  @override
  final String dob;
  // required String username,
  @override
  final DateTime createdAt;
  @override
  final bool? isEmailAuthenticated;
  @override
  final String? status;
  @override
  final bool? isVisible;
  @override
  final DateTime? updatedAt;
  @override
  final dynamic emergencyContact;
  @override
  final DateTime? deletedAt;
  @override
  final bool? isLinked;
  @override
  final bool? isPhoneNumberAuthenticated;
  @override
  final String? accessToken;
  @override
  final String? refreshToken;
  @override
  final String? message;
  @override
  final int? statusCode;

  @override
  String toString() {
    return 'SignupResponse(id: $id, firstName: $firstName, lastName: $lastName, email: $email, phoneNumber: $phoneNumber, gender: $gender, dob: $dob, createdAt: $createdAt, isEmailAuthenticated: $isEmailAuthenticated, status: $status, isVisible: $isVisible, updatedAt: $updatedAt, emergencyContact: $emergencyContact, deletedAt: $deletedAt, isLinked: $isLinked, isPhoneNumberAuthenticated: $isPhoneNumberAuthenticated, accessToken: $accessToken, refreshToken: $refreshToken, message: $message, statusCode: $statusCode)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SignupResponseImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.gender, gender) || other.gender == gender) &&
            (identical(other.dob, dob) || other.dob == dob) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.isEmailAuthenticated, isEmailAuthenticated) ||
                other.isEmailAuthenticated == isEmailAuthenticated) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.isVisible, isVisible) ||
                other.isVisible == isVisible) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            const DeepCollectionEquality().equals(
              other.emergencyContact,
              emergencyContact,
            ) &&
            (identical(other.deletedAt, deletedAt) ||
                other.deletedAt == deletedAt) &&
            (identical(other.isLinked, isLinked) ||
                other.isLinked == isLinked) &&
            (identical(
                  other.isPhoneNumberAuthenticated,
                  isPhoneNumberAuthenticated,
                ) ||
                other.isPhoneNumberAuthenticated ==
                    isPhoneNumberAuthenticated) &&
            (identical(other.accessToken, accessToken) ||
                other.accessToken == accessToken) &&
            (identical(other.refreshToken, refreshToken) ||
                other.refreshToken == refreshToken) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.statusCode, statusCode) ||
                other.statusCode == statusCode));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    id,
    firstName,
    lastName,
    email,
    phoneNumber,
    gender,
    dob,
    createdAt,
    isEmailAuthenticated,
    status,
    isVisible,
    updatedAt,
    const DeepCollectionEquality().hash(emergencyContact),
    deletedAt,
    isLinked,
    isPhoneNumberAuthenticated,
    accessToken,
    refreshToken,
    message,
    statusCode,
  ]);

  /// Create a copy of SignupResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SignupResponseImplCopyWith<_$SignupResponseImpl> get copyWith =>
      __$$SignupResponseImplCopyWithImpl<_$SignupResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$SignupResponseImplToJson(this);
  }
}

abstract class _SignupResponse implements SignupResponse {
  const factory _SignupResponse({
    required final String id,
    required final String firstName,
    required final String lastName,
    required final String email,
    required final String phoneNumber,
    required final String gender,
    required final String dob,
    required final DateTime createdAt,
    final bool? isEmailAuthenticated,
    final String? status,
    final bool? isVisible,
    final DateTime? updatedAt,
    final dynamic emergencyContact,
    final DateTime? deletedAt,
    final bool? isLinked,
    final bool? isPhoneNumberAuthenticated,
    final String? accessToken,
    final String? refreshToken,
    final String? message,
    final int? statusCode,
  }) = _$SignupResponseImpl;

  factory _SignupResponse.fromJson(Map<String, dynamic> json) =
      _$SignupResponseImpl.fromJson;

  @override
  String get id;
  @override
  String get firstName;
  @override
  String get lastName;
  @override
  String get email;
  @override
  String get phoneNumber;
  @override
  String get gender;
  @override
  String get dob; // required String username,
  @override
  DateTime get createdAt;
  @override
  bool? get isEmailAuthenticated;
  @override
  String? get status;
  @override
  bool? get isVisible;
  @override
  DateTime? get updatedAt;
  @override
  dynamic get emergencyContact;
  @override
  DateTime? get deletedAt;
  @override
  bool? get isLinked;
  @override
  bool? get isPhoneNumberAuthenticated;
  @override
  String? get accessToken;
  @override
  String? get refreshToken;
  @override
  String? get message;
  @override
  int? get statusCode;

  /// Create a copy of SignupResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SignupResponseImplCopyWith<_$SignupResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UserModel _$UserModelFromJson(Map<String, dynamic> json) {
  return _UserModel.fromJson(json);
}

/// @nodoc
mixin _$UserModel {
  String get id => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String get firstName => throw _privateConstructorUsedError;
  String get lastName => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  bool? get isEmailAuthenticated => throw _privateConstructorUsedError;
  String? get status => throw _privateConstructorUsedError;
  String? get gender => throw _privateConstructorUsedError;
  DateTime? get dob => throw _privateConstructorUsedError;
  String? get username => throw _privateConstructorUsedError;
  String? get phoneNumber => throw _privateConstructorUsedError;
  bool? get isVisible => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  dynamic get emergencyContact =>
      throw _privateConstructorUsedError; // or create specific model if needed
  DateTime? get deletedAt => throw _privateConstructorUsedError;
  bool? get isLinked => throw _privateConstructorUsedError;
  bool? get isPhoneNumberAuthenticated => throw _privateConstructorUsedError;
  int? get avatar => throw _privateConstructorUsedError;
  String? get profile => throw _privateConstructorUsedError;
  bool? get isOnline => throw _privateConstructorUsedError;
  int? get hoursDedicatedPerWeek => throw _privateConstructorUsedError;

  /// Serializes this UserModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserModelCopyWith<UserModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserModelCopyWith<$Res> {
  factory $UserModelCopyWith(UserModel value, $Res Function(UserModel) then) =
      _$UserModelCopyWithImpl<$Res, UserModel>;
  @useResult
  $Res call({
    String id,
    String email,
    String firstName,
    String lastName,
    DateTime createdAt,
    bool? isEmailAuthenticated,
    String? status,
    String? gender,
    DateTime? dob,
    String? username,
    String? phoneNumber,
    bool? isVisible,
    DateTime? updatedAt,
    dynamic emergencyContact,
    DateTime? deletedAt,
    bool? isLinked,
    bool? isPhoneNumberAuthenticated,
    int? avatar,
    String? profile,
    bool? isOnline,
    int? hoursDedicatedPerWeek,
  });
}

/// @nodoc
class _$UserModelCopyWithImpl<$Res, $Val extends UserModel>
    implements $UserModelCopyWith<$Res> {
  _$UserModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? email = null,
    Object? firstName = null,
    Object? lastName = null,
    Object? createdAt = null,
    Object? isEmailAuthenticated = freezed,
    Object? status = freezed,
    Object? gender = freezed,
    Object? dob = freezed,
    Object? username = freezed,
    Object? phoneNumber = freezed,
    Object? isVisible = freezed,
    Object? updatedAt = freezed,
    Object? emergencyContact = freezed,
    Object? deletedAt = freezed,
    Object? isLinked = freezed,
    Object? isPhoneNumberAuthenticated = freezed,
    Object? avatar = freezed,
    Object? profile = freezed,
    Object? isOnline = freezed,
    Object? hoursDedicatedPerWeek = freezed,
  }) {
    return _then(
      _value.copyWith(
            id:
                null == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as String,
            email:
                null == email
                    ? _value.email
                    : email // ignore: cast_nullable_to_non_nullable
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
            createdAt:
                null == createdAt
                    ? _value.createdAt
                    : createdAt // ignore: cast_nullable_to_non_nullable
                        as DateTime,
            isEmailAuthenticated:
                freezed == isEmailAuthenticated
                    ? _value.isEmailAuthenticated
                    : isEmailAuthenticated // ignore: cast_nullable_to_non_nullable
                        as bool?,
            status:
                freezed == status
                    ? _value.status
                    : status // ignore: cast_nullable_to_non_nullable
                        as String?,
            gender:
                freezed == gender
                    ? _value.gender
                    : gender // ignore: cast_nullable_to_non_nullable
                        as String?,
            dob:
                freezed == dob
                    ? _value.dob
                    : dob // ignore: cast_nullable_to_non_nullable
                        as DateTime?,
            username:
                freezed == username
                    ? _value.username
                    : username // ignore: cast_nullable_to_non_nullable
                        as String?,
            phoneNumber:
                freezed == phoneNumber
                    ? _value.phoneNumber
                    : phoneNumber // ignore: cast_nullable_to_non_nullable
                        as String?,
            isVisible:
                freezed == isVisible
                    ? _value.isVisible
                    : isVisible // ignore: cast_nullable_to_non_nullable
                        as bool?,
            updatedAt:
                freezed == updatedAt
                    ? _value.updatedAt
                    : updatedAt // ignore: cast_nullable_to_non_nullable
                        as DateTime?,
            emergencyContact:
                freezed == emergencyContact
                    ? _value.emergencyContact
                    : emergencyContact // ignore: cast_nullable_to_non_nullable
                        as dynamic,
            deletedAt:
                freezed == deletedAt
                    ? _value.deletedAt
                    : deletedAt // ignore: cast_nullable_to_non_nullable
                        as DateTime?,
            isLinked:
                freezed == isLinked
                    ? _value.isLinked
                    : isLinked // ignore: cast_nullable_to_non_nullable
                        as bool?,
            isPhoneNumberAuthenticated:
                freezed == isPhoneNumberAuthenticated
                    ? _value.isPhoneNumberAuthenticated
                    : isPhoneNumberAuthenticated // ignore: cast_nullable_to_non_nullable
                        as bool?,
            avatar:
                freezed == avatar
                    ? _value.avatar
                    : avatar // ignore: cast_nullable_to_non_nullable
                        as int?,
            profile:
                freezed == profile
                    ? _value.profile
                    : profile // ignore: cast_nullable_to_non_nullable
                        as String?,
            isOnline:
                freezed == isOnline
                    ? _value.isOnline
                    : isOnline // ignore: cast_nullable_to_non_nullable
                        as bool?,
            hoursDedicatedPerWeek:
                freezed == hoursDedicatedPerWeek
                    ? _value.hoursDedicatedPerWeek
                    : hoursDedicatedPerWeek // ignore: cast_nullable_to_non_nullable
                        as int?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$UserModelImplCopyWith<$Res>
    implements $UserModelCopyWith<$Res> {
  factory _$$UserModelImplCopyWith(
    _$UserModelImpl value,
    $Res Function(_$UserModelImpl) then,
  ) = __$$UserModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String email,
    String firstName,
    String lastName,
    DateTime createdAt,
    bool? isEmailAuthenticated,
    String? status,
    String? gender,
    DateTime? dob,
    String? username,
    String? phoneNumber,
    bool? isVisible,
    DateTime? updatedAt,
    dynamic emergencyContact,
    DateTime? deletedAt,
    bool? isLinked,
    bool? isPhoneNumberAuthenticated,
    int? avatar,
    String? profile,
    bool? isOnline,
    int? hoursDedicatedPerWeek,
  });
}

/// @nodoc
class __$$UserModelImplCopyWithImpl<$Res>
    extends _$UserModelCopyWithImpl<$Res, _$UserModelImpl>
    implements _$$UserModelImplCopyWith<$Res> {
  __$$UserModelImplCopyWithImpl(
    _$UserModelImpl _value,
    $Res Function(_$UserModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? email = null,
    Object? firstName = null,
    Object? lastName = null,
    Object? createdAt = null,
    Object? isEmailAuthenticated = freezed,
    Object? status = freezed,
    Object? gender = freezed,
    Object? dob = freezed,
    Object? username = freezed,
    Object? phoneNumber = freezed,
    Object? isVisible = freezed,
    Object? updatedAt = freezed,
    Object? emergencyContact = freezed,
    Object? deletedAt = freezed,
    Object? isLinked = freezed,
    Object? isPhoneNumberAuthenticated = freezed,
    Object? avatar = freezed,
    Object? profile = freezed,
    Object? isOnline = freezed,
    Object? hoursDedicatedPerWeek = freezed,
  }) {
    return _then(
      _$UserModelImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as String,
        email:
            null == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
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
        createdAt:
            null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                    as DateTime,
        isEmailAuthenticated:
            freezed == isEmailAuthenticated
                ? _value.isEmailAuthenticated
                : isEmailAuthenticated // ignore: cast_nullable_to_non_nullable
                    as bool?,
        status:
            freezed == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                    as String?,
        gender:
            freezed == gender
                ? _value.gender
                : gender // ignore: cast_nullable_to_non_nullable
                    as String?,
        dob:
            freezed == dob
                ? _value.dob
                : dob // ignore: cast_nullable_to_non_nullable
                    as DateTime?,
        username:
            freezed == username
                ? _value.username
                : username // ignore: cast_nullable_to_non_nullable
                    as String?,
        phoneNumber:
            freezed == phoneNumber
                ? _value.phoneNumber
                : phoneNumber // ignore: cast_nullable_to_non_nullable
                    as String?,
        isVisible:
            freezed == isVisible
                ? _value.isVisible
                : isVisible // ignore: cast_nullable_to_non_nullable
                    as bool?,
        updatedAt:
            freezed == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                    as DateTime?,
        emergencyContact:
            freezed == emergencyContact
                ? _value.emergencyContact
                : emergencyContact // ignore: cast_nullable_to_non_nullable
                    as dynamic,
        deletedAt:
            freezed == deletedAt
                ? _value.deletedAt
                : deletedAt // ignore: cast_nullable_to_non_nullable
                    as DateTime?,
        isLinked:
            freezed == isLinked
                ? _value.isLinked
                : isLinked // ignore: cast_nullable_to_non_nullable
                    as bool?,
        isPhoneNumberAuthenticated:
            freezed == isPhoneNumberAuthenticated
                ? _value.isPhoneNumberAuthenticated
                : isPhoneNumberAuthenticated // ignore: cast_nullable_to_non_nullable
                    as bool?,
        avatar:
            freezed == avatar
                ? _value.avatar
                : avatar // ignore: cast_nullable_to_non_nullable
                    as int?,
        profile:
            freezed == profile
                ? _value.profile
                : profile // ignore: cast_nullable_to_non_nullable
                    as String?,
        isOnline:
            freezed == isOnline
                ? _value.isOnline
                : isOnline // ignore: cast_nullable_to_non_nullable
                    as bool?,
        hoursDedicatedPerWeek:
            freezed == hoursDedicatedPerWeek
                ? _value.hoursDedicatedPerWeek
                : hoursDedicatedPerWeek // ignore: cast_nullable_to_non_nullable
                    as int?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UserModelImpl implements _UserModel {
  const _$UserModelImpl({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.createdAt,
    this.isEmailAuthenticated,
    this.status,
    this.gender,
    this.dob,
    this.username,
    this.phoneNumber,
    this.isVisible,
    this.updatedAt,
    this.emergencyContact,
    this.deletedAt,
    this.isLinked,
    this.isPhoneNumberAuthenticated,
    this.avatar,
    this.profile,
    this.isOnline,
    this.hoursDedicatedPerWeek,
  });

  factory _$UserModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserModelImplFromJson(json);

  @override
  final String id;
  @override
  final String email;
  @override
  final String firstName;
  @override
  final String lastName;
  @override
  final DateTime createdAt;
  @override
  final bool? isEmailAuthenticated;
  @override
  final String? status;
  @override
  final String? gender;
  @override
  final DateTime? dob;
  @override
  final String? username;
  @override
  final String? phoneNumber;
  @override
  final bool? isVisible;
  @override
  final DateTime? updatedAt;
  @override
  final dynamic emergencyContact;
  // or create specific model if needed
  @override
  final DateTime? deletedAt;
  @override
  final bool? isLinked;
  @override
  final bool? isPhoneNumberAuthenticated;
  @override
  final int? avatar;
  @override
  final String? profile;
  @override
  final bool? isOnline;
  @override
  final int? hoursDedicatedPerWeek;

  @override
  String toString() {
    return 'UserModel(id: $id, email: $email, firstName: $firstName, lastName: $lastName, createdAt: $createdAt, isEmailAuthenticated: $isEmailAuthenticated, status: $status, gender: $gender, dob: $dob, username: $username, phoneNumber: $phoneNumber, isVisible: $isVisible, updatedAt: $updatedAt, emergencyContact: $emergencyContact, deletedAt: $deletedAt, isLinked: $isLinked, isPhoneNumberAuthenticated: $isPhoneNumberAuthenticated, avatar: $avatar, profile: $profile, isOnline: $isOnline, hoursDedicatedPerWeek: $hoursDedicatedPerWeek)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.isEmailAuthenticated, isEmailAuthenticated) ||
                other.isEmailAuthenticated == isEmailAuthenticated) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.gender, gender) || other.gender == gender) &&
            (identical(other.dob, dob) || other.dob == dob) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.isVisible, isVisible) ||
                other.isVisible == isVisible) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            const DeepCollectionEquality().equals(
              other.emergencyContact,
              emergencyContact,
            ) &&
            (identical(other.deletedAt, deletedAt) ||
                other.deletedAt == deletedAt) &&
            (identical(other.isLinked, isLinked) ||
                other.isLinked == isLinked) &&
            (identical(
                  other.isPhoneNumberAuthenticated,
                  isPhoneNumberAuthenticated,
                ) ||
                other.isPhoneNumberAuthenticated ==
                    isPhoneNumberAuthenticated) &&
            (identical(other.avatar, avatar) || other.avatar == avatar) &&
            (identical(other.profile, profile) || other.profile == profile) &&
            (identical(other.isOnline, isOnline) ||
                other.isOnline == isOnline) &&
            (identical(other.hoursDedicatedPerWeek, hoursDedicatedPerWeek) ||
                other.hoursDedicatedPerWeek == hoursDedicatedPerWeek));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    id,
    email,
    firstName,
    lastName,
    createdAt,
    isEmailAuthenticated,
    status,
    gender,
    dob,
    username,
    phoneNumber,
    isVisible,
    updatedAt,
    const DeepCollectionEquality().hash(emergencyContact),
    deletedAt,
    isLinked,
    isPhoneNumberAuthenticated,
    avatar,
    profile,
    isOnline,
    hoursDedicatedPerWeek,
  ]);

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserModelImplCopyWith<_$UserModelImpl> get copyWith =>
      __$$UserModelImplCopyWithImpl<_$UserModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserModelImplToJson(this);
  }
}

abstract class _UserModel implements UserModel {
  const factory _UserModel({
    required final String id,
    required final String email,
    required final String firstName,
    required final String lastName,
    required final DateTime createdAt,
    final bool? isEmailAuthenticated,
    final String? status,
    final String? gender,
    final DateTime? dob,
    final String? username,
    final String? phoneNumber,
    final bool? isVisible,
    final DateTime? updatedAt,
    final dynamic emergencyContact,
    final DateTime? deletedAt,
    final bool? isLinked,
    final bool? isPhoneNumberAuthenticated,
    final int? avatar,
    final String? profile,
    final bool? isOnline,
    final int? hoursDedicatedPerWeek,
  }) = _$UserModelImpl;

  factory _UserModel.fromJson(Map<String, dynamic> json) =
      _$UserModelImpl.fromJson;

  @override
  String get id;
  @override
  String get email;
  @override
  String get firstName;
  @override
  String get lastName;
  @override
  DateTime get createdAt;
  @override
  bool? get isEmailAuthenticated;
  @override
  String? get status;
  @override
  String? get gender;
  @override
  DateTime? get dob;
  @override
  String? get username;
  @override
  String? get phoneNumber;
  @override
  bool? get isVisible;
  @override
  DateTime? get updatedAt;
  @override
  dynamic get emergencyContact; // or create specific model if needed
  @override
  DateTime? get deletedAt;
  @override
  bool? get isLinked;
  @override
  bool? get isPhoneNumberAuthenticated;
  @override
  int? get avatar;
  @override
  String? get profile;
  @override
  bool? get isOnline;
  @override
  int? get hoursDedicatedPerWeek;

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserModelImplCopyWith<_$UserModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UpdateProfileRequest _$UpdateProfileRequestFromJson(Map<String, dynamic> json) {
  return _UpdateProfileRequest.fromJson(json);
}

/// @nodoc
mixin _$UpdateProfileRequest {
  String? get firstName => throw _privateConstructorUsedError;
  String? get lastName => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  String? get gender => throw _privateConstructorUsedError; // String? dob,
  String? get username => throw _privateConstructorUsedError;
  String? get phoneNumber => throw _privateConstructorUsedError;

  /// Serializes this UpdateProfileRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UpdateProfileRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UpdateProfileRequestCopyWith<UpdateProfileRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UpdateProfileRequestCopyWith<$Res> {
  factory $UpdateProfileRequestCopyWith(
    UpdateProfileRequest value,
    $Res Function(UpdateProfileRequest) then,
  ) = _$UpdateProfileRequestCopyWithImpl<$Res, UpdateProfileRequest>;
  @useResult
  $Res call({
    String? firstName,
    String? lastName,
    String? email,
    String? gender,
    String? username,
    String? phoneNumber,
  });
}

/// @nodoc
class _$UpdateProfileRequestCopyWithImpl<
  $Res,
  $Val extends UpdateProfileRequest
>
    implements $UpdateProfileRequestCopyWith<$Res> {
  _$UpdateProfileRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UpdateProfileRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? firstName = freezed,
    Object? lastName = freezed,
    Object? email = freezed,
    Object? gender = freezed,
    Object? username = freezed,
    Object? phoneNumber = freezed,
  }) {
    return _then(
      _value.copyWith(
            firstName:
                freezed == firstName
                    ? _value.firstName
                    : firstName // ignore: cast_nullable_to_non_nullable
                        as String?,
            lastName:
                freezed == lastName
                    ? _value.lastName
                    : lastName // ignore: cast_nullable_to_non_nullable
                        as String?,
            email:
                freezed == email
                    ? _value.email
                    : email // ignore: cast_nullable_to_non_nullable
                        as String?,
            gender:
                freezed == gender
                    ? _value.gender
                    : gender // ignore: cast_nullable_to_non_nullable
                        as String?,
            username:
                freezed == username
                    ? _value.username
                    : username // ignore: cast_nullable_to_non_nullable
                        as String?,
            phoneNumber:
                freezed == phoneNumber
                    ? _value.phoneNumber
                    : phoneNumber // ignore: cast_nullable_to_non_nullable
                        as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$UpdateProfileRequestImplCopyWith<$Res>
    implements $UpdateProfileRequestCopyWith<$Res> {
  factory _$$UpdateProfileRequestImplCopyWith(
    _$UpdateProfileRequestImpl value,
    $Res Function(_$UpdateProfileRequestImpl) then,
  ) = __$$UpdateProfileRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? firstName,
    String? lastName,
    String? email,
    String? gender,
    String? username,
    String? phoneNumber,
  });
}

/// @nodoc
class __$$UpdateProfileRequestImplCopyWithImpl<$Res>
    extends _$UpdateProfileRequestCopyWithImpl<$Res, _$UpdateProfileRequestImpl>
    implements _$$UpdateProfileRequestImplCopyWith<$Res> {
  __$$UpdateProfileRequestImplCopyWithImpl(
    _$UpdateProfileRequestImpl _value,
    $Res Function(_$UpdateProfileRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UpdateProfileRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? firstName = freezed,
    Object? lastName = freezed,
    Object? email = freezed,
    Object? gender = freezed,
    Object? username = freezed,
    Object? phoneNumber = freezed,
  }) {
    return _then(
      _$UpdateProfileRequestImpl(
        firstName:
            freezed == firstName
                ? _value.firstName
                : firstName // ignore: cast_nullable_to_non_nullable
                    as String?,
        lastName:
            freezed == lastName
                ? _value.lastName
                : lastName // ignore: cast_nullable_to_non_nullable
                    as String?,
        email:
            freezed == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                    as String?,
        gender:
            freezed == gender
                ? _value.gender
                : gender // ignore: cast_nullable_to_non_nullable
                    as String?,
        username:
            freezed == username
                ? _value.username
                : username // ignore: cast_nullable_to_non_nullable
                    as String?,
        phoneNumber:
            freezed == phoneNumber
                ? _value.phoneNumber
                : phoneNumber // ignore: cast_nullable_to_non_nullable
                    as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UpdateProfileRequestImpl implements _UpdateProfileRequest {
  const _$UpdateProfileRequestImpl({
    this.firstName,
    this.lastName,
    this.email,
    this.gender,
    this.username,
    this.phoneNumber,
  });

  factory _$UpdateProfileRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$UpdateProfileRequestImplFromJson(json);

  @override
  final String? firstName;
  @override
  final String? lastName;
  @override
  final String? email;
  @override
  final String? gender;
  // String? dob,
  @override
  final String? username;
  @override
  final String? phoneNumber;

  @override
  String toString() {
    return 'UpdateProfileRequest(firstName: $firstName, lastName: $lastName, email: $email, gender: $gender, username: $username, phoneNumber: $phoneNumber)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateProfileRequestImpl &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.gender, gender) || other.gender == gender) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    firstName,
    lastName,
    email,
    gender,
    username,
    phoneNumber,
  );

  /// Create a copy of UpdateProfileRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateProfileRequestImplCopyWith<_$UpdateProfileRequestImpl>
  get copyWith =>
      __$$UpdateProfileRequestImplCopyWithImpl<_$UpdateProfileRequestImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$UpdateProfileRequestImplToJson(this);
  }
}

abstract class _UpdateProfileRequest implements UpdateProfileRequest {
  const factory _UpdateProfileRequest({
    final String? firstName,
    final String? lastName,
    final String? email,
    final String? gender,
    final String? username,
    final String? phoneNumber,
  }) = _$UpdateProfileRequestImpl;

  factory _UpdateProfileRequest.fromJson(Map<String, dynamic> json) =
      _$UpdateProfileRequestImpl.fromJson;

  @override
  String? get firstName;
  @override
  String? get lastName;
  @override
  String? get email;
  @override
  String? get gender; // String? dob,
  @override
  String? get username;
  @override
  String? get phoneNumber;

  /// Create a copy of UpdateProfileRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdateProfileRequestImplCopyWith<_$UpdateProfileRequestImpl>
  get copyWith => throw _privateConstructorUsedError;
}

ProfileApiResponse _$ProfileApiResponseFromJson(Map<String, dynamic> json) {
  return _ProfileApiResponse.fromJson(json);
}

/// @nodoc
mixin _$ProfileApiResponse {
  UserModel get data =>
      throw _privateConstructorUsedError; // Direct user data, not wrapped in AuthData
  String get message => throw _privateConstructorUsedError;
  int get statusCode => throw _privateConstructorUsedError;

  /// Serializes this ProfileApiResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ProfileApiResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProfileApiResponseCopyWith<ProfileApiResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProfileApiResponseCopyWith<$Res> {
  factory $ProfileApiResponseCopyWith(
    ProfileApiResponse value,
    $Res Function(ProfileApiResponse) then,
  ) = _$ProfileApiResponseCopyWithImpl<$Res, ProfileApiResponse>;
  @useResult
  $Res call({UserModel data, String message, int statusCode});

  $UserModelCopyWith<$Res> get data;
}

/// @nodoc
class _$ProfileApiResponseCopyWithImpl<$Res, $Val extends ProfileApiResponse>
    implements $ProfileApiResponseCopyWith<$Res> {
  _$ProfileApiResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProfileApiResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
    Object? message = null,
    Object? statusCode = null,
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
          )
          as $Val,
    );
  }

  /// Create a copy of ProfileApiResponse
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
abstract class _$$ProfileApiResponseImplCopyWith<$Res>
    implements $ProfileApiResponseCopyWith<$Res> {
  factory _$$ProfileApiResponseImplCopyWith(
    _$ProfileApiResponseImpl value,
    $Res Function(_$ProfileApiResponseImpl) then,
  ) = __$$ProfileApiResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({UserModel data, String message, int statusCode});

  @override
  $UserModelCopyWith<$Res> get data;
}

/// @nodoc
class __$$ProfileApiResponseImplCopyWithImpl<$Res>
    extends _$ProfileApiResponseCopyWithImpl<$Res, _$ProfileApiResponseImpl>
    implements _$$ProfileApiResponseImplCopyWith<$Res> {
  __$$ProfileApiResponseImplCopyWithImpl(
    _$ProfileApiResponseImpl _value,
    $Res Function(_$ProfileApiResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ProfileApiResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
    Object? message = null,
    Object? statusCode = null,
  }) {
    return _then(
      _$ProfileApiResponseImpl(
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
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ProfileApiResponseImpl implements _ProfileApiResponse {
  const _$ProfileApiResponseImpl({
    required this.data,
    required this.message,
    required this.statusCode,
  });

  factory _$ProfileApiResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProfileApiResponseImplFromJson(json);

  @override
  final UserModel data;
  // Direct user data, not wrapped in AuthData
  @override
  final String message;
  @override
  final int statusCode;

  @override
  String toString() {
    return 'ProfileApiResponse(data: $data, message: $message, statusCode: $statusCode)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProfileApiResponseImpl &&
            (identical(other.data, data) || other.data == data) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.statusCode, statusCode) ||
                other.statusCode == statusCode));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, data, message, statusCode);

  /// Create a copy of ProfileApiResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProfileApiResponseImplCopyWith<_$ProfileApiResponseImpl> get copyWith =>
      __$$ProfileApiResponseImplCopyWithImpl<_$ProfileApiResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ProfileApiResponseImplToJson(this);
  }
}

abstract class _ProfileApiResponse implements ProfileApiResponse {
  const factory _ProfileApiResponse({
    required final UserModel data,
    required final String message,
    required final int statusCode,
  }) = _$ProfileApiResponseImpl;

  factory _ProfileApiResponse.fromJson(Map<String, dynamic> json) =
      _$ProfileApiResponseImpl.fromJson;

  @override
  UserModel get data; // Direct user data, not wrapped in AuthData
  @override
  String get message;
  @override
  int get statusCode;

  /// Create a copy of ProfileApiResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProfileApiResponseImplCopyWith<_$ProfileApiResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UpdateProfilePicRequest _$UpdateProfilePicRequestFromJson(
  Map<String, dynamic> json,
) {
  return _UpdateProfilePicRequest.fromJson(json);
}

/// @nodoc
mixin _$UpdateProfilePicRequest {
  int? get avatar => throw _privateConstructorUsedError;

  /// Serializes this UpdateProfilePicRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UpdateProfilePicRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UpdateProfilePicRequestCopyWith<UpdateProfilePicRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UpdateProfilePicRequestCopyWith<$Res> {
  factory $UpdateProfilePicRequestCopyWith(
    UpdateProfilePicRequest value,
    $Res Function(UpdateProfilePicRequest) then,
  ) = _$UpdateProfilePicRequestCopyWithImpl<$Res, UpdateProfilePicRequest>;
  @useResult
  $Res call({int? avatar});
}

/// @nodoc
class _$UpdateProfilePicRequestCopyWithImpl<
  $Res,
  $Val extends UpdateProfilePicRequest
>
    implements $UpdateProfilePicRequestCopyWith<$Res> {
  _$UpdateProfilePicRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UpdateProfilePicRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? avatar = freezed}) {
    return _then(
      _value.copyWith(
            avatar:
                freezed == avatar
                    ? _value.avatar
                    : avatar // ignore: cast_nullable_to_non_nullable
                        as int?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$UpdateProfilePicRequestImplCopyWith<$Res>
    implements $UpdateProfilePicRequestCopyWith<$Res> {
  factory _$$UpdateProfilePicRequestImplCopyWith(
    _$UpdateProfilePicRequestImpl value,
    $Res Function(_$UpdateProfilePicRequestImpl) then,
  ) = __$$UpdateProfilePicRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? avatar});
}

/// @nodoc
class __$$UpdateProfilePicRequestImplCopyWithImpl<$Res>
    extends
        _$UpdateProfilePicRequestCopyWithImpl<
          $Res,
          _$UpdateProfilePicRequestImpl
        >
    implements _$$UpdateProfilePicRequestImplCopyWith<$Res> {
  __$$UpdateProfilePicRequestImplCopyWithImpl(
    _$UpdateProfilePicRequestImpl _value,
    $Res Function(_$UpdateProfilePicRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UpdateProfilePicRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? avatar = freezed}) {
    return _then(
      _$UpdateProfilePicRequestImpl(
        avatar:
            freezed == avatar
                ? _value.avatar
                : avatar // ignore: cast_nullable_to_non_nullable
                    as int?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UpdateProfilePicRequestImpl implements _UpdateProfilePicRequest {
  const _$UpdateProfilePicRequestImpl({this.avatar});

  factory _$UpdateProfilePicRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$UpdateProfilePicRequestImplFromJson(json);

  @override
  final int? avatar;

  @override
  String toString() {
    return 'UpdateProfilePicRequest(avatar: $avatar)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateProfilePicRequestImpl &&
            (identical(other.avatar, avatar) || other.avatar == avatar));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, avatar);

  /// Create a copy of UpdateProfilePicRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateProfilePicRequestImplCopyWith<_$UpdateProfilePicRequestImpl>
  get copyWith => __$$UpdateProfilePicRequestImplCopyWithImpl<
    _$UpdateProfilePicRequestImpl
  >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UpdateProfilePicRequestImplToJson(this);
  }
}

abstract class _UpdateProfilePicRequest implements UpdateProfilePicRequest {
  const factory _UpdateProfilePicRequest({final int? avatar}) =
      _$UpdateProfilePicRequestImpl;

  factory _UpdateProfilePicRequest.fromJson(Map<String, dynamic> json) =
      _$UpdateProfilePicRequestImpl.fromJson;

  @override
  int? get avatar;

  /// Create a copy of UpdateProfilePicRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdateProfilePicRequestImplCopyWith<_$UpdateProfilePicRequestImpl>
  get copyWith => throw _privateConstructorUsedError;
}

ForgotPasswordRequest _$ForgotPasswordRequestFromJson(
  Map<String, dynamic> json,
) {
  return _ForgotPasswordRequest.fromJson(json);
}

/// @nodoc
mixin _$ForgotPasswordRequest {
  String get email => throw _privateConstructorUsedError;

  /// Serializes this ForgotPasswordRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ForgotPasswordRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ForgotPasswordRequestCopyWith<ForgotPasswordRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ForgotPasswordRequestCopyWith<$Res> {
  factory $ForgotPasswordRequestCopyWith(
    ForgotPasswordRequest value,
    $Res Function(ForgotPasswordRequest) then,
  ) = _$ForgotPasswordRequestCopyWithImpl<$Res, ForgotPasswordRequest>;
  @useResult
  $Res call({String email});
}

/// @nodoc
class _$ForgotPasswordRequestCopyWithImpl<
  $Res,
  $Val extends ForgotPasswordRequest
>
    implements $ForgotPasswordRequestCopyWith<$Res> {
  _$ForgotPasswordRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ForgotPasswordRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? email = null}) {
    return _then(
      _value.copyWith(
            email:
                null == email
                    ? _value.email
                    : email // ignore: cast_nullable_to_non_nullable
                        as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ForgotPasswordRequestImplCopyWith<$Res>
    implements $ForgotPasswordRequestCopyWith<$Res> {
  factory _$$ForgotPasswordRequestImplCopyWith(
    _$ForgotPasswordRequestImpl value,
    $Res Function(_$ForgotPasswordRequestImpl) then,
  ) = __$$ForgotPasswordRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String email});
}

/// @nodoc
class __$$ForgotPasswordRequestImplCopyWithImpl<$Res>
    extends
        _$ForgotPasswordRequestCopyWithImpl<$Res, _$ForgotPasswordRequestImpl>
    implements _$$ForgotPasswordRequestImplCopyWith<$Res> {
  __$$ForgotPasswordRequestImplCopyWithImpl(
    _$ForgotPasswordRequestImpl _value,
    $Res Function(_$ForgotPasswordRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ForgotPasswordRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? email = null}) {
    return _then(
      _$ForgotPasswordRequestImpl(
        email:
            null == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ForgotPasswordRequestImpl implements _ForgotPasswordRequest {
  const _$ForgotPasswordRequestImpl({required this.email});

  factory _$ForgotPasswordRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$ForgotPasswordRequestImplFromJson(json);

  @override
  final String email;

  @override
  String toString() {
    return 'ForgotPasswordRequest(email: $email)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ForgotPasswordRequestImpl &&
            (identical(other.email, email) || other.email == email));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, email);

  /// Create a copy of ForgotPasswordRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ForgotPasswordRequestImplCopyWith<_$ForgotPasswordRequestImpl>
  get copyWith =>
      __$$ForgotPasswordRequestImplCopyWithImpl<_$ForgotPasswordRequestImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ForgotPasswordRequestImplToJson(this);
  }
}

abstract class _ForgotPasswordRequest implements ForgotPasswordRequest {
  const factory _ForgotPasswordRequest({required final String email}) =
      _$ForgotPasswordRequestImpl;

  factory _ForgotPasswordRequest.fromJson(Map<String, dynamic> json) =
      _$ForgotPasswordRequestImpl.fromJson;

  @override
  String get email;

  /// Create a copy of ForgotPasswordRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ForgotPasswordRequestImplCopyWith<_$ForgotPasswordRequestImpl>
  get copyWith => throw _privateConstructorUsedError;
}

ResetPasswordRequest _$ResetPasswordRequestFromJson(Map<String, dynamic> json) {
  return _ResetPasswordRequest.fromJson(json);
}

/// @nodoc
mixin _$ResetPasswordRequest {
  String get email => throw _privateConstructorUsedError;
  String get password => throw _privateConstructorUsedError;
  String get passwordConfirm => throw _privateConstructorUsedError;
  String get otp => throw _privateConstructorUsedError;

  /// Serializes this ResetPasswordRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ResetPasswordRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ResetPasswordRequestCopyWith<ResetPasswordRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ResetPasswordRequestCopyWith<$Res> {
  factory $ResetPasswordRequestCopyWith(
    ResetPasswordRequest value,
    $Res Function(ResetPasswordRequest) then,
  ) = _$ResetPasswordRequestCopyWithImpl<$Res, ResetPasswordRequest>;
  @useResult
  $Res call({
    String email,
    String password,
    String passwordConfirm,
    String otp,
  });
}

/// @nodoc
class _$ResetPasswordRequestCopyWithImpl<
  $Res,
  $Val extends ResetPasswordRequest
>
    implements $ResetPasswordRequestCopyWith<$Res> {
  _$ResetPasswordRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ResetPasswordRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? password = null,
    Object? passwordConfirm = null,
    Object? otp = null,
  }) {
    return _then(
      _value.copyWith(
            email:
                null == email
                    ? _value.email
                    : email // ignore: cast_nullable_to_non_nullable
                        as String,
            password:
                null == password
                    ? _value.password
                    : password // ignore: cast_nullable_to_non_nullable
                        as String,
            passwordConfirm:
                null == passwordConfirm
                    ? _value.passwordConfirm
                    : passwordConfirm // ignore: cast_nullable_to_non_nullable
                        as String,
            otp:
                null == otp
                    ? _value.otp
                    : otp // ignore: cast_nullable_to_non_nullable
                        as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ResetPasswordRequestImplCopyWith<$Res>
    implements $ResetPasswordRequestCopyWith<$Res> {
  factory _$$ResetPasswordRequestImplCopyWith(
    _$ResetPasswordRequestImpl value,
    $Res Function(_$ResetPasswordRequestImpl) then,
  ) = __$$ResetPasswordRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String email,
    String password,
    String passwordConfirm,
    String otp,
  });
}

/// @nodoc
class __$$ResetPasswordRequestImplCopyWithImpl<$Res>
    extends _$ResetPasswordRequestCopyWithImpl<$Res, _$ResetPasswordRequestImpl>
    implements _$$ResetPasswordRequestImplCopyWith<$Res> {
  __$$ResetPasswordRequestImplCopyWithImpl(
    _$ResetPasswordRequestImpl _value,
    $Res Function(_$ResetPasswordRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ResetPasswordRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? password = null,
    Object? passwordConfirm = null,
    Object? otp = null,
  }) {
    return _then(
      _$ResetPasswordRequestImpl(
        email:
            null == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                    as String,
        password:
            null == password
                ? _value.password
                : password // ignore: cast_nullable_to_non_nullable
                    as String,
        passwordConfirm:
            null == passwordConfirm
                ? _value.passwordConfirm
                : passwordConfirm // ignore: cast_nullable_to_non_nullable
                    as String,
        otp:
            null == otp
                ? _value.otp
                : otp // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ResetPasswordRequestImpl implements _ResetPasswordRequest {
  const _$ResetPasswordRequestImpl({
    required this.email,
    required this.password,
    required this.passwordConfirm,
    required this.otp,
  });

  factory _$ResetPasswordRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$ResetPasswordRequestImplFromJson(json);

  @override
  final String email;
  @override
  final String password;
  @override
  final String passwordConfirm;
  @override
  final String otp;

  @override
  String toString() {
    return 'ResetPasswordRequest(email: $email, password: $password, passwordConfirm: $passwordConfirm, otp: $otp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ResetPasswordRequestImpl &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.passwordConfirm, passwordConfirm) ||
                other.passwordConfirm == passwordConfirm) &&
            (identical(other.otp, otp) || other.otp == otp));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, email, password, passwordConfirm, otp);

  /// Create a copy of ResetPasswordRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ResetPasswordRequestImplCopyWith<_$ResetPasswordRequestImpl>
  get copyWith =>
      __$$ResetPasswordRequestImplCopyWithImpl<_$ResetPasswordRequestImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ResetPasswordRequestImplToJson(this);
  }
}

abstract class _ResetPasswordRequest implements ResetPasswordRequest {
  const factory _ResetPasswordRequest({
    required final String email,
    required final String password,
    required final String passwordConfirm,
    required final String otp,
  }) = _$ResetPasswordRequestImpl;

  factory _ResetPasswordRequest.fromJson(Map<String, dynamic> json) =
      _$ResetPasswordRequestImpl.fromJson;

  @override
  String get email;
  @override
  String get password;
  @override
  String get passwordConfirm;
  @override
  String get otp;

  /// Create a copy of ResetPasswordRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ResetPasswordRequestImplCopyWith<_$ResetPasswordRequestImpl>
  get copyWith => throw _privateConstructorUsedError;
}

ForgotPasswordResponse _$ForgotPasswordResponseFromJson(
  Map<String, dynamic> json,
) {
  return _ForgotPasswordResponse.fromJson(json);
}

/// @nodoc
mixin _$ForgotPasswordResponse {
  String get data => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  int get statusCode => throw _privateConstructorUsedError;

  /// Serializes this ForgotPasswordResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ForgotPasswordResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ForgotPasswordResponseCopyWith<ForgotPasswordResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ForgotPasswordResponseCopyWith<$Res> {
  factory $ForgotPasswordResponseCopyWith(
    ForgotPasswordResponse value,
    $Res Function(ForgotPasswordResponse) then,
  ) = _$ForgotPasswordResponseCopyWithImpl<$Res, ForgotPasswordResponse>;
  @useResult
  $Res call({String data, String message, int statusCode});
}

/// @nodoc
class _$ForgotPasswordResponseCopyWithImpl<
  $Res,
  $Val extends ForgotPasswordResponse
>
    implements $ForgotPasswordResponseCopyWith<$Res> {
  _$ForgotPasswordResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ForgotPasswordResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
    Object? message = null,
    Object? statusCode = null,
  }) {
    return _then(
      _value.copyWith(
            data:
                null == data
                    ? _value.data
                    : data // ignore: cast_nullable_to_non_nullable
                        as String,
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
}

/// @nodoc
abstract class _$$ForgotPasswordResponseImplCopyWith<$Res>
    implements $ForgotPasswordResponseCopyWith<$Res> {
  factory _$$ForgotPasswordResponseImplCopyWith(
    _$ForgotPasswordResponseImpl value,
    $Res Function(_$ForgotPasswordResponseImpl) then,
  ) = __$$ForgotPasswordResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String data, String message, int statusCode});
}

/// @nodoc
class __$$ForgotPasswordResponseImplCopyWithImpl<$Res>
    extends
        _$ForgotPasswordResponseCopyWithImpl<$Res, _$ForgotPasswordResponseImpl>
    implements _$$ForgotPasswordResponseImplCopyWith<$Res> {
  __$$ForgotPasswordResponseImplCopyWithImpl(
    _$ForgotPasswordResponseImpl _value,
    $Res Function(_$ForgotPasswordResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ForgotPasswordResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
    Object? message = null,
    Object? statusCode = null,
  }) {
    return _then(
      _$ForgotPasswordResponseImpl(
        data:
            null == data
                ? _value.data
                : data // ignore: cast_nullable_to_non_nullable
                    as String,
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
class _$ForgotPasswordResponseImpl implements _ForgotPasswordResponse {
  const _$ForgotPasswordResponseImpl({
    required this.data,
    required this.message,
    required this.statusCode,
  });

  factory _$ForgotPasswordResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$ForgotPasswordResponseImplFromJson(json);

  @override
  final String data;
  @override
  final String message;
  @override
  final int statusCode;

  @override
  String toString() {
    return 'ForgotPasswordResponse(data: $data, message: $message, statusCode: $statusCode)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ForgotPasswordResponseImpl &&
            (identical(other.data, data) || other.data == data) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.statusCode, statusCode) ||
                other.statusCode == statusCode));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, data, message, statusCode);

  /// Create a copy of ForgotPasswordResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ForgotPasswordResponseImplCopyWith<_$ForgotPasswordResponseImpl>
  get copyWith =>
      __$$ForgotPasswordResponseImplCopyWithImpl<_$ForgotPasswordResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ForgotPasswordResponseImplToJson(this);
  }
}

abstract class _ForgotPasswordResponse implements ForgotPasswordResponse {
  const factory _ForgotPasswordResponse({
    required final String data,
    required final String message,
    required final int statusCode,
  }) = _$ForgotPasswordResponseImpl;

  factory _ForgotPasswordResponse.fromJson(Map<String, dynamic> json) =
      _$ForgotPasswordResponseImpl.fromJson;

  @override
  String get data;
  @override
  String get message;
  @override
  int get statusCode;

  /// Create a copy of ForgotPasswordResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ForgotPasswordResponseImplCopyWith<_$ForgotPasswordResponseImpl>
  get copyWith => throw _privateConstructorUsedError;
}

ResetPasswordResponse _$ResetPasswordResponseFromJson(
  Map<String, dynamic> json,
) {
  return _ResetPasswordResponse.fromJson(json);
}

/// @nodoc
mixin _$ResetPasswordResponse {
  ResetPasswordData get data => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  int get statusCode => throw _privateConstructorUsedError;

  /// Serializes this ResetPasswordResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ResetPasswordResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ResetPasswordResponseCopyWith<ResetPasswordResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ResetPasswordResponseCopyWith<$Res> {
  factory $ResetPasswordResponseCopyWith(
    ResetPasswordResponse value,
    $Res Function(ResetPasswordResponse) then,
  ) = _$ResetPasswordResponseCopyWithImpl<$Res, ResetPasswordResponse>;
  @useResult
  $Res call({ResetPasswordData data, String message, int statusCode});

  $ResetPasswordDataCopyWith<$Res> get data;
}

/// @nodoc
class _$ResetPasswordResponseCopyWithImpl<
  $Res,
  $Val extends ResetPasswordResponse
>
    implements $ResetPasswordResponseCopyWith<$Res> {
  _$ResetPasswordResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ResetPasswordResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
    Object? message = null,
    Object? statusCode = null,
  }) {
    return _then(
      _value.copyWith(
            data:
                null == data
                    ? _value.data
                    : data // ignore: cast_nullable_to_non_nullable
                        as ResetPasswordData,
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

  /// Create a copy of ResetPasswordResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ResetPasswordDataCopyWith<$Res> get data {
    return $ResetPasswordDataCopyWith<$Res>(_value.data, (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ResetPasswordResponseImplCopyWith<$Res>
    implements $ResetPasswordResponseCopyWith<$Res> {
  factory _$$ResetPasswordResponseImplCopyWith(
    _$ResetPasswordResponseImpl value,
    $Res Function(_$ResetPasswordResponseImpl) then,
  ) = __$$ResetPasswordResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({ResetPasswordData data, String message, int statusCode});

  @override
  $ResetPasswordDataCopyWith<$Res> get data;
}

/// @nodoc
class __$$ResetPasswordResponseImplCopyWithImpl<$Res>
    extends
        _$ResetPasswordResponseCopyWithImpl<$Res, _$ResetPasswordResponseImpl>
    implements _$$ResetPasswordResponseImplCopyWith<$Res> {
  __$$ResetPasswordResponseImplCopyWithImpl(
    _$ResetPasswordResponseImpl _value,
    $Res Function(_$ResetPasswordResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ResetPasswordResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
    Object? message = null,
    Object? statusCode = null,
  }) {
    return _then(
      _$ResetPasswordResponseImpl(
        data:
            null == data
                ? _value.data
                : data // ignore: cast_nullable_to_non_nullable
                    as ResetPasswordData,
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
class _$ResetPasswordResponseImpl implements _ResetPasswordResponse {
  const _$ResetPasswordResponseImpl({
    required this.data,
    required this.message,
    required this.statusCode,
  });

  factory _$ResetPasswordResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$ResetPasswordResponseImplFromJson(json);

  @override
  final ResetPasswordData data;
  @override
  final String message;
  @override
  final int statusCode;

  @override
  String toString() {
    return 'ResetPasswordResponse(data: $data, message: $message, statusCode: $statusCode)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ResetPasswordResponseImpl &&
            (identical(other.data, data) || other.data == data) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.statusCode, statusCode) ||
                other.statusCode == statusCode));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, data, message, statusCode);

  /// Create a copy of ResetPasswordResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ResetPasswordResponseImplCopyWith<_$ResetPasswordResponseImpl>
  get copyWith =>
      __$$ResetPasswordResponseImplCopyWithImpl<_$ResetPasswordResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ResetPasswordResponseImplToJson(this);
  }
}

abstract class _ResetPasswordResponse implements ResetPasswordResponse {
  const factory _ResetPasswordResponse({
    required final ResetPasswordData data,
    required final String message,
    required final int statusCode,
  }) = _$ResetPasswordResponseImpl;

  factory _ResetPasswordResponse.fromJson(Map<String, dynamic> json) =
      _$ResetPasswordResponseImpl.fromJson;

  @override
  ResetPasswordData get data;
  @override
  String get message;
  @override
  int get statusCode;

  /// Create a copy of ResetPasswordResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ResetPasswordResponseImplCopyWith<_$ResetPasswordResponseImpl>
  get copyWith => throw _privateConstructorUsedError;
}

ResetPasswordData _$ResetPasswordDataFromJson(Map<String, dynamic> json) {
  return _ResetPasswordData.fromJson(json);
}

/// @nodoc
mixin _$ResetPasswordData {
  String get message => throw _privateConstructorUsedError;

  /// Serializes this ResetPasswordData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ResetPasswordData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ResetPasswordDataCopyWith<ResetPasswordData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ResetPasswordDataCopyWith<$Res> {
  factory $ResetPasswordDataCopyWith(
    ResetPasswordData value,
    $Res Function(ResetPasswordData) then,
  ) = _$ResetPasswordDataCopyWithImpl<$Res, ResetPasswordData>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class _$ResetPasswordDataCopyWithImpl<$Res, $Val extends ResetPasswordData>
    implements $ResetPasswordDataCopyWith<$Res> {
  _$ResetPasswordDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ResetPasswordData
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
abstract class _$$ResetPasswordDataImplCopyWith<$Res>
    implements $ResetPasswordDataCopyWith<$Res> {
  factory _$$ResetPasswordDataImplCopyWith(
    _$ResetPasswordDataImpl value,
    $Res Function(_$ResetPasswordDataImpl) then,
  ) = __$$ResetPasswordDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$ResetPasswordDataImplCopyWithImpl<$Res>
    extends _$ResetPasswordDataCopyWithImpl<$Res, _$ResetPasswordDataImpl>
    implements _$$ResetPasswordDataImplCopyWith<$Res> {
  __$$ResetPasswordDataImplCopyWithImpl(
    _$ResetPasswordDataImpl _value,
    $Res Function(_$ResetPasswordDataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ResetPasswordData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null}) {
    return _then(
      _$ResetPasswordDataImpl(
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
class _$ResetPasswordDataImpl implements _ResetPasswordData {
  const _$ResetPasswordDataImpl({required this.message});

  factory _$ResetPasswordDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$ResetPasswordDataImplFromJson(json);

  @override
  final String message;

  @override
  String toString() {
    return 'ResetPasswordData(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ResetPasswordDataImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of ResetPasswordData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ResetPasswordDataImplCopyWith<_$ResetPasswordDataImpl> get copyWith =>
      __$$ResetPasswordDataImplCopyWithImpl<_$ResetPasswordDataImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ResetPasswordDataImplToJson(this);
  }
}

abstract class _ResetPasswordData implements ResetPasswordData {
  const factory _ResetPasswordData({required final String message}) =
      _$ResetPasswordDataImpl;

  factory _ResetPasswordData.fromJson(Map<String, dynamic> json) =
      _$ResetPasswordDataImpl.fromJson;

  @override
  String get message;

  /// Create a copy of ResetPasswordData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ResetPasswordDataImplCopyWith<_$ResetPasswordDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
