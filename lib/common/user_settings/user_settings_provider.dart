import 'package:flutter/material.dart';
import 'package:helios/common/common.dart';
import 'package:hive/hive.dart';

class AppUserSettings extends StatefulWidget {
  const AppUserSettings({
    super.key,
    required this.child,
  });

  final Widget child;

  static UserSettings of(BuildContext context, {bool listen = false}) =>
      _AppUserSettingsInheritedWidget.of(context, listen: listen).userSettings;

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
  late UserSettings userSettings;

  void _update(UserSettings userSettings) {
    setState(() {
      this.userSettings = userSettings;
    });
    if (Hive.isBoxOpen("UserSettings")) {
      Hive.box<UserSettings>("UserSettings").put(
        "userSettings",
        userSettings,
      );
    }
  }

  void _changeTheme(SelectedTheme? selectedTheme) {
    UserSettings newUserSettings = UserSettingsImpl();
    newUserSettings.selectedTheme = selectedTheme;
    newUserSettings.subscriptionType = userSettings.subscriptionType;
    setState(() {
      userSettings = newUserSettings;
    });
    if (Hive.isBoxOpen("UserSettings")) {
      Hive.box<UserSettings>("UserSettings").put(
        "userSettings",
        userSettings,
      );
    }
  }

  void _changeSubscription(SubscriptionType? subscriptionType) {
    UserSettings newUserSettings = UserSettingsImpl();
    newUserSettings.selectedTheme = userSettings.selectedTheme;
    newUserSettings.subscriptionType = subscriptionType;
    setState(() {
      userSettings = newUserSettings;
    });
    if (Hive.isBoxOpen("UserSettings")) {
      Hive.box<UserSettings>("UserSettings").put(
        "userSettings",
        userSettings,
      );
    }
  }

  @override
  void initState() {
    userSettings = Hive.box<UserSettings>("UserSettings").get(
      "userSettings",
      defaultValue: UserSettingsImpl(),
    )!;
    super.initState();
  }

  @override
  void dispose() {
    try {
      if (Hive.isBoxOpen("UserSettings")) {
        Hive.box<UserSettings>("UserSettings").put(
          "userSettings",
          userSettings,
        );
      }
    } on HiveError catch (error) {
      print(error.message);
    }
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.detached) dispose();

    super.didChangeAppLifecycleState(state);
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
  final UserSettings userSettings;

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
      oldWidget.userSettings != userSettings;
}
