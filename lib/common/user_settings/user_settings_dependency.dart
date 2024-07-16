import 'package:flutter/material.dart';
import 'package:helios/common/common.dart';
import "package:hive/hive.dart";
import 'user_settings.dart';

class AppUserSettings extends StatefulWidget {
  const AppUserSettings({
    super.key,
    required this.child,
  });

  final Widget child;

  static UserSettings? of(BuildContext context, {bool listen = true}) => 
    _AppUserSettingsInheritedWidget.of(context, listen: listen).userSettings; 

  static void update(BuildContext context, UserSettings userSettings) {
    _AppUserSettingsInheritedWidget.of(context).state._update(userSettings);
  }

  static void changeTheme(BuildContext context, SelectedTheme? selectedTheme) {
    final userSettings = _AppUserSettingsInheritedWidget.of(context).userSettings;
    userSettings!.selectedTheme = selectedTheme;
    update(context, userSettings);
    AppTheme.update(context, userSettings.theme);
  }   

  @override
  State<AppUserSettings> createState() => _AppUserSettingsState();
}

class _AppUserSettingsState extends State<AppUserSettings> { //can be done using streams, because for now it is hot pile of shit
  UserSettings? userSettings;

  @override
  void initState() {
    super.initState();
    Hive.openBox<UserSettings>("UserSettings") 
      .then(
        (value) {
          setState(() {
            userSettings = value.get(
              "userSettings", 
              defaultValue: UserSettingsImpl(),
            );
          });
        }
      );
  }

  @override
  void dispose() {
    super.dispose();
    try {
      Hive.box("UserSettings")
        ..put("userSettings", userSettings)
        ..close();
    } on HiveError catch(error) {
      print(error.message);
    }
  }

  void _update(UserSettings userSettings) { 
    Hive.box("UserSettings").put("userSettings", userSettings);
    setState(() {
      this.userSettings = userSettings;
    });
  }

  @override
  Widget build(BuildContext context) => _AppUserSettingsInheritedWidget(
    state: this, 
    userSettings: userSettings, 
    child: widget.child,
  );
}

class _AppUserSettingsInheritedWidget extends InheritedWidget {
  const _AppUserSettingsInheritedWidget({
    required this.state, 
    required this.userSettings,
    required super.child,
  });

  final _AppUserSettingsState state;
  final UserSettings? userSettings;

  static _AppUserSettingsInheritedWidget? maybeof(BuildContext context, {bool listen = false}) => listen
    ?
    context.dependOnInheritedWidgetOfExactType<_AppUserSettingsInheritedWidget>()
    :
    context.getInheritedWidgetOfExactType<_AppUserSettingsInheritedWidget>();

  static _AppUserSettingsInheritedWidget of(BuildContext context, {bool listen = false}) => maybeof(
    context, 
    listen: listen
  )!;

  @override
  bool updateShouldNotify(_AppUserSettingsInheritedWidget oldWidget) => 
    userSettings != oldWidget.userSettings;
}