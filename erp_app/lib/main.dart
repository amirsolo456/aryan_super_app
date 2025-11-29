import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:models_package/Base/language.dart';
import 'package:provider/provider.dart';
import 'package:resources_package/l10n/app_localizations.dart';
import 'package:services_package/Interfaces/apiclient_middleware_service.dart';
import 'package:services_package/api_client_service.dart';
import 'package:services_package/login_service.dart';
import 'package:services_package/setup_services.dart';
import 'package:services_package/storage_service.dart';

import 'components/mainlayout/main_layout.dart';
import 'core/network/custom_http_override.dart';
import 'core/network/injection_container.dart';
import 'feature/menu/presentation/bloc/menu_bloc.dart';
import 'feature/menu/presentation/bloc/menu_event.dart';
import 'feature/person/person_list_bloc.dart';
import 'feature/profile/profile_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  init();
  setupServices();

  final apiClient = getIt.get<ApiClient>();
  final apiMiddleware = ApiClientMiddlewareService(apiClient: apiClient);
  final storageService = sl<StorageService>();

  final lang =
      await storageService.getLanguage() ??
      Language(id: 0, smallName: 'fa', completeName: 'fa_IR', bigName: 'IR');

  runApp(
    MultiBlocProvider(
      providers: [
        Provider<LoginService>(
          create: (_) =>
              LoginService(client: apiClient, storage: StorageService()),
        ),
        BlocProvider(create: (_) => ProfileBloc()),
        BlocProvider(
          create: (_) => PersonListBloc(apiMiddleware: apiMiddleware),
        ),

        BlocProvider(create: (_) => sl<MenuBloc>()..add(LoadMenuEvent())),
      ],
      child: MainApp(initialLanguage: lang),
    ),

    // MaterialApp(
    //   title: 'Named Routes Demo',
    //   // Start the app with the "/" named route. In this case, the app starts
    //   // on the FirstScreen widget.
    //   initialRoute: '/',
    //   routes: {
    //     // When navigating to the "/" route, build the FirstScreen widget.
    //     '/': (context) => const FirstScreen(),
    //     // When navigating to the "/second" route, build the SecondScreen widget.
    //     '/second': (context) => const SecondScreen(),
    //   },
    // )
  );
}

@override
Widget build(BuildContext context) {
  final storageService = getIt.get<StorageService>();

  return FutureBuilder<Language?>(
    future: storageService.getLanguage(),
    builder: (context, snapshot) {
      final lang =
          snapshot.data ??
          Language(
            id: 0,
            smallName: 'fa',
            completeName: 'fa_IR',
            bigName: 'IR',
          );
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Aryan Front',
        locale: Locale(lang.languageCode.toString()),
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [Locale('en', 'US'), Locale('fa', 'IR')],
        theme: ThemeData(
          fontFamily: 'IRanSans',
          fontFamilyFallback: ['Vazirmatn', 'Tahoma', 'sans-serif'],
          scaffoldBackgroundColor: Colors.white,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        ),
        home: const MainLayoutPage(),
      );
    },
  );
}

class MainApp extends StatelessWidget {
  final Language initialLanguage;

  const MainApp({super.key, required this.initialLanguage});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: Locale(initialLanguage.languageCode.toString()),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en', 'US'), Locale('fa', 'IR')],
      theme: ThemeData(
        fontFamily: 'IRanSans',
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
      ),
      home: const MainLayoutPage(),
    );
  }
}

Widget buildERPApp(Language lang) {
  final apiClient = getIt.get<ApiClient>();
  final apiMiddleware = ApiClientMiddlewareService(apiClient: apiClient);
  init();
  return MultiBlocProvider(
    providers: [
      Provider<LoginService>(
        create: (_) =>
            LoginService(client: apiClient, storage: StorageService()),
      ),
      BlocProvider(create: (_) => sl<MenuBloc>()..add(LoadMenuEvent())),
      BlocProvider(create: (_) => ProfileBloc()),
      BlocProvider(create: (_) => PersonListBloc(apiMiddleware: apiMiddleware)),
    ],
    // child: const MainLayoutPage(),
    child: PartOfContainerApp(initialLanguage: lang),
  );
}

class PartOfContainerApp extends StatelessWidget {
  final Language initialLanguage;

  const PartOfContainerApp({super.key, required this.initialLanguage});

  @override
  Widget build(BuildContext context) {
    // final storageService = getIt.get<StorageService>();
    // final Locale appLocalization;
    // final StorageService storageService;
    // if (getIt.isRegistered<StorageService>()) {
    //   storageService = getIt.get<StorageService>();
    //   Language lang = storageService.getLanguage();
    // }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: const Locale('fa', 'IR'),
      supportedLocales: const [Locale('fa', 'IR'), Locale('en', 'US')],
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],

      title: 'Erp',
      // locale: Locale(initialLanguage.languageCode.toString()),
      // localizationsDelegates: const [
      //   AppLocalizations.delegate,
      //   GlobalMaterialLocalizations.delegate,
      //   GlobalWidgetsLocalizations.delegate,
      //   GlobalCupertinoLocalizations.delegate,
      // ],
      // supportedLocales: const [Locale('en', 'US'), Locale('fa', 'IR')],
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
      ),
      home: const MainLayoutPage(),
    );
  }
}
