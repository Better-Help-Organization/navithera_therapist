// answers_provider.dart
import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:navicare/core/constants/base_url.dart';
import 'package:navicare/feature/questionnaire/domain/entities/answer_models.dart';

 final FlutterSecureStorage _secureStorage = const FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
    iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock),
  );

final answersProvider = FutureProvider.family<AnswerResponse, List<String>>((
  ref,
  answerIds,
) async {
  final accessToken = await _secureStorage.read(key: 'access_token');

  final dio = Dio();
  dio.options.headers['Authorization'] = 'Bearer $accessToken';

  final idsParam = answerIds.join(',');
  final response = await dio.get(
    '$base_url_dev/answer',
    queryParameters: {
      'fields': 'question.*,singleOption.*,multiOption.*,text',
      'ids': idsParam,
    },
  );
  log('im here2 : ${response.data}');

  return AnswerResponse.fromJson(response.data);
});
