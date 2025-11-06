import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/network/dio_client.dart';
import '../models/auth_models.dart';

part 'auth_remote_data_source.g.dart';

@RestApi()
abstract class AuthRemoteDataSource {
  factory AuthRemoteDataSource(Dio dio) = _AuthRemoteDataSource;

  @POST('/auth/login/therapist')
  Future<ApiResponse> login(@Body() LoginRequest request);

  @POST('/auth/signup/therapist')
  Future<ApiResponse> signup(@Body() SignupRequest request);

  @POST('/auth/logout')
  Future<void> logout();

  @POST('/auth/refresh')
  Future<ApiResponse> refreshToken(@Field() String refreshToken);

  @PATCH('/therapist/me')
  Future<ProfileApiResponse> updateProfile(
    @Body() UpdateProfileRequest request,
  );

  @PATCH('/therapist/me')
  Future<ProfileApiResponse> updateProfilePicture(
    @Body() UpdateProfilePicRequest request,
  );

  @GET('/therapist/me')
  Future<ProfileApiResponse> getCurrentUserProfile();

  @POST('/auth/forgotPwd/therapist')
  Future<ForgotPasswordResponse> forgotPassword(
    @Body() ForgotPasswordRequest request,
  );

  @POST('/auth/resetPwd/therapist')
  Future<ResetPasswordResponse> resetPassword(
    @Body() ResetPasswordRequest request,
  );
}

final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>((ref) {
  final dio = ref.read(dioProvider);
  return AuthRemoteDataSource(dio);
});
