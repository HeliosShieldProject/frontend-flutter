import 'package:flutter/material.dart';
import 'user.dart';

class AppUser extends StatefulWidget {
  const AppUser({super.key});

  @override
  State<AppUser> createState() => _AppUserState();
}

class _AppUserState extends State<AppUser> {


  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}


class _AppUserInheritedWidget extends InheritedWidget {
  _AppUserInheritedWidget({
    required this.state,
    required this.user,
    required super.child,
  });

  State state;
  User user = UserImpl();

  _AppUserInheritedWidget? maybeof(BuildContext context, {bool listen = false}) => listen 
    ?
    context.dependOnInheritedWidgetOfExactType<_AppUserInheritedWidget>()
    :
    context.getInheritedWidgetOfExactType<_AppUserInheritedWidget>();

  _AppUserInheritedWidget of(BuildContext context, {bool listen = false}) =>
    maybeof(context, listen: listen)!;  

  @override
  bool updateShouldNotify(covariant _AppUserInheritedWidget oldWidget) => oldWidget.user != user; 
}