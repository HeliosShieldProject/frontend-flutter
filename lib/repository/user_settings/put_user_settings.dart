import 'package:hive/hive.dart';

import 'package:Helios/repository/hive_keys.dart';

import 'package:Helios/common/interafces/interfaces.dart';

bool putUserSettings({required UserSettings userSettings}) {
  try {
    final Box<UserSettings> userSettingsBox =
        Hive.box<UserSettings>(HiveKeys.userSettingsBox);
    userSettingsBox.put(HiveKeys.userSettingsKey, userSettings);
  } catch (e) {
    return false;
  }

  return true;
}
