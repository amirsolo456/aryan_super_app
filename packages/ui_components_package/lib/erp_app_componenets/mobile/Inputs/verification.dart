import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:resources_package/resources/Theme/theme_manager.dart';

const Color primaryColor = Color(0xFF121212);
const Color accentPurpleColor = Color(0xFF6A53A1);
const Color accentPinkColor = Color(0xFFF99BBD);
const Color accentDarkGreenColor = Color(0xFF115C49);
const Color accentYellowColor = Color(0xFFFFB612);
const Color accentOrangeColor = Color(0xFFEA7A3B);

class VerificationWidget extends StatefulWidget {
  final Function onSubmited;
  final ValueChanged<String>? onChanged;

  const VerificationWidget({
    super.key,
    required this.onSubmited,
    required this.onChanged,
  });

  @override
  _VerificationWidgetState createState() => _VerificationWidgetState();
}

class _VerificationWidgetState extends State<VerificationWidget> {
  int numberOfFields = 4;
  bool clearText = false;
  late List<TextEditingController?> controls;

  String getCode() {
    // Safely concatenate texts from controllers
    if (controls.isEmpty) return '';
    return controls.map((controller) => controller?.text ?? '').join();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Directionality(
      textDirection: TextDirection.ltr,
      child: OtpTextField(
        numberOfFields: numberOfFields,
        alignment: Alignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        decoration: const InputDecoration(hintTextDirection: TextDirection.ltr),
        filled: true,
        borderColor: ThemeColorsManager(ThemeManager.themeMode).aryanBorder,
        fillColor: ThemeColorsManager(
          ThemeManager.themeMode,
        ).aryanOrdinaryWhite,
        focusedBorderColor: ThemeColorsManager(
          ThemeManager.themeMode,
        ).darkPrimary,
        enabledBorderColor: ThemeColorsManager(
          ThemeManager.themeMode,
        ).aryanBorder,
        borderWidth: 1,
        showCursor: false,
        crossAxisAlignment: CrossAxisAlignment.center,
        obscureText: false,
        margin: const EdgeInsets.only(left: 5, right: 5),
        autoFocus: true,
        clearText: clearText,
        showFieldAsBox: true,

        borderRadius: const BorderRadius.all(Radius.circular(8)),
        onCodeChanged: (String value) {
          final otp = controls.map((c) => c!.text).join();
          widget.onChanged?.call(otp);
        },
        handleControllers: (controllers) {
          controls = controllers;
        },
        fieldHeight: 46,
        fieldWidth: 55,

        onSubmit: (String verificationCode) {
          widget.onSubmited.call(verificationCode);
        },
      ),
    );
  }
}
