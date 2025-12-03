part of 'login_bloc.dart';

@immutable
abstract class LoginEvents {}

class LoginInitialEvent extends LoginEvents {}

class LoginUsernameEvent extends LoginEvents {
  final String username;
  LoginUsernameEvent(this.username);
}

class LoginPasswordEvent extends LoginEvents {
  final String username;
  final String password;
  LoginPasswordEvent(this.username, this.password);
}

class LoginRecoveryPasswordEvent extends LoginEvents {
  final String username;
  LoginRecoveryPasswordEvent(this.username);
}

class LoginOtpEvent extends LoginEvents {
  final String username;
  final String otpCode;
  LoginOtpEvent(this.username, this.otpCode);
}

class LoginUserNotFoundEvent extends LoginEvents {
  final String username;
  LoginUserNotFoundEvent(this.username);
}

class LoginSignUpEvent extends LoginEvents {
  final String username;
  LoginSignUpEvent(this.username);
}

class LoginBackEvent extends LoginEvents {
  final LoginStates currentState;
  LoginBackEvent(this.currentState);
}

class LoginLoadingEvent extends LoginEvents {
  final bool isLoading;
  final String? message;
  LoginLoadingEvent(this.isLoading, [this.message]);
}

class LoginCriticalErrorEvent extends LoginEvents {
  final Exception? _exception;
  LoginCriticalErrorEvent(this._exception);
}

class LoginApiErrorEvent extends LoginEvents {
  final LoginModuleResult moduleResult;
  LoginApiErrorEvent(this.moduleResult);
}

class LoginSuccessEvent extends LoginEvents {
  final LoginModuleResult moduleResult;
  LoginSuccessEvent(this.moduleResult);
}

class LoginOpenManagementPickerEvent extends LoginEvents {
  final LoginModuleResult result;
  LoginOpenManagementPickerEvent(this.result);
}

class LoginManagementSelectedEvent extends LoginEvents {
  final LoginModuleResult result;
  final Login.ManagementAccounts selectedManager;

  LoginManagementSelectedEvent(this.result, this.selectedManager);
}
