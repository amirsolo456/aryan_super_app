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
  }) {
    colors ??= AryanText.defaultColors;
    return TextFormField(
      controller: controller,
      validator: validator,
      onChanged: onChanged,
      onTap: onTap,
      minLines: 1,
      maxLines: 1,
      cursorColor: Colors.black,
      obscureText: obscureText,
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      style: AryanText.secondary(colors),
      textAlign: TextAlign.right,
      textDirection: TextDirection.ltr,
      selectAllOnFocus: true,
      decoration: InputDecoration(
        contentPadding: EdgeInsetsGeometry.all(5),
        hintFadeDuration: Duration(milliseconds: 550),
        hintText: hintText ?? '',
        hintStyle: TextStyle(color: colors.hintColor, fontSize: 14),
        fillColor: colors.aryanText,
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
    void Function(String)? onChanged,
  }) {
    final Widget _closePass = AryanAppAssets.images.imageByKey(
      'eyesClose',
      width: 24,
      height: 24,
      fit: BoxFit.fill,
    );

    final Widget _openPass = AryanAppAssets.images.imageByKey(
      'eyesOpen',
      width: 24,
      height: 24,
      fit: BoxFit.fill,
    );

    return ValueListenableBuilder<bool>(
      valueListenable: obscureNotifier,
      builder: (context, obscure, child) {
        return TextFormField(
          controller: controller,
          validator: validator,
          onChanged: onChanged,
          obscureText: obscure,
          style: AryanText.secondary(ThemeManager.colors),
          textAlign: TextAlign.right,
          decoration: _inputDeco(
            inputHintText ?? '',
            true,
            ThemeManager.colors.hintColor,
            ThemeManager.colors.aryanText,
            hasIconButton: true,
            closeIcon: _closePass,
            openIcon: _openPass,
          ),
        );
      },
    );
  }

  static InputDecoration _inputDeco(
    String customHintText,
    bool obscure,
    Color hintColor,
    Color fillColor, {
    bool hasIconButton = false,
    Widget? openIcon,
    Widget? closeIcon,
  }) => InputDecoration(
    hintText: customHintText,
    hintFadeDuration: Duration(milliseconds: 550),
    hintStyle: TextStyle(color: hintColor, fontSize: 14),
    fillColor: fillColor,
    contentPadding: EdgeInsetsGeometry.all(5),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
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

    suffixIcon: hasIconButton
        ? IconButton(
            icon: (obscure ? (openIcon ?? defIcon) : (closeIcon ?? defIcon)),
            onPressed: () {
              obscureNotifier.value = !obscureNotifier.value;
            },
          )
        : null,
  );
}
