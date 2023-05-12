import 'package:flutter/material.dart';

class ThemeClass {
  static Color lightPrimaryColor = Colors.white;
  static Color darkPrimaryColor = Colors.black;
  // 渐变色
  static Color secondaryColor = Colors.white;

  static ThemeData lightTheme = ThemeData(
    primaryColor: ThemeData.light().scaffoldBackgroundColor,
    colorScheme: const ColorScheme.light().copyWith(
      primary: lightPrimaryColor,
      secondary: secondaryColor,
    ),
  );
  static ThemeData darkTheme = ThemeData(
    primaryColor: ThemeData.dark().scaffoldBackgroundColor,
    colorScheme: const ColorScheme.dark().copyWith(
      primary: darkPrimaryColor,
      secondary: secondaryColor,
    ),
  );
}
