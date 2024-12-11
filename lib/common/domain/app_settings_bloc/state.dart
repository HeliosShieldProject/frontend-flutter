part of "bloc.dart";

@immutable
class AppSettingsState extends Equatable {
  const AppSettingsState({
    required this.selectedTheme,
    required this.subscriptionType,
  });

  final SelectedTheme selectedTheme;
  final SubscriptionType subscriptionType;

  const AppSettingsState.unknown()
      : selectedTheme = SelectedTheme.dark,
        subscriptionType = SubscriptionType.free;

  AppSettingsState copyWith(
          {SelectedTheme? selectedTheme, SubscriptionType? subscriptionType}) =>
      AppSettingsState(
        selectedTheme: selectedTheme ?? this.selectedTheme,
        subscriptionType: subscriptionType ?? this.subscriptionType,
      );

  ThemeMode get themeMode => getThemeMode(selectedTheme);

  @override
  List<Object?> get props => [selectedTheme, subscriptionType];
}
