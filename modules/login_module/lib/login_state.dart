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
  final String username;

  LoginRecoverPasswordState(this.username);
}

class LoginOtpValidationState extends LoginStates {
  final String phoneNumber;

  LoginOtpValidationState(this.phoneNumber);
}

class LoginSignUpState extends LoginStates {
  final String username;

  LoginSignUpState(this.username);
}

class LoginLoadingState extends LoginStates {
  final String message;

  LoginLoadingState(this.message);
}

class LoginErrorState extends LoginStates {
  final LoginModuleResult moduleResult;

  LoginErrorState(this.moduleResult);
}

class LoginSuccessState extends LoginStates {
  final LoginModuleResult moduleResult;

  LoginSuccessState(this.moduleResult);
}
