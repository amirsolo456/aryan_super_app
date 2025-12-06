part of 'login_bloc.dart';

@immutable
abstract class LoginStates {}

class LoginInitialState extends LoginStates {}

class LoginUsernameState extends LoginStates {
  final String username;

  LoginUsernameState(this.username);
}

class LoginPasswordState extends LoginStates {
  final String username;

  LoginPasswordState(this.username);
}

class LoginRecoverPasswordState extends LoginStates {
  final String otpCode;
  final String username;

  LoginRecoverPasswordState(this.username, this.otpCode);
}

class LoginOtpValidationState extends LoginStates {
  final String phoneNumber;
  final String correctOtpCode;

  LoginOtpValidationState(this.phoneNumber, this.correctOtpCode);
}

class LoginOtpRequestState extends LoginStates {
  final String phoneNumber;

  LoginOtpRequestState(this.phoneNumber);
}

class LoginSignUpState extends LoginStates {
  final String username;

  LoginSignUpState(this.username);
}

class LoginLoadingState extends LoginStates {
  final String message;

  LoginLoadingState(this.message);
}

class LoginCriticalErrorState extends LoginStates {
  final Exception? exception;

  LoginCriticalErrorState(this.exception);
}

class LoginApiErrorState extends LoginStates {
  final LoginModuleResult moduleResult;

  LoginApiErrorState(this.moduleResult);
}

class LoginSuccessState extends LoginStates {
  final LoginModuleResult moduleResult;

  LoginSuccessState(this.moduleResult);
}

class LoginManagementPickerState extends LoginStates {
  final LoginModuleResult result;

  LoginManagementPickerState(this.result);
}
