import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../domain/entities/questions_response.dart';

part 'questions_remote_data_source.g.dart';

@RestApi()
abstract class QuestionsRemoteDataSource {
  factory QuestionsRemoteDataSource(Dio dio) = _QuestionsRemoteDataSource;

  @GET('/question')
  Future<QuestionsResponse> getQuestions({
    @Query('fields') String fields = 'option.*,text,type,createdAt,modal.id',
    @Query('take') int take = 0,
  });
}
