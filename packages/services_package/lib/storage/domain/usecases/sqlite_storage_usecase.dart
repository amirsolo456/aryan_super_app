import 'dart:core';

import 'package:models_package/Base/base_request.dart';
import 'package:path/path.dart';
import 'package:services_package/storage/data/datasource/sqlite_storage_datasource.dart';
import 'package:services_package/storage/data/model/sqlite_storage_data_model.dart';
import 'package:sqflite/sqflite.dart';

class SqliteStorageUseCase implements ISqliteStorageDataSource {
  static const String _filtersTable = 'filters';
  static const String _filterInfoTable = 'filter_info';
  static const String _orderInfoTable = 'order_info';
  static const String _pagingInfoTable = 'paging_info';
  static const String _defaultsTable = 'defaults';
  late Database _database;

  // Added for database initialization (call this before using the class)
  Future<void> initDatabase() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'app_storage.db');
    _database = await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  // Placeholder table creations - replace columns with actual model fields
  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS $_defaultsTable (
        id INTEGER PRIMARY KEY,
        -- Add Defaults model fields, e.g., theme TEXT, language TEXT
      )
    ''');
    await db.execute('''
      CREATE TABLE IF NOT EXISTS $_filtersTable (
        id INTEGER PRIMARY KEY,
        -- Add Filters model fields, e.g., category TEXT, active INTEGER
      )
    ''');
    await db.execute('''
      CREATE TABLE IF NOT EXISTS $_filterInfoTable (
        id INTEGER PRIMARY KEY,
        -- Add FilterInfo model fields, e.g., count INTEGER, type TEXT
      )
    ''');
    await db.execute('''
      CREATE TABLE IF NOT EXISTS $_orderInfoTable (
        id INTEGER PRIMARY KEY,
        -- Add OrderInfo model fields, e.g., sortBy TEXT, direction TEXT
      )
    ''');
    await db.execute('''
      CREATE TABLE IF NOT EXISTS $_pagingInfoTable (
        id INTEGER PRIMARY KEY,
        -- Add PagingInfo model fields, e.g., page INTEGER, size INTEGER
      )
    ''');
  }

  @override
  Future<void> _loadAll() async {
    // Optional: Preload data if caching is needed; otherwise, empty as no internal state
  }

  @override
  Future<Defaults> loadDefaults() async {
    final List<Map<String, dynamic>> maps = await _database.query(
      _defaultsTable,
      where: 'id = ?',
      whereArgs: [1],
    );
    if (maps.isEmpty) {
      return Defaults(); // Assume default constructor
    }
    return Defaults.fromJson(maps.first);
  }

  @override
  Future<FilterInfo> loadFilterInfo() async {
    final List<Map<String, dynamic>> maps = await _database.query(
      _filterInfoTable,
      where: 'id = ?',
      whereArgs: [1],
    );
    if (maps.isEmpty) {
      return FilterInfo();
    }
    return FilterInfo.fromJson(maps.first);
  }

  @override
  Future<Filters> loadFilters() async {
    final List<Map<String, dynamic>> maps = await _database.query(
      _filtersTable,
      where: 'id = ?',
      whereArgs: [1],
    );
    if (maps.isEmpty) {
      return Filters();
    }
    return Filters.fromJson(maps.first);
  }

  @override
  Future<OrderInfo> loadOrderInfo() async {
    final List<Map<String, dynamic>> maps = await _database.query(
      _orderInfoTable,
      where: 'id = ?',
      whereArgs: [1],
    );
    if (maps.isEmpty) {
      return OrderInfo();
    }
    return OrderInfo.fromJson(maps.first);
  }

  @override
  Future<PagingInfo> loadPagingInfo() async {
    final List<Map<String, dynamic>> maps = await _database.query(
      _pagingInfoTable,
      where: 'id = ?',
      whereArgs: [1],
    );
    if (maps.isEmpty) {
      return PagingInfo();
    }
    return PagingInfo.fromJson(maps.first);
  }

  @override
  Future<void> removeDefaults() async {
    await _database.delete(_defaultsTable, where: 'id = ?', whereArgs: [1]);
  }

  @override
  Future<void> removeFilterInfo() async {
    await _database.delete(_filterInfoTable, where: 'id = ?', whereArgs: [1]);
  }

  @override
  Future<void> removeFilters() async {
    await _database.delete(_filtersTable, where: 'id = ?', whereArgs: [1]);
  }

  @override
  Future<void> removeOrderInfo() async {
    await _database.delete(_orderInfoTable, where: 'id = ?', whereArgs: [1]);
  }

  @override
  Future<void> removePagingInfo() async {
    await _database.delete(_pagingInfoTable, where: 'id = ?', whereArgs: [1]);
  }

  @override
  Future<void> saveDefaults(Defaults defaults) async {
    var map = defaults.toJson();
    map['id'] = 1;
    await _database.insert(
      _defaultsTable,
      map,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<void> saveFilterInfo(FilterInfo filterInfo) async {
    var map = filterInfo.toJson();
    map['id'] = 1;
    await _database.insert(
      _filterInfoTable,
      map,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<void> saveFilters(Filters filters) async {
    var map = filters.toJson();
    map['id'] = 1;
    await _database.insert(
      _filtersTable,
      map,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<void> saveOrderInfo(OrderInfo orderInfo) async {
    var map = orderInfo.toJson();
    map['id'] = 1;
    await _database.insert(
      _orderInfoTable,
      map,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<void> savePagingInfo(PagingInfo pagingInfo) async {
    var map = pagingInfo.toJson();
    map['id'] = 1;
    await _database.insert(
      _pagingInfoTable,
      map,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<SqliteStorageDataModel> loadAll() async {
    return SqliteStorageDataModel(
      Id: 0,
      defaults: await loadDefaults(),
      filters: await loadFilters(),
      filterInfos: await loadFilterInfo(),
      sortOrder: await loadOrderInfo(),
      pagingInfo: await loadPagingInfo(),
    );
  }

  @override
  Future<void> removeAll() async {
    await removeDefaults();
    await removeFilters();
    await removeFilterInfo();
    await removeOrderInfo();
    await removePagingInfo();
  }

  @override
  Future<void> signOut() async {
    // Optionally remove other session-related data, e.g., await removeFilters();
  }
}
