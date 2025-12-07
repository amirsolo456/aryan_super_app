import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../Theme/theme_manager.dart';
import 'font_size.dart';

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

  //Hesaraki Change

  static TextStyle objectStyle([ThemeColorsManager? colors]) {
    colors ??= defaultColors;
    return TextStyle(
      fontSize: AryanSizes.primaryFontSize14,
      fontWeight: FontWeight.w500,
      fontFamily: 'IRANSansX',
      color: colors.primary,
    );
  }

  static TextStyle subItemStyle([ThemeColorsManager? colors]) {
    colors ??= defaultColors;
    return TextStyle(
      fontSize: AryanSizes.subFontSize14,
      fontWeight: FontWeight.w500,
      fontFamily: 'IRANSansX',
      color: colors.primary,
    );
  }

  static TextStyle exitStyle([ThemeColorsManager? colors]) {
    colors ??= defaultColors;
    return TextStyle(
      fontSize: AryanSizes.subFontSize14,
      fontWeight: FontWeight.w500,
      fontFamily: 'IRANSansX',
      color: colors.exitColor,
    );
  }

  //Hesaraki Change

  static TextStyle primButtonTextStyle([ThemeColorsManager? colors]) {
    colors ??= defaultColors;
    return TextStyle(
      fontSize: AryanSizes.primButtonTextFontSize24,
      fontWeight: FontWeight.bold,
      fontFamily: 'IRANSansX',
      color: colors.aryanOrdinaryWhite,
    );
  }

  static TextStyle listTitleStyle([ThemeColorsManager? colors]) {
    colors ??= defaultColors;
    return TextStyle(
      fontSize: AryanSizes.listTitleFontSize24,
      fontWeight: FontWeight.bold,
      color: colors.listTitlePrimary,
    );
  }

  static TextStyle listContentTitleStyle([ThemeColorsManager? colors]) {
    colors ??= defaultColors;
    return TextStyle(
      fontSize: AryanSizes.listContentTitleFontSize24,
      fontWeight: FontWeight.bold,
      color: colors.listContentTitlePrimary,
    );
  }

  static TextStyle listContentStyle([ThemeColorsManager? colors]) {
    colors ??= defaultColors;
    return TextStyle(
      fontSize: AryanSizes.darkTextStyleFontSize24,
      fontWeight: FontWeight.bold,
      fontFamily: 'Yekan',
      color: colors.listContentPrimary,
    );
  }

  static TextStyle darkStyle([ThemeColorsManager? colors]) {
    colors ??= defaultColors;
    return TextStyle(
      fontSize: AryanSizes.darkTextStyleFontSize24,
      fontWeight: FontWeight.bold,
      fontFamily: 'Yekan',
      color: colors.listTitlePrimary,
    );
  }

  static TextStyle secondary([ThemeColorsManager? colors]) {
    colors ??= defaultColors;
    return TextStyle(
      fontSize: AryanSizes.listTileFontSize14,
      leadingDistribution: TextLeadingDistribution.proportional,
      fontStyle: FontStyle.normal,
      height: 1,
      fontWeight: FontWeight.w700,
      fontFamily: 'Yekan',
      color: colors.primary,
      letterSpacing: 1,
    );
  }
}

class aryanSecondaryFormField extends TextFormField {
  aryanSecondaryFormField({
    super.key,
    TextEditingController? controller,
    String? Function(String?)? validator,
    void Function(String)? onChanged,
    void Function()? onTap,
    bool obscureText = false,
    bool ignorePointer = true,
    String? hintText,
    ThemeColorsManager? colors,
    InputDecoration? decoration,
    List<TextInputFormatter>? inputFormatters,
    TextInputType? keyboardType,
    bool? suggestion,
    bool? correct,
    String? obsChar,
    bool IsRtl = true,
  }) : super(
         controller: controller,
         validator: validator,
         onChanged: onChanged,
         onTap: onTap,
         cursorColor: Colors.black,
         obscuringCharacter: (obscureText == true ? (obsChar ?? " ") : " "),
         enableSuggestions: suggestion ?? false,
         autocorrect: correct ?? false,
         autofocus: true,
         textAlign: TextAlign.start,
         textDirection: (IsRtl == true ? TextDirection.rtl : TextDirection.ltr),
         cursorOpacityAnimates: false,
         inputFormatters: inputFormatters,
         ignorePointers: ignorePointer,
         selectAllOnFocus: true,
         cursorErrorColor: Colors.red,
         cursorHeight: 25,
         obscureText: obscureText,
         style: AryanText.secondary(ThemeManager.colors),
         keyboardType: keyboardType,
         decoration: decoration ?? aryanSecondaryInputDecoration(),
       );
}

class aryanSecondaryInputDecoration extends InputDecoration {
  aryanSecondaryInputDecoration({
    String? customHintText,
    IconButton? suffixIcon,
    Color? hintColor,
    Color? fillColor,
    Widget? customHint,
  }) : super(
         suffixIcon: suffixIcon ?? null,
         hintFadeDuration: Duration(milliseconds: 550),
         maintainHintSize: true,
         fillColor: fillColor,
         contentPadding: EdgeInsets.all(10),
         isDense: false,
         hintTextDirection: TextDirection.ltr,
         hint:
             customHint ??
             Align(
               alignment: Alignment.centerRight,
               child: Text(
                 textDirection: TextDirection.ltr,
                 customHintText ?? "******",
                 style: TextStyle(
                   color: hintColor ?? Colors.white38,
                   fontSize: 15,
                 ),
               ),
             ),

         border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
         enabledBorder: OutlineInputBorder(
           borderSide: const BorderSide(color: Colors.black, width: 0.5),
           borderRadius: BorderRadius.circular(10),
         ),
         focusedBorder: OutlineInputBorder(
           borderSide: const BorderSide(color: Colors.black, width: 1),
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
         filled: true,
         errorStyle: const TextStyle(color: Colors.red, fontSize: 12),
       );
}
