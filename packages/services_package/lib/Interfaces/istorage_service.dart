

import 'package:flutter/material.dart';


import 'package:models_package/Base/language.dart';
import 'package:models_package/Data/Auth/User/dto.dart';

abstract class IStorageService {
  Future<void> setUser(UserDto? user);
  Future<UserDto?> getUser();

  Future<void> setToken(String token);
  Future<String?> getToken();

  Future<void> clearAll();
  Future<void> setDeviceToken(String token);
  Future<String?> getDeviceToken();

  Future<void> setLanguage(Language token);
  Future<Language?> getLanguage();
  // Future<Locale?> readLocale();
  // Future<Language?> saveLocale(Locale locale);
}
