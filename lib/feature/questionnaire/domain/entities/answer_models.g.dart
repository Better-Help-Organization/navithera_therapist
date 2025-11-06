// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'answer_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AnswerResponseImpl _$$AnswerResponseImplFromJson(Map<String, dynamic> json) =>
    _$AnswerResponseImpl(
      data:
          (json['data'] as List<dynamic>)
              .map((e) => AnswerData.fromJson(e as Map<String, dynamic>))
              .toList(),
      pagination: Pagination.fromJson(
        json['pagination'] as Map<String, dynamic>,
      ),
      message: json['message'] as String,
      statusCode: (json['statusCode'] as num).toInt(),
      method: json['method'] as String?,
      path: json['path'] as String?,
      timestamp: json['timestamp'] as String?,
    );

Map<String, dynamic> _$$AnswerResponseImplToJson(
  _$AnswerResponseImpl instance,
) => <String, dynamic>{
  'data': instance.data,
  'pagination': instance.pagination,
  'message': instance.message,
  'statusCode': instance.statusCode,
  'method': instance.method,
  'path': instance.path,
  'timestamp': instance.timestamp,
};

_$AnswerDataImpl _$$AnswerDataImplFromJson(Map<String, dynamic> json) =>
    _$AnswerDataImpl(
      id: json['id'] as String,
      text: json['text'] as String?,
      question: Question.fromJson(json['question'] as Map<String, dynamic>),
      singleOption:
          json['singleOption'] == null
              ? null
              : QuestionOption.fromJson(
                json['singleOption'] as Map<String, dynamic>,
              ),
      multiOption:
          (json['multiOption'] as List<dynamic>)
              .map((e) => QuestionOption.fromJson(e as Map<String, dynamic>))
              .toList(),
    );

Map<String, dynamic> _$$AnswerDataImplToJson(_$AnswerDataImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'question': instance.question,
      'singleOption': instance.singleOption,
      'multiOption': instance.multiOption,
    };

_$QuestionImpl _$$QuestionImplFromJson(Map<String, dynamic> json) =>
    _$QuestionImpl(
      id: json['id'] as String,
      createdAt: json['createdAt'] as String,
      text: json['text'] as String,
      type: json['type'] as String,
    );

Map<String, dynamic> _$$QuestionImplToJson(_$QuestionImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdAt,
      'text': instance.text,
      'type': instance.type,
    };

_$QuestionOptionImpl _$$QuestionOptionImplFromJson(Map<String, dynamic> json) =>
    _$QuestionOptionImpl(
      id: json['id'] as String,
      createdAt: json['createdAt'] as String,
      text: json['text'] as String,
    );

Map<String, dynamic> _$$QuestionOptionImplToJson(
  _$QuestionOptionImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'createdAt': instance.createdAt,
  'text': instance.text,
};

_$PaginationImpl _$$PaginationImplFromJson(Map<String, dynamic> json) =>
    _$PaginationImpl(
      totalItems: (json['totalItems'] as num).toInt(),
      totalPages: (json['totalPages'] as num).toInt(),
      currentPage: (json['currentPage'] as num).toInt(),
      pageSize: (json['pageSize'] as num).toInt(),
    );

Map<String, dynamic> _$$PaginationImplToJson(_$PaginationImpl instance) =>
    <String, dynamic>{
      'totalItems': instance.totalItems,
      'totalPages': instance.totalPages,
      'currentPage': instance.currentPage,
      'pageSize': instance.pageSize,
    };
