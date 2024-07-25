import 'package:flutter/material.dart';
import 'package:helios/common/common.dart';

class AppTheme extends StatefulWidget {
  const AppTheme({super.key, required this.child});

  final Widget child;

  static MyTheme of(BuildContext context, {bool listen = false}) =>
      _AppThemeInheritedWidget.of(context, listen: listen).theme;

  @override
  State<AppTheme> createState() => _AppThemeState();
}

class _AppThemeState extends State<AppTheme> {
  MyTheme? theme;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    UserSettings? appUserSettings = AppUserSettings.of(context, listen: true);
    theme = getTheme((appUserSettings ?? UserSettingsImpl()).selectedTheme);
  }

  @override
  Widget build(BuildContext context) {
    return _AppThemeInheritedWidget(
        theme: theme!, state: this, child: widget.child);
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
  final MyTheme theme;

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
      theme.isLight != oldWidget.theme.isLight;
}
