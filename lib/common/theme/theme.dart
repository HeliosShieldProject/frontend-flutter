import 'package:flutter/material.dart';

class MyTheme {
  const MyTheme({
    required this.theme,
    required this.isLight,
  });

  final ThemeData? theme; 
  final bool? isLight;
}

final MyTheme darkTheme = MyTheme(
  theme: ThemeData(
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFFACB823),
      secondary: Color(0xFF83847D), 
      background: Color.fromARGB(255, 0, 0, 0), 
      onBackground: Color.fromARGB(255, 255, 255, 255), 
      surface: Color(0xFF262626), 
      onSurface: Color.fromARGB(128, 255, 255, 255)
    ),
    textTheme: const TextTheme(
      displayMedium: TextStyle(
        color: Colors.black,
        fontFamily: 'Ubuntu'
        ),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.white,
      elevation: 0
    ),
    elevatedButtonTheme: const ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor:  MaterialStatePropertyAll<Color>(Colors.white),
      ), 
    ),
  ),
  isLight: false,
);

final MyTheme lightTheme = MyTheme(
  theme: ThemeData(
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFFACB823),
      secondary: Color(0xFF83847D), 
      background: Color.fromARGB(255, 255, 255, 255), 
      onBackground: Color.fromARGB(255, 0, 0, 0), 
      surface: Color(0xFF262626), 
      onSurface: Color.fromARGB(128, 255, 255, 255)
    ),
    textTheme: const TextTheme(
      displayMedium: TextStyle(
        color: Color.fromARGB(255, 255, 255, 255),
        fontFamily: 'Ubuntu'
        ),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.white,
      elevation: 0
    ),
    elevatedButtonTheme: const ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor:  MaterialStatePropertyAll<Color>(Colors.black),
      ), 
    ),
  ),
  isLight: true,
);
