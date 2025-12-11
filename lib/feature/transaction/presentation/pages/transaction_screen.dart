// transaction_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:navicare/core/theme/app_colors.dart';
import 'package:navicare/feature/transaction/data/models/transaction_models.dart';
import 'package:navicare/feature/transaction/presentation/providers/transaction_provider.dart';

class TransactionScreen extends ConsumerStatefulWidget {
  const TransactionScreen({super.key});

  @override
  ConsumerState<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends ConsumerState<TransactionScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadTransactions();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _loadTransactions({
    bool loadMore = false,
    bool silent = false,
  }) async {
    try {
      await ref
          .read(transactionProvider.notifier)
          .getTransactions(loadMore: loadMore, silent: silent);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to load transactions'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      final state = ref.read(transactionProvider);
      if (state is TransactionLoaded && state.canLoadMore) {
        _loadTransactions(loadMore: true, silent: true);
      }
    }
  }

  Future<void> _handleRefresh() async {
    await _loadTransactions(silent: true);
  }

  void _toggleTransactionExpansion(String transactionId) {
    ref
        .read(transactionProvider.notifier)
        .toggleTransactionExpansion(transactionId);
  }

  String _formatCurrency(double amount) {
    return NumberFormat.currency(
      symbol: 'ETB ',
      decimalDigits: 2,
    ).format(amount);
  }

  String _formatDate(DateTime date) {
    return DateFormat('MM/dd/yyyy').format(date);
  }

  String _formatDateWithDay(DateTime date) {
    final weekday = DateFormat('EEEE').format(date);
    final dateFormatted = DateFormat('MM/dd/yyyy').format(date);
    return '$weekday, $dateFormatted';
  }

  @override
  Widget build(BuildContext context) {
    final transactionState = ref.watch(transactionProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.white,
        title: const Text("Transactions"),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: _buildBody(transactionState),
    );
  }

  Widget _buildBody(TransactionState transactionState) {
    return switch (transactionState) {
      TransactionInitial() => RefreshIndicator(
        onRefresh: _handleRefresh,
        color: AppColors.primary,
        child: const Center(child: Text('No transactions available')),
      ),
      TransactionLoading() => const Center(
        child: CircularProgressIndicator(color: AppColors.primary),
      ),
      TransactionError(:final failure) => RefreshIndicator(
        onRefresh: _handleRefresh,
        color: AppColors.primary,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.8,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Text(failure.message.toString()),
              ),
            ),
          ),
        ),
      ),
      TransactionLoaded(:final transactions, :final canLoadMore) =>
        RefreshIndicator(
          onRefresh: _handleRefresh,
          color: AppColors.primary,
          child: ListView.builder(
            controller: _scrollController,
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: transactions.length + (canLoadMore ? 1 : 0),
            itemBuilder: (context, index) {
              if (index == transactions.length) {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: Center(
                    child: CircularProgressIndicator(color: AppColors.primary),
                  ),
                );
              }

              final transaction = transactions[index];
              return _buildTransactionItem(transaction);
            },
          ),
        ),
      // TODO: Handle this case.
      TransactionState() => throw UnimplementedError(),
    };
  }

  Widget _buildTransactionItem(TransactionItem transaction) {
    return Consumer(
      builder: (context, ref, child) {
        return InkWell(
          onTap: () {
            _toggleTransactionExpansion(transaction.id);
          },
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  leading: Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.primary,
                    ),
                    child: const Icon(
                      Icons.attach_money,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  title: Text(
                    'Payment Period',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _formatDateWithDay(transaction.createdAt),
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Period: ${_formatDate(transaction.startDate)} - ${_formatDate(transaction.endDate)}',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey[600],
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                  trailing: Text(
                    _formatCurrency(transaction.totalRevenue),
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                ),
                if (transaction.isExpanded) ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildDetailRow(
                          'Period:',
                          '${_formatDate(transaction.startDate)} - ${_formatDate(transaction.endDate)}',
                        ),
                        const SizedBox(height: 8),
                        _buildDetailRow('Payment ID:', transaction.id),
                        const SizedBox(height: 8),
                        _buildDetailRow(
                          'Payment Date:',
                          _formatDateWithDay(transaction.createdAt),
                        ),
                        const SizedBox(height: 12),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Total Revenue:',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primary,
                                ),
                              ),
                              Text(
                                _formatCurrency(transaction.totalRevenue),
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 100,
          child: Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(value, style: const TextStyle(color: Colors.black87)),
        ),
      ],
    );
  }
}
