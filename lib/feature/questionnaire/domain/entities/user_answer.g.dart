// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_answer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserAnswerImpl _$$UserAnswerImplFromJson(Map<String, dynamic> json) =>
    _$UserAnswerImpl(
      questionId: json['questionId'] as String,
      selectedOptionId: json['selectedOptionId'] as String?,
      textAnswer: json['textAnswer'] as String?,
    );

Map<String, dynamic> _$$UserAnswerImplToJson(_$UserAnswerImpl instance) =>
    <String, dynamic>{
      'questionId': instance.questionId,
      'selectedOptionId': instance.selectedOptionId,
      'textAnswer': instance.textAnswer,
    };
