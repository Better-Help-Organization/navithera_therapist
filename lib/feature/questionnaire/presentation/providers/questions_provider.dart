import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/network/dio_client.dart';
import '../../data/datasources/questions_remote_data_source.dart';
import '../../data/repositories/questions_repository_impl.dart';
import '../../domain/entities/questions_response.dart';
import '../../domain/entities/user_answer.dart';
import '../../domain/repositories/questions_repository.dart';

// Repository provider
final questionsRepositoryProvider = Provider<QuestionsRepository>((ref) {
  final dio = ref.read(dioProvider);
  final remoteDataSource = QuestionsRemoteDataSource(dio);
  return QuestionsRepositoryImpl(remoteDataSource);
});

// Questions state provider
final questionsProvider = StateNotifierProvider<QuestionsNotifier, AsyncValue<QuestionsResponse>>((ref) {
  final repository = ref.read(questionsRepositoryProvider);
  return QuestionsNotifier(repository);
});

// User answers provider
final userAnswersProvider = StateNotifierProvider<UserAnswersNotifier, List<UserAnswer>>((ref) {
  return UserAnswersNotifier();
});

// Current question index provider
final currentQuestionIndexProvider = StateProvider<int>((ref) => 0);

class QuestionsNotifier extends StateNotifier<AsyncValue<QuestionsResponse>> {
  final QuestionsRepository _repository;

  QuestionsNotifier(this._repository) : super(const AsyncValue.loading());

  Future<void> loadQuestions({String? category}) async {
    state = const AsyncValue.loading();
    try {
      final questions = await _repository.getQuestions();
      
      // If category is specified, filter questions based on category
      if (category != null && category.isNotEmpty) {
        // For now, we'll simulate category filtering
        // In a real implementation, you'd filter based on question categories
        // or make a separate API call with category parameter
        final filteredQuestions = _filterQuestionsByCategory(questions, category);
        state = AsyncValue.data(filteredQuestions);
      } else {
        state = AsyncValue.data(questions);
      }
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
  
  QuestionsResponse _filterQuestionsByCategory(QuestionsResponse questions, String categoryId) {
    // Filter questions based on the modal ID relationship
    final allQuestions = questions.data;
    
    // Filter questions that belong to the selected category (modal)
    final filteredQuestions = allQuestions.where((question) {
      // Check if the question has a modal and if its ID matches the selected category
      if (question.modal != null && question.modal!['id'] != null) {
        return question.modal!['id'] == categoryId;
      }
      return false;
    }).toList();
    
    return QuestionsResponse(data: filteredQuestions);
  }
}

class UserAnswersNotifier extends StateNotifier<List<UserAnswer>> {
  UserAnswersNotifier() : super([]);

  void addAnswer(UserAnswer answer) {
    // Remove existing answer for the same question if it exists
    state = [
      ...state.where((a) => a.questionId != answer.questionId),
      answer,
    ];
  }

  void updateAnswer(String questionId, {String? selectedOptionId, String? textAnswer}) {
    final answer = UserAnswer(
      questionId: questionId,
      selectedOptionId: selectedOptionId,
      textAnswer: textAnswer,
    );
    addAnswer(answer);
  }

  UserAnswer? getAnswerForQuestion(String questionId) {
    try {
      return state.firstWhere((answer) => answer.questionId == questionId);
    } catch (e) {
      return null;
    }
  }

  void clearAnswers() {
    state = [];
  }
}
