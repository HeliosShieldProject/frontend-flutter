part of "bloc.dart";

sealed class AppSettingsEvent {}

class _ChangeSettingsEvent extends AppSettingsEvent {
  _ChangeSettingsEvent({required this.userSettings});

  final UserSettings userSettings;
}
