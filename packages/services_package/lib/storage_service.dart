import 'dart:convert';

import 'package:models_package/Base/language.dart';
import 'package:models_package/Base/login_module.dart';
import 'package:models_package/Data/Auth/Login/dto.dart';
import 'package:models_package/Data/Auth/User/dto.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'Interfaces/istorage_service.dart';

class StorageService implements IStorageService {
  static final StorageService _instance = StorageService._internal();

  factory StorageService() => _instance;

  StorageService._internal();

  static String _tableKey = 'table_Data',
      _userDataKey = 'user_Data',
      _userTokenKey = 'user_Token',
      _deviceTokenkey = 'device_Token',
      _languageKey = 'language_Data',
      _selectedManagementKey =
          'selected_Management', // کلید جدید برای مدیریت انتخاب شده
      _loginResultKey = 'login_Result',
      _storageKey = 'app_storage.db';

  Database? _db;

  Future<Database> get _database async {
    if (_db != null) return _db!;
    _db = await _initDb();
    return _db!;
  }

  Future<Database> _initDb() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, _storageKey);
    await deleteDatabase(path);

    return await openDatabase(
      path,
      version: 2,
      onCreate: (db, version) async {
        await db.execute(
          '''
          CREATE TABLE ''' +
              _tableKey +
              '''(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            key TEXT UNIQUE,
            value TEXT
          )
        ''',
        );
      },
    );
  }

  Future<void> _setValue(String key, String value) async {
    final db = await _database;
    await db.insert(_tableKey, {
      'key': key,
      'value': value,
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<String?> _getValue(String key) async {
    final db = await _database;
    final result = await db.query(
      _tableKey,
      where: 'key = ?',
      whereArgs: [key],
    );
    if (result.isNotEmpty) return result.first['value'] as String;
    return null;
  }

  @override
  Future<void> setUser(UserDto? user) async {
    if (user == null) {
      await _setValue(_userDataKey, '');
    } else {
      await _setValue(_userDataKey, jsonEncode(user.toJson()));
    }
  }

  @override
  Future<UserDto?> getUser() async {
    final value = await _getValue(_userDataKey);
    if (value == null || value.isEmpty) return null;
    final Map<String, dynamic> map = jsonDecode(value);
    return UserDto.fromJson(map);
  }

  @override
  Future<void> setToken(String token) async => _setValue(_userTokenKey, token);

  @override
  Future<String?> getToken() async => _getValue(_userTokenKey);

  @override
  Future<void> clearAll() async {
    final db = await _database;
    await db.delete(_tableKey);
  }

  @override
  Future<String?> getDeviceToken() async {
    return await _getValue(_deviceTokenkey);
  }

  @override
  Future<void> setDeviceToken(String token) async {
    return await _setValue(_deviceTokenkey, token);
  }

  @override
  Future<Language?> getLanguage() async {
    final value = await _getValue(_languageKey);
    if (value == null || value.isEmpty) return null;

    try {
      final Map<String, dynamic> map =
          jsonDecode(value) as Map<String, dynamic>;
      return Language.fromJson(map);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> setLanguage(Language token) async {
    await _setValue(_languageKey, jsonEncode(token.toJson()));
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
      return null;
    }
  }

  Future<void> clearSelectedManagement() async {
    await _setValue(_selectedManagementKey, '');
  }

  @override
  Future<void> setLoginModuleResult(LoginModuleResult result) async {
    try {
      await _setValue(_loginResultKey, jsonEncode(result.toJson()));
    } catch (e) {
      print('Error saving login result: $e');
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
      print('Error loading login result: $e');
      return null;
    }
  }

  Future<void> clearLoginModuleResult() async {
    await _setValue(_loginResultKey, '');
  }

  Future<LoginModuleResult?> loadLastLoginSession() async {
    final storageService = StorageService();

    // بررسی آیا session ذخیره شده وجود دارد
    final lastResult = await storageService.getLoginModuleResult();

    if (lastResult != null && lastResult.success) {
      // بررسی منقضی نشدن token (اختیاری)
      final token = await storageService.getToken();
      if (token != null) {
        return lastResult;
      }
    }

    return null;
  }

  Future<void> saveLoginSession({
    required UserDto user,
    required String token,
    ManagementAccounts? selectedManagement,
    LoginModuleResult? loginResult,
  }) async {
    await setUser(user);
    await setToken(token);

    if (selectedManagement != null) {
      await setSelectedManagement(selectedManagement);
    }

    if (loginResult != null) {
      await setLoginModuleResult(loginResult);
    }
  }

  Future<Map<String, dynamic>> loadLoginSession() async {
    final user = await getUser();
    final token = await getToken();
    final selectedManagement = await getSelectedManagement();
    final loginResult = await getLoginModuleResult();

    return {
      'user': user,
      'token': token,
      'selectedManagement': selectedManagement,
      'loginResult': loginResult,
    };
  }

  Future<void> clearLoginSession() async {
    await _setValue(_userDataKey, '');
    await _setValue(_userTokenKey, '');
    await _setValue(_selectedManagementKey, '');
    await _setValue(_loginResultKey, '');
  }
}
