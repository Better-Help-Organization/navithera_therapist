import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_answer.freezed.dart';
part 'user_answer.g.dart';

@freezed
class UserAnswer with _$UserAnswer {
  const factory UserAnswer({
    required String questionId,
    String? selectedOptionId, // For single choice questions
    String? textAnswer, // For open-ended questions
  }) = _UserAnswer;

  factory UserAnswer.fromJson(Map<String, dynamic> json) =>
      _$UserAnswerFromJson(json);
}
