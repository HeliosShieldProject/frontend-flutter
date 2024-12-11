part of "bloc.dart";

sealed class SettingsEvent {}

class _ChangeSettingsEvent extends SettingsEvent {
  _ChangeSettingsEvent({
    required this.userSettings,
  });

  final UserSettings userSettings;
}

class ChangeSelectedThemeEvent extends SettingsEvent {
  ChangeSelectedThemeEvent({required this.selectedTheme});

  final SelectedTheme selectedTheme;
}
