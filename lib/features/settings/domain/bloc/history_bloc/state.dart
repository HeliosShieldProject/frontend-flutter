part of "bloc.dart";

class HistoryState extends Equatable {
  const HistoryState({
    required this.status,
    required this.historyInfo,
    required this.reachedEnd,
  });

  final List<HistoryInfo> historyInfo;
  final Auth? status;
  final bool reachedEnd;

  const HistoryState.empty()
      : status = null,
        historyInfo = const <HistoryInfo>[],
        reachedEnd = false;

  HistoryState copyWith({
    Auth? status,
    List<HistoryInfo>? historyInfo,
    bool? reachedEnd,
  }) =>
      HistoryState(
        status: status ?? this.status,
        historyInfo: historyInfo ?? this.historyInfo,
        reachedEnd: reachedEnd ?? this.reachedEnd,
      );

  HistoryState add({
    required List<HistoryInfo> historyInfo,
  }) =>
      HistoryState(
        status: status,
        reachedEnd: reachedEnd,
        historyInfo: [...this.historyInfo, ...historyInfo],
      );

  List<double> get lastWeek {
    late final List<double> lastWeekDurations;

    if (historyInfo.isNotEmpty) {
      final now = DateTime.now();
      lastWeekDurations = List<double>.filled(7, 0.0);

      for (final info in historyInfo) {
        final daysAgo = now.difference(info.dateTimeOpened).inDays;
        if (daysAgo < 7) {
          lastWeekDurations[6 - daysAgo] += info.duration.inSeconds.toDouble();
        } else {
          break;
        }
      }
    } else {
      lastWeekDurations = <double>[];
    }

    return lastWeekDurations;
  }

  @override
  List<Object?> get props => [status, ...historyInfo, reachedEnd];
}
