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
      final DateTime now = DateTime.now();
      lastWeekDurations = List<double>.filled(7, 0.0);

      for (final info in historyInfo) {
        final DateTime sessionStart = info.dateTimeOpened;
        final DateTime sessionEnd = info.dateTimeClosed;

        if (sessionEnd.isBefore(DateTime(now.year, now.month, now.day)
            .subtract(const Duration(days: 6)))) {
          break;
        }

        DateTime current =
            sessionStart.isBefore(now.subtract(const Duration(days: 6)))
                ? now.subtract(const Duration(days: 6))
                : sessionStart;
        DateTime end = sessionEnd.isAfter(now) ? now : sessionEnd;

        while (current.isBefore(end)) {
          final nextDay =
              DateTime(current.year, current.month, current.day + 1);
          final segmentEnd = nextDay.isBefore(end) ? nextDay : end;

          final int daysAgo = DateTime(now.year, now.month, now.day)
              .difference(DateTime(current.year, current.month, current.day))
              .inDays;

          if (daysAgo >= 0 && daysAgo < 7) {
            lastWeekDurations[6 - daysAgo] +=
                segmentEnd.difference(current).inSeconds.toDouble();
          }

          current = segmentEnd;
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
