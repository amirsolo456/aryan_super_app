import 'package:flutter/material.dart';

class OperationResult {
  final bool isSuccess;
  final String? message;
  final FormatException? exception;
  final Color? textColor;
  final dynamic? data; // برای ذخیره داده‌های اضافی

  OperationResult({
    required this.isSuccess,
    this.exception,
    this.message,
    this.textColor = Colors.black,
    this.data,
  });

  // Constructor برای موفقیت
  OperationResult.success({
    String? message,
    Color? textColor = Colors.green,
    dynamic? data,
  }) : this(
         isSuccess: true,
         message: message,
         textColor: textColor,
         exception: null,
         data: data,
       );

  // Constructor برای شکست
  OperationResult.failure({
    String? message,
    FormatException? excepotion,
    Color? textColor = Colors.red,
    dynamic? data,
  }) : this(
         isSuccess: false,
         exception: excepotion,
         message: message,
         textColor: textColor,
         data: data,
       );

  // Getter برای دریافت exception (اگر وجود داشته باشد)
  FormatException? get occurefException => isSuccess
      ? null
      : FormatException(exception.toString(), exception, exception.hashCode);
}

class OperationError extends OperationResult {
  final dynamic errorDetails;

  OperationError({
    required String message,
    required FormatException exception,
    this.errorDetails,
    Color textColor = Colors.red,
  }) : super.failure(
         message: message,
         excepotion: exception,
         textColor: textColor,
         data: errorDetails,
       );
}
