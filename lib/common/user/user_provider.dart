import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:Helios/common/interafces/user.dart';
import '../../repositories/local_repository/user/models/user_impl.dart';

class AppUser extends StatefulWidget {
  const AppUser({
    super.key,
    required this.child,
  });

  final Widget child;

  static User? of(BuildContext context, {bool listen = false}) =>
      _AppUserInheritedWidget.of(context, listen: listen).user;

  static void update(BuildContext context, User user) {
    _AppUserInheritedWidget.of(context).state._update(user);
  }

  @override
  State<AppUser> createState() => _AppUserState();
}

class _AppUserState extends State<AppUser> with WidgetsBindingObserver {
  late User user;

  void _update(User user) {
    setState(() {
      this.user = user;
    });
    if (Hive.isBoxOpen("User")) {
      Hive.box<User>("User").put(
        "user",
        user,
      );
    }
  }

  @override
  void initState() {
    user = Hive.box<User>("User").get(
      "user",
      defaultValue: UserImpl(),
    )!;
    super.initState();
  }

  @override
  void dispose() {
    try {
      if (Hive.isBoxOpen("User")) {
        Hive.box<User>("User").put(
          "user",
          user,
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
  Widget build(BuildContext context) => _AppUserInheritedWidget(
        user: user,
        state: this,
        child: widget.child,
      );
}

class _AppUserInheritedWidget extends InheritedWidget {
  const _AppUserInheritedWidget({
    super.key,
    required this.state,
    required this.user,
    required super.child,
  });

  final _AppUserState state;
  final User user;

  static _AppUserInheritedWidget? maybeof(BuildContext context,
          {bool listen = false}) =>
      listen
          ? context
              .dependOnInheritedWidgetOfExactType<_AppUserInheritedWidget>()
          : context.getInheritedWidgetOfExactType<_AppUserInheritedWidget>();

  static _AppUserInheritedWidget of(BuildContext context,
          {bool listen = false}) =>
      maybeof(context, listen: listen)!;

  @override
  bool updateShouldNotify(covariant _AppUserInheritedWidget oldWidget) =>
      oldWidget.user != user;
}
