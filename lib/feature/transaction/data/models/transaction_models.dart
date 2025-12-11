// transaction_models.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'transaction_models.freezed.dart';
part 'transaction_models.g.dart';

@freezed
class TransactionListResponse with _$TransactionListResponse {
  const factory TransactionListResponse({
    required List<TransactionItem> data,
    required Pagination pagination,
    required String message,
    required int statusCode,
    required String method,
    required String path,
    required DateTime timestamp,
  }) = _TransactionListResponse;

  factory TransactionListResponse.fromJson(Map<String, dynamic> json) =>
      _$TransactionListResponseFromJson(json);
}

@freezed
class TransactionItem with _$TransactionItem {
  const factory TransactionItem({
    required String id,
    required DateTime updatedAt,
    required DateTime createdAt,
    required DateTime startDate,
    required DateTime endDate,
    required double totalRevenue,
    @JsonKey(ignore: true) @Default(false) bool isExpanded,
  }) = _TransactionItem;

  factory TransactionItem.fromJson(Map<String, dynamic> json) =>
      _$TransactionItemFromJson(json);
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
