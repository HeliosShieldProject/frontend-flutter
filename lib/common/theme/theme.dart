import 'package:flutter/material.dart';

final ThemeData darkTheme = ThemeData(
  colorScheme: const ColorScheme.dark(
    primary: Color(0xFFACB823),
    secondary: Color(0xFF83847D),
    background: Color.fromARGB(255, 0, 0, 0),
    onBackground: Color.fromARGB(255, 255, 255, 255),
    surface: Color(0xFF262626),
    onSurface: Color.fromARGB(255, 62, 62, 62),
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
      fontFamily: 'Ubuntu',
      fontWeight: FontWeight.w500,
    ),
    headlineMedium: TextStyle(
      color: Colors.white,
      fontSize: 18,
      fontFamily: 'Ubuntu',
      fontWeight: FontWeight.w500,
    ),
    bodyMedium: TextStyle(
      color: Color.fromARGB(128, 255, 255, 255),
      fontSize: 13,
      fontFamily: 'Ubuntu',
      fontWeight: FontWeight.w500,
    ),
    bodyLarge: TextStyle(
      color: Colors.white,
      fontSize: 16,
      fontFamily: 'Ubuntu',
      fontWeight: FontWeight.w500,
    ),
  ),
  appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.white,
      elevation: 0),
  scaffoldBackgroundColor: Colors.black,
);

final ThemeData lightTheme = ThemeData(
  colorScheme: const ColorScheme.light(
    primary: Color(0xFFACB823),
    secondary: Color(0xFF83847D),
    background: Color.fromARGB(255, 255, 255, 255),
    onBackground: Color.fromARGB(255, 0, 0, 0),
    surface: Color(0xFF262626),
    onSurface: Color.fromARGB(255, 62, 62, 62),
  ),
  textTheme: const TextTheme(
    displayMedium: TextStyle(
      color: Colors.black,
      fontFamily: 'Ubuntu',
      fontSize: 12,
    ),
    labelMedium: TextStyle(
      color: Colors.white,
      fontSize: 18,
      fontFamily: 'Ubuntu',
      fontWeight: FontWeight.w500,
    ),
    headlineMedium: TextStyle(
      color: Colors.black,
      fontSize: 18,
      fontFamily: 'Ubuntu',
      fontWeight: FontWeight.w500,
    ),
    bodyMedium: TextStyle(
      color: Color.fromARGB(128, 255, 255, 255),
      fontSize: 13,
      fontFamily: 'Ubuntu',
      fontWeight: FontWeight.w500,
    ),
    bodyLarge: TextStyle(
      color: Colors.white,
      fontSize: 16,
      fontFamily: 'Ubuntu',
      fontWeight: FontWeight.w500,
    ),
  ),
  appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.white,
      elevation: 0),
  scaffoldBackgroundColor: Colors.white,
);
