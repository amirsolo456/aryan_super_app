import 'package:flutter/material.dart';

import '../Theme/theme_manager.dart';

abstract class AryanText {
  static final ThemeColorsManager defaultColors = ThemeColorsManager(
    Brightness.light,
  );

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
      color: colors.listContentPrimary,
    );
  }

  static TextStyle darkStyle([ThemeColorsManager? colors]) {
    colors ??= defaultColors;
    return TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: colors.listTitlePrimary,
    );
  }

  static TextStyle secondary([ThemeColorsManager? colors]) {
    colors ??= defaultColors;
    return TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      fontFamily: 'IRANSansX',
      color: colors.secondary,
    );
  }

  static Widget secondaryPasswordTextFormWithToggle({
    ThemeColorsManager? colors,
    TextEditingController? controller,
    String? hintText,
    String? Function(String?)? validator,
    void Function(String)? onChanged,
  }) {
    colors ??= defaultColors;

    final ValueNotifier<bool> obscureNotifier = ValueNotifier<bool>(true);
    final Widget _closePass = Image.asset(
      'assets/images/eyes_close.png',
      package: 'resources_package',
      width: 24,
      height: 24,
    );

    final Widget _openPass = Image.asset(
      'assets/images/eyes_open.png',
      package: 'resources_package',
      width: 24,
      height: 24,
    );
    return ValueListenableBuilder<bool>(
      valueListenable: obscureNotifier,
      builder: (context, obscure, child) {
        return TextFormField(
          controller: controller,
          validator: validator,
          onChanged: onChanged,
          obscureText: obscure,
          style: AryanText.secondary(colors),
          textAlign: TextAlign.right,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black, width: 2),
              borderRadius: BorderRadius.circular(10),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.red, width: 1),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.red, width: 2),
              borderRadius: BorderRadius.circular(10),
            ),
            suffixIcon: IconButton(
              icon: obscure ? _openPass : _closePass,
              // color: colors.secondary,
              onPressed: () {
                obscureNotifier.value = !obscureNotifier.value;
              },
            ),
          ),
        );
      },
    );
  }

  static TextFormField secondaryUsernameTextForm({
    ThemeColorsManager? colors,
    TextEditingController? controller,
    String? hintText,
    String? Function(String?)? validator,
    void Function(String)? onChanged,
    void Function()? onTap,
    bool obscureText = false,
  }) {
    colors ??= defaultColors;
    return TextFormField(
      controller: controller,
      validator: validator,
      onChanged: onChanged,
      onTap: onTap,
      obscureText: obscureText,
      style: secondary(colors),
      textAlign: TextAlign.right,
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: colors.aryanBorder, width: 1),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red, width: 1),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
