import 'dart:ui';

import '/Resources/Styles/Colors/dark.dart' as dark;
import '/Resources/Styles/Colors/light.dart' as light;

class ThemeColorsManager {
  final Brightness brightness;
  ThemeColorsManager(this.brightness);

  Color get primary => brightness == Brightness.dark
      ? dark.FontColors.primary
      : light.FontColors.primary;

  Color get secondary => brightness == Brightness.dark
      ? dark.FontColors.secondary
      : light.FontColors.secondary;

  Color get darkPrimary => brightness == Brightness.dark
      ? dark.FontColors.darkPrimary
      : light.FontColors.darkPrimary;

  Color get aryanText => brightness == Brightness.dark
      ? dark.FontColors.aryanText
      : light.FontColors.aryanText;

  Color get listTitlePrimary => brightness == Brightness.dark
      ? dark.FontColors.listTitlePrimary
      : light.FontColors.listTitlePrimary;

  Color get listContentTitlePrimary => brightness == Brightness.dark
      ? dark.FontColors.listContentTitlePrimary
      : light.FontColors.listContentTitlePrimary;

  Color get listContentPrimary => brightness == Brightness.dark
      ? dark.FontColors.listContentSecondary
      : light.FontColors.listContentSecondary;

  Color get aryanBorder => brightness == Brightness.dark
      ? dark.FontColors.aryanTextBorderColor
      : light.FontColors.aryanTextBorderColor;

  Color get aryanOrdinaryWhite => brightness == Brightness.dark
      ? dark.FontColors.ordinaryWhite
      : light.FontColors.ordinaryWhite;
}
