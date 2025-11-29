import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:models_package/Base/language.dart';
import 'package:services_package/storage_service.dart';

part 'language_button_stand_alone_state.dart';

class LanguageButtonStandAloneCubit extends Cubit<Locale> {
  final StorageService? storage;

  LanguageButtonStandAloneCubit({required Locale initialLocale, this.storage})
    : super(initialLocale);

  String get languageCode => state.languageCode;

  /// متدی که از بیرون فراخوانی می‌شود تا زبان را عوض کند.
  /// این متد داخل خودش `emit` را صدا می‌زند — هیچ جایی نباید از بیرون emit صدا زده شود.
  Future<void> setLocale(Locale locale) async {
    if (locale == state) return; // جلوگیری از emit تکراری
    emit(locale);

    try {
      final lang = Language(
        id: 0,
        smallName: locale.languageCode,
        bigName: locale.countryCode ?? '',
        completeName: locale.toString(),
        countryCode: locale.countryCode,
        languageCode: locale.languageCode,
      );

      await storage?.setLanguage(lang);
    } catch (e) {
      // optional: لاگ کردن یا هندل کردن خطا
      print('Error saving language: $e');
    }
  }

  Future<void> loadSavedLocale() async {
    if (storage == null) return;
    try {
      final lang = await storage!.getLanguage();
      if (lang != null) {
        final savedLocale = Locale(lang.smallName ?? 'en', lang.bigName);
        if (savedLocale != state) emit(savedLocale);
      }
    } catch (e) {
      print('Error loading saved locale: $e');
    }
  }
}
