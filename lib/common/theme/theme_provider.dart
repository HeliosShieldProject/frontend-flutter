import 'package:flutter/material.dart';

import 'package:Helios/bloc/user_settings/state/user_settings.dart';

import 'package:Helios/common/user_settings/user_settings_provider.dart';

import 'package:Helios/common/theme/utils/get_theme.dart';

class AppTheme extends StatefulWidget {
  const AppTheme({super.key, required this.child});

  final Widget child;

  static ThemeData of(BuildContext context, {bool listen = false}) =>
      _AppThemeInheritedWidget.of(context, listen: listen).theme;

  @override
  State<AppTheme> createState() => _AppThemeState();
}

class _AppThemeState extends State<AppTheme> {
  late ThemeData theme;

  @override
  void didChangeDependencies() {
    UserSettings appUserSettings = AppUserSettings.of(context, listen: true);
    theme = getTheme(appUserSettings.selectedTheme);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return _AppThemeInheritedWidget(
      theme: theme,
      state: this,
      child: widget.child,
    );
  }
}

class _AppThemeInheritedWidget extends InheritedWidget {
  const _AppThemeInheritedWidget({
    super.key,
    required this.theme,
    required this.state,
    required super.child,
  });

  final _AppThemeState state;
  final ThemeData theme;

  static _AppThemeInheritedWidget? maybeof(BuildContext context,
          {bool listen = false}) =>
      listen
          ? context
              .dependOnInheritedWidgetOfExactType<_AppThemeInheritedWidget>()
          : context.getInheritedWidgetOfExactType<_AppThemeInheritedWidget>();

  static _AppThemeInheritedWidget of(BuildContext context,
          {bool listen = false}) =>
      maybeof(context, listen: listen)!;

  @override
  bool updateShouldNotify(_AppThemeInheritedWidget oldWidget) =>
      theme.brightness != oldWidget.theme.brightness;
}
