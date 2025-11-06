// answer_models.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'answer_models.freezed.dart';
part 'answer_models.g.dart';

@freezed
class AnswerResponse with _$AnswerResponse {
  const factory AnswerResponse({
    required List<AnswerData> data,
    required Pagination pagination,
    required String message,
    required int statusCode,
    String? method,
    String? path,
    String? timestamp,
  }) = _AnswerResponse;

  factory AnswerResponse.fromJson(Map<String, dynamic> json) =>
      _$AnswerResponseFromJson(json);
}

@freezed
class AnswerData with _$AnswerData {
  const factory AnswerData({
    required String id,
    String? text,
    required Question question,
    QuestionOption? singleOption,
    required List<QuestionOption> multiOption,
  }) = _AnswerData;

  factory AnswerData.fromJson(Map<String, dynamic> json) =>
      _$AnswerDataFromJson(json);
}

@freezed
class Question with _$Question {
  const factory Question({
    required String id,
    required String createdAt,
    required String text,
    required String type,
  }) = _Question;

  factory Question.fromJson(Map<String, dynamic> json) =>
      _$QuestionFromJson(json);
}

@freezed
class QuestionOption with _$QuestionOption {
  const factory QuestionOption({
    required String id,
    required String createdAt,
    required String text,
  }) = _QuestionOption;

  factory QuestionOption.fromJson(Map<String, dynamic> json) =>
      _$QuestionOptionFromJson(json);
}

@freezed
class Pagination with _$Pagination {
  const factory Pagination({
    required int totalItems,
    required int totalPages,
    required int currentPage,
    required int pageSize,
  }) = _Pagination;

  factory Pagination.fromJson(Map<String, dynamic> json) =>
      _$PaginationFromJson(json);
}
