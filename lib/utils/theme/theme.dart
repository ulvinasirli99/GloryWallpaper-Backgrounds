import 'package:flutter/material.dart';

final darkTheme = ThemeData(
  primarySwatch: Colors.grey,
  primaryColor: Colors.black,
  brightness: Brightness.dark,
  backgroundColor: const Color(0xFF212121),
  accentColor: Colors.white,
  accentIconTheme: IconThemeData(color: Colors.black),
  dividerColor: Colors.black12,
);

final lightTheme = ThemeData(
  primarySwatch: Colors.grey,
  primaryColor: Colors.white,
  brightness: Brightness.light,
  backgroundColor: const Color(0xFFE5E5E5),
  accentColor: Colors.black,
  accentIconTheme: IconThemeData(color: Colors.white),
  dividerColor: Colors.white54,
);

final setLightTheme = _buildLightTheme();
final setDarkTheme = _buildDarkTheme();

ThemeData _buildLightTheme() {
  return ThemeData(
    primarySwatch: Colors.grey,
    primaryColor: Colors.white,
    brightness: Brightness.light,
    backgroundColor: const Color(0xFFE5E5E5),
    accentColor: Colors.black,
    accentIconTheme: IconThemeData(color: Colors.white),
    dividerColor: Colors.white54,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.lightBlue[900],
      selectedIconTheme: IconThemeData(color: Colors.white),
    ),
  );
}

ThemeData _buildDarkTheme() {
  return ThemeData(
    primarySwatch: Colors.yellow,
    primaryColor:
         Colors.black,//Todo AppBar Color and textFields colors.....
    backgroundColor: Colors.orange,
    scaffoldBackgroundColor: Colors.black,
    accentColor:
        Colors.white, //Todo Icon Colors and drarwer menu toglle icon color
    accentIconTheme: IconThemeData(color: Colors.deepPurple),
    dividerColor: Colors.red,
    bottomAppBarColor: Colors.white,
    bottomAppBarTheme: BottomAppBarTheme(color: Colors.white),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedIconTheme: IconThemeData(color: Colors.yellow),
    ),
  );
}
