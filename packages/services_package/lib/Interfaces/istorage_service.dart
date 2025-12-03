import 'package:models_package/Base/language.dart';
import 'package:models_package/Base/login_module.dart';
import 'package:models_package/Base/operation_result.dart';
import 'package:models_package/Data/Auth/Login/dto.dart';
import 'package:models_package/Data/Auth/User/dto.dart';

abstract class IStorageService {
  Future<void> setUser(UserDto? user);

  Future<UserDto?> getUser();

  Future<void> setToken(String token);

  Future<String?> getToken();

  Future<void> clearAll();

  Future<void> setDeviceToken(String token);

  Future<String?> getDeviceToken();

  Future<void> setLanguage(Language token);

  Future<Language?> getLanguage();

  Future<void> setLoginModuleResult(LoginModuleResult result);

  Future<OperationResult> setLoginSession({
    required UserDto user,
    required String token,
    required Language language,
    ManagementAccounts? selectedManagement,
    LoginModuleResult? loginResult,
  });

  Future<LoginModuleResult?> getLoginModuleResult();

  Future<LoginModuleResult?> loadLastLoginSession();

  Future<Map<String, dynamic>> loadLoginSession();
}
