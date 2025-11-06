// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserImpl _$$UserImplFromJson(Map<String, dynamic> json) => _$UserImpl(
  id: json['id'] as String,
  email: json['email'] as String,
  firstName: json['firstName'] as String,
  lastName: json['lastName'] as String,
  status: json['status'] as String?,
  username: json['username'] as String?,
  phoneNumber: json['phoneNumber'] as String?,
  avatar: (json['avatar'] as num?)?.toInt(),
  gender: json['gender'] as String?,
  profile: json['profile'] as String?,
  hoursDedicatedPerWeek: (json['hoursDedicatedPerWeek'] as num?)?.toInt(),
);

Map<String, dynamic> _$$UserImplToJson(_$UserImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'status': instance.status,
      'username': instance.username,
      'phoneNumber': instance.phoneNumber,
      'avatar': instance.avatar,
      'gender': instance.gender,
      'profile': instance.profile,
      'hoursDedicatedPerWeek': instance.hoursDedicatedPerWeek,
    };
