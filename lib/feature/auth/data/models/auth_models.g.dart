// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ApiResponseImpl _$$ApiResponseImplFromJson(Map<String, dynamic> json) =>
    _$ApiResponseImpl(
      data: AuthData.fromJson(json['data'] as Map<String, dynamic>),
      message: json['message'] as String,
      statusCode: (json['statusCode'] as num).toInt(),
    );

Map<String, dynamic> _$$ApiResponseImplToJson(_$ApiResponseImpl instance) =>
    <String, dynamic>{
      'data': instance.data,
      'message': instance.message,
      'statusCode': instance.statusCode,
    };

_$AuthDataImpl _$$AuthDataImplFromJson(Map<String, dynamic> json) =>
    _$AuthDataImpl(
      user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
      accessToken: json['accessToken'] as String,
      refreshToken: json['refreshToken'] as String,
    );

Map<String, dynamic> _$$AuthDataImplToJson(_$AuthDataImpl instance) =>
    <String, dynamic>{
      'user': instance.user,
      'accessToken': instance.accessToken,
      'refreshToken': instance.refreshToken,
    };

_$LoginRequestImpl _$$LoginRequestImplFromJson(Map<String, dynamic> json) =>
    _$LoginRequestImpl(
      phoneNumber: json['phoneNumber'] as String,
      password: json['password'] as String,
      firebaseToken: json['firebaseToken'] as String,
    );

Map<String, dynamic> _$$LoginRequestImplToJson(_$LoginRequestImpl instance) =>
    <String, dynamic>{
      'phoneNumber': instance.phoneNumber,
      'password': instance.password,
      'firebaseToken': instance.firebaseToken,
    };

_$LoginResponseImpl _$$LoginResponseImplFromJson(Map<String, dynamic> json) =>
    _$LoginResponseImpl(
      user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
      accessToken: json['accessToken'] as String,
      refreshToken: json['refreshToken'] as String,
    );

Map<String, dynamic> _$$LoginResponseImplToJson(_$LoginResponseImpl instance) =>
    <String, dynamic>{
      'user': instance.user,
      'accessToken': instance.accessToken,
      'refreshToken': instance.refreshToken,
    };

_$SignupRequestImpl _$$SignupRequestImplFromJson(Map<String, dynamic> json) =>
    _$SignupRequestImpl(
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      firebaseToken: json['firebaseToken'] as String,
      gender: json['gender'] as String,
      dob: json['dob'] as String,
      phoneNumber: json['phoneNumber'] as String,
    );

Map<String, dynamic> _$$SignupRequestImplToJson(_$SignupRequestImpl instance) =>
    <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
      'password': instance.password,
      'firebaseToken': instance.firebaseToken,
      'gender': instance.gender,
      'dob': instance.dob,
      'phoneNumber': instance.phoneNumber,
    };

_$SignupResponseImpl _$$SignupResponseImplFromJson(Map<String, dynamic> json) =>
    _$SignupResponseImpl(
      id: json['id'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      email: json['email'] as String,
      phoneNumber: json['phoneNumber'] as String,
      gender: json['gender'] as String,
      dob: json['dob'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      isEmailAuthenticated: json['isEmailAuthenticated'] as bool?,
      status: json['status'] as String?,
      isVisible: json['isVisible'] as bool?,
      updatedAt:
          json['updatedAt'] == null
              ? null
              : DateTime.parse(json['updatedAt'] as String),
      emergencyContact: json['emergencyContact'],
      deletedAt:
          json['deletedAt'] == null
              ? null
              : DateTime.parse(json['deletedAt'] as String),
      isLinked: json['isLinked'] as bool?,
      isPhoneNumberAuthenticated: json['isPhoneNumberAuthenticated'] as bool?,
      accessToken: json['accessToken'] as String?,
      refreshToken: json['refreshToken'] as String?,
      message: json['message'] as String?,
      statusCode: (json['statusCode'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$SignupResponseImplToJson(
  _$SignupResponseImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'firstName': instance.firstName,
  'lastName': instance.lastName,
  'email': instance.email,
  'phoneNumber': instance.phoneNumber,
  'gender': instance.gender,
  'dob': instance.dob,
  'createdAt': instance.createdAt.toIso8601String(),
  'isEmailAuthenticated': instance.isEmailAuthenticated,
  'status': instance.status,
  'isVisible': instance.isVisible,
  'updatedAt': instance.updatedAt?.toIso8601String(),
  'emergencyContact': instance.emergencyContact,
  'deletedAt': instance.deletedAt?.toIso8601String(),
  'isLinked': instance.isLinked,
  'isPhoneNumberAuthenticated': instance.isPhoneNumberAuthenticated,
  'accessToken': instance.accessToken,
  'refreshToken': instance.refreshToken,
  'message': instance.message,
  'statusCode': instance.statusCode,
};

_$UserModelImpl _$$UserModelImplFromJson(Map<String, dynamic> json) =>
    _$UserModelImpl(
      id: json['id'] as String,
      email: json['email'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      isEmailAuthenticated: json['isEmailAuthenticated'] as bool?,
      status: json['status'] as String?,
      gender: json['gender'] as String?,
      dob: json['dob'] == null ? null : DateTime.parse(json['dob'] as String),
      username: json['username'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      isVisible: json['isVisible'] as bool?,
      updatedAt:
          json['updatedAt'] == null
              ? null
              : DateTime.parse(json['updatedAt'] as String),
      emergencyContact: json['emergencyContact'],
      deletedAt:
          json['deletedAt'] == null
              ? null
              : DateTime.parse(json['deletedAt'] as String),
      isLinked: json['isLinked'] as bool?,
      isPhoneNumberAuthenticated: json['isPhoneNumberAuthenticated'] as bool?,
      avatar: (json['avatar'] as num?)?.toInt(),
      profile: json['profile'] as String?,
      isOnline: json['isOnline'] as bool?,
      hoursDedicatedPerWeek: (json['hoursDedicatedPerWeek'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$UserModelImplToJson(_$UserModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'createdAt': instance.createdAt.toIso8601String(),
      'isEmailAuthenticated': instance.isEmailAuthenticated,
      'status': instance.status,
      'gender': instance.gender,
      'dob': instance.dob?.toIso8601String(),
      'username': instance.username,
      'phoneNumber': instance.phoneNumber,
      'isVisible': instance.isVisible,
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'emergencyContact': instance.emergencyContact,
      'deletedAt': instance.deletedAt?.toIso8601String(),
      'isLinked': instance.isLinked,
      'isPhoneNumberAuthenticated': instance.isPhoneNumberAuthenticated,
      'avatar': instance.avatar,
      'profile': instance.profile,
      'isOnline': instance.isOnline,
      'hoursDedicatedPerWeek': instance.hoursDedicatedPerWeek,
    };

_$UpdateProfileRequestImpl _$$UpdateProfileRequestImplFromJson(
  Map<String, dynamic> json,
) => _$UpdateProfileRequestImpl(
  firstName: json['firstName'] as String?,
  lastName: json['lastName'] as String?,
  email: json['email'] as String?,
  gender: json['gender'] as String?,
  username: json['username'] as String?,
  phoneNumber: json['phoneNumber'] as String?,
);

Map<String, dynamic> _$$UpdateProfileRequestImplToJson(
  _$UpdateProfileRequestImpl instance,
) => <String, dynamic>{
  'firstName': instance.firstName,
  'lastName': instance.lastName,
  'email': instance.email,
  'gender': instance.gender,
  'username': instance.username,
  'phoneNumber': instance.phoneNumber,
};

_$ProfileApiResponseImpl _$$ProfileApiResponseImplFromJson(
  Map<String, dynamic> json,
) => _$ProfileApiResponseImpl(
  data: UserModel.fromJson(json['data'] as Map<String, dynamic>),
  message: json['message'] as String,
  statusCode: (json['statusCode'] as num).toInt(),
);

Map<String, dynamic> _$$ProfileApiResponseImplToJson(
  _$ProfileApiResponseImpl instance,
) => <String, dynamic>{
  'data': instance.data,
  'message': instance.message,
  'statusCode': instance.statusCode,
};

_$UpdateProfilePicRequestImpl _$$UpdateProfilePicRequestImplFromJson(
  Map<String, dynamic> json,
) => _$UpdateProfilePicRequestImpl(avatar: (json['avatar'] as num?)?.toInt());

Map<String, dynamic> _$$UpdateProfilePicRequestImplToJson(
  _$UpdateProfilePicRequestImpl instance,
) => <String, dynamic>{'avatar': instance.avatar};

_$ForgotPasswordRequestImpl _$$ForgotPasswordRequestImplFromJson(
  Map<String, dynamic> json,
) => _$ForgotPasswordRequestImpl(email: json['email'] as String);

Map<String, dynamic> _$$ForgotPasswordRequestImplToJson(
  _$ForgotPasswordRequestImpl instance,
) => <String, dynamic>{'email': instance.email};

_$ResetPasswordRequestImpl _$$ResetPasswordRequestImplFromJson(
  Map<String, dynamic> json,
) => _$ResetPasswordRequestImpl(
  email: json['email'] as String,
  password: json['password'] as String,
  passwordConfirm: json['passwordConfirm'] as String,
  otp: json['otp'] as String,
);

Map<String, dynamic> _$$ResetPasswordRequestImplToJson(
  _$ResetPasswordRequestImpl instance,
) => <String, dynamic>{
  'email': instance.email,
  'password': instance.password,
  'passwordConfirm': instance.passwordConfirm,
  'otp': instance.otp,
};

_$ForgotPasswordResponseImpl _$$ForgotPasswordResponseImplFromJson(
  Map<String, dynamic> json,
) => _$ForgotPasswordResponseImpl(
  data: json['data'] as String,
  message: json['message'] as String,
  statusCode: (json['statusCode'] as num).toInt(),
);

Map<String, dynamic> _$$ForgotPasswordResponseImplToJson(
  _$ForgotPasswordResponseImpl instance,
) => <String, dynamic>{
  'data': instance.data,
  'message': instance.message,
  'statusCode': instance.statusCode,
};

_$ResetPasswordResponseImpl _$$ResetPasswordResponseImplFromJson(
  Map<String, dynamic> json,
) => _$ResetPasswordResponseImpl(
  data: ResetPasswordData.fromJson(json['data'] as Map<String, dynamic>),
  message: json['message'] as String,
  statusCode: (json['statusCode'] as num).toInt(),
);

Map<String, dynamic> _$$ResetPasswordResponseImplToJson(
  _$ResetPasswordResponseImpl instance,
) => <String, dynamic>{
  'data': instance.data,
  'message': instance.message,
  'statusCode': instance.statusCode,
};

_$ResetPasswordDataImpl _$$ResetPasswordDataImplFromJson(
  Map<String, dynamic> json,
) => _$ResetPasswordDataImpl(message: json['message'] as String);

Map<String, dynamic> _$$ResetPasswordDataImplToJson(
  _$ResetPasswordDataImpl instance,
) => <String, dynamic>{'message': instance.message};
