import 'package:models_package/Base/login_module.dart';
import 'package:models_package/Data/Auth/User/dto.dart';
import 'package:services_package/storage/data/datasource/storage_datasource.dart';

abstract class ISecureStorageDataSource extends StorageDatasource {
  Future<String> loadToken();
  Future<void> saveToken(String token);
  Future<void> removeToken();

  Future<UserDto> loadUser();
  Future<void> saveUser(UserDto user);
  Future<void> removeUser();

  Future<LoginModuleResult> loadLoginSessionModel();
  Future<void> saveLoginSessionModel(LoginModuleResult loginSessionModel);
  Future<void> removeLoginSessionModel();
}
