import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LanguageCubit extends Cubit<Locale> {
  final void Function(Locale)? persistLocale; // optional callback to persist

  LanguageCubit({
    required Locale initialLocale,
    this.persistLocale,
  }) : super(initialLocale);

  String get languageCode => state.languageCode;

  void setLocale(Locale locale) {
    if (locale == state) return; // جلوگیری از emit تکراری
    emit(locale);
    // اگر پروژه مادر persistence خواست، callback اجرا می‌شود
    persistLocale?.call(locale);
  }

  void toggleToNext() {
    // نمونه: بین fa/en سوییچ کن
    if (state.languageCode == 'fa') {
      setLocale(const Locale('en', 'US'));
    } else {
      setLocale(const Locale('fa', 'IR'));
    }
  }
}
