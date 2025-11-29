import 'dart:convert';

import 'package:models_package/Base/language.dart';
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

    return await openDatabase(
      path,
      version: 1,
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
    return await _setValue(_deviceTokenkey,token);
  }

  @override
  Future<Language?> getLanguage() async {
    final value = await _getValue(_languageKey);
    if (value == null || value.isEmpty) return null;

    try {
      final Map<String, dynamic> map = jsonDecode(value) as Map<String, dynamic>;
      return Language.fromJson(map);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> setLanguage(Language token) async {
    await _setValue(_languageKey, jsonEncode(token.toJson()));
  }
}
