import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:models_package/Base/enums.dart';
import 'package:models_package/Base/login_module.dart';
import 'package:models_package/Data/Auth/Login/dto.dart' as Login;
import 'package:models_package/Data/Auth/User/dto.dart' as User;
import 'package:models_package/Data/Auth/User/dto.dart';
import 'package:services_package/login_service.dart';
import 'package:services_package/storage_service.dart';
import 'package:services_package/user_exist.dart';

import 'login_manager_service.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvents, LoginStates> {
  final LoginService _loginService = GetIt.instance<LoginService>();
  final StorageService _storageService = GetIt.instance<StorageService>();
  final UserExistService _userExistService = GetIt.instance<UserExistService>();
  final LoginModuleManager _moduleManager =
      GetIt.instance<LoginModuleManager>();

  final int _networkMode;
  final Login.LoginRequest finalRequest = Login.LoginRequest();

  LoginBloc({required int networkMode})
    : _networkMode = networkMode,
      super(LoginInitialState()) {
    on<LoginInitialEvent>(_onInitialEvent);
    on<LoginUsernameEvent>(_onUsernameEvent);
    on<LoginPasswordEvent>(_onPasswordEvent);
    on<LoginRecoveryPasswordEvent>(_onRecoveryPasswordEvent);
    on<LoginOtpEvent>(_onOtpEvent);
    on<LoginUserNotFoundEvent>(_onUserNotFoundEvent);
    on<LoginSignUpEvent>(_onSignUpEvent);
    on<LoginBackEvent>(_onBackEvent);
    on<LoginLoadingEvent>(_onLoadingEvent);
    on<LoginErrorEvent>(_onErrorEvent);
    on<LoginSuccessEvent>(_onSuccessEvent);
  }

  FutureOr<void> _onInitialEvent(
    LoginInitialEvent event,
    Emitter<LoginStates> emit,
  ) {
    emit(LoginInitialState());
  }

  FutureOr<void> _onUsernameEvent(
    LoginUsernameEvent event,
    Emitter<LoginStates> emit,
  ) async {
    User.Response? response = null;
    if (_networkMode == 0) {
      response = await _userExistService.CheckIfExist(
        User.Request(userName: event.username, deviceToken: ''),
      );
      if (response != null) {
        if (response.result!.isNotEmpty &&
            response.result!.toLowerCase().contains('success')) {
          finalRequest.userName = event.username;
          emit(LoginPasswordState(event.username));
        } else {
          finalRequest.userName = null;
          emit(LoginSignUpState(event.username));
        }
      }
    } else if (_networkMode == 1) {
      emit(LoginPasswordState(event.username));
    } else if (_networkMode == 2) {
      finalRequest.userName = null;
      emit(LoginSignUpState(event.username));
    }
  }

  FutureOr<void> _onPasswordEvent(
    LoginPasswordEvent event,
    Emitter<LoginStates> emit,
  ) async {
    // emit(LoginLoadingState('در حال ورود...'));
    if (_networkMode == 0) {
      try {
        final result = await _performLogin(event.username, event.password);
        if (result.success) {
          emit(LoginSuccessState(result));
        } else {
          emit(LoginErrorState(result));
        }
      } catch (e) {
        emit(
          LoginErrorState(
            LoginModuleResult(
              success: false,
              error: 'خطای غیرمنتظره: ${e.toString()}',
              resultType: LoginResultType.error,
            ),
          ),
        );
      }
    } else if (_networkMode == 1) {
      await Future.delayed(Duration(milliseconds: 500));
      final simulatedUser = UserDto(
        token: 'simulated_token',
        refreshToken: 'simulated_refresh_token',
        firstName: 'asd',
        fullName: 'asd',
      );
      final result = LoginModuleResult(
        success: true,
        token: simulatedUser.token,
        user: simulatedUser,

        resultType: LoginResultType.success,
      );
      emit(LoginSuccessState(result));
    } else if (_networkMode == 2) {
      await Future.delayed(Duration(milliseconds: 500));
      final result = LoginModuleResult(
        success: false,
        error: 'خطا در ورود',
        resultType: LoginResultType.error,
      );
      emit(LoginErrorState(result));
    }
  }

  FutureOr<void> _onRecoveryPasswordEvent(
    LoginRecoveryPasswordEvent event,
    Emitter<LoginStates> emit,
  ) {
    emit(LoginOtpValidationState(event.username));
    // emit(LoginRecoverPasswordState(event.username));
  }

  FutureOr<void> _onOtpEvent(
    LoginOtpEvent event,
    Emitter<LoginStates> emit,
  ) async {
    emit(LoginLoadingState('در حال بررسی کد...'));

    // اینجا منطق بررسی OTP پیاده‌سازی می‌شود
    await Future.delayed(Duration(seconds: 2)); // شبیه‌سازی

    // پس از موفقیت آمیز بودن OTP
    emit(LoginPasswordState(event.username));
  }

  FutureOr<void> _onUserNotFoundEvent(
    LoginUserNotFoundEvent event,
    Emitter<LoginStates> emit,
  ) {
    emit(LoginSignUpState(event.username));
  }

  FutureOr<void> _onSignUpEvent(
    LoginSignUpEvent event,
    Emitter<LoginStates> emit,
  ) {
    // اینجا می‌توان کاربر را به صفحه ثبت‌نام هدایت کرد
    emit(LoginSignUpState(event.username));
  }

  FutureOr<void> _onBackEvent(LoginBackEvent event, Emitter<LoginStates> emit) {
    final currentState = event.currentState;

    if (currentState is LoginPasswordState) {
      emit(LoginUsernameState(currentState.username));
    } else if (currentState is LoginRecoverPasswordState) {
      emit(LoginUsernameState(currentState.username));
    } else if (currentState is LoginSignUpState) {
      emit(LoginInitialState());
    } else if (currentState is LoginOtpValidationState) {
      emit(LoginUsernameState(currentState.phoneNumber));
    } else {
      emit(LoginInitialState());
    }
  }

  FutureOr<void> _onLoadingEvent(
    LoginLoadingEvent event,
    Emitter<LoginStates> emit,
  ) {
    if (event.isLoading) {
      emit(LoginLoadingState(event.message ?? 'در حال پردازش...'));
    }
  }

  FutureOr<void> _onErrorEvent(
    LoginErrorEvent event,
    Emitter<LoginStates> emit,
  ) {
    emit(LoginErrorState(event.moduleResult));

    _moduleManager.notifyResult(event.moduleResult);
  }

  FutureOr<void> _onSuccessEvent(
    LoginSuccessEvent event,
    Emitter<LoginStates> emit,
  ) {
    emit(LoginSuccessState(event.moduleResult));

    _moduleManager.notifyResult(event.moduleResult);
  }

  Future<LoginModuleResult> _performLogin(
    String username,
    String password,
  ) async {
    try {
      final deviceToken = await _storageService.getDeviceToken();
      final request = Login.LoginRequest(
        userName: username,
        password: password,
        deviceToken: deviceToken,
        isRefreshToken: false,
        managementAccountId: 1,
        langId: 1,
        deviceType: 2,
        grantType: "password",
      );

      final response = await _loginService.login(request);

      if (response != null && response.result?.contains('success') == true) {
        final userDto = UserDto(
          token: response.accessToken!,
          refreshToken: response.refreshToken!,
          firstName: username,
          // You might want to get the actual first name from the response
          fullName: username,
        );
        await _storageService.setToken(userDto.token!);
        await _storageService.setUser(userDto);

        return LoginModuleResult(
          success: true,
          token: response.accessToken,
          user: userDto,
          resultType: LoginResultType.success,
        );
      } else {
        return LoginModuleResult(
          success: false,
          error: 'نام کاربری یا رمز عبور نادرست است',
          resultType: LoginResultType.validationError,
        );
      }
    } catch (e) {
      return LoginModuleResult(
        success: false,
        error: 'خطا در ارتباط با سرور: ${e.toString()}',
        resultType: LoginResultType.networkError,
      );
    }
  }

  Future<bool> checkUserExists(String username) async {
    try {
      final deviceToken = await _storageService.getDeviceToken();
      final request = Request(userName: username, deviceToken: deviceToken);
      final response = await _userExistService.CheckIfExist(request);

      return response?.data != null;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<void> close() {
    _moduleManager.dispose();
    return super.close();
  }
}

// کلاس کمکی برای مدیریت نتیجه لاگین
