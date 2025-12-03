import 'package:flutter/material.dart';

/*
class AppColors {
  static const Color primary = Color(0xFF8E7CFF);
  static const Color primaryDark = Color(0xFF6A5ACD);
  static const Color secondary = Color(0xFF2A2440);
  static const Color aryanText = Color(0xFFE0E0E0);
}
*/

class FontColors {
  static const Color _primary = Color(0xFF585858);
  static const Color _secondary = Color(0xFF767676);
  static const Color _dark = Color(0xFF050505);
  static const Color _aryanTextBackgroundColor = Color(0xFFF4F4F4);
  static const Color _aryanTextBorderColor = Color(0xFFCECECE);
  static const Color _white = Color(0XFFFBFBFB);
  static const Color _counterTheme = Color(0XFF333333);

  static Color get primary => _primary;
  static Color get listTitlePrimary => _primary;
  static Color get listContentTitlePrimary => _primary;

  static Color get aryanText => _aryanTextBackgroundColor;
  static Color get aryanTextBackgroundColor => _aryanTextBackgroundColor;

  static Color get aryanTextBorderColor => _aryanTextBorderColor;

  static Color get secondary => _secondary;
  static Color get listContentSecondary => _secondary;

  static Color get darkPrimary => _dark;

  static Color get ordinaryWhite => _white;

  static Color get counterTheme => _counterTheme;
}
