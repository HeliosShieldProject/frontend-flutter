part of 'settings_bloc.dart';

@immutable
sealed class SettingsEvent {}

class SettingsChangedThemeEvent extends SettingsEvent {
  SettingsChangedThemeEvent({
    required this.newTheme,
  });

  final SelectedTheme newTheme;
}

class SettingsChangedSubscriptionEvent extends SettingsEvent {
  SettingsChangedSubscriptionEvent({
    required this.newSubscription,
  });

  final SubscriptionType newSubscription;
}
