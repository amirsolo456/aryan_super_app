import 'package:models_package/Base/language.dart';
import 'package:services_package/storage/data/datasource/storage_datasource.dart';

abstract class ISharedStorageDataSource extends StorageDatasource {
  Future<Language> loadLanguage();
  Future<void> saveLanguage(Language language);
  Future<void> removeLanguage();

  Future<String> loadDeviceToken();
  Future<void> saveDeviceToken(String deviceToken);
  Future<void> removeDeviceToken();
}
