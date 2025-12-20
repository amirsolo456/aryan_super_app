import 'package:models_package/Base/language.dart';

abstract class ISharedStorageDataSource {
  Future<Language> loadLanguage();
  Future<void> saveLanguage(Language language);
  Future<void> removeLanguage();

  Future<String> loadDeviceToken();
  Future<void> saveDeviceToken(String deviceToken);
  Future<void> removeDeviceToken();

  Future<String?> getSharedDbPath();
}
