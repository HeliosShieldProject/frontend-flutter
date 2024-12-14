import 'dart:async';

import 'package:Helios/common/enums/enums.dart';
import 'package:Helios/common/interafces/user_settings.dart';
import 'package:Helios/repositories/local_repository/user_settings/models/user_settings_impl.dart';
import 'package:Helios/repositories/local_repository/user_settings/user_settings.dart';

class UserSettingsRepository {
  UserSettings? _userSettings;

  final StreamController<UserSettings> _userSettingsController =
      StreamController();

  late final Stream<UserSettings> stream =
      _userSettingsController.stream.asBroadcastStream();

  void init() {
    if (_userSettings != null) {
      _userSettingsController.add(_userSettings!);
    } else {
      _userSettings = getLocalUserSettings();
      _userSettingsController.add(_userSettings!);
    }
  }

  void dispose() => _userSettingsController.close();

  bool put({required UserSettings userSettings}) {
    if (userSettings != _userSettings &&
        putLocalUserSettings(userSettings: userSettings)) {
      _userSettings = userSettings;
      _userSettingsController.add(_userSettings!);
      return true;
    } else if (userSettings == _userSettings) {
      return true;
    }
    return false;
  }

  Future<void> delete() async {
    _userSettingsController.add(const UserSettingsImpl.basic().copyWith(
      selectedTheme: _userSettings?.selectedTheme ?? SelectedTheme.system,
    ));
    _userSettings = null;
    await deleteLocalUserSettings();
  }
}
