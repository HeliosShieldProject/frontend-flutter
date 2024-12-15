part of "bloc.dart";

sealed class HistoryEvent {}

class InitHistoryEvent extends HistoryEvent {}

class BottomHitEvent extends HistoryEvent {}
