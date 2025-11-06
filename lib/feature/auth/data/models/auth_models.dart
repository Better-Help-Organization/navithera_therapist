import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_models.freezed.dart';
part 'auth_models.g.dart';

@freezed
class ApiResponse with _$ApiResponse {
  const factory ApiResponse({
    required AuthData data,
    required String message,
    required int statusCode,
  }) = _ApiResponse;

  factory ApiResponse.fromJson(Map<String, dynamic> json) =>
      _$ApiResponseFromJson(json);
}

@freezed
class AuthData with _$AuthData {
  const factory AuthData({
    required UserModel user,
    required String accessToken,
    required String refreshToken,
  }) = _AuthData;

  factory AuthData.fromJson(Map<String, dynamic> json) =>
      _$AuthDataFromJson(json);
}

@freezed
class LoginRequest with _$LoginRequest {
  const factory LoginRequest({
    required String phoneNumber,
    required String password,
    required String firebaseToken,
  }) = _LoginRequest;

  factory LoginRequest.fromJson(Map<String, dynamic> json) =>
      _$LoginRequestFromJson(json);
}

@freezed
class LoginResponse with _$LoginResponse {
  const factory LoginResponse({
    required UserModel user,
    required String accessToken,
    required String refreshToken,
  }) = _LoginResponse;

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);
}

@freezed
class SignupRequest with _$SignupRequest {
  const factory SignupRequest({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String firebaseToken,
    required String gender,
    required String dob,
    // required String username,
    required String phoneNumber,
  }) = _SignupRequest;

  factory SignupRequest.fromJson(Map<String, dynamic> json) =>
      _$SignupRequestFromJson(json);
}

@freezed
class SignupResponse with _$SignupResponse {
  const factory SignupResponse({
    required String id,
    required String firstName,
    required String lastName,
    required String email,
    required String phoneNumber,
    required String gender,
    required String dob,
    // required String username,
    required DateTime createdAt,
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
  }) = _SignupResponse;

  factory SignupResponse.fromJson(Map<String, dynamic> json) =>
      _$SignupResponseFromJson(json);
}

@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    required String id,
    required String email,
    required String firstName,
    required String lastName,
    required DateTime createdAt,
    bool? isEmailAuthenticated,
    String? status,
    String? gender,
    DateTime? dob,
    String? username,
    String? phoneNumber,
    bool? isVisible,
    DateTime? updatedAt,
    dynamic emergencyContact, // or create specific model if needed
    DateTime? deletedAt,
    bool? isLinked,
    bool? isPhoneNumberAuthenticated,
    int? avatar,
    String? profile,
    bool? isOnline,
    int? hoursDedicatedPerWeek,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}

@freezed
class UpdateProfileRequest with _$UpdateProfileRequest {
  const factory UpdateProfileRequest({
    String? firstName,
    String? lastName,
    String? email,
    String? gender,
    // String? dob,
    String? username,
    String? phoneNumber,
    // String? avatar,
  }) = _UpdateProfileRequest;

  factory UpdateProfileRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateProfileRequestFromJson(json);
}

@freezed
class ProfileApiResponse with _$ProfileApiResponse {
  const factory ProfileApiResponse({
    required UserModel data, // Direct user data, not wrapped in AuthData
    required String message,
    required int statusCode,
  }) = _ProfileApiResponse;

  factory ProfileApiResponse.fromJson(Map<String, dynamic> json) =>
      _$ProfileApiResponseFromJson(json);
}

@freezed
class UpdateProfilePicRequest with _$UpdateProfilePicRequest {
  const factory UpdateProfilePicRequest({int? avatar}) =
      _UpdateProfilePicRequest;

  factory UpdateProfilePicRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateProfilePicRequestFromJson(json);
}

@freezed
class ForgotPasswordRequest with _$ForgotPasswordRequest {
  const factory ForgotPasswordRequest({required String email}) =
      _ForgotPasswordRequest;

  factory ForgotPasswordRequest.fromJson(Map<String, dynamic> json) =>
      _$ForgotPasswordRequestFromJson(json);
}

@freezed
class ResetPasswordRequest with _$ResetPasswordRequest {
  const factory ResetPasswordRequest({
    required String email,
    required String password,
    required String passwordConfirm,
    required String otp,
  }) = _ResetPasswordRequest;

  factory ResetPasswordRequest.fromJson(Map<String, dynamic> json) =>
      _$ResetPasswordRequestFromJson(json);
}

@freezed
class ForgotPasswordResponse with _$ForgotPasswordResponse {
  const factory ForgotPasswordResponse({
    required String data,
    required String message,
    required int statusCode,
  }) = _ForgotPasswordResponse;

  factory ForgotPasswordResponse.fromJson(Map<String, dynamic> json) =>
      _$ForgotPasswordResponseFromJson(json);
}

@freezed
class ResetPasswordResponse with _$ResetPasswordResponse {
  const factory ResetPasswordResponse({
    required ResetPasswordData data,
    required String message,
    required int statusCode,
  }) = _ResetPasswordResponse;

  factory ResetPasswordResponse.fromJson(Map<String, dynamic> json) =>
      _$ResetPasswordResponseFromJson(json);
}

@freezed
class ResetPasswordData with _$ResetPasswordData {
  const factory ResetPasswordData({required String message}) =
      _ResetPasswordData;

  factory ResetPasswordData.fromJson(Map<String, dynamic> json) =>
      _$ResetPasswordDataFromJson(json);
}
