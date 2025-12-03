import 'package:flutter/cupertino.dart';
import 'package:sms_module/otp_validation.dart';

class SmsListenerService {
  static Widget GetOtpVerification() {
    return OtpValidation();
  }
}
