import 'package:flutter/material.dart';
import 'package:Helios/features/register_sign_in/views/registration_page.dart';
import 'package:Helios/features/settings/views/settings_page.dart';
import 'package:Helios/features/unknown/views/unknown_page.dart';
import 'package:Helios/features/register_sign_in/views/welcome_page.dart';
import 'package:Helios/features/register_sign_in/views/login_page.dart';
import 'package:Helios/features/vpn_app/views/home_page.dart';

abstract interface class RouteNames {
  static const String welcome = "/welcome";
  static const String login = "/login";
  static const String reg = "/reg";
  static const String home = "/home";
  static const String settings = "/settings";
  static const String subscription = "/sub";
  static const String history = "/history";
  static const String password = "/password";
  static const String appearance = "/appearance";
}

abstract class RoutesBuilder {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case (RouteNames.welcome):
        print("Welcome onGenerateRoute");
        return MaterialPageRoute(
          builder: (_) => const WelcomePage(),
          settings: settings,
        );
      case (RouteNames.home):
        print("Home onGenerateRoute");
        return MaterialPageRoute(
          builder: (_) => const HomePage(),
          settings: settings,
        );
      case (RouteNames.login):
        print("Login onGenerateRoute");
        return MaterialPageRoute(
          builder: (_) => const LoginPage(),
          settings: settings,
        );
      case (RouteNames.reg):
        print("Reg onGenerateRoute");
        return MaterialPageRoute(
          builder: (_) => const RegistrationPage(),
          settings: settings,
        );
      case (RouteNames.settings):
        print("Settings onGenerateRoute");
        return MaterialPageRoute(
          builder: (_) => const SettingsPage(),
          settings: settings,
        );
    }

    return null;
  }

  static Route<dynamic>? onUnknownRoute(RouteSettings settings) =>
      MaterialPageRoute(
        builder: (_) => const UnknownPage(),
        settings: settings,
      );
}
