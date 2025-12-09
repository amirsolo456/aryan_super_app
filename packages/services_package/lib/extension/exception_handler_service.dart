import 'dart:async';
import 'dart:developer' as developer;

import 'package:flutter/material.dart';

import '../Interfaces/front_helper_services/imessage_helper_service.dart';

class AppErrorHandler {
  static IMessengerHelperService? _messengerService;

  // متد ثبت سرویس (مشابه RegisterMethodCustomExtensions در کد C# شما)
  static void registerMessengerService(IMessengerHelperService messenger) {
    _messengerService = messenger;
  }

  // ثبت خطاهای سراسری برنامه
  static void initializeErrorHandlers(Widget appWidget) {
    // مدیریت خطاهای Dart در Zone
    runZonedGuarded(
      () {
        // مدیریت خطاهای فریم‌ورک Flutter
        FlutterError.onError = (FlutterErrorDetails details) async {
          developer.log(
            'Flutter Error',
            error: details.exception,
            stackTrace: details.stack,
          );

          await _messengerService?.recordFlutterError(details);

          // در محیط Production این خط را کامنت کنید
          // FlutterError.presentError(details);

          // در عوض، می‌توانید خطا را به صورت سفارشی مدیریت کنید
          if (_messengerService != null) {
            _messengerService!.sendError(
              AppErrorHandler,
              details.exception,
              'Flutter Framework Error',
            );
          }
        };

        // اجرای برنامه
        runApp(appWidget);
      },
      (error, stackTrace) async {
        // این بخش خطاهای catch نشده در Zone را می‌گیرد
        developer.log(
          'Uncaught Zone Error',
          error: error,
          stackTrace: stackTrace,
        );

        await _messengerService?.recordError(
          error,
          stackTrace,
          message: 'Zoned Error',
        );
      },
    );
  }

  // 3. ثبت خطا به صورت دستی (مشابه LogException در کد C# شما)
  static Future<void> logException(
    dynamic ex, {
    StackTrace? stackTrace,
    String? context,
    Object? sender,
  }) async {
    developer.log(
      'Logged Exception: ${context ?? 'No Context'}',
      error: ex,
      stackTrace: stackTrace,
    );

    // ارسال به سرویس گزارش خطا
    await _messengerService?.recordError(
      ex,
      stackTrace,
      message: context ?? 'Manual Log',
    );

    // نمایش خطا به کاربر (اختیاری)
    if (_messengerService != null && sender != null) {
      _messengerService!.sendError(sender, ex, context ?? 'خطا رخ داد');
    }
  }
}

// 4. Extension Methods (مشابه کد C# شما)
// ----------------- Future<T> -----------------
extension FutureExceptionHandlerExtension<T> on Future<T> {
  Future<T> withExceptionHandler({
    required Object sender,
    IMessengerHelperService? messenger,
    String errorMessage = 'خطا رخ داد',
    T? defaultValue,
    bool rethrowException = false,
  }) async {
    try {
      return await this;
    } catch (ex, stackTrace) {
      final service = messenger ?? AppErrorHandler._messengerService;

      if (service != null) {
        await service.recordError(ex, stackTrace, message: errorMessage);
        service.sendError(sender, ex, errorMessage);
      } else {
        developer.log(
          'No messenger service registered for error:',
          error: ex,
          stackTrace: stackTrace,
        );
      }

      if (rethrowException) {
        rethrow;
      }

      return defaultValue as T;
    }
  }
}

// ----------------- Future<void> -----------------
extension FutureVoidExceptionHandlerExtension on Future<void> {
  Future<void> withExceptionHandler({
    required Object sender,
    IMessengerHelperService? messenger,
    String errorMessage = 'خطا رخ داد',
    bool rethrowException = false,
  }) async {
    try {
      await this;
    } catch (ex, stackTrace) {
      final service = messenger ?? AppErrorHandler._messengerService;

      if (service != null) {
        await service.recordError(ex, stackTrace, message: errorMessage);
        service.sendError(sender, ex, errorMessage);
      } else {
        developer.log(
          'No messenger service registered for error:',
          error: ex,
          stackTrace: stackTrace,
        );
      }

      if (rethrowException) {
        rethrow;
      }
    }
  }
}

// ----------------- Function (void) -----------------
extension FunctionExceptionHandlerExtension on void Function() {
  void withExceptionHandler({
    required Object sender,
    IMessengerHelperService? messenger,
    String errorMessage = 'خطا رخ داد',
  }) {
    try {
      this();
    } catch (ex, stackTrace) {
      final service = messenger ?? AppErrorHandler._messengerService;

      if (service != null) {
        service.recordError(ex, stackTrace, message: errorMessage);
        service.sendError(sender, ex, errorMessage);
      } else {
        developer.log(
          'No messenger service registered for error:',
          error: ex,
          stackTrace: stackTrace,
        );
      }
    }
  }
}

// ----------------- Func<T> -----------------
extension GenericFunctionExceptionHandlerExtension<T> on T Function() {
  T withExceptionHandler({
    required Object sender,
    IMessengerHelperService? messenger,
    String errorMessage = 'خطا رخ داد',
    T? defaultValue,
  }) {
    try {
      return this();
    } catch (ex, stackTrace) {
      final service = messenger ?? AppErrorHandler._messengerService;

      if (service != null) {
        service.recordError(ex, stackTrace, message: errorMessage);
        service.sendError(sender, ex, errorMessage);
      } else {
        developer.log(
          'No messenger service registered for error:',
          error: ex,
          stackTrace: stackTrace,
        );
      }

      return defaultValue as T;
    }
  }
}
