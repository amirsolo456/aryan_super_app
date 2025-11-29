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

class LoginErrorEvent extends LoginEvents {
  final LoginModuleResult moduleResult;
  LoginErrorEvent(this.moduleResult);
}

class LoginSuccessEvent extends LoginEvents {
  final LoginModuleResult moduleResult;
  LoginSuccessEvent(this.moduleResult);
}
