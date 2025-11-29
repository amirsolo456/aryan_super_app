import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '/Resources/Styles/Colors/dark.dart' as dark;
import '/Resources/Styles/Colors/light.dart' as light;
import '../Styles/Colors/dark.dart';
import '../Styles/Colors/light.dart';

class ThemeManager {
  static final ValueNotifier<ThemeMode> mode = ValueNotifier<ThemeMode>(
    ThemeMode.light,
  );

  static ThemeColorsManager get colors =>
      ThemeColorsManager(ThemeManager.themeMode);

  static SharedPreferences? _prefs;
  static const _prefKey = 'app_theme_mode';

  static Future<void> init({ThemeMode fallback = ThemeMode.light}) async {
    _prefs = await SharedPreferences.getInstance();
    final saved = _prefs!.getString(_prefKey);
    if (saved == 'dark') {
      mode.value = ThemeMode.dark;
    } else if (saved == 'system') {
      mode.value = ThemeMode.system;
    } else if (saved == 'light') {
      mode.value = ThemeMode.light;
    } else {
      mode.value = fallback;
    }
  }

  static ThemeMode get themeMode => mode.value;

  static Future<void> setTheme(ThemeMode newMode, {bool persist = true}) async {
    mode.value = newMode;
    if (persist) {
      _prefs ??= await SharedPreferences.getInstance();
      await _prefs!.setString(
        _prefKey,
        newMode == ThemeMode.dark
            ? 'dark'
            : newMode == ThemeMode.system
            ? 'system'
            : 'light',
      );
    }
  }

  static Future<void> toggle() async {
    final next = themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    await setTheme(next);
  }

  static String get currentThemeString => themeMode == ThemeMode.light
      ? 'Light Theme'
      : themeMode == ThemeMode.dark
      ? 'Dark Theme'
      : 'System';

  static Brightness get currentThemeBrightness {
    switch (themeMode) {
      case ThemeMode.dark:
        return Brightness.dark;
      case ThemeMode.light:
        return Brightness.light;
      case ThemeMode.system:
      default:
        return WidgetsBinding.instance.window.platformBrightness;
    }
  }

  static IconData get currentThemeIcon {
    switch (themeMode) {
      case ThemeMode.light:
        return Icons.dark_mode;
      case ThemeMode.dark:
        return Icons.light_mode;
      case ThemeMode.system:
      default:
        return Icons.brightness_auto;
    }
  }
}

class ThemeColorsManager {
  final ThemeMode? themeMode;

  ThemeColorsManager([this.themeMode]);

  ThemeMode get _mode => themeMode ?? ThemeManager.themeMode;

  bool get isDark => effectiveBrightness == Brightness.dark;

  Brightness get effectiveBrightness {
    final mode = _mode;
    if (mode == ThemeMode.system) {

      try {
        return WidgetsBinding.instance.platformDispatcher.platformBrightness;
      } catch (_) {
        return Brightness.light;
      }
    }
    return mode == ThemeMode.dark ? Brightness.dark : Brightness.light;
  }

  ThemeColorsManager.fromBrightness(Brightness brightness)
    : themeMode = brightness == Brightness.dark
          ? ThemeMode.dark
          : ThemeMode.light;

  ThemeData get aryanTheme =>
      isDark ? DarkColorTheme.darkTheme : LightColorTheme.lightTheme;

  Color get darkPrimary =>
      isDark ? dark.FontColors.darkPrimary : light.FontColors.darkPrimary;

  Color get hintColor => isDark
      ? dark.FontColors.aryanTextHintColor
      : light.FontColors.aryanTextHintColor;

  Color get aryanText =>
      isDark ? dark.FontColors.aryanText : light.FontColors.aryanText;

  Color get listTitlePrimary => isDark
      ? dark.FontColors.listTitlePrimary
      : light.FontColors.listTitlePrimary;

  Color get listContentTitlePrimary => isDark
      ? dark.FontColors.listContentTitlePrimary
      : light.FontColors.listContentTitlePrimary;

  Color get listContentPrimary => isDark
      ? dark.FontColors.listContentSecondary
      : light.FontColors.listContentSecondary;

  Color get aryanBorder => isDark
      ? dark.FontColors.aryanTextBorderColor
      : light.FontColors.aryanTextBorderColor;

  Color get aryanOrdinaryWhite =>
      isDark ? dark.FontColors.ordinaryWhite : light.FontColors.ordinaryWhite;

  Color get primary =>
      isDark ? dark.FontColors.primary : light.FontColors.primary;

  Color get secondary =>
      isDark ? dark.FontColors.secondary : light.FontColors.secondary;
}
