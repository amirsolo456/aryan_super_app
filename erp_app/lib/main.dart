import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:models_package/Base/enums.dart';
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

import 'feature/menu/bloc/menu_bloc.dart';
import 'feature/menu/bloc/menu_event.dart';
import 'feature/person/person_list_bloc.dart';
import 'feature/profile/profile_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  initStandAlone();
  initPartition();

  final apiClient = getIt.get<ApiClient>();
  final apiMiddleware = ApiClientMiddlewareService(apiClient: apiClient);
  final storageService = sl<StorageService>();

  final lang =
      await storageService.getLanguage() ??
      Language(id: 0, smallName: 'fa', completeName: 'fa_IR', bigName: 'IR');

  // final can = await CheckDatasForStandAlone(storageService);
  final can = true;
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
  );
}

Future<bool> CheckDatasForStandAlone(StorageService storage) async {
  try {
    Map<String,dynamic> result = await storage.loadLoginSession();
    if (result[SessionKeys.loginResult.key] == null) return false;
    if (result[SessionKeys.token.key] == null) return false;
    if (result[SessionKeys.selectedManagement.key] == null) return false;
    if (result[SessionKeys.user.key] == null) return false;
    return true;
  } catch (e) {
    return false;
  }
}


class MainApp extends StatelessWidget {
  final Language initialLanguage;
  final bool invalidSession;

  const MainApp({
    super.key,
    required this.initialLanguage,
    this.invalidSession = false,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: Locale(initialLanguage.languageCode ?? "fa"),
      supportedLocales: const [Locale('en', 'US'), Locale('fa', 'IR')],
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: invalidSession
          ? Scaffold(
              body: Center(
                child: Text(
                  'اطلاعات معتبر نمی‌باشد، لطفاً از ابتدا وارد شوید.',
                ),
              ),
            )
          : MainLayoutPage(),
    );
  }
}

Widget buildERPApp({required Map<String, dynamic> loginDatas}) {
  if (loginDatas == null) return SizedBox();

  if (loginDatas[SessionKeys.language.key] == null)
    loginDatas[SessionKeys.language.key] = Language(
      languageCode: 'fa',
      smallName: 'fa',
      id: 0,
      bigName: 'IR',
      completeName: 'fa_IR',
    );

  initPartition();
  final storageService = getIt.get<StorageService>();
  final isOk = storageService
      .setLoginSession(
        user: loginDatas[SessionKeys.user.key],
        token: loginDatas[SessionKeys.token.key],
        language: loginDatas[SessionKeys.language.key],
        loginResult: loginDatas[SessionKeys.loginResult.key],
      )
      .then((isOk) {
        if (!isOk.isSuccess) {
          return SizedBox();
        }
      });

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
        (loginModuleResult[SessionKeys.language.key] ??
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
      home: MainLayoutPage(),
    );
  }
}
