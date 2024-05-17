import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

var myDarkTheme = ThemeData(
  brightness: Brightness.dark,
  colorScheme: const ColorScheme.dark(
    primary: Color(0xFFACB823),
    secondary: Color(0xFF83847D), 
    background: Color.fromARGB(255, 0, 0, 0), 
    onBackground: Color.fromARGB(255, 255, 255, 255), 
    surface: Color(0xFF262626), 
    onSurface: Color.fromARGB(128, 255, 255, 255)
  ),
  textTheme: GoogleFonts.ubuntuTextTheme(
    const TextTheme(
      bodyMedium: TextStyle(color: Colors.white),
    ),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.transparent,
    foregroundColor: Colors.white,
    elevation: 0
  ),
);