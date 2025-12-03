import 'dart:convert';
import 'dart:io';

import 'package:models_package/Base/language.dart';
import 'package:models_package/Base/login_module.dart';
import 'package:models_package/Base/operation_result.dart';
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
      _selectedManagementKey = 'selected_Management',
      _loginResultKey = 'login_Result',
      _storageKey = 'app_storage.db';

  Database? _db;

  Future<Database> get _database async {
    if (_db != null) return _db!;
    _db = await _initDb();
    return _db!;
  }

  Future<void> _createDatabase(Database db, int version) async {
    print('🔨 ساخت دیتابیس جدید');
    await db.execute('''
    CREATE TABLE $_tableKey(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      key TEXT UNIQUE NOT NULL,
      value TEXT,
      created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
      updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    )
  ''');

    await db.execute('CREATE INDEX idx_key ON $_tableKey(key)');
    print('✅ ساختار دیتابیس ایجاد شد');
  }

  Future<bool> _tableExists(Database db, String tableName) async {
    final result = await db.rawQuery(
      "SELECT name FROM sqlite_master WHERE type='table' AND name='$tableName'",
    );
    return result.isNotEmpty;
  }

  Future<Database> _initDb() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, _storageKey);

    // بررسی وجود دیتابیس
    final dbFile = File(path);
    final dbExists = await dbFile.exists();

    return await openDatabase(
      path,
      version: 2,
      onCreate: _createDatabase,
      onUpgrade: (db, oldVersion, newVersion) async {
        print('🔄 آپگرید از نسخه $oldVersion به $newVersion');

        // مهاجرت از نسخه 1 به 2
        if (oldVersion < 2) {
          final tableExists = await _tableExists(db, _tableKey);
          if (!tableExists) {
            await _createDatabase(db, newVersion);
          } else {
            // در اینجا می‌توانید تغییرات ساختاری را اعمال کنید
            // مثلاً اضافه کردن ستون جدید
            // await db.execute('ALTER TABLE $_tableKey ADD COLUMN new_column TEXT');
          }
        }
      },
      onOpen: (db) {
        print('📖 دیتابیس باز شد');
      },
    );
  }

  Future<void> _setValue(String key, String value) async {
    final db = await _database;
    await db.insert(_tableKey, {
      'key': key,
      'value': value,
      'updated_at': DateTime.now().toIso8601String(),
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
    try {
      final Map<String, dynamic> map = jsonDecode(value);
      return UserDto.fromJson(map);
    } catch (e) {
      print('❌ خطا در خواندن کاربر: $e');
      return null;
    }
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
  Future<String?> getDeviceToken() async => await _getValue(_deviceTokenkey);

  @override
  Future<void> setDeviceToken(String token) async {
    return await _setValue(_deviceTokenkey, token);
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
    await _setValue(_selectedManagementKey, '');
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
    await _setValue(_loginResultKey, '');
  }

  @override
  Future<LoginModuleResult?> loadLastLoginSession() async {
    final token = await getToken();
    if (token == null) return null;

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

    final token = (user != null && user.token != null ?? user!.token, "");

    final language = await getLanguage();
    // final selectedManagementKey = await getSelectedManagement();
    final loginResult = await getLoginModuleResult();

    return {
      'user': user,
      'token': token,
      // 'selectedManagementKey': selectedManagementKey,
      'loginResult': loginResult,
      'language': language,
    };
  }

  Future<void> clearLoginSession() async {
    await _setValue(_userDataKey, '');
    await _setValue(_userTokenKey, '');
    await _setValue(_selectedManagementKey, '');
    await _setValue(_loginResultKey, '');
    await _setValue(_languageKey, '');
  }

  // متد کمکی برای دیباگ
  Future<List<Map<String, dynamic>>> getAllData() async {
    final db = await _database;
    return await db.query(_tableKey);
  }
}
