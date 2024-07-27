import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import '../common.dart';

class MyTheme {
  const MyTheme({
    required this.themeData,
    required this.isLight,
  });

  final ThemeData themeData;
  final bool isLight;
}

MyTheme getTheme(SelectedTheme? theme) => switch (theme) {
      (SelectedTheme.system) =>
        SchedulerBinding.instance.platformDispatcher.platformBrightness ==
                Brightness.dark
            ? darkTheme
            : lightTheme,
      (SelectedTheme.dark) => darkTheme,
      (SelectedTheme.light) => lightTheme,
      (null) => throw ("Unknown behaviour"),
    };

final MyTheme darkTheme = MyTheme(
  themeData: ThemeData(
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFFACB823),
      secondary: Color(0xFF83847D),
      background: Color.fromARGB(255, 0, 0, 0),
      onBackground: Color.fromARGB(255, 255, 255, 255),
      surface: Color(0xFF262626),
      onSurface: Color.fromARGB(128, 255, 255, 255),
    ),
    textTheme: const TextTheme(
      displayMedium: TextStyle(
        color: Colors.white,
        fontFamily: 'Ubuntu',
        fontSize: 12,
      ),
      labelMedium: TextStyle(
        color: Colors.black,
        fontSize: 18,
        fontWeight: FontWeight.w500,
      ),
      bodyMedium: TextStyle(
        color: Color.fromARGB(128, 255, 255, 255),
        fontSize: 13,
        fontWeight: FontWeight.w500,
      ),
    ),
    appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        elevation: 0),
  ),
  isLight: false,
);

final MyTheme lightTheme = MyTheme(
  themeData: ThemeData(
    colorScheme: const ColorScheme.dark(
        primary: Color(0xFFACB823),
        secondary: Color(0xFF83847D),
        background: Color.fromARGB(255, 255, 255, 255),
        onBackground: Color.fromARGB(255, 0, 0, 0),
        surface: Color(0xFF262626),
        onSurface: Color.fromARGB(128, 255, 255, 255)),
    textTheme: const TextTheme(
        displayMedium: TextStyle(color: Colors.black, fontFamily: 'Ubuntu'),
        labelMedium: TextStyle(
            color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500)),
    appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        elevation: 0),
  ),
  isLight: true,
);
