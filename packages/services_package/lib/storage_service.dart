import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:models_package/Base/enums.dart';
import 'package:models_package/Base/language.dart';
import 'package:models_package/Base/login_module.dart';
import 'package:models_package/Base/operation_result.dart';
import 'package:models_package/Data/Auth/Login/dto.dart';
import 'package:models_package/Data/Auth/User/dto.dart';

import 'Interfaces/front_helper_services/istorage_service.dart';
import 'extension/exception_handler_service.dart';

class StorageService implements IStorageService {
  static final StorageService _instance = StorageService._internal();

  factory StorageService() => _instance;
  static const String _deviceTokenkey = 'device_Token';

  StorageService._internal();

  static const String _userDataKey = 'user_Data',
      _userTokenKey = 'user_Token',
      _languageKey = 'language_Data',
      _selectedManagementKey = 'selected_Management',
      _loginResultKey = 'login_Result';

  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage(
    // aOptions: AndroidOptions(
    //   encryptedSharedPreferences: true,
    //   resetOnError: true,
    //   sharedPreferencesName: 'LocalAndroidDb',
    //   storageCipherAlgorithm: StorageCipherAlgorithm.AES_CBC_PKCS7Padding,
    // ),
  );

  Future<void> _setValue(String key, String value) async {
    await _secureStorage.write(key: key, value: value);
  }

  Future<String?> _getValue(String key) async {
    return await _secureStorage.read(key: key);
  }

  Future<void> _deleteValue(String key) async {
    await _secureStorage.delete(key: key);
  }

  @override
  Future<void> setUser(UserDto? user) async {
    if (user == null) {
      await _deleteValue(_userDataKey);
    } else {
      await _setValue(_userDataKey, jsonEncode(user.toJson()));
    }
  }

  @override
  Future<UserDto?> getUser() async {
    final value = await _getValue(_userDataKey).withExceptionHandler(
      defaultValue: "",
      errorMessage: "USER Not Found !",
      sender: this,
    );
    if (value == null || value.isEmpty) return null;
    try {
      final Map<String, dynamic> map = jsonDecode(value);
      return UserDto.fromJson(map);
    } catch (e) {
      print('❌ خطا در خواندن کاربر: $e');
      return null;
    }
  }

  @override
  Future<void> setToken(String token) async {
    if (token.isEmpty) {
      await _deleteValue(_userTokenKey);
    } else {
      await _setValue(_userTokenKey, token);
    }
  }

  @override
  Future<String?> getToken() async => _getValue(_userTokenKey);

  @override
  Future<void> clearAll() async {
    await _secureStorage.deleteAll();
  }

  @override
  Future<String?> getDeviceToken() async => await _getValue(_deviceTokenkey);

  @override
  Future<void> setDeviceToken(String token) async {
    if (token.isEmpty) {
      await _deleteValue(_deviceTokenkey);
    } else {
      await _setValue(_deviceTokenkey, token);
    }
  }

  @override
  Future<Language?> getLanguage() async {
    final value = await _getValue(_languageKey);
    if (value == null || value.isEmpty) return null;
    try {
      final Map<String, dynamic> map = jsonDecode(value);
      return Language.fromJson(map);
    } catch (e) {
      print('❌ خطا در خواندن زبان: $e');
      return null;
    }
  }

  @override
  Future<void> setLanguage(Language language) async {
    await _setValue(_languageKey, jsonEncode(language.toJson()));
  }

  Future<void> setSelectedManagement(ManagementAccounts management) async {
    await _setValue(_selectedManagementKey, jsonEncode(management.toJson()));
  }

  Future<ManagementAccounts?> getSelectedManagement() async {
    final value = await _getValue(_selectedManagementKey);
    if (value == null || value.isEmpty) return null;
    try {
      final Map<String, dynamic> map = jsonDecode(value);
      return ManagementAccounts.fromJson(map);
    } catch (e) {
      print('❌ خطا در خواندن مدیریت: $e');
      return null;
    }
  }

  Future<void> clearSelectedManagement() async {
    await _deleteValue(_selectedManagementKey);
  }

  @override
  Future<void> setLoginModuleResult(LoginModuleResult result) async {
    try {
      await _setValue(_loginResultKey, jsonEncode(result.toJson()));
    } catch (e) {
      print('❌ خطا در ذخیره نتیجه لاگین: $e');
      throw e;
    }
  }

  @override
  Future<LoginModuleResult?> getLoginModuleResult() async {
    final value = await _getValue(_loginResultKey);
    if (value == null || value.isEmpty) return null;
    try {
      final Map<String, dynamic> map = jsonDecode(value);
      return LoginModuleResult.fromJson(map);
    } catch (e) {
      print('❌ خطا در خواندن نتیجه لاگین: $e');
      return null;
    }
  }

  Future<void> clearLoginModuleResult() async {
    await _deleteValue(_loginResultKey);
  }

  @override
  Future<LoginModuleResult?> loadLastLoginSession() async {
    final token = await getToken();
    if (token == null || token.isEmpty) return null;
    final lastResult = await getLoginModuleResult();
    if (lastResult != null && lastResult.success) {
      return lastResult;
    }
    return null;
  }

  @override
  Future<OperationResult> setLoginSession({
    required UserDto user,
    required String token,
    required Language language,
    ManagementAccounts? selectedManagement,
    LoginModuleResult? loginResult,
  }) async {
    try {
      await setUser(user);
      await setToken(token);
      await setLanguage(language);
      if (selectedManagement != null) {
        await setSelectedManagement(selectedManagement);
      }
      if (loginResult != null) {
        await setLoginModuleResult(loginResult);
      }
      return OperationResult.success(
        message: "اطلاعات ورود با موفقیت ذخیره شد",
        data: {
          'user': user.userName,
          'tokenLength': token.length,
          'language': language.languageCode,
        },
      );
    } catch (e, stackTrace) {
      String errorMessage;
      if (e is FormatException) {
        errorMessage = "خطا در فرمت داده‌های ورودی";
      } else if (e is UnsupportedError) {
        errorMessage = "عملیات مورد نظر پشتیبانی نمی‌شود";
      } else {
        errorMessage = "خطا در ذخیره اطلاعات ورود";
      }
      return OperationResult.failure(
        message: "$errorMessage: ${e.toString()}",
        data: {
          'exception': e,
          'stackTrace': stackTrace.toString(),
          'user': user.userName,
        },
      );
    }
  }

  @override
  Future<Map<String, dynamic>> loadLoginSession() async {
    final user = await getUser();
    final token = await getToken() ?? '';
    final language = await getLanguage();
    final selectedManagement = await getSelectedManagement();
    final loginResult = await getLoginModuleResult();
    return {
      SessionKeys.user.key: user,
      SessionKeys.token.key: token,
      SessionKeys.selectedManagement.key: selectedManagement,
      SessionKeys.loginResult.key: loginResult,
      SessionKeys.language.key: language,
    };
  }

  Future<void> clearLoginSession() async {
    await _deleteValue(_userDataKey);
    await _deleteValue(_userTokenKey);
    await _deleteValue(_selectedManagementKey);
    await _deleteValue(_loginResultKey);
    await _deleteValue(_languageKey);
  }

  // متد کمکی برای دیباگ (Note: Secure storage doesn't support querying all, so this is optional or use for testing)
  Future<Map<String, String>> getAllData() async {
    return await _secureStorage.readAll();
  }
}
