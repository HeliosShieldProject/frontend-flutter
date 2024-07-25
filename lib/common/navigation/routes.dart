import 'package:flutter/material.dart';

abstract interface class RouteNames {
  static const String splash = "/splash"; 
  static const String welcome = "/welcome";
  static const String login = "/login";
  static const String reg = "/reg";
  static const String home = "/";
  static const String settings = "/settings";
  static const String subscription = "/sub";
  static const String history = "/history";
  static const String password = "/password";
}

abstract class RoutesBuilder {
  static final routesBuilder = <String, Widget Function(BuildContext)> {
    RouteNames.welcome: (_) => ,
    RouteNames.login: (_) => ,

  };

  static Route<Object?>? onGenerateRoute(RouteSettings settings) {
    return switch(settings.name) {
      
      RouteNames.splash => ,
      null => throw UnimplementedError(),
      String() => throw UnimplementedError(),
    }
  }

}

class NavigationManager {
  NavigationManager._();

  static final NavigationManager instance = NavigationManager._();

  final GlobalKey<NavigatorState> _navigator = GlobalKey<NavigatorState>();

  
}