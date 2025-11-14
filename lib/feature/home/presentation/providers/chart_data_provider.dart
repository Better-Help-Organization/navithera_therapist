// chart_data_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:navicare/core/error/failures.dart';
import 'package:navicare/feature/home/data/models/chart_data_models.dart';
import 'package:navicare/feature/home/domain/repositories/chart_data_repository.dart';

part 'chart_data_provider.freezed.dart';

@freezed
class ChartDataState with _$ChartDataState {
  const factory ChartDataState.initial() = ChartDataInitial;
  const factory ChartDataState.loading() = ChartDataLoading;
  const factory ChartDataState.loaded(WeeklyStats weeklyStats) =
      ChartDataLoaded;
  const factory ChartDataState.error(Failure failure) = ChartDataError;
}

class ChartDataNotifier extends StateNotifier<ChartDataState> {
  final ChartDataRepository _repo;

  ChartDataNotifier(this._repo) : super(const ChartDataState.initial());

  Future<void> load() async {
    try {
      state = const ChartDataState.loading();
      final res = await _repo.getWeeklyStats();
      res.fold(
        (l) => state = ChartDataState.error(l),
        (r) => state = ChartDataState.loaded(r),
      );
    } catch (e) {
      state = ChartDataState.error(Failure.unknownFailure(e.toString()));
    }
  }

  void reset() {
    state = const ChartDataState.initial();
  }
}

final chartDataProvider =
    StateNotifierProvider<ChartDataNotifier, ChartDataState>((ref) {
      final repo = ref.read(chartDataRepositoryProvider);
      return ChartDataNotifier(repo);
    });
