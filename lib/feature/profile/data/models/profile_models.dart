import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_models.freezed.dart';
part 'profile_models.g.dart';

@freezed
class UpdatePersonalDetailsRequest with _$UpdatePersonalDetailsRequest {
  const factory UpdatePersonalDetailsRequest({
    required String firstName,
    required String lastName,
    String? username,
    String? emergencyContact,
    String? gender,
  }) = _UpdatePersonalDetailsRequest;

  factory UpdatePersonalDetailsRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdatePersonalDetailsRequestFromJson(json);
}

@freezed
class UpdatePersonalDetailsResponse with _$UpdatePersonalDetailsResponse {
  const factory UpdatePersonalDetailsResponse({
    required String id,
    required String firstName,
    required String lastName,
    required String email,
    String? phoneNumber,
    String? gender,
    String? dateOfBirth,
    String? username,
    int? avatar,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? message,
    int? statusCode,
  }) = _UpdatePersonalDetailsResponse;

  factory UpdatePersonalDetailsResponse.fromJson(Map<String, dynamic> json) =>
      _$UpdatePersonalDetailsResponseFromJson(json);
}

@freezed
class ProfileModel with _$ProfileModel {
  const factory ProfileModel({
    required String id,
    required String firstName,
    required String lastName,
    required String email,
    String? phoneNumber,
    String? gender,
    String? dateOfBirth,
    String? username,
    int? avatar,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _ProfileModel;

  factory ProfileModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileModelFromJson(json);
}
