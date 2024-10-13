import 'package:flutter/material.dart';

const String fontFamily = "Ubuntu";

final ThemeData darkTheme = ThemeData(
  colorScheme: const ColorScheme.dark(
    primary: Color(0xFFACB823),
    secondary: Color(0xFF83847D),
    surface: Colors.black,
    onSurface: Colors.white,
    tertiary: Color(0xFF262626),
    onTertiary: Color.fromARGB(255, 62, 62, 62),
  ),
  textTheme: const TextTheme(
    titleLarge: TextStyle(
      color: Colors.white,
      fontFamily: fontFamily,
      fontSize: 18,
      fontWeight: FontWeight.w500,
    ),
    titleMedium: TextStyle(
      color: Colors.white,
      fontFamily: fontFamily,
      fontSize: 16,
      fontWeight: FontWeight.w500,
    ),
    labelMedium: TextStyle(
      color: Colors.white,
      fontFamily: fontFamily,
      fontSize: 13,
      fontWeight: FontWeight.w500,
    ),
    bodyMedium: TextStyle(
      color: Color(0x80FFFFFF),
      fontFamily: fontFamily,
      fontSize: 13,
      fontWeight: FontWeight.w300,
    ),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.transparent,
    foregroundColor: Colors.white,
    elevation: 0,
  ),
  scaffoldBackgroundColor: Colors.black,
);

final ThemeData lightTheme = ThemeData(
  colorScheme: const ColorScheme.light(
    primary: Color(0xFFACB823),
    secondary: Color(0xFF83847D),
    surface: Color.fromARGB(255, 255, 255, 255),
    onSurface: Color.fromARGB(255, 0, 0, 0),
    tertiary: Color(0xFF262626),
    onTertiary: Color.fromARGB(255, 62, 62, 62),
  ),
  textTheme: const TextTheme(
    titleLarge: TextStyle(
      color: Colors.black,
      fontFamily: fontFamily,
      fontSize: 18,
      fontWeight: FontWeight.w500,
    ),
    titleMedium: TextStyle(
      color: Colors.black,
      fontFamily: fontFamily,
      fontSize: 16,
      fontWeight: FontWeight.w500,
    ),
    labelMedium: TextStyle(
      color: Colors.black,
      fontFamily: fontFamily,
      fontSize: 13,
      fontWeight: FontWeight.w500,
    ),
    bodyMedium: TextStyle(
      color: Color(0x80FFFFFF),
      fontFamily: fontFamily,
      fontSize: 13,
      fontWeight: FontWeight.w300,
    ),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.transparent,
    foregroundColor: Colors.black,
    elevation: 0,
  ),
  scaffoldBackgroundColor: Colors.white,
);
