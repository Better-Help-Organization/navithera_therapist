import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:navicare/core/network/dio_client.dart';
import 'package:retrofit/retrofit.dart';
import '../models/chart_data_models.dart';

part 'chart_data_remote_data_source.g.dart';

@RestApi()
abstract class ChartDataRemoteDataSource {
  factory ChartDataRemoteDataSource(Dio dio) = _ChartDataRemoteDataSource;

  @GET('/therapist/stats')
  Future<WeeklyStatsResponse> getWeeklyStats({
    @Query('startDate') required String startDate,
    @Query('endDate') required String endDate,
  });
}

final chartDataRemoteDataSourceProvider = Provider<ChartDataRemoteDataSource>((
  ref,
) {
  final dio = ref.read(dioProvider);
  return ChartDataRemoteDataSource(dio);
});
