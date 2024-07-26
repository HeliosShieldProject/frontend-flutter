import 'package:flutter/material.dart';

class NavigationManager {
  NavigationManager._();

  static final NavigationManager instance = NavigationManager._();

  static final GlobalKey<NavigatorState> key = GlobalKey<NavigatorState>();

  final NavigatorState _navigator = key.currentState!;

  Future<Object?> push(String name, {Object? arguments}) {
    return _navigator.pushNamed(name, arguments: arguments);
  }

  void pop({Object? result}) {
    _navigator.pop(result);
  }

  Future<Object?> pushAndPopAll(String name, {Object? arguments}) {
    return _navigator.pushNamedAndRemoveUntil(name, (_) => false,
        arguments: arguments);
  }

  Future<Object?> pushReplacement(String name, {Object? arguments}) {
    return _navigator.popAndPushNamed(name, arguments: arguments);
  }
}
