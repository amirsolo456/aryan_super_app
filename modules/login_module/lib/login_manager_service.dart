import 'dart:async';

import 'package:models_package/Base/enums.dart';
import 'package:models_package/Base/login_module.dart';

class LoginModuleManager {
  static final LoginModuleManager _instance = LoginModuleManager._internal();
  factory LoginModuleManager() => _instance;
  LoginModuleManager._internal();

  final StreamController<LoginModuleResult> _resultController =
      StreamController<LoginModuleResult>.broadcast();

  Stream<LoginModuleResult> get resultStream => _resultController.stream;

  void notifyResult(LoginModuleResult result) {
    if (!_resultController.isClosed) {
      _resultController.add(result);
    }
  }

  void reset() {
    if (!_resultController.isClosed) {
      _resultController.add(
        LoginModuleResult(
          success: false,
          resultType: LoginResultType.cancelled,
        ),
      );
    }
  }

  void dispose() {
    if (!_resultController.isClosed) {
      _resultController.close();
    }
  }

  bool get isClosed => _resultController.isClosed;
}
