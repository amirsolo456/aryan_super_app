import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';


const Color primaryColor = Color(0xFF121212);
const Color accentPurpleColor = Color(0xFF6A53A1);
const Color accentPinkColor = Color(0xFFF99BBD);
const Color accentDarkGreenColor = Color(0xFF115C49);
const Color accentYellowColor = Color(0xFFFFB612);
const Color accentOrangeColor = Color(0xFFEA7A3B);

class VerificationWidget extends StatefulWidget {
  const VerificationWidget({super.key});

  @override
  _VerificationWidgetState createState() => _VerificationWidgetState();
}

class _VerificationWidgetState extends State<VerificationWidget> {
  int numberOfFields = 4;
  bool clearText = false;
  late List<TextEditingController?> controls;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return OtpTextField(
      numberOfFields: numberOfFields,
      borderColor: Color(0xFFCECECE),
      fillColor: Color(0xFFFBFBFB),
      focusedBorderColor: primaryColor,
      enabledBorderColor: Color(0xFFCECECE),
      borderWidth: 1,
      cursorColor: Colors.black38,
      showCursor: false,
      crossAxisAlignment: CrossAxisAlignment.center,
      obscureText: false,
      margin: EdgeInsetsGeometry.only(left: 5, right: 5),
      autoFocus: true,
      clearText: clearText,
      showFieldAsBox: true,
      borderRadius: BorderRadius.all(Radius.circular(8)),
      onCodeChanged: (String value) {},
      handleControllers: (controllers) {
        controls = controllers;
      },
      fieldHeight: 46,
      fieldWidth: 55,
      onSubmit: (String verificationCode) {},
    );
  }
}
