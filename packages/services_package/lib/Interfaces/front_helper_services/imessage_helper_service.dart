import 'dart:async';

import 'package:flutter/material.dart';

// 1. اینترفیس سرویس گزارش خطا
abstract class IMessengerHelperService {
  void sendError(
    Object sender,
    dynamic ex,
    String message, {
    BuildContext? context,
  });

  Future<void> recordError(
    dynamic exception,
    StackTrace? stack, {
    String? message,
    BuildContext? context,
  });

  Future<void> recordFlutterError(FlutterErrorDetails details);
}
