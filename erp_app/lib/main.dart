import 'dart:io';
import 'package:erp_app/feature/person/domain/repositories/person_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:get_it/get_it.dart';
import 'package:models_package/Base/enums.dart';
import 'package:models_package/Base/language.dart';
import 'package:models_package/Base/login_module.dart';
import 'package:models_package/Data/Auth/Login/dto.dart';
import 'package:navigation_builder/navigation_builder.dart';
import 'package:provider/provider.dart';
import 'package:resources_package/l10n/app_localizations.dart';
import 'package:services_package/api_client_service.dart';
import 'package:services_package/com/person/person_service.dart';
import 'package:services_package/extension/exception_handler_service.dart';
import 'package:services_package/login_service.dart';
import 'package:services_package/storage/domain/usecases/storage_service.dart';
import 'package:services_package/storage_service.dart';
import 'package:ui_components_package/erp_app_componenets/mobile/Components/erp_appbar.dart';
import 'package:ui_components_package/erp_app_componenets/mobile/Components/erp_not_found.dart';
import 'components/mainlayout/main_layout.dart';
import 'core/messengers_services/exception_helper_service.dart';
import 'core/network/custom_http_override.dart';
import 'core/network/injection_container.dart';
import 'feature/menu/bloc/menu_bloc.dart';
import 'feature/menu/bloc/menu_event.dart';
import 'feature/person/presentation/blocs/person_bloc/person_list_bloc.dart';
import 'feature/person/presentation/blocs/search_person_bloc/search_person_bloc.dart';
import 'feature/person/presentation/features/person_list_page.dart';
import 'feature/profile/profile_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  initStandAlone();

  final apiClient = GetIt.instance<ApiClient>();
  final storageService = GetIt.instance<StorageService>();
  final personService = GetIt.instance<PersonService>();
  final personRepo = GetIt.instance<PersonRepository>();
  final lang =
      await storageService.loadLanguage() ??
      Language(id: 0, smallName: 'fa', completeName: 'fa_IR', bigName: 'IR');

  final rootWidget = MultiBlocProvider(
    providers: [
      Provider<LoginService>(create: (_) => LoginService(client: apiClient)),
      BlocProvider(create: (_) => ProfileBloc()),
      BlocProvider(create: (_) => PersonListBloc(personService: personService)),
      BlocProvider(create: (_) => SearchPersonBloc(personRepo)),
      BlocProvider(
        create: (_) => GetIt.instance<MenuBloc>()..add(LoadMenuEvent()),
      ),
    ],
    child: MainApp(
      initialLanguage: lang,
      messengerService: sl<ExceptionHelperService>(),
    ),
  );

  AppErrorHandler.initializeErrorHandlers(rootWidget);
}

class MainApp extends StatelessWidget {
  final Language initialLanguage;
  final bool invalidSession;
  final ExceptionHelperService messengerService;

  const MainApp({
    super.key,
    required this.initialLanguage,
    required this.messengerService,
    this.invalidSession = false,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: messengerService.navigatorKey,
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
          : MainLayoutPage(tab: NavButtonTabBarMode.erpDashboardTabMode),
    );
  }
}

Widget buildERPApp({required Map<String, dynamic> loginDatas}) {
  if (loginDatas.isEmpty) return const SizedBox();

  if (loginDatas[SessionKeys.language.key] == null) {
    loginDatas[SessionKeys.language.key] = Language(
      languageCode: 'fa',
      smallName: 'fa',
      id: 0,
      bigName: 'IR',
      completeName: 'fa_IR',
    );
  }

  usePathUrlStrategy();
  final storageService = GetIt.instance<StorageService>();

  // ذخیره session
  storageService.saveLoginSessionModel(
    LoginModuleResult.success(
      user: loginDatas[SessionKeys.user.key],
      token: loginDatas[SessionKeys.token.key],
      networkMode: 0,
      cachedKey: '',
      language: loginDatas[SessionKeys.language.key],
      managementAccount:  [],
      selectedManagementAccount: loginDatas[SessionKeys.selectedManagement.key],
    ),
  );

  final apiClient = GetIt.instance<ApiClient>();
  final personRepo = GetIt.instance<PersonRepository>();
  final personService = GetIt.instance<PersonService>();

  return MultiBlocProvider(
    providers: [
      Provider<LoginService>(create: (_) => LoginService(client: apiClient)),
      BlocProvider(
        create: (_) => GetIt.instance<MenuBloc>()..add(LoadMenuEvent()),
      ),
      BlocProvider(create: (_) => ProfileBloc()),
      BlocProvider(create: (_) => PersonListBloc(personService: personService)),
      BlocProvider(
        // ✅ این خط اضافه شد
        create: (_) => SearchPersonBloc(personRepo),
      ),
    ],
    child: PartOfContainerApp(loginModuleResult: loginDatas),
  );
}

class PartOfContainerApp extends StatelessWidget {
  final Map<String, dynamic> loginModuleResult;

  const PartOfContainerApp({super.key, required this.loginModuleResult});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: erpNavigator.routerConfig,
      debugShowCheckedModeBanner: false,
      locale: Locale(
        (loginModuleResult[SessionKeys.language.key] as Language?)
                ?.languageCode ??
            'fa',
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
    );
  }
}

final erpNavigator = NavigationBuilder.create(
  routes: {
    '/': (RouteData data) =>
        const MainLayoutPage(tab: NavButtonTabBarMode.erpDashboardTabMode),
    '/:erpMenuTabBarId': (RouteData data) {
      final id = data.pathParams['erpMenuTabBarId']; // دسترسی به پارامترها
      NavButtonTabBarMode tab = NavButtonTabBarMode.values.firstWhere(
        (e) => e.value == id,
        orElse: () =>
            NavButtonTabBarMode.erpNotFound, // اگر پیدا نشد، erpNotFound
      );
      return MainLayoutPage(tab: tab);
    },
    '/Com/PersonList': (RouteData data) {
      return BlocProvider<SearchPersonBloc>.value(
        value: GetIt.instance<SearchPersonBloc>(),
        child: PersonListPage(refreshData: true),
      );
    },
    '/notFound': (RouteData data) {
      return ErpNotFound();
    },
    '/home/*': (RouteData data) => data.redirectTo('/'),
    // wildcard برای همه زیرمسیرها
    '/page6': (RouteData data) => RouteWidget(),
  },

  initialLocation: '/',

  unknownRoute: (route) => Scaffold(appBar: AppBar(), body: SizedBox()),
  // صفحه برای مسیر نامعلوم
  builder: (Widget outlet) => Scaffold(
    appBar: ErpAppBar(mode: AppBarsMode.erpNotFound),
    body: outlet,
  ),
  transitionsBuilder:
      (context, anim, secAnim, child) => // انیمیشن جهانی
          FadeTransition(opacity: anim, child: child),
  transitionDuration: const Duration(milliseconds: 1000),
  debugPrintWhenRouted: true, // لاگ برای دیباگ
);
