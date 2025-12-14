import 'dart:convert';
import 'dart:core';

import 'package:models_package/Base/base_request.dart';
import 'package:models_package/Base/enums.dart';
import 'package:models_package/Base/login_module.dart';
import 'package:path/path.dart';
import 'package:services_package/storage/data/datasource/sqlite_storage_datasource.dart';
import 'package:services_package/storage/data/model/sqlite_storage_data_model.dart';
import 'package:sqflite/sqflite.dart';

class SqliteStorageUseCase implements ISqliteStorageDataSource {
  static const String _dbName = 'app_storage.db';
  static const int _dbVersion = 2;
  static const int _singleRowId = 1;
  static const String _filtersTable = 'filters';
  static const String _filterInfoTable = 'filter_info';
  static const String _orderInfoTable = 'order_info';
  static const String _pagingInfoTable = 'paging_info';
  static const String _defaultsTable = 'defaults';
  static const String _loginSessionTable = 'login_sessions';

  Future<Database?> database() async => await _db;
  Database? _database;

  static final SqliteStorageUseCase instance = SqliteStorageUseCase();

  Future<Database> get _db async {
    if (_database != null && _database!.isOpen) {
      return _database!;
    }
    _database = await _initDatabase();
    return _database!;
  }

  void initialDb() async {
    _database = await _initDatabase();
  }

  Future<Database> _initDatabase() async {
    try {
      final path = join(await getDatabasesPath(), _dbName);

      return await openDatabase(
        path,
        version: _dbVersion,
        onCreate: _onCreate,
        onUpgrade: _onUpgrade,
        onOpen: _onOpen,
      );
    } catch (e) {
      throw (e.toString());
    }
  }

  Future<void> _onOpen(Database db) async {
    await _createAllTables(db, _dbVersion);
  }

  /// فقط وقتی DB تازه ساخته می‌شود
  Future<void> _onCreate(Database db, int version) async {
    await _createAllTables(db, _dbVersion);
  }

  Future<void> _createAllTables(Database db, int version) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS $_loginSessionTable (
        id INTEGER PRIMARY KEY,
        data TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE IF NOT EXISTS $_defaultsTable (
        id INTEGER PRIMARY KEY,
        data TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE IF NOT EXISTS $_filtersTable (
        id INTEGER PRIMARY KEY,
        data TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE IF NOT EXISTS $_filterInfoTable (
        id INTEGER PRIMARY KEY,
        data TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE IF NOT EXISTS $_orderInfoTable (
        id INTEGER PRIMARY KEY,
        data TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE IF NOT EXISTS $_pagingInfoTable (
        id INTEGER PRIMARY KEY,
        data TEXT NOT NULL
      )
    ''');
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {}

  bool get isDatabaseOpen {
    return _database != null && _database!.isOpen;
  }

  @override
  Future<Defaults> loadDefaults() {
    // TODO: implement loadDefaults
    throw UnimplementedError();
  }

  @override
  Future<FilterInfo> loadFilterInfo() {
    // TODO: implement loadFilterInfo
    throw UnimplementedError();
  }

  @override
  Future<Filters> loadFilters() {
    // TODO: implement loadFilters
    throw UnimplementedError();
  }

  @override
  Future<OrderInfo> loadOrderInfo() {
    // TODO: implement loadOrderInfo
    throw UnimplementedError();
  }

  @override
  Future<PagingInfo> loadPagingInfo() {
    // TODO: implement loadPagingInfo
    throw UnimplementedError();
  }

  @override
  Future<void> removeAll() async {
    final db = await _db;
    try {
      await db.transaction((txn) async {
        await txn.delete(_loginSessionTable);
        await txn.delete(_defaultsTable);
        await txn.delete(_filtersTable);
        await txn.delete(_filterInfoTable);
        await txn.delete(_orderInfoTable);
        await txn.delete(_pagingInfoTable);
      });
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Future<void> removeDefaults() {
    // TODO: implement removeDefaults
    throw UnimplementedError();
  }

  @override
  Future<void> removeFilterInfo() {
    // TODO: implement removeFilterInfo
    throw UnimplementedError();
  }

  @override
  Future<void> removeFilters() {
    // TODO: implement removeFilters
    throw UnimplementedError();
  }

  @override
  Future<void> removeOrderInfo() {
    // TODO: implement removeOrderInfo
    throw UnimplementedError();
  }

  @override
  Future<void> removePagingInfo() {
    // TODO: implement removePagingInfo
    throw UnimplementedError();
  }

  @override
  Future<void> saveDefaults(Defaults defaults) {
    // TODO: implement saveDefaults
    throw UnimplementedError();
  }

  @override
  Future<void> saveFilterInfo(FilterInfo filterInfos) {
    // TODO: implement saveFilterInfo
    throw UnimplementedError();
  }

  @override
  Future<void> saveFilters(Filters filters) {
    // TODO: implement saveFilters
    throw UnimplementedError();
  }

  @override
  Future<void> saveOrderInfo(OrderInfo filters) {
    // TODO: implement saveOrderInfo
    throw UnimplementedError();
  }

  @override
  Future<void> savePagingInfo(PagingInfo pagingInfo) {
    // TODO: implement savePagingInfo
    throw UnimplementedError();
  }

  @override
  Future<void> signOut() async {
    final db = await _db;
    await db.transaction((txn) async {
      await txn.delete(_loginSessionTable);
    });
  }

  @override
  Future<LoginModuleResult> sqlLoadLoginSessionModel() async {
    try {
      final data = await _load(_loginSessionTable);
      if (data == null) {
        return LoginModuleResult(
          success: false,
          resultType: LoginResultType.error,
        );
      }
      return LoginModuleResult.fromJson(data);
    } catch (e) {
      throw ('Failed to load login session: $e');
    }
  }

  @override
  Future<void> sqlRemoveLoginSessionModel() => _remove(_loginSessionTable);

  @override
  Future<void> sqlSaveLoginSessionModel(
    LoginModuleResult loginSessionModel,
  ) async {
    try {
      final now = DateTime.now();
      final expiresAt = now.add(const Duration(days: 7));

      await _save(_loginSessionTable, loginSessionModel.toJson());
    } catch (e) {}
  }

  Future<SqliteStorageDataModel> loadAll() {
    throw UnimplementedError();
  }

  Future<void> _save(String table, Map<String, dynamic> json) async {
    final db = await _db;
    await db.insert(table, {
      'id': _singleRowId,
      'data': jsonEncode(json),
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<Map<String, dynamic>?> _load(String table) async {
    final db = await _db;
    final result = await db!.query(
      table,
      where: 'id = ?',
      whereArgs: [_singleRowId],
      limit: 1,
    );

    if (result.isEmpty) return null;
    return jsonDecode(result.first['data'] as String);
  }

  Future<void> _remove(String table) async {
    final db = await _db;
    await db.delete(table, where: 'id = ?', whereArgs: [_singleRowId]);
  }
}
