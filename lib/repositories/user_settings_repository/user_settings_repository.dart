import 'package:Helios/common/interafces/user_settings.dart';
import 'package:Helios/common/user_settings/user_settings_impl.dart';
import 'package:Helios/repositories/local_repository/user_settings/get_user_settings.dart';
import 'package:Helios/repository/user_settings/put_user_settings.dart';

class UserSettingsRepository {
  UserSettings? _userSettings;

  UserSettings getUserSettings() {
    if (_userSettings != null) {
      return _userSettings!;
    }
    _userSettings = getLocalUserSettings();
    return _userSettings!;
  }

  bool putUserSettings() {
    return putLocalUserSettings(
      userSettings: _userSettings ?? const UserSettingsImpl.basic(),
    );
  }
}