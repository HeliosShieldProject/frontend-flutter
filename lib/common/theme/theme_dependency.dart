import 'package:flutter/material.dart';
import 'package:helios/common/common.dart';
import 'theme.dart';

class AppTheme extends StatefulWidget {
  const AppTheme({
    super.key,
    required this.theme,
    required this.child,
  });

  final Widget child;
  final MyTheme theme;

  static MyTheme of(BuildContext context, {bool listen = false}) => 
    _ThemeInheritedWidget.of(context, listen: listen).theme;

  static void update(BuildContext context, MyTheme theme) {
    _ThemeInheritedWidget.of(context).state._update(theme);
  }

  @override
  State<AppTheme> createState() => _AppThemeState();
}

class _AppThemeState extends State<AppTheme> {
  MyTheme? theme; 

  void _update(MyTheme theme) {
    setState(() {
      this.theme = theme;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _ThemeInheritedWidget(
      theme: theme ?? widget.theme,
      state: this,
      child: widget.child,
    );
  }
}

 @immutable
class _ThemeInheritedWidget extends InheritedWidget {
  const _ThemeInheritedWidget({
    required this.theme,
    required this.state,
    required super.child,
  });

  final MyTheme theme;
  final _AppThemeState state;
  
  static _ThemeInheritedWidget? maybeof(BuildContext context, {bool listen = false}) => 
    listen ? 
    context.dependOnInheritedWidgetOfExactType<_ThemeInheritedWidget>() 
    : context.getInheritedWidgetOfExactType<_ThemeInheritedWidget>();

  static _ThemeInheritedWidget of(BuildContext context, {bool listen = false}) =>
    maybeof(context, listen: listen)!;

  @override
  bool updateShouldNotify(_ThemeInheritedWidget oldWidget) => 
    theme.isLight != oldWidget.theme.isLight;
}


