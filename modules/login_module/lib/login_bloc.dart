import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:login_module/services/snackbar_service.dart';
import 'package:models_package/Base/enums.dart';
import 'package:models_package/Base/language.dart';
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
  final SnackBarService _snackBarService = GetIt.instance<SnackBarService>();
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
    on<LoginOtpRequestMessageEvent>(_onOtpRequestEvent);
    on<LoginOtpValidationEvent>(_onOtpValidationEvent);
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
        response = await _userExistService.get(
          User.Request(userName: event.username, deviceToken: _deviveToken),
          (json) => Response.fromJson(
            json,
            // (item) => User.ResponseData.fromJson(item),
          ),
        );
        if (response != null) {
          if (response.result!.isNotEmpty &&
              response.result!.toLowerCase().contains('success')) {
            finalRequest.userName = event.username;
            emit(LoginPasswordState(event.username));
          } else {
            _snackBarService.showError(
              (response != null ? response.error : "") ?? "",
            );
            finalRequest.userName = null;
            emit(LoginSignUpState(event.username));
          }
        }
      }
    } else if (_networkMode == 1 || _networkMode == 3) {
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
          safeEmit(emit, LoginSuccessState(result));
        } else {
          if (result.resultType == LoginResultType.managementAccountPick) {
            safeEmit(emit, LoginManagementPickerState(result));
          } else {
            safeEmit(
              emit,
              LoginCriticalErrorState(Exception(result.error ?? 'خطا در ورود')),
            );
          }
        }
      } catch (e) {
        safeEmit(emit, LoginCriticalErrorState(Exception(e)));
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
        networkMode: _networkMode,
        success: true,
        token: simulatedUser.token,
        user: simulatedUser,
        resultType: LoginResultType.success,
      );
      emit(LoginSuccessState(result));
    } else if (_networkMode == 2) {
      await Future.delayed(Duration(milliseconds: 500));
      final result = LoginModuleResult(
        networkMode: _networkMode,
        success: false,
        error: 'خطا در ورود',
        resultType: LoginResultType.error,
      );
    } else if (_networkMode == 3) {
      final result = LoginModuleResult(
        networkMode: _networkMode,
        success: true,
        selectedManagementAccount: ManagementAccounts(
          managementAccountId: 1,
          inActive: false,
          managementAccountDesc: 'amir',
        ),
        resultType: LoginResultType.error,
      );
      emit(LoginSuccessState(result));
    }
  }

  FutureOr<void> _onRecoveryPasswordEvent(
    LoginRecoveryPasswordEvent event,
    Emitter<LoginStates> emit,
  ) {
    emit(
      LoginSuccessState(
        LoginModuleResult(
          resultType: LoginResultType.success,
          success: true,
          networkMode: _networkMode,
        ),
      ),
    );
  }

  FutureOr<void> _onOtpRequestEvent(
    LoginOtpRequestMessageEvent event,
    Emitter<LoginStates> emit,
  ) async {
    emit(LoginLoadingState(event.username));
    final String correctOtp = "4444";

    await Future.delayed(Duration(seconds: 2));
    emit(LoginOtpValidationState(event.username, correctOtp));
  }

  FutureOr<void> _onOtpValidationEvent(
    LoginOtpValidationEvent event,
    Emitter<LoginStates> emit,
  ) async {
    // دسترسی به state فعلی
    final currentState = state;

    if (currentState is LoginOtpValidationState) {
      final enteredCode = event.otpCode.trim();
      final correctCode = currentState.correctOtpCode;

      if (enteredCode == correctCode) {
        // کد درست است
        emit(LoginRecoverPasswordState(event.username, enteredCode));
        // یا مستقیم برو به صفحه تغییر رمز و ...
      } else {
        // کد اشتباه
        emit(LoginOtpValidationState(currentState.phoneNumber, correctCode));
      }
    }
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
      emit(LoginPasswordState(""));
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

  void safeEmit(Emitter<LoginStates> emit, LoginStates newState) {
    if (state != newState) {
      emit(newState);
    }
  }

  FutureOr<void> _onSuccessEvent(
    LoginSuccessEvent event,
    Emitter<LoginStates> emit,
  ) {
    safeEmit(emit, LoginSuccessState(event.moduleResult));
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
              networkMode: _networkMode,
              success: false,
              cachedKey: response.cacheKey,
              user: userDto,
              managementAccount: response.managementAccounts,
              resultType: LoginResultType.managementAccountPick,
            );
          } else {
            return LoginModuleResult(
              networkMode: _networkMode,
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
            networkMode: _networkMode,
            success: false,
            error: 'managementAccount = null',
            resultType: LoginResultType.validationError,
          );
        }
      } else {
        return LoginModuleResult(
          success: false,
          networkMode: _networkMode,
          error: 'نام کاربری یا رمز عبور نادرست است',
          resultType: LoginResultType.validationError,
        );
      }
    } catch (e) {
      return LoginModuleResult(
        networkMode: _networkMode,
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
                networkMode: _networkMode,
                user: moduleResult.user,
                token: moduleResult.token,
                cachedKey: cachedKey,
                language: Language(id: 0, languageCode: 'fa'),
                error: null,
                success: true,
                timestamp: DateTime.now(),
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
      UserDto user = (prev != null && prev!.user != null)
          ? prev.user!.copyWith(
              token: result.accessToken ?? '',
              refreshToken: result.refreshToken ?? '',
            )
          : UserDto(
              refreshToken: "a",
              token: "a",
              id: 0,
              fullName: "a",
              firstName: "A",
              imageUrl: "",
              password: "A",
              lastName: "a",
              userName: "f",
              type: "f",
            );

      final updated = LoginModuleResult(
        networkMode: _networkMode,
        success: true,
        token: result.accessToken,
        user: user,
        selectedManagementAccount: event.result.selectedManagementAccount,
        managementAccount: event.result.managementAccount,
        cachedKey: event.result.cachedKey,
        resultType: LoginResultType.success,
      );
      safeEmit(emit, LoginSuccessState(updated));
      _moduleManager.notifyResult(updated);
    }
  }
}
