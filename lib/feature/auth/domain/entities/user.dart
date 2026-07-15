import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:navicare/feature/auth/data/models/auth_models.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  const factory User({
    required String id,
    required String email,
    required String firstName,
    required String lastName,
    String? status,
    String? username,
    String? phoneNumber,
    int? avatar,
    String? gender,
    String? profile,
    int? hoursDedicatedPerWeek,
    List<TherapistBank>? therapistBank, 
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
