import 'dart:convert';
import 'dart:core';
import 'dart:io' show Platform;

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:models_package/Base/login_module.dart' as prefix0;
import 'package:models_package/Base/login_module.dart';
import 'package:models_package/Data/Auth/User/dto.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

import '../../data/datasource/secure_storage_datasource.dart';
import '../../data/model/secure_storage_data_model.dart';

class SecureStorageUseCase implements ISecureStorageDataSource {
  static const String _tokenKey = 'auth_token';
  static const String _userKey = 'user_data';
  static const String _sessionTable = 'login_sessions';

  // گزینه‌های امنیتی برای iOS و Android
  static const AndroidOptions _androidOptions = AndroidOptions(
    // encryptedSharedPreferences: true,
  );

  static const IOSOptions _iosOptions = IOSOptions(
    // accessibility: KeychainAccessibility.first_unlock,
  );

  final FlutterSecureStorage _secureStorage;

  // Constructor با امکان inject کردن storage برای تست‌پذیری
  SecureStorageUseCase({FlutterSecureStorage? secureStorage})
    : _secureStorage =
          secureStorage ??
          const FlutterSecureStorage(
            aOptions: _androidOptions,
            iOptions: _iosOptions,
          );

  @override
  Future<String> loadToken() async {
    try {
      final token = await _secureStorage.read(
        key: _tokenKey,
        aOptions: _androidOptions,
        iOptions: _iosOptions,
      );
      return token ?? '';
    } catch (e) {
      print('Error loading token: $e');
      return '';
    }
  }

  @override
  Future<void> saveToken(String token) async {
    try {
      await _secureStorage.write(
        key: _tokenKey,
        value: token,
        aOptions: _androidOptions,
        iOptions: _iosOptions,
      );
    } catch (e) {
      print('Error saving token: $e');
      throw Exception('Failed to save token');
    }
  }

  @override
  Future<void> removeToken() async {
    try {
      await _secureStorage.delete(
        key: _tokenKey,
        aOptions: _androidOptions,
        iOptions: _iosOptions,
      );
    } catch (e) {
      print('Error removing token: $e');
      throw Exception('Failed to remove token');
    }
  }

  @override
  Future<UserDto> loadUser() async {
    try {
      final userJson = await _secureStorage.read(
        key: _userKey,
        aOptions: _androidOptions,
        iOptions: _iosOptions,
      );

      if (userJson == null || userJson.isEmpty) {
        return UserDto(id: 0, refreshToken: '', token: '');
      }

      final Map<String, dynamic> userMap = json.decode(userJson);
      return UserDto.fromJson(userMap);
    } catch (e) {
      print('Error loading user: $e');
      return UserDto(id: 0, refreshToken: '', token: '');
    }
  }

  @override
  Future<void> saveUser(UserDto user) async {
    try {
      final userJson = json.encode(user.toJson());
      await _secureStorage.write(
        key: _userKey,
        value: userJson,
        aOptions: _androidOptions,
        iOptions: _iosOptions,
      );
    } catch (e) {
      print('Error saving user: $e');
      throw Exception('Failed to save user');
    }
  }

  @override
  Future<void> removeUser() async {
    try {
      await _secureStorage.delete(
        key: _userKey,
        aOptions: _androidOptions,
        iOptions: _iosOptions,
      );
    } catch (e) {
      print('Error removing user: $e');
      throw Exception('Failed to remove user');
    }
  }

  Future<SecureStorageDataModel> loadAll() async {
    try {
      final token = await loadToken();
      final user = await loadUser();

      return SecureStorageDataModel(Id: 0, token: token, user: user);
    } catch (e) {
      print('Error loading all data: $e');
      return SecureStorageDataModel(
        Id: 0,
        token: '',
        user: UserDto(token: '', refreshToken: ''),
      );
    }
  }

  @override
  Future<void> removeAll() async {
    try {
      await _secureStorage.deleteAll(
        aOptions: _androidOptions,
        iOptions: _iosOptions,
      );
    } catch (e) {
      print('Error removing all data: $e');
      throw Exception('Failed to remove all data');
    }
  }

  @override
  Future<void> signOut() async {
    try {
      // ابتدا توکن و کاربر را حذف می‌کنیم
      await removeToken();
      await removeUser();

      // یا می‌توانیم از removeAll استفاده کنیم:
      // await removeAll();
    } catch (e) {
      print('Error signing out: $e');
      throw Exception('Failed to sign out');
    }
  }

  // متد کمکی برای چک کردن وجود توکن
  Future<bool> hasToken() async {
    final token = await loadToken();
    return token.isNotEmpty;
  }

  // متد کمکی برای چک کردن وجود کاربر
  Future<bool> hasUser() async {
    final user = await loadUser();
    if (user == null) return false;
    return true; // فرض می‌کنیم UserDto متد isEmpty دارد
  }

  // متد کمکی برای به‌روزرسانی قسمتی از اطلاعات کاربر
  Future<void> updateUserPartial(Map<String, dynamic> partialData) async {
    try {
      final currentUser = await loadUser();
      final updatedUser = UserDto.fromJson(partialData);
      await saveUser(updatedUser);
    } catch (e) {
      print('Error updating user partially: $e');
      throw Exception('Failed to update user');
    }
  }

  @override
  Future<prefix0.LoginModuleResult> loadLoginSessionModel() async {
    try {
      final String? jsonString = await _secureStorage.read(
        key: _sessionTable,
        aOptions: _androidOptions,
        iOptions: _iosOptions,
      );

      print('Loaded from storage: $jsonString'); // اضافه کردن log

      if (jsonString == null || jsonString.isEmpty) {
        print('No session found in storage'); // log
        return prefix0.LoginModuleResult.failure('Session not found');
      }

      final Map<String, dynamic> jsonMap =
          jsonDecode(jsonString) as Map<String, dynamic>;

      print('Decoded map: $jsonMap'); // log

      return prefix0.LoginModuleResult.fromJson(jsonMap);
    } catch (e) {
      print('Error loading session: $e'); // log
      return prefix0.LoginModuleResult.failure('Invalid session data: $e');
    }
  }

  @override
  Future<void> removeLoginSessionModel() async {
    await _secureStorage.delete(
      key: _sessionTable,
      aOptions: _androidOptions,
      iOptions: _iosOptions,
    );
  }

  @override
  Future<void> saveLoginSessionModel(
    LoginModuleResult loginSessionModel,
  ) async {
    try {
      // 1️⃣ ذخیره Token
      final accessToken = loginSessionModel.token;
      if (accessToken != null && accessToken.isNotEmpty) {
        await saveToken(accessToken);
      }

      // 2️⃣ ذخیره User
      final user = loginSessionModel.user;
      if (user != null) {
        await saveUser(user);
      }

      // 3️⃣ ذخیره Session Meta (بدون token و user)
      final Map<String, dynamic> sessionMap =
          Map<String, dynamic>.from(loginSessionModel.toJson())
            ..remove('access_token')
            ..remove('Access_Token')
            ..remove('user');

      final jsonString = jsonEncode(sessionMap);

      await _secureStorage.write(
        key: _sessionTable,
        value: jsonString,
        aOptions: _androidOptions,
        iOptions: _iosOptions,
      );
    } catch (e) {
      print('Error saving login session model: $e');
      throw Exception('Failed to save login session model');
    }
  }

  @override
  Future<String?> getSecureDbPath() async {
    try {
      if (Platform.isAndroid) {
        final directory = await getApplicationSupportDirectory();
        final sharedPrefsPath = path.join(directory.path, '../shared_prefs');
        final filePath = path.join(sharedPrefsPath, 'FlutterSecureStorage.xml');
        return filePath;
      } else {
        return null;
      }
    } catch (e) {
      print('Error getting secure storage path: $e');
      return null;
    }
  }

  //
  // @override
  // Future<void> saveLoginSessionModel(
  //   LoginModuleResult loginSessionModel,
  // ) async {
  //   Map<String, dynamic> map;
  //   final dyn = loginSessionModel as dynamic;
  //
  //   try {
  //     map = (dyn.toJson() as Map<String, dynamic>);
  //   } catch (_) {
  //     try {
  //       map = (dyn.toMap() as Map<String, dynamic>);
  //     } catch (_) {
  //       try {
  //         map = jsonDecode(jsonEncode(dyn)) as Map<String, dynamic>;
  //       } catch (e) {
  //         throw Exception('Unable to convert LoginSessionModel to Map: $e');
  //       }
  //     }
  //   }
  //
  //   // این قسمت اضافه شده - ذخیره‌سازی واقعی
  //   final jsonString = jsonEncode(map);
  //   await _secureStorage.write(
  //     key: _sessionTable,
  //     value: jsonString,
  //     aOptions: _androidOptions,
  //     iOptions: _iosOptions,
  //   );
  // }
}
