import 'dart:async';

import 'package:models_package/Base/base_request.dart';
import 'package:models_package/Base/language.dart';
import 'package:models_package/Base/login_module.dart';
import 'package:models_package/Data/Auth/User/dto.dart';
import 'package:services_package/storage/domain/usecases/secure_storage_usecasae.dart';
import 'package:services_package/storage/domain/usecases/shared_storage_usecase.dart';
import 'package:services_package/storage/domain/usecases/sqlite_storage_usecase.dart';
import 'package:sqflite/sqflite.dart';

import '../../data/datasource/secure_storage_datasource.dart';
import '../../data/datasource/shared_storage_datasouce.dart';
import '../../data/datasource/sqlite_storage_datasource.dart';
import '../../data/model/storage_data_model.dart';

class StorageService
    implements
        ISecureStorageDataSource,
        ISharedStorageDataSource,
        ISqliteStorageDataSource {
  final SecureStorageUseCase _secureStorageUseCase;
  final SharedStorageUseCase _sharedStorageUseCase;
  final SqliteStorageUseCase _sqliteStorageUseCase;

  const StorageService({
    required secureStorageUseCase,
    required sharedStorageUseCase,
    required sqliteStorageUseCase,
  }) : _secureStorageUseCase = secureStorageUseCase,
       _sharedStorageUseCase = sharedStorageUseCase,
       _sqliteStorageUseCase = sqliteStorageUseCase;

  @override
  Future<Defaults> loadDefaults() {
    throw UnimplementedError();
  }

  @override
  Future<String> loadDeviceToken() async =>
      await _sharedStorageUseCase.loadDeviceToken();

  @override
  Future<FilterInfo> loadFilterInfo() async =>
      await _sqliteStorageUseCase.loadFilterInfo();

  @override
  Future<Filters> loadFilters() async =>
      await _sqliteStorageUseCase.loadFilters();

  @override
  Future<Language> loadLanguage() async =>
      await _sharedStorageUseCase.loadLanguage();

  @override
  Future<LoginModuleResult> loadLoginSessionModel() async =>
      await _secureStorageUseCase.loadLoginSessionModel();

  @override
  Future<OrderInfo> loadOrderInfo() async =>
      await _sqliteStorageUseCase.loadOrderInfo();

  @override
  Future<PagingInfo> loadPagingInfo() async =>
      await _sqliteStorageUseCase.loadPagingInfo();

  @override
  Future<String> loadToken() async => await _secureStorageUseCase.loadToken();

  @override
  Future<void> removeDefaults() async =>
      await _sqliteStorageUseCase.removeDefaults();

  @override
  Future<void> removeDeviceToken() async =>
      await _sharedStorageUseCase.removeDeviceToken();

  @override
  Future<void> removeFilterInfo() async =>
      await _sqliteStorageUseCase.removeFilterInfo();

  @override
  Future<void> removeFilters() async =>
      await _sqliteStorageUseCase.removeFilters();

  @override
  Future<void> removeLanguage() async =>
      await _sharedStorageUseCase.removeLanguage();

  @override
  Future<void> removeLoginSessionModel() async =>
      await _secureStorageUseCase.removeLoginSessionModel();

  @override
  Future<void> removeOrderInfo() async =>
      await _sqliteStorageUseCase.removeOrderInfo();

  @override
  Future<void> removePagingInfo() async =>
      await _sqliteStorageUseCase.removePagingInfo();

  @override
  Future<void> removeToken() async => await _secureStorageUseCase.removeToken();

  @override
  Future<void> removeUser() async => await _secureStorageUseCase.removeUser();

  @override
  Future<void> saveDefaults(Defaults defaults) async =>
      await _sqliteStorageUseCase.saveDefaults(defaults);

  @override
  Future<void> saveDeviceToken(String deviceToken) async =>
      await _sharedStorageUseCase.saveDeviceToken(deviceToken);

  @override
  Future<void> saveFilterInfo(FilterInfo filterInfos) async =>
      await _sqliteStorageUseCase.saveFilterInfo(filterInfos);

  @override
  Future<void> saveFilters(Filters filters) async =>
      await _sqliteStorageUseCase.saveFilters(filters);

  @override
  Future<void> saveLanguage(Language language) async =>
      await _sharedStorageUseCase.saveLanguage(language);

  @override
  Future<void> saveLoginSessionModel(
    LoginModuleResult loginSessionModel,
  ) async {
    await _secureStorageUseCase.saveLoginSessionModel(loginSessionModel);
    await _sqliteStorageUseCase.sqlSaveLoginSessionModel(loginSessionModel);
    if (loginSessionModel.language != null)
      await _sharedStorageUseCase.saveLanguage(loginSessionModel.language!);
  }

  @override
  Future<void> saveOrderInfo(OrderInfo filters) async =>
      await _sqliteStorageUseCase.saveOrderInfo(filters);

  @override
  Future<void> savePagingInfo(PagingInfo pagingInfo) async =>
      await _sqliteStorageUseCase.savePagingInfo(pagingInfo);

  @override
  Future<void> saveToken(String token) async =>
      await _secureStorageUseCase.saveToken(token);

  @override
  Future<UserDto> loadUser() async => await _secureStorageUseCase.loadUser();

  @override
  Future<void> saveUser(UserDto user) async =>
      await _secureStorageUseCase.saveUser(user);

  @override
  Future<void> removeAll() async {
    await _secureStorageUseCase.removeAll();
    await _sharedStorageUseCase.removeAll();
    await _sqliteStorageUseCase.removeAll();
  }

  @override
  Future<void> signOut() async {
    // await removeToken();
    // await removeUser();
    // await removeLoginSessionModel();
    await removeAll();
  }

  Future<StorageDataModel> loadAll() async {
    final secure = await _secureStorageUseCase.loadAll();
    final shared = await _sharedStorageUseCase.loadAll();
    final sqlite = await _sqliteStorageUseCase.loadAll();
    return StorageDataModel(
      secureModel: secure,
      sqlLiteModel: sqlite,
      sharedStorageModel: shared,
    );
  }

  Future<Database?> waitUntilDbBuild() async =>
      await _sqliteStorageUseCase.database();

  @override
  Future<LoginModuleResult> sqlLoadLoginSessionModel() async =>
      await _sqliteStorageUseCase.sqlLoadLoginSessionModel();

  @override
  Future<void> sqlRemoveLoginSessionModel() async =>
      await _sqliteStorageUseCase.sqlRemoveLoginSessionModel();

  @override
  Future<void> sqlSaveLoginSessionModel(
    LoginModuleResult loginSessionModel,
  ) async =>
      await _sqliteStorageUseCase.sqlSaveLoginSessionModel(loginSessionModel);

  Future<List<String>> getDbPath() async {
    List<String> pathes = [];
    pathes.add(await _secureStorageUseCase.getSecureDbPath() ?? '');
    pathes.add(await _sharedStorageUseCase.getSharedDbPath() ?? '');
    pathes.add(await _sqliteStorageUseCase.getSqliteDbPath() ?? '');
    return pathes;
  }

  @override
  Future<String?> getSecureDbPath() => _secureStorageUseCase.getSecureDbPath();

  @override
  Future<String?> getSharedDbPath() => _sharedStorageUseCase.getSharedDbPath();

  @override
  Future<String?> getSqliteDbPath() => _sqliteStorageUseCase.getSqliteDbPath();
}
