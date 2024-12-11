part of "bloc.dart";

@immutable
class SettingsState extends Equatable {
  const SettingsState({
    required this.selectedTheme,
    required this.subscriptionType,
    required this.email,
  });

  const SettingsState.unknown()
      : selectedTheme = SelectedTheme.dark,
        subscriptionType = SubscriptionType.free,
        email = "test@email.com";

  final SelectedTheme selectedTheme;
  final SubscriptionType subscriptionType;
  final String email;

  SettingsState copyWith({
    SelectedTheme? selectedTheme,
    SubscriptionType? subscriptionType,
    String? email,
  }) =>
      SettingsState(
        selectedTheme: selectedTheme ?? this.selectedTheme,
        subscriptionType: subscriptionType ?? this.subscriptionType,
        email: email ?? this.email,
      );

  @override
  List<Object?> get props => <Object>[selectedTheme, subscriptionType, email];
}
