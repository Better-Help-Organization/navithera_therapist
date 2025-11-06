import 'package:freezed_annotation/freezed_annotation.dart';
import 'question_option.dart';

part 'question.freezed.dart';
part 'question.g.dart';

@freezed
class Question with _$Question {
  const factory Question({
    required String id,
    required String text,
    required String type, // "single" or "open"
    required List<QuestionOption> option,
    required Map<String, dynamic>? modal, // Modal relationship with id
  }) = _Question;

  factory Question.fromJson(Map<String, dynamic> json) =>
      _$QuestionFromJson(json);
}
