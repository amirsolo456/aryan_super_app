// import 'dart:async';
// import 'dart:convert';
//
// import 'package:models_package/Base/enums.dart';
// import 'package:models_package/Base/language.dart';
// import 'package:models_package/Base/login_module.dart';
// import 'package:models_package/Base/operation_result.dart';
// import 'package:models_package/Data/Auth/Login/dto.dart';
// import 'package:models_package/Data/Auth/User/dto.dart';
// import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';
//
// import 'Interfaces/front_helper_services/istorage_service.dart';
// import 'extension/exception_handler_service.dart';
//
// class StorageService implements IStorageService {
//   // Singleton pattern
//   static final StorageService _instance = StorageService._internal();
//
//   factory StorageService() => _instance;
//
//   StorageService._internal();
//
//   // کلیدهای ذخیره‌سازی (همانند قبل)
//   static const String _userDataKey = 'user_Data';
//   static const String _userTokenKey = 'user_Token';
//   static const String _languageKey = 'language_Data';
//   static const String _selectedManagementKey = 'selected_Management';
//   static const String _loginResultKey = 'login_Result';
//   static const String _deviceTokenkey = 'device_Token';
//
//   // تنظیمات دیتابیس
//   static const String _databaseName = 'app_storage.db';
//   static const int _databaseVersion =
//       2; // اگر نیاز به آپگرید داشتید افزایش دهید
//   static const String _tableName = 'key_value_storage';
//   static const String _columnKey = 'key';
//   static const String _columnValue = 'value';
//   static const String _columnUpdatedAt = 'updated_at';
//
//   Database? _database;
//
//   // Getter برای دیتابیس (lazy initialization)
//   Future<Database> get database async {
//     if (_database != null) return _database!;
//     _database = await _initDatabase();
//     return _database!;
//   }
//
//   Future<Database> _initDatabase() async {
//     final databasesPath = await getDatabasesPath();
//     final path = join(databasesPath, _databaseName);
//
//     return await openDatabase(
//       path,
//       version: _databaseVersion,
//       onCreate: _onCreate,
//       onUpgrade: _onUpgrade,
//       onConfigure: _onConfigure,
//     );
//   }
//
//   Future<void> _onConfigure(Database db) async {
//     await db.execute('PRAGMA foreign_keys = ON');
//   }
//
//   Future<void> _onCreate(Database db, int version) async {
//     await db.execute('''
//       CREATE TABLE $_tableName (
//         $_columnKey TEXT PRIMARY KEY,
//         $_columnValue TEXT,
//         $_columnUpdatedAt INTEGER DEFAULT (strftime('%s', 'now'))
//       )
//     ''');
//
//     // ایجاد ایندکس برای بهبود performance
//     await db.execute('''
//       CREATE INDEX idx_updated_at ON $_tableName($_columnUpdatedAt)
//     ''');
//   }
//
//   Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
//     if (oldVersion < 2) {
//       // برای نسخه‌های آینده - می‌توانید منطق مهاجرت اضافه کنید
//       await db.execute('''
//         ALTER TABLE $_tableName ADD COLUMN $_columnUpdatedAt INTEGER DEFAULT (strftime('%s', 'now'))
//       ''');
//     }
//   }
//
//   // ========== متدهای اصلی CRUD ==========
//
//   Future<void> _setValue(String key, String value) async {
//     final db = await database;
//     final timestamp = DateTime.now().millisecondsSinceEpoch ~/ 1000;
//
//     await db.insert(_tableName, {
//       _columnKey: key,
//       _columnValue: value,
//       _columnUpdatedAt: timestamp,
//     }, conflictAlgorithm: ConflictAlgorithm.replace);
//   }
//
//   Future<String?> _getValue(String key) async {
//     final db = await database;
//     final List<Map<String, dynamic>> result = await db.query(
//       _tableName,
//       columns: [_columnValue],
//       where: '$_columnKey = ?',
//       whereArgs: [key],
//       limit: 1,
//     );
//
//     if (result.isNotEmpty) {
//       return result.first[_columnValue] as String?;
//     }
//     return null;
//   }
//
//   Future<void> _deleteValue(String key) async {
//     final db = await database;
//     await db.delete(_tableName, where: '$_columnKey = ?', whereArgs: [key]);
//   }
//
//   Future<void> _deleteAll() async {
//     final db = await database;
//     await db.delete(_tableName);
//   }
//
//   Future<int> _getItemCount() async {
//     final db = await database;
//     final count = Sqflite.firstIntValue(
//       await db.rawQuery('SELECT COUNT(*) FROM $_tableName'),
//     );
//     return count ?? 0;
//   }
//
//   Future<Map<String, String>> getAllData() async {
//     final db = await database;
//     final List<Map<String, dynamic>> maps = await db.query(
//       _tableName,
//       orderBy: '$_columnUpdatedAt DESC',
//     );
//
//     final Map<String, String> result = {};
//     for (final map in maps) {
//       final key = map[_columnKey] as String;
//       final value = map[_columnValue] as String?;
//       if (value != null) {
//         result[key] = value;
//       }
//     }
//     return result;
//   }
//
//   Future<void> backupDatabase() async {
//     final databasesPath = await getDatabasesPath();
//     final sourcePath = join(databasesPath, _databaseName);
//     final backupPath = join(databasesPath, '${_databaseName}.backup');
//
//     // این بخش نیاز به import dart:io دارد
//     // await File(sourcePath).copy(backupPath);
//   }
//
//   // ========== متدهای اینترفیس (بدون تغییر نسبت به قبل) ==========
//
//   @override
//   Future<void> setUser(UserDto? user) async {
//     if (user == null) {
//       await _deleteValue(_userDataKey);
//     } else {
//       await _setValue(_userDataKey, jsonEncode(user.toJson()));
//     }
//   }
//
//   @override
//   Future<UserDto?> getUser() async {
//     final value = await _getValue(_userDataKey).withExceptionHandler(
//       defaultValue: "",
//       errorMessage: "USER Not Found !",
//       sender: this,
//     );
//     if (value == null || value.isEmpty) return null;
//     try {
//       final Map<String, dynamic> map = jsonDecode(value);
//       return UserDto.fromJson(map);
//     } catch (e) {
//       print('❌ خطا در خواندن کاربر: $e');
//       return null;
//     }
//   }
//
//   @override
//   Future<void> setToken(String token) async {
//     if (token.isEmpty) {
//       await _deleteValue(_userTokenKey);
//     } else {
//       await _setValue(_userTokenKey, token);
//     }
//   }
//
//   @override
//   Future<String?> getToken() async => _getValue(_userTokenKey);
//
//   @override
//   Future<void> clearAll() async {
//     await _deleteAll();
//   }
//
//   @override
//   Future<String?> getDeviceToken() async => await _getValue(_deviceTokenkey);
//
//   @override
//   Future<void> setDeviceToken(String token) async {
//     if (token.isEmpty) {
//       await _deleteValue(_deviceTokenkey);
//     } else {
//       await _setValue(_deviceTokenkey, token);
//     }
//   }
//
//   @override
//   Future<Language?> getLanguage() async {
//     final value = await _getValue(_languageKey);
//     if (value == null || value.isEmpty) return null;
//     try {
//       final Map<String, dynamic> map = jsonDecode(value);
//       return Language.fromJson(map);
//     } catch (e) {
//       print('❌ خطا در خواندن زبان: $e');
//       return null;
//     }
//   }
//
//   @override
//   Future<void> setLanguage(Language language) async {
//     await _setValue(_languageKey, jsonEncode(language.toJson()));
//   }
//
//   Future<void> setSelectedManagement(ManagementAccounts management) async {
//     await _setValue(_selectedManagementKey, jsonEncode(management.toJson()));
//   }
//
//   Future<ManagementAccounts?> getSelectedManagement() async {
//     final value = await _getValue(_selectedManagementKey);
//     if (value == null || value.isEmpty) return null;
//     try {
//       final Map<String, dynamic> map = jsonDecode(value);
//       return ManagementAccounts.fromJson(map);
//     } catch (e) {
//       print('❌ خطا در خواندن مدیریت: $e');
//       return null;
//     }
//   }
//
//   Future<void> clearSelectedManagement() async {
//     await _deleteValue(_selectedManagementKey);
//   }
//
//   @override
//   Future<void> setLoginModuleResult(LoginModuleResult result) async {
//     try {
//       await _setValue(_loginResultKey, jsonEncode(result.toJson()));
//     } catch (e) {
//       print('❌ خطا در ذخیره نتیجه لاگین: $e');
//       throw e;
//     }
//   }
//
//   @override
//   Future<LoginModuleResult?> getLoginModuleResult() async {
//     final value = await _getValue(_loginResultKey);
//     if (value == null || value.isEmpty) return null;
//     try {
//       final Map<String, dynamic> map = jsonDecode(value);
//       return LoginModuleResult.fromJson(map);
//     } catch (e) {
//       print('❌ خطا در خواندن نتیجه لاگین: $e');
//       return null;
//     }
//   }
//
//   Future<void> clearLoginModuleResult() async {
//     await _deleteValue(_loginResultKey);
//   }
//
//   @override
//   Future<LoginModuleResult?> loadLastLoginSession() async {
//     final token = await getToken();
//     if (token == null || token.isEmpty) return null;
//     final lastResult = await getLoginModuleResult();
//     if (lastResult != null && lastResult.success) {
//       return lastResult;
//     }
//     return null;
//   }
//
//   @override
//   Future<OperationResult> setLoginSession({
//     required UserDto user,
//     required String token,
//     required Language language,
//     ManagementAccounts? selectedManagement,
//     LoginModuleResult? loginResult,
//   }) async {
//     try {
//       await setUser(user);
//       await setToken(token);
//       await setLanguage(language);
//       if (selectedManagement != null) {
//         await setSelectedManagement(selectedManagement);
//       }
//       if (loginResult != null) {
//         await setLoginModuleResult(loginResult);
//       }
//       return OperationResult.success(
//         message: "اطلاعات ورود با موفقیت ذخیره شد",
//         data: {
//           'user': user.userName,
//           'tokenLength': token.length,
//           'language': language.languageCode,
//         },
//       );
//     } catch (e, stackTrace) {
//       String errorMessage;
//       if (e is FormatException) {
//         errorMessage = "خطا در فرمت داده‌های ورودی";
//       } else if (e is UnsupportedError) {
//         errorMessage = "عملیات مورد نظر پشتیبانی نمی‌شود";
//       } else {
//         errorMessage = "خطا در ذخیره اطلاعات ورود";
//       }
//       return OperationResult.failure(
//         message: "$errorMessage: ${e.toString()}",
//         data: {
//           'exception': e,
//           'stackTrace': stackTrace.toString(),
//           'user': user.userName,
//         },
//       );
//     }
//   }
//
//   @override
//   Future<Map<String, dynamic>> loadLoginSession() async {
//     final user = await getUser();
//     final token = await getToken() ?? '';
//     final language = await getLanguage();
//     final selectedManagement = await getSelectedManagement();
//     final loginResult = await getLoginModuleResult();
//     return {
//       SessionKeys.user.key: user,
//       SessionKeys.token.key: token,
//       SessionKeys.selectedManagement.key: selectedManagement,
//       SessionKeys.loginResult.key: loginResult,
//       SessionKeys.language.key: language,
//     };
//   }
//
//   Future<void> clearLoginSession() async {
//     await _deleteValue(_userDataKey);
//     await _deleteValue(_userTokenKey);
//     await _deleteValue(_selectedManagementKey);
//     await _deleteValue(_loginResultKey);
//     await _deleteValue(_languageKey);
//   }
//
//   // متدهای اضافی برای مدیریت بهتر
//
//   Future<void> closeDatabase() async {
//     if (_database != null) {
//       await _database!.close();
//       _database = null;
//     }
//   }
//
//   Future<void> deleteDatabaseFile() async {
//     await closeDatabase();
//     final databasesPath = await getDatabasesPath();
//     final path = join(databasesPath, _databaseName);
//     await deleteDatabase(path);
//   }
//
//   // Future<int> getDatabaseSize() async {
//   //   final databasesPath = await getDatabasesPath();
//   //   final path = join(databasesPath);
//   //   return await openDatabase(
//   //     path,
//   //     onCreate: (db, version) => _onCreate(db, version),
//   //     onConfigure: (db) => _onConfigure,
//   //     version: 2,
//   //   );
//   // }
// }
