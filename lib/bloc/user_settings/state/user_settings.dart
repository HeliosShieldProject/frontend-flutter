import 'package:Helios/common/enums/enums.dart';

abstract interface class UserSettings {
  SubscriptionType? subscriptionType;

  SelectedTheme? selectedTheme;

  UserSettings copyWith({
    SubscriptionType? subscriptionType,
    SelectedTheme? selectedTheme,
  });
}
