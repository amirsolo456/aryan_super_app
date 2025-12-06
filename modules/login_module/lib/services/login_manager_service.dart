import 'dart:async';

import 'package:models_package/Base/enums.dart';
import 'package:models_package/Base/login_module.dart';

class LoginModuleManager {
  static final LoginModuleManager _instance = LoginModuleManager._internal();

  factory LoginModuleManager() => _instance;

  LoginModuleManager._internal();

  Completer<LoginModuleResult> _completer = Completer<LoginModuleResult>();

  Future<LoginModuleResult> get result => _completer.future;

  void notifyResult(LoginModuleResult result) {
    if (!_completer.isCompleted) {
      _completer.complete(result);
    }
  }

  void cancel() {
    if (!_completer.isCompleted) {
      _completer.complete(
        LoginModuleResult(
          success: false,
          resultType: LoginResultType.cancelled,
        ),
      );
    }
  }

  void reset() {
    // فقط اگر قبلاً کامل شده بود، یه Completer جدید بساز
    if (_completer.isCompleted) {
      _completer = Completer<LoginModuleResult>();
    }
  }
}
