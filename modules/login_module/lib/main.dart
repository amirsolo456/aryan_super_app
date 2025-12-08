import 'dart:io';

import 'package:erp_app/core/network/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:login_module/login_page.dart';
import 'package:login_module/services/snackbar_service.dart';
import 'package:models_package/Base/language.dart';
import 'package:resources_package/Resources/Theme/theme_manager.dart';
import 'package:resources_package/l10n/app_localizations.dart';
import 'package:services_package/storage_service.dart';
import 'package:ui_components_package/erp_app_componenets/common/Buttons/language_button_standalone/language_button_stand_alone_cubit.dart';

import 'login_bloc.dart';
import 'services/login_manager_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  GetIt.I.registerLazySingleton(() => LoginModuleManager());
  GetIt.I.registerLazySingleton(() => SnackBarService());

  Language? initialLocal;
  if (initialLocal == null)
    initialLocal = Language(
      id: 0,
      smallName: 'fa',
      bigName: 'IR',
      languageCode: 'fa',
    );
  runApp(
    MyApp(
      initialLocale: Locale(initialLocal.languageCode ?? 'fa'),
      deviceToken: '',
      runMode: 3,
    ),
  );
}

class MyApp extends StatelessWidget {
  final Locale initialLocale;
  final String deviceToken;
  final int runMode;

  const MyApp({
    super.key,
    required this.initialLocale,
    required this.deviceToken,
    required this.runMode,
  });

  @override
  Widget build(BuildContext context) {
    final Locale local = Locale(initialLocale.languageCode);
    ThemeManager.init();
    StorageService storageService = sl.get<StorageService>();
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(
          create: (_) =>
              LoginBloc(networkMode: runMode, deviceToken: deviceToken),
        ),
        BlocProvider<LanguageButtonStandAloneCubit>(
          create: (_) => LanguageButtonStandAloneCubit(
            initialLocale: initialLocale,
            storage: storageService,
          ),
        ),
      ],
      child: BlocBuilder<LanguageButtonStandAloneCubit, Locale>(
        builder: (context, locale) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            scaffoldMessengerKey: SnackBarService.messengerKey,
            locale: locale,
            supportedLocales: AppLocalizations.supportedLocales,
            localeResolutionCallback: (locale, supportedLocales) {
              if (locale == null) {
                return supportedLocales.first;
              }
              for (var supportedLocale in supportedLocales) {
                if (supportedLocale.languageCode == locale.languageCode) {
                  if (supportedLocale.countryCode == locale.countryCode) {
                    return supportedLocale;
                  }
                }
              }
              for (var supportedLocale in supportedLocales) {
                if (supportedLocale.languageCode == locale.languageCode) {
                  return supportedLocale;
                }
              }
              return supportedLocales.first;
            },
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            theme: ThemeColorsManager(.light).aryanTheme,
            darkTheme: ThemeColorsManager(.dark).aryanTheme,
            themeMode: ThemeManager.themeMode,
            home: LoginPage(
              deviceToken: deviceToken,
              locale: local,
              netMode: runMode,
            ),
          );
        },
      ),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
