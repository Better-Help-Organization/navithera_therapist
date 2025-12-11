// transaction_repository.dart
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:navicare/core/error/failures.dart';
import 'package:navicare/feature/transaction/data/data_sources/transaction_remote_data_source.dart';
import 'package:navicare/feature/transaction/data/models/transaction_models.dart';

abstract class TransactionRepository {
  Future<Either<Failure, TransactionListResponse>> getTransactions({
    int? page,
    int? limit,
  });
}

class TransactionRepositoryImpl implements TransactionRepository {
  final TransactionRemoteDataSource remoteDataSource;

  TransactionRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, TransactionListResponse>> getTransactions({
    int? page,
    int? limit,
  }) async {
    try {
      final response = await remoteDataSource.getTransactions(
        page: page,
        take: limit,
        sort: 'createdAt=Desc',
      );
      return Right(response);
    } on DioException catch (e) {
      String errorMessage =
          "We're having trouble loading your transactions. Please check your connection and try again.";
      if (e.response?.statusCode == 401) {
        errorMessage = 'Unauthorized';
      } else if (e.response?.data is Map<String, dynamic>) {
        errorMessage = e.response?.data['message'] ?? errorMessage;
      }
      return Left(Failure.serverFailure(errorMessage));
    } catch (e) {
      return Left(Failure.unknownFailure(e.toString()));
    }
  }
}

final transactionRepositoryProvider = Provider<TransactionRepository>((ref) {
  final remoteDataSource = ref.read(transactionRemoteDataSourceProvider);
  return TransactionRepositoryImpl(remoteDataSource);
});
