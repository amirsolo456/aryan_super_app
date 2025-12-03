import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:models_package/Base/base_request.dart';
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
        home:  MainLayoutPage(token: null  ),
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
      home:  MainLayoutPage(token: null),
    );
  }
}

Widget buildERPApp({required Map<String, dynamic> loginDatas}) {
  if (loginDatas == null) return SizedBox();

  if (loginDatas['language'] == null)
    loginDatas['language'] = Language(
      languageCode: 'fa',
      smallName: 'fa',
      id: 0,
      bigName: 'IR',
      completeName: 'fa_IR',
    );
  init();
  setupServices();
  final defaults = Defaults(

  );
  final apiClient = getIt.get<ApiClient>();
  final apiMiddleware = ApiClientMiddlewareService(apiClient: apiClient);

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
    child: PartOfContainerApp(loginModuleResult: loginDatas),
  );
}

class PartOfContainerApp extends StatelessWidget {
  final Map<String, dynamic> loginModuleResult;

  const PartOfContainerApp({super.key, required this.loginModuleResult});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: Locale(
        (loginModuleResult['language'] ??
                Language(id: 0, languageCode: 'fa') as Language)
            .languageCode,
      ),
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      title: 'Erp',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
      ),
      home: MainLayoutPage(token: null),
    );
  }
}
