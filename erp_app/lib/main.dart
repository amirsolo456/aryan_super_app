import 'dart:io';

import 'package:erp_app/feature/person/domain/repositories/person_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:get_it/get_it.dart';
import 'package:models_package/Base/enums.dart';
import 'package:models_package/Base/language.dart';
import 'package:navigation_builder/navigation_builder.dart';
import 'package:provider/provider.dart';
import 'package:resources_package/l10n/app_localizations.dart';
import 'package:services_package/Interfaces/apiclient_middleware_service.dart';
import 'package:services_package/api_client_service.dart';
import 'package:services_package/com/person/person_service.dart';
import 'package:services_package/default/mng/select/language_service.dart';
import 'package:services_package/login_service.dart';
import 'package:services_package/storage_service.dart';
import 'package:ui_components_package/erp_app_componenets/mobile/Components/erp_appbar.dart';
import 'package:ui_components_package/erp_app_componenets/mobile/Components/erp_not_found.dart';

import 'components/mainlayout/main_layout.dart';
import 'core/network/custom_http_override.dart';
import 'core/network/injection_container.dart';

import 'feature/default_page/Language/bloc/language_bloc.dart';
import 'feature/default_page/Language/bloc/language_event.dart';
import 'feature/menu/bloc/menu_bloc.dart';
import 'feature/menu/bloc/menu_event.dart';
import 'feature/person/presentation/blocs/person_bloc/person_list_bloc.dart';
import 'feature/person/presentation/blocs/search_person_bloc/search_person_bloc.dart';
import 'feature/person/presentation/features/person_list_page.dart';
import 'feature/profile/profile_bloc.dart';

// اضافه کردن import‌های مربوط به Language

// 🔧 متغیر برای جلوگیری از initPartition تکراری
bool _isGetItInitialized = false;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  initStandAlone();

  // فقط یک بار initPartition را فراخوانی کنید
  if (!_isGetItInitialized) {
    initPartition();
    _isGetItInitialized = true;
  }

  final apiClient = GetIt.instance<ApiClient>();
  final storageService = GetIt.instance<StorageService>();
  final personService = GetIt.instance<PersonService>();
  final personRepo = GetIt.instance<PersonRepository>();

  // LanguageService را از GetIt دریافت کنید
  final languageService = GetIt.instance<LanguageService>();

  final lang =
      await storageService.getLanguage() ??
          Language(id: 0, smallName: 'fa', completeName: 'fa_IR', bigName: 'IR');

  final can = true; // await CheckDatasForStandAlone(storageService);

  runApp(
    MultiBlocProvider(
      providers: [
        Provider<LoginService>(
          create: (_) =>
              LoginService(client: apiClient, storage: StorageService()),
        ),
        BlocProvider(create: (_) => ProfileBloc()),

        // ✅ هر دو Bloc را اینجا ثبت کنید
        BlocProvider(
          create: (_) => PersonListBloc(personService: personService),
        ),
        BlocProvider(
          create: (_) => SearchPersonBloc(personRepo),
        ),

        BlocProvider(
          create: (_) => GetIt.instance<MenuBloc>()..add(LoadMenuEvent()),
        ),

        // Change Ehsan

        BlocProvider(
          create: (_) => LanguageBloc( getLanguageUseCase: languageService)
            ..add(const LoadLanguageEvent()),
        ),

        // Change Ehsan
      ],
      child: MainApp(initialLanguage: lang),
    ),
  );
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

  // ❌ این خط را حذف کنید - initPartition قبلاً در main() فراخوانی شده
  // initPartition();

  final storageService = GetIt.instance<StorageService>();

  // ذخیره session
  storageService
      .setLoginSession(
    user: loginDatas[SessionKeys.user.key],
    token: loginDatas[SessionKeys.token.key],
    language: loginDatas[SessionKeys.language.key],
    loginResult: loginDatas[SessionKeys.loginResult.key],
  )
      .then((isOk) {
    if (!isOk.isSuccess) {
      return const SizedBox();
    }
  });

  final apiClient = GetIt.instance<ApiClient>();
  final apiMiddleware = GetIt.instance<ApiClientMiddlewareService>();
  final personRepo = GetIt.instance<PersonRepository>();
  final personService = GetIt.instance<PersonService>();

  // LanguageService را از GetIt دریافت کنید
  final languageService = GetIt.instance<LanguageService>();

  return MultiBlocProvider(
    providers: [
      Provider<LoginService>(
        create: (_) => LoginService(client: apiClient, storage: StorageService()),
      ),
      BlocProvider(
        create: (_) => GetIt.instance<MenuBloc>()..add(LoadMenuEvent()),
      ),
      BlocProvider(
        create: (_) => ProfileBloc(),
      ),
      BlocProvider(
        create: (_) => PersonListBloc(personService: personService),
      ),
      BlocProvider(
        create: (_) => SearchPersonBloc(personRepo),
      ),

      // ✅ اضافه کردن LanguageBloc به providers در اینجا هم
      BlocProvider(
        create: (_) => LanguageBloc( getLanguageUseCase: languageService)
          ..add(const LoadLanguageEvent()),
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

// ... بقیه کد navigation بدون تغییر
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

  debugPrintWhenRouted: true,
);