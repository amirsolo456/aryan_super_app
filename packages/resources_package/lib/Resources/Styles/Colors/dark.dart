import 'package:flutter/material.dart';

class DarkColorTheme {
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: FontColors.darkBackground,
    primaryColor: FontColors.darkTextPrimary,
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: FontColors.darkTextPrimary, fontSize: 16),
      bodyMedium: TextStyle(color: FontColors.darkTextSecondary, fontSize: 14),
      bodySmall: TextStyle(color: FontColors.darkTextSecondary, fontSize: 12),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: FontColors.darkSurface,

      hintStyle: TextStyle(color: FontColors.darkTextSecondary, fontSize: 12),

      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),

      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: FontColors.darkBorder, width: 1),
      ),

      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: FontColors.darkTextPrimary, width: 2),
      ),
    ),

    appBarTheme: AppBarTheme(
      backgroundColor: FontColors.darkSurface,
      elevation: 0,
      titleTextStyle: TextStyle(
        color: FontColors.darkTextPrimary,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
      iconTheme: IconThemeData(color: FontColors.darkTextPrimary),
    ),

    dividerColor: FontColors.darkBorder,
    cardColor: FontColors.darkSurface,
  );
}

class FontColors {
  static const Color _primary = Color(0xFF585858);
  static const Color _secondary = Color(0xFF767676);
  static const Color _dark = Color(0xFF050505);
  static const Color _aryanTextBackgroundColor = Color(0xFFF4F4F4);
  static const Color _aryanTextBorderColor = Color(0xFFCECECE);
  static const Color _white = Color(0XFFFBFBFB);
  static const Color _counterTheme = Color(0XFFF9F9F9);
  static const Color _darkBackground = Color(0xFF121212);
  static const Color _darkSurface = Color(0xFF1E1E1E);
  static const Color _darkTextPrimary = Color(0xFFE8E8E8);
  static const Color _darkTextSecondary = Color(0xFFBEBEBE);
  static const Color _darkBorder = Color(0xFF3A3A3A);
  static const Color _aryanTextHintColor = Color(0xFF939393);
  static const Color _linkColor = Color(0XFF086EDC);

  // Dark getters
  static Color get darkBackground => _darkBackground;
  static Color get darkSurface => _darkSurface;
  static Color get darkTextPrimary => _darkTextPrimary;
  static Color get darkTextSecondary => _darkTextSecondary;
  static Color get darkBorder => _darkBorder;

  static Color get primary => _primary;
  static Color get listTitlePrimary => _primary;
  static Color get listContentTitlePrimary => _primary;

  static Color get aryanText => _aryanTextBackgroundColor;
  static Color get aryanTextHintColor => _aryanTextHintColor;
  static Color get aryanTextBackgroundColor => _aryanTextBackgroundColor;

  static Color get aryanTextBorderColor => _aryanTextBorderColor;

  static Color get secondary => _secondary;
  static Color get listContentSecondary => _secondary;

  static Color get darkPrimary => _dark;

  static Color get aryanLinkColor => _linkColor;

  static Color get ordinaryWhite => _white;

  static Color get counterTheme => _counterTheme;
}
