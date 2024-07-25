import 'package:flutter/material.dart';
import 'package:helios/common/common.dart';
import 'package:hive/hive.dart';

class AppUserSettings extends StatefulWidget {
  const AppUserSettings({
    super.key,
    required this.child,
  });

  final Widget child;

  static UserSettings? of(BuildContext context, {bool listen = false}) =>
      _AppUserSettingsInheritedWidget.of(context, listen: listen).userSettings;

  static bool isBoxOpen(BuildContext context, {bool listen = false}) =>
      _AppUserSettingsInheritedWidget.of(context, listen: listen).state.boxOpen;

  static void update(BuildContext context, UserSettings userSettings) {
    _AppUserSettingsInheritedWidget.of(context).state._update(userSettings);
  }

  static void changeTheme(BuildContext context, SelectedTheme theme) {
    _AppUserSettingsInheritedWidget.of(context).state._changeTheme(theme);
  }

  static void changeSubscription(
      BuildContext context, SubscriptionType subscriptionType) {
    _AppUserSettingsInheritedWidget.of(context)
        .state
        ._changeSubscription(subscriptionType);
  }

  @override
  State<AppUserSettings> createState() => _AppUserSettingsState();
}

class _AppUserSettingsState extends State<AppUserSettings>
    with WidgetsBindingObserver {
  UserSettings? userSettings;
  bool boxOpen = false;

  void _update(UserSettings userSettings) {
    setState(() {
      this.userSettings = userSettings;
    });
    if (Hive.isBoxOpen("UserSettings"))
      Hive.box("UserSettings").put("userSettings", userSettings);
  }

  void _changeTheme(SelectedTheme? selectedTheme) {
    UserSettings newUserSettings = UserSettingsImpl();
    newUserSettings.selectedTheme = selectedTheme;
    newUserSettings.subscriptionType = userSettings?.subscriptionType;
    setState(() {
      userSettings = newUserSettings;
    });
    if (Hive.isBoxOpen("UserSettings"))
      Hive.box("UserSettings").put("userSettings", userSettings);
  }

  void _changeSubscription(SubscriptionType? subscriptionType) {
    UserSettings newUserSettings = UserSettingsImpl();
    newUserSettings.selectedTheme = userSettings?.selectedTheme;
    newUserSettings.subscriptionType = subscriptionType;
    setState(() {
      userSettings = newUserSettings;
    });
    if (Hive.isBoxOpen("UserSettings"))
      Hive.box("UserSettings").put("userSettings", userSettings);
  }

  @override
  void initState() {
    super.initState();
    Hive.openBox("UserSettings").then((value) {
      boxOpen = true;
      setState(() {
        userSettings = value.get(
          "userSettings",
          defaultValue: UserSettingsImpl(),
        );
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    try {
      if (Hive.isBoxOpen("UserSettings")) {
        Hive.box("UserSettings")
          ..put("userSettings", userSettings)
          ..close();
      }
    } on HiveError catch (error) {
      print(error.message);
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.detached) dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _AppUserSettingsInheritedWidget(
      state: this,
      userSettings: userSettings,
      child: widget.child,
    );
  }
}

class _AppUserSettingsInheritedWidget extends InheritedWidget {
  const _AppUserSettingsInheritedWidget({
    super.key,
    required this.state,
    required this.userSettings,
    required super.child,
  });

  final _AppUserSettingsState state;
  final UserSettings? userSettings;

  static _AppUserSettingsInheritedWidget? maybeof(BuildContext context,
          {bool listen = false}) =>
      listen
          ? context.dependOnInheritedWidgetOfExactType<
              _AppUserSettingsInheritedWidget>()
          : context
              .getInheritedWidgetOfExactType<_AppUserSettingsInheritedWidget>();

  static _AppUserSettingsInheritedWidget of(BuildContext context,
          {bool listen = false}) =>
      maybeof(context, listen: listen)!;

  @override
  bool updateShouldNotify(
          covariant _AppUserSettingsInheritedWidget oldWidget) =>
      (userSettings?.selectedTheme?.name !=
          oldWidget.userSettings?.selectedTheme?.name) ||
      (userSettings?.subscriptionType?.name !=
          oldWidget.userSettings?.subscriptionType?.name);
}
