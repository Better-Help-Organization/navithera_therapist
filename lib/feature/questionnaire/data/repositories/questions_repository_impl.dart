import '../../domain/entities/questions_response.dart';
import '../../domain/repositories/questions_repository.dart';
import '../datasources/questions_remote_data_source.dart';

class QuestionsRepositoryImpl implements QuestionsRepository {
  final QuestionsRemoteDataSource _remoteDataSource;

  QuestionsRepositoryImpl(this._remoteDataSource);

  @override
  Future<QuestionsResponse> getQuestions() async {
    try {
      return await _remoteDataSource.getQuestions();
    } catch (e) {
      rethrow;
    }
  }
}
