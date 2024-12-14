import 'package:Helios/common/interafces/user_settings.dart';
import 'package:Helios/repositories/local_repository/hive_keys.dart';
import 'package:hive/hive.dart';

Future<void> deleteLocalUserSettings() async {
  await Hive.box<UserSettings>(HiveKeys.userSettingsBox).clear();
}
