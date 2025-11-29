import 'package:flutter/material.dart';

class LightColorTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: FontColors.aryanWhite,

    primaryColor: FontColors.primary,
    hintColor: FontColors.secondary,
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: FontColors.aryanTextBackgroundColor,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: FontColors.aryanTextBorderColor,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: FontColors.darkPrimary, width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
      hintStyle: TextStyle(color: FontColors.secondary, fontSize: 12),
    ),

    textTheme: TextTheme(
      bodyLarge: TextStyle(color: FontColors.primary, fontSize: 16),
      bodyMedium: TextStyle(color: FontColors.secondary, fontSize: 14),
      bodySmall: TextStyle(color: FontColors.aryanWhite, fontSize: 12),
    ),

    appBarTheme: AppBarTheme(
      backgroundColor: FontColors.aryanWhite,
      elevation: 0,
      titleTextStyle: TextStyle(
        color: FontColors.darkPrimary,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
      iconTheme: IconThemeData(color: FontColors.darkPrimary),
    ),

    dividerColor: FontColors.aryanTextBorderColor,
    cardColor: FontColors.aryanTextBackgroundColor,
  );
}

class FontColors {
  static const Color _primary = Color(0xFF585858);
  static const Color _secondary = Color(0xFF767676);
  static const Color _dark = Color(0xFF050505);
  static const Color _aryanTextBackgroundColor = Color(0xFFF4F4F4);
  static const Color _aryanTextBorderColor = Color(0xFFCECECE);
  static const Color _aryanTextHintColor = Color(0xFF939393);
  static const Color _white = Color(0XFFFFFFFF);
  static const Color _cromeWite = Color(0XFFFBFBFB);
  static const Color _counterTheme = Color(0XFF333333);
  static const Color _linkColor = Color(0XFF086EDC);

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

  static Color get ordinaryWhite => _cromeWite;

  static Color get aryanWhite => _white;

  static Color get aryanLinkColor => _linkColor;

  static Color get counterTheme => _counterTheme;
}
