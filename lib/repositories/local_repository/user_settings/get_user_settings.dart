import 'package:hive/hive.dart';

import 'package:Helios/repositories/local_repository/hive_keys.dart';

import 'package:Helios/common/user_settings/user_settings_impl.dart';
import 'package:Helios/common/interafces/interfaces.dart';

UserSettings getLocalUserSettings() {
  late final UserSettings userSettings;

  try {
    final Box<UserSettings> userSettingsBox =
        Hive.box<UserSettings>(HiveKeys.userSettingsBox);
    userSettings = userSettingsBox.get(HiveKeys.userSettingsKey,
        defaultValue: const UserSettingsImpl.basic())!;
  } catch (e) {
    return userSettings;
  }

  return userSettings;
}
