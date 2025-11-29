import 'package:flutter/material.dart';

import '../Theme/theme_manager.dart';

abstract class AryanText {
  static ThemeColorsManager get defaultColors =>
      ThemeColorsManager(ThemeManager.themeMode);

  static TextStyle primaryStyle([ThemeColorsManager? colors]) {
    colors ??= defaultColors;
    return TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      fontFamily: 'IRANSansX',
      color: colors.primary,
    );
  }

  static TextStyle primButtonTextStyle([ThemeColorsManager? colors]) {
    colors ??= defaultColors;
    return TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      fontFamily: 'IRANSansX',
      color: colors.aryanOrdinaryWhite,
    );
  }

  static TextStyle listTitleStyle([ThemeColorsManager? colors]) {
    colors ??= defaultColors;
    return TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: colors.listTitlePrimary,
    );
  }

  static TextStyle listContentTitleStyle([ThemeColorsManager? colors]) {
    colors ??= defaultColors;
    return TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: colors.listContentTitlePrimary,
    );
  }

  static TextStyle listContentStyle([ThemeColorsManager? colors]) {
    colors ??= defaultColors;
    return TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      fontFamily: 'Yekan',
      color: colors.listContentPrimary,
    );
  }

  static TextStyle darkStyle([ThemeColorsManager? colors]) {
    colors ??= defaultColors;
    return TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      fontFamily: 'Yekan',
      color: colors.listTitlePrimary,
    );
  }

  static TextStyle secondary([ThemeColorsManager? colors]) {
    colors ??= defaultColors;
    return TextStyle(
      fontSize: 14,
      leadingDistribution: TextLeadingDistribution.proportional,
      fontStyle: FontStyle.normal,
      height: 1,
      fontWeight: FontWeight.w500,
      fontFamily: 'Yekan',
      color: colors.primary,
    );
  }
}
