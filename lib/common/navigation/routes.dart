import 'package:flutter/material.dart';
import 'package:helios/app/app.dart';
import 'package:helios/welcome/welcome.dart';

abstract interface class RouteNames {
  static const String welcome = "/welcome";
  static const String login = "/login";
  static const String reg = "/reg";
  static const String home = "/home";
  static const String settings = "/settings";
  static const String subscription = "/sub";
  static const String history = "/history";
  static const String password = "/password";
}

abstract class RoutesBuilder {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case (RouteNames.welcome):
        print("Welcome onGenerateRoute");
        return MaterialPageRoute(
          builder: (_) => const WelcomeScreen(),
          settings: settings,
        );
      case (RouteNames.home):
        print("Home onGenerateRoute");
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
          settings: settings,
        );
    }

    return null;
  }

  static Route<dynamic>? onUnknownRoute(RouteSettings settings) =>
      MaterialPageRoute(
        builder: (_) => const Placeholder(),
        settings: settings,
      );
}
