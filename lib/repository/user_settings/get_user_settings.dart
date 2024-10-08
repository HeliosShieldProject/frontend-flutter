import 'package:hive/hive.dart';

import 'package:Helios/repository/hive_keys.dart';

import 'package:Helios/bloc/user_settings/state/user_settings_impl.dart';
import 'package:Helios/common/interafces/interfaces.dart';

UserSettings getUserSettings() {
  UserSettings userSettings = UserSettingsImpl();

  try {
    final Box<UserSettings> userSettingsBox =
        Hive.box<UserSettings>(HiveKeys.userSettingsBox);
    userSettings = userSettingsBox.get(HiveKeys.userSettingsKey,
        defaultValue: UserSettingsImpl())!;
  } catch (e) {
    return UserSettingsImpl();
  }

  return userSettings;
}
