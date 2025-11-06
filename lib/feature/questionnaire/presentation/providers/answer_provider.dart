// answers_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:navicare/core/constants/base_url.dart';
import 'package:navicare/feature/questionnaire/domain/entities/answer_models.dart';
import 'package:shared_preferences/shared_preferences.dart';

final answersProvider = FutureProvider.family<AnswerResponse, List<String>>((
  ref,
  answerIds,
) async {
  final sharedPreferences = await SharedPreferences.getInstance();
  final accessToken = sharedPreferences.getString('access_token');

  final dio = Dio();
  dio.options.headers['Authorization'] = 'Bearer $accessToken';

  final idsParam = answerIds.join(',');
  final response = await dio.get(
    '${base_url_dev}/answer',
    queryParameters: {
      'fields': 'question.*,singleOption.*,multiOption.*,text',
      'ids': idsParam,
    },
  );

  return AnswerResponse.fromJson(response.data);
});
