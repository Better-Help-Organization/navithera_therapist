import '../entities/questions_response.dart';

abstract class QuestionsRepository {
  Future<QuestionsResponse> getQuestions();
}
