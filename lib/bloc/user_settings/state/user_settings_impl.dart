import 'package:Helios/common/enums/enums.dart';
import 'package:Helios/bloc/user_settings/state/user_settings.dart';
import 'package:hive/hive.dart';

part '../../../common/user_settings/user_settings.g.dart';

@HiveType(typeId: 0)
class UserSettingsImpl implements UserSettings {
  @HiveField(0)
  @override
  SelectedTheme? selectedTheme = SelectedTheme.dark;

  @HiveField(1)
  @override
  SubscriptionType? subscriptionType = SubscriptionType.free;

  @override
  UserSettings copyWith({
    SubscriptionType? subscriptionType,
    SelectedTheme? selectedTheme,
  }) {
    return this
      ..subscriptionType = subscriptionType ?? this.subscriptionType
      ..selectedTheme = selectedTheme ?? this.selectedTheme;
  }
}
