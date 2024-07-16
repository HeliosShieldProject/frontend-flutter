import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'user.dart';

class AppUser extends StatefulWidget {
  const AppUser({
    super.key, 
    required this.child,
  });

  final Widget child;

  static void update(BuildContext context, User user) {
    _AppUserInheritedWidget.of(context).state._update(user);
  }

  static User? of(BuildContext context, {bool listen = false}) => 
    _AppUserInheritedWidget.of(context, listen: listen).user;

  @override
  State<AppUser> createState() => _AppUserState();
}

class _AppUserState extends State<AppUser> {
  User? user;

  @override
  void initState() {
    super.initState();
    Hive.openBox<User>("User")
      .then(
        (value) {
          setState(() {
            user = value.get(
              "user",
              defaultValue: UserImpl(),
            );
          });
        }
    );
  }

  @override 
  void dispose() {
    super.dispose();
    try{
      Hive.box("User")
        ..put("user", user)
        ..close();
    } on HiveError catch(error) {
      print(error.message);
    }
    
  }

  void _update(User user) {
    setState(() {
      this.user = user;     
    });
  }

  @override
  Widget build(BuildContext context) => _AppUserInheritedWidget(
    user: user, 
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

  final _AppUserState state;
  final User? user;

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
  bool updateShouldNotify(covariant _AppUserInheritedWidget oldWidget) => 
    oldWidget.user != user; 
}