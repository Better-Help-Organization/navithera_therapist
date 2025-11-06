import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/network/dio_client.dart';
import '../models/profile_models.dart';

part 'profile_remote_data_source.g.dart';

@RestApi()
abstract class ProfileRemoteDataSource {
  factory ProfileRemoteDataSource(Dio dio) = _ProfileRemoteDataSource;

  @PATCH('/therapist/me')
  Future<UpdatePersonalDetailsResponse> updatePersonalDetails(
    @Body() UpdatePersonalDetailsRequest request,
  );

  @GET('/therapist/me')
  Future<ProfileModel> getCurrentProfile();
}

final profileRemoteDataSourceProvider = Provider<ProfileRemoteDataSource>((
  ref,
) {
  final dio = ref.read(dioProvider);
  return ProfileRemoteDataSource(dio);
});
