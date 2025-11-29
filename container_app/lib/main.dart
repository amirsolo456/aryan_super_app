import 'dart:io';
import 'package:container_app/pages/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:login_module/login_manager_service.dart';
import 'package:resources_package/Resources/Theme/theme_manager.dart';
import 'package:resources_package/l10n/app_localizations.dart';
import 'package:services_package/setup_services.dart';
import 'package:services_package/storage_service.dart';
import 'package:ui_components_package/erp_app_componenets/common/Buttons/language_button_standalone/language_button_stand_alone_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();

  setupServices();
  Locale initialLocale = Locale('fa');
  GetIt.I.registerLazySingleton(() => LoginModuleManager());
  ThemeManager.init();

  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyDaFoQ1BufZNuUKKYrVfnoAPjVytggLeJY",
      appId: "1:511210742680:android:a754014ad3e3daefab81ed",
      messagingSenderId: "511210742680",
      projectId: "aryanerp-e996e",
      databaseURL: "https://aryanerp-e996e-default-rtdb.firebaseio.com",
      storageBucket: "aryanerp-e996e.firebasestorage.app",
      androidClientId:
          "511210742680-xxxxxxxxxxxxxxxxxxxxxxxxxxxx.apps.googleusercontent.com",
    ),
  );

  try {
    String? token = await FirebaseMessaging.instance.getToken();
    if (token != null && token.isNotEmpty) {
      final storageService = GetIt.I.get<StorageService>();
      await storageService.setDeviceToken(token);
    }

    if (GetIt.I.isRegistered<StorageService>()) {
      final _storage = GetIt.instance<StorageService>();
      final _lang = await _storage.getLanguage();
      if (_lang != null) {
        initialLocale = Locale(_lang.languageCode ?? 'fa');
      }
    }
  } catch (e) {
    debugPrint('Error in token/setup: $e');
    initialLocale = Locale('fa');
  }

  runApp(MyApp(initialLocal: Locale(initialLocale.languageCode)));
}

class MyApp extends StatelessWidget {
  final Locale initialLocal;

  const MyApp({super.key, required this.initialLocal});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => LanguageButtonStandAloneCubit(
            initialLocale: initialLocal,
            storage: GetIt.I<StorageService>(),
          ),
        ),
      ],
      child: BlocBuilder<LanguageButtonStandAloneCubit, Locale>(
        builder: (context, locale) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            locale: locale,
            supportedLocales: const [Locale('fa', 'IR'), Locale('en', 'US')],
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            theme: ThemeColorsManager(.light).aryanTheme,
            darkTheme: ThemeColorsManager(.dark).aryanTheme,
            themeMode: ThemeManager.themeMode,
            home: SplashScreenPage(),
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
