import 'dart:convert';

import 'package:models_package/Base/language.dart';
import 'package:services_package/storage/data/datasource/shared_storage_datasouce.dart';
import 'package:services_package/storage/data/model/shared_storage_data_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedStorageUseCase implements ISharedStorageDataSource {
  static const String _deviceTokenKey = 'device_token';
  static const String _languageKey = 'language';

  late SharedPreferences _sharedPrefs;

  // helper to ensure SharedPreferences آماده است
  Future<void> _init() async {
    // اگر قبلاً مقداردهی نشده باشد، مقداردهی می‌کنیم
    try {
      _sharedPrefs = await SharedPreferences.getInstance();
    } catch (e) {
      // در صورت خطای دسترسی به SharedPreferences، دوباره پرتاب می‌کنیم
      rethrow;
    }
  }

  @override
  Future<String> loadDeviceToken() async {
    await _init();
    return _sharedPrefs.getString(_deviceTokenKey) ?? '';
  }

  @override
  Future<Language> loadLanguage() async {
    await _init();

    final jsonString = _sharedPrefs.getString(_languageKey);

    if (jsonString == null || jsonString.isEmpty) {
      return const Language(); // مقدار پیش‌فرض
    }

    try {
      final map = jsonDecode(jsonString) as Map<String, dynamic>;
      return Language.fromJson(map);
    } catch (_) {
      // در صورت فاسد بودن JSON، مقدار پیش‌فرض برمی‌گردد
      return const Language();
    }
  }

  @override
  Future<void> removeDeviceToken() async {
    await _init();
    await _sharedPrefs.remove(_deviceTokenKey);
  }

  @override
  Future<void> removeLanguage() async {
    await _init();
    await _sharedPrefs.remove(_languageKey);
  }

  @override
  Future<void> saveDeviceToken(String deviceToken) async {
    await _init();
    await _sharedPrefs.setString(_deviceTokenKey, deviceToken);
  }

  @override
  Future<void> saveLanguage(Language language) async {
    await _init();

    final jsonString = jsonEncode(language.toJson());
    await _sharedPrefs.setString(_languageKey, jsonString);
  }

  Future<SharedStorageDataModel> loadAll() async {
    await _init();
    final token = await loadDeviceToken();
    final language = await loadLanguage();

    // فرض: SharedStorageDataModel دارای سازنده با پارامترهای نام‌گذاری‌شده deviceToken و language است
    return SharedStorageDataModel(
      Id: 0,
      deviceToken: token,
      language: language,
    );
  }

  @override
  Future<void> removeAll() async {
    await _init();
    // فقط کلیدهایی که این usecase استفاده می‌کند را پاک می‌کنیم
    await _sharedPrefs.remove(_deviceTokenKey);
    await _sharedPrefs.remove(_languageKey);
  }

  @override
  Future<void> signOut() async {
    // در این پروژه signOut صرفاً همه‌ی داده‌های محلی مرتبط را پاک می‌کند.
    // اگر رفتار دیگری (مثل invalidate توکن سمت سرور) مد نظرتون هست، باید آن را اضافه کنید.
    await removeAll();
  }
}
