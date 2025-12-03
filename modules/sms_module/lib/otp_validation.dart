import 'package:flutter/material.dart';
import 'package:ui_components_package/erp_app_componenets/mobile/Inputs/verification.dart';

class OtpValidation extends StatefulWidget {
  const OtpValidation({super.key});

  @override
  State<OtpValidation> createState() => _OtpValidationState();
}

class _OtpValidationState extends State<OtpValidation> {
  @override
  Widget build(BuildContext context) {
    return VerificationWidget();
  }
}
