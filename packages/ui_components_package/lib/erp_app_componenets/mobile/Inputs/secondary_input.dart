import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:resources_package/Resources/Assets/icons_manager.dart'
    show AryanAppAssets;
import 'package:resources_package/Resources/Styles/styles.dart';
import 'package:resources_package/Resources/Theme/theme_manager.dart';

abstract class AryanInputs {
  static TextFormField secondaryUsernameTextForm({
    ThemeColorsManager? colors,
    TextEditingController? controller,
    String? hintText,
    String? Function(String?)? validator,
    void Function(String)? onChanged,
    void Function()? onTap,
    bool obscureText = false,
    String? obsCharacter,
    bool isRtl = true,
  }) {
    colors ??= AryanText.defaultColors;
    return aryanSecondaryFormField(
      controller: controller,
      validator: validator,
      ignorePointer: true,
      correct: true,
      suggestion: true,
      IsRtl: isRtl,
      decoration: aryanSecondaryInputDecoration(
        customHintText: hintText,
        hintColor: ThemeManager.colors.hintColor,
      ),
      obscureText: obscureText,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      keyboardType: TextInputType.number,
      onTap: onTap,
      onChanged: onChanged,
    );
  }

  static ValueNotifier<bool> obscureNotifier = ValueNotifier<bool>(true);
  static final Widget defIcon = AryanAppAssets.images.imageByKey(
    'defaultImage',
    width: 24,
    height: 24,
    fit: BoxFit.fill,
  );

  static Widget secondaryPasswordTextFormWithToggle({
    TextEditingController? controller,
    String? inputHintText,
    String? Function(String?)? validator,
    bool isRtl = true,
    void Function(String)? onChanged,
  }) {
    final Widget _closePass = AryanAppAssets.images.imageByKey(
      'eyesClose',
      width: 22,
      height: 22,
      fit: BoxFit.fill,
    );

    final Widget _openPass = AryanAppAssets.images.imageByKey(
      'eyesOpen',
      width: 22,
      height: 22,
      fit: BoxFit.fill,
    );

    return ValueListenableBuilder<bool>(
      valueListenable: obscureNotifier,
      builder: (context, obscure, child) {
        return aryanSecondaryFormField(
          IsRtl: isRtl,
          controller: controller,
          validator: validator,
          obscureText: obscure,
          ignorePointer: false,
          obsChar: "*",
          onChanged: onChanged,
          decoration: aryanSecondaryInputDecoration(
            customHint: Align(
              alignment: Alignment.centerRight,
              child: Text(
                "*********",
                style: TextStyle(
                  color: ThemeManager.colors.hintColor,
                  fontSize: 15,
                  letterSpacing: 2,
                ),
              ),
            ),
            hintColor: ThemeManager.colors.hintColor,
            suffixIcon: IconButton(
              icon: (obscure
                  ? (_openPass ?? defIcon)
                  : (_closePass ?? defIcon)),
              highlightColor: Colors.transparent,
              onPressed: () {
                obscureNotifier.value = !obscureNotifier.value;
              },
            ),
            customHintText: inputHintText ?? '',
          ),
        );
      },
    );
  }
}
