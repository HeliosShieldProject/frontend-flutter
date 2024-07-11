import 'package:flutter/material.dart';
import 'user.dart';

class AppUser extends StatefulWidget {
  const AppUser({
    super.key, 
    required this.user,
    required this.child,
  });

  final User user;
  final Widget child;

  static User of(BuildContext context, {bool listen = false}) => 
    _AppUserInheritedWidget.of(context, listen: listen).user;

  @override
  State<AppUser> createState() => _AppUserState();
}

class _AppUserState extends State<AppUser> {
  User? user;

  @override
  Widget build(BuildContext context) => _AppUserInheritedWidget(
    user: user ?? widget.user, 
    state: this, 
    child: widget.child,
  );
}


class _AppUserInheritedWidget extends InheritedWidget {
  const _AppUserInheritedWidget({
    required this.state,
    required this.user,
    required super.child,
  });

  final State state;
  final User user;

  static _AppUserInheritedWidget? maybeof(BuildContext context, {bool listen = false}) => listen 
    ?
    context.dependOnInheritedWidgetOfExactType<_AppUserInheritedWidget>()
    :
    context.getInheritedWidgetOfExactType<_AppUserInheritedWidget>();

  static _AppUserInheritedWidget of(BuildContext context, {bool listen = false}) => maybeof(
    context, 
    listen: listen
  )!;  

  @override
  bool updateShouldNotify(covariant _AppUserInheritedWidget oldWidget) => oldWidget.user != user; 
}