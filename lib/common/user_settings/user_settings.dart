import 'package:hive/hive.dart';

part 'user_settings.g.dart';

@HiveType(typeId: 0)
class UserSettingsImpl implements UserSettings {
  @HiveField(0)
  @override
  SelectedTheme? selectedTheme = SelectedTheme.dark;

  @HiveField(1)
  @override
  SubscriptionType? subscriptionType = SubscriptionType.free;
}
