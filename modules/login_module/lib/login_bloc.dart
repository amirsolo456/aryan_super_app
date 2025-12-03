import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:models_package/Base/enums.dart';
import 'package:models_package/Base/login_module.dart';
import 'package:models_package/Data/Auth/Login/dto.dart' as Login;
import 'package:models_package/Data/Auth/Login/dto.dart';
import 'package:models_package/Data/Auth/User/dto.dart' as User;
import 'package:models_package/Data/Auth/User/dto.dart';
import 'package:services_package/login_service.dart';
import 'package:services_package/user_exist.dart';

import 'services/login_manager_service.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvents, LoginStates> {
  final LoginService _loginService = GetIt.instance<LoginService>();
  final UserExistService _userExistService = GetIt.instance<UserExistService>();
  final LoginModuleManager _moduleManager =
      GetIt.instance<LoginModuleManager>();
  final String _deviveToken;
  final int _networkMode;
  final Login.LoginRequest finalRequest = Login.LoginRequest();

  LoginBloc({required int networkMode, required String deviceToken})
    : _networkMode = networkMode,
      _deviveToken = deviceToken,
      super(LoginInitialState()) {
    on<LoginInitialEvent>(_onInitialEvent);
    on<LoginUsernameEvent>(_onUsernameEvent);
    on<LoginPasswordEvent>(_onPasswordEvent);
    on<LoginRecoveryPasswordEvent>(_onRecoveryPasswordEvent);
    on<LoginOpenManagementPickerEvent>(_onOpenManagementPicker);
    on<LoginManagementSelectedEvent>(_onManagementSelected);
    on<LoginOtpEvent>(_onOtpEvent);
    on<LoginUserNotFoundEvent>(_onUserNotFoundEvent);
    on<LoginSignUpEvent>(_onSignUpEvent);
    on<LoginBackEvent>(_onBackEvent);
    on<LoginLoadingEvent>(_onLoadingEvent);
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
      if (_deviveToken != '') {
        response = await _userExistService.CheckIfExist(
          User.Request(userName: event.username, deviceToken: _deviveToken),
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
    if (_networkMode == 0) {
      try {
        final result = await _performLogin(event.username, event.password);
        if (result.success) {
          emit(LoginSuccessState(result));
        } else {
          if (result.resultType == LoginResultType.managementAccountPick) {
            emit(LoginManagementPickerState(result));
          }
        }
      } catch (e) {
        emit(LoginCriticalErrorState(Exception(e)));
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
    }
  }

  FutureOr<void> _onRecoveryPasswordEvent(
    LoginRecoveryPasswordEvent event,
    Emitter<LoginStates> emit,
  ) {
    emit(LoginOtpValidationState(event.username));
  }

  FutureOr<void> _onOtpEvent(
    LoginOtpEvent event,
    Emitter<LoginStates> emit,
  ) async {
    emit(LoginLoadingState('در حال بررسی کد...'));
    await Future.delayed(Duration(seconds: 2)); // شبیه‌سازی
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
      final request = Login.LoginRequest(
        userName: username,
        password: password,
        deviceToken: _deviveToken,
        isRefreshToken: false,
        managementAccountId: 1,
        langId: 1,
        deviceType: 2,
        grantType: "password",
      );

      final response = await _loginService.login(request);

      if (response != null &&
          response.result?.toLowerCase().contains('success') == true) {
        final userDto = UserDto(
          token: response.accessToken!,
          refreshToken: response.refreshToken!,
          userName: username,
          password: password,
        );

        if (response.managementAccounts != null) {
          if (response.managementAccounts!.length > 1) {
            return LoginModuleResult(
              success: false,
              cachedKey: response.cacheKey,
              user: userDto,
              managementAccount: response.managementAccounts,
              resultType: LoginResultType.managementAccountPick,
            );
          } else {
            return LoginModuleResult(
              success: true,
              cachedKey: response.cacheKey,
              selectedManagementAccount:
                  response.managementAccounts!.firstOrNull,
              managementAccount: response.managementAccounts,
              token: response.accessToken,
              user: userDto,
              resultType: LoginResultType.success,
            );
          }
        } else {
          return LoginModuleResult(
            success: false,
            error: 'managementAccount = null',
            resultType: LoginResultType.validationError,
          );
        }
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
        error: 'serverConnectionError',
        resultType: LoginResultType.networkError,
      );
    }
  }

  FutureOr<LoginModuleResult> selectManagementAccout(
    LoginModuleResult moduleResult,
  ) async {
    try {
      if (moduleResult != null && moduleResult.cachedKey != '') {
        if (moduleResult.selectedManagementAccount != null) {
          final String cachedKey = moduleResult.cachedKey ?? '';
          final ManagementAccounts management =
              moduleResult.selectedManagementAccount ?? ManagementAccounts();

          final result = await _loginService.nextLogin(cachedKey, management);

          if (result != null) {
            if (result.result != null &&
                result.result!.toLowerCase().contains('success')) {
              final loginModule = LoginModuleResult.success(
                user: moduleResult.user,
                token: moduleResult.token,
                cachedKey: cachedKey,
                managementAccount: moduleResult.managementAccount,
                selectedManagementAccount: management,
              );
              return loginModule;
            }
          } else {
            moduleResult.error = 'selectedManagementAccount = null';
            return moduleResult;
          }
        } else {
          moduleResult.error = 'selectedManagementAccount = null';
          return moduleResult;
        }
      } else {
        moduleResult.error = 'cacheKey = null';
        return moduleResult;
      }
    } catch (e) {
      moduleResult.error = e.toString();
      return moduleResult;
    }
    return moduleResult;
  }

  Future<bool> checkUserExists(String username) async {
    try {
      final request = Request(userName: username, deviceToken: _deviveToken);
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

  FutureOr<void> _onOpenManagementPicker(
    LoginOpenManagementPickerEvent event,
    Emitter<LoginStates> emit,
  ) {
    emit(LoginManagementPickerState(event.result));
  }

  FutureOr<void> _onManagementSelected(
    LoginManagementSelectedEvent event,
    Emitter<LoginStates> emit,
  ) async {
    final prev = event.result; // نتیجه لاگین که چند اکانت داشت

    final result = await _loginService.nextLogin(
      prev.cachedKey ?? '',
      prev.selectedManagementAccount ?? ManagementAccounts(),
    );

    if (result != null &&
        result.result!.isNotEmpty &&
        result.result!.toLowerCase().contains('success')) {
      UserDto user = prev.user!.copyWith(
        token: result.accessToken ?? '',
        refreshToken: result.refreshToken ?? '',
      );

      final updated = LoginModuleResult(
        success: true,
        token: result.accessToken,
        user: user,
        selectedManagementAccount: event.result.selectedManagementAccount,
        managementAccount: event.result.managementAccount,
        cachedKey: event.result.cachedKey,
        resultType: LoginResultType.success,
      );
      emit(LoginSuccessState(updated));
      _moduleManager.notifyResult(updated);
    }
  }
}
