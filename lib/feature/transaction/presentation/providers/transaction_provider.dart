// transaction_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:navicare/core/error/failures.dart';
import 'package:navicare/feature/transaction/data/models/transaction_models.dart';
import 'package:navicare/feature/transaction/domain/repositories/transaction_repository.dart';

part 'transaction_provider.freezed.dart';

@freezed
class TransactionState with _$TransactionState {
  const factory TransactionState.initial() = TransactionInitial;
  const factory TransactionState.loading() = TransactionLoading;
  const factory TransactionState.loaded(
    List<TransactionItem> transactions,
    Pagination pagination,
    bool canLoadMore,
  ) = TransactionLoaded;
  const factory TransactionState.error(Failure failure) = TransactionError;
}

class TransactionNotifier extends StateNotifier<TransactionState> {
  final TransactionRepository _repository;

  TransactionNotifier(this._repository)
    : super(const TransactionState.initial());

  Future<void> getTransactions({
    bool loadMore = false,
    bool silent = false,
  }) async {
    try {
      final currentState = state;
      int nextPage = 1;

      if (loadMore && currentState is TransactionLoaded) {
        if (!currentState.canLoadMore) return;
        nextPage = currentState.pagination.currentPage + 1;
      } else {
        if (!silent) {
          state = const TransactionState.loading();
        }
      }

      final result = await _repository.getTransactions(page: nextPage);

      result.fold((failure) => state = TransactionState.error(failure), (
        response,
      ) {
        final transactions = response.data;
        final pagination = response.pagination;
        final canLoadMore = pagination.currentPage < pagination.totalPages;

        if (loadMore && currentState is TransactionLoaded) {
          final allTransactions = [
            ...currentState.transactions,
            ...transactions,
          ];
          state = TransactionState.loaded(
            allTransactions,
            pagination,
            canLoadMore,
          );
        } else {
          state = TransactionState.loaded(
            transactions,
            pagination,
            canLoadMore,
          );
        }
      });
    } catch (e) {
      state = TransactionState.error(Failure.unknownFailure(e.toString()));
    }
  }

  void toggleTransactionExpansion(String transactionId) {
    final currentState = state;
    if (currentState is TransactionLoaded) {
      final updatedTransactions =
          currentState.transactions.map((transaction) {
            if (transaction.id == transactionId) {
              return transaction.copyWith(isExpanded: !transaction.isExpanded);
            }
            return transaction.copyWith(isExpanded: false);
          }).toList();

      state = TransactionState.loaded(
        updatedTransactions,
        currentState.pagination,
        currentState.canLoadMore,
      );
    }
  }
}

final transactionProvider =
    StateNotifierProvider<TransactionNotifier, TransactionState>((ref) {
      final repository = ref.read(transactionRepositoryProvider);
      return TransactionNotifier(repository);
    });
