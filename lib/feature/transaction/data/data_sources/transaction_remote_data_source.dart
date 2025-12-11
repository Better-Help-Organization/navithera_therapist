// transaction_remote_data_source.dart
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:navicare/core/network/dio_client.dart';
import 'package:retrofit/retrofit.dart';
import '../models/transaction_models.dart';

part 'transaction_remote_data_source.g.dart';

@RestApi()
abstract class TransactionRemoteDataSource {
  factory TransactionRemoteDataSource(Dio dio) = _TransactionRemoteDataSource;

  @GET('/therapist-payment-period')
  Future<TransactionListResponse> getTransactions({
    @Query('page') int? page,
    @Query('take') int? take,
    @Query('sort') String? sort,
  });
}

final transactionRemoteDataSourceProvider =
    Provider<TransactionRemoteDataSource>((ref) {
      final dio = ref.read(dioProvider);
      return TransactionRemoteDataSource(dio);
    });
