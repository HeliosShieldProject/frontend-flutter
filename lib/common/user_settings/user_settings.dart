import 'package:hive/hive.dart';

part 'user_settings.g.dart';

abstract interface class UserSettings {
  SubscriptionType? subscriptionType;

  SelectedTheme? selectedTheme;
} 

@HiveType(typeId: 0)
class UserSettingsImpl implements UserSettings {
  @HiveField(0)
  @override
  SelectedTheme? selectedTheme = SelectedTheme.system;
  
  @HiveField(1)
  @override
  SubscriptionType? subscriptionType = SubscriptionType.free;
}

@HiveType(typeId: 1)
enum SubscriptionType {
  @HiveField(0)
  free, 

  @HiveField(1)
  premium,
  
  @HiveField(2)
  superPremium, 
}

@HiveType(typeId: 2)
enum SelectedTheme {
  @HiveField(0)
  system,

  @HiveField(1)
  dark,

  @HiveField(2)
  light,
}