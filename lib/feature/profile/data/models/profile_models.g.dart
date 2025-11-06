// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UpdatePersonalDetailsRequestImpl _$$UpdatePersonalDetailsRequestImplFromJson(
  Map<String, dynamic> json,
) => _$UpdatePersonalDetailsRequestImpl(
  firstName: json['firstName'] as String,
  lastName: json['lastName'] as String,
  username: json['username'] as String?,
  emergencyContact: json['emergencyContact'] as String?,
  gender: json['gender'] as String?,
);

Map<String, dynamic> _$$UpdatePersonalDetailsRequestImplToJson(
  _$UpdatePersonalDetailsRequestImpl instance,
) => <String, dynamic>{
  'firstName': instance.firstName,
  'lastName': instance.lastName,
  'username': instance.username,
  'emergencyContact': instance.emergencyContact,
  'gender': instance.gender,
};

_$UpdatePersonalDetailsResponseImpl
_$$UpdatePersonalDetailsResponseImplFromJson(Map<String, dynamic> json) =>
    _$UpdatePersonalDetailsResponseImpl(
      id: json['id'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      email: json['email'] as String,
      phoneNumber: json['phoneNumber'] as String?,
      gender: json['gender'] as String?,
      dateOfBirth: json['dateOfBirth'] as String?,
      username: json['username'] as String?,
      avatar: (json['avatar'] as num?)?.toInt(),
      createdAt:
          json['createdAt'] == null
              ? null
              : DateTime.parse(json['createdAt'] as String),
      updatedAt:
          json['updatedAt'] == null
              ? null
              : DateTime.parse(json['updatedAt'] as String),
      message: json['message'] as String?,
      statusCode: (json['statusCode'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$UpdatePersonalDetailsResponseImplToJson(
  _$UpdatePersonalDetailsResponseImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'firstName': instance.firstName,
  'lastName': instance.lastName,
  'email': instance.email,
  'phoneNumber': instance.phoneNumber,
  'gender': instance.gender,
  'dateOfBirth': instance.dateOfBirth,
  'username': instance.username,
  'avatar': instance.avatar,
  'createdAt': instance.createdAt?.toIso8601String(),
  'updatedAt': instance.updatedAt?.toIso8601String(),
  'message': instance.message,
  'statusCode': instance.statusCode,
};

_$ProfileModelImpl _$$ProfileModelImplFromJson(Map<String, dynamic> json) =>
    _$ProfileModelImpl(
      id: json['id'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      email: json['email'] as String,
      phoneNumber: json['phoneNumber'] as String?,
      gender: json['gender'] as String?,
      dateOfBirth: json['dateOfBirth'] as String?,
      username: json['username'] as String?,
      avatar: (json['avatar'] as num?)?.toInt(),
      createdAt:
          json['createdAt'] == null
              ? null
              : DateTime.parse(json['createdAt'] as String),
      updatedAt:
          json['updatedAt'] == null
              ? null
              : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$ProfileModelImplToJson(_$ProfileModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'gender': instance.gender,
      'dateOfBirth': instance.dateOfBirth,
      'username': instance.username,
      'avatar': instance.avatar,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
