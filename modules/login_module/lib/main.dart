import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:login_module/login_page.dart';
import 'package:models_package/Base/language.dart';
import 'package:resources_package/Resources/Theme/theme_manager.dart';
import 'package:resources_package/l10n/app_localizations.dart';
import 'package:services_package/setup_services.dart';
import 'package:services_package/storage_service.dart';
import 'package:ui_components_package/erp_app_componenets/common/Buttons/language_button_standalone/language_button_stand_alone_cubit.dart';

import 'login_bloc.dart';
import 'login_manager_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  setupServices();
  GetIt.I.registerLazySingleton(() => LoginModuleManager());
  StorageService storageService = getIt.get<StorageService>();
  Language? initialLocal = await storageService.getLanguage();
  if (initialLocal == null)
    initialLocal = Language(
      id: 0,
      smallName: 'fa',
      bigName: 'IR',
      languageCode: 'fa',
    );
  runApp(MyApp(initialLocale: Locale(initialLocal.languageCode ?? 'fa')));
}

class MyApp extends StatelessWidget {
  final Locale initialLocale;

  const MyApp({super.key, required this.initialLocale});

  @override
  Widget build(BuildContext context) {
    ThemeManager.init();
    StorageService storageService = getIt.get<StorageService>();
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(create: (_) => LoginBloc(networkMode: 0)),
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
            home: const LoginPage(),
          );
        },
      ),
    );
  }
}
