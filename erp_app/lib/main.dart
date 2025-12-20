import 'dart:io';
import 'package:erp_app/feature/navigation_button/presentation/widget/app_navigation_button.dart';
import 'package:erp_app/feature/redux/generic_lists/erp_store/models/field_display_config.dart';
import 'package:erp_app/page_cache_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:get_it/get_it.dart';
import 'package:models_package/Base/enums.dart';
import 'package:models_package/Base/language.dart';
import 'package:models_package/Base/login_module.dart';
import 'package:models_package/Data/Auth/Login/dto.dart' as login;
import 'package:models_package/Data/Auth/User/dto.dart' as user;
import 'package:navigation_builder/navigation_builder.dart';
import 'package:provider/provider.dart';
import 'package:resources_package/l10n/app_localizations.dart';
import 'package:restart_app/restart_app.dart';
import 'package:services_package/api_client_service.dart';
import 'package:services_package/com/person/person_service.dart';
import 'package:services_package/default/com/select/Year_Select_Service.dart';
import 'package:services_package/default/com/select/currency_service.dart';
import 'package:services_package/default/mng/select/language_service.dart';
import 'package:services_package/default/mng/select/place_service.dart';
import 'package:services_package/default/trh/select/cashier_service.dart';
import 'package:services_package/extension/exception_handler_service.dart';
import 'package:services_package/login_service.dart';
import 'package:services_package/storage/domain/usecases/storage_service.dart';
import 'package:ui_components_package/erp_app_componenets/mobile/Components/erp_not_found.dart';
import 'advance_router.dart';
import 'core/messengers_services/exception_helper_service.dart';
import 'core/network/custom_http_override.dart';
import 'core/network/injection_container.dart';
import 'data/models/login_module_model.dart';
import 'feature/auth/menu/bloc/menu_bloc.dart';
import 'feature/auth/menu/bloc/menu_event.dart';
// import 'feature/add_new/add_new_page_event.dart';
import 'feature/com/person/domain/repositories/person_repository.dart';
import 'feature/com/person/presentation/blocs/person_bloc/person_list_bloc.dart';
import 'feature/com/person/presentation/blocs/search_person_bloc/search_person_bloc.dart';
import 'feature/default_page/Language/bloc/language_bloc.dart';
import 'feature/default_page/Place/bloc/place_bloc.dart';
import 'feature/default_page/select_cashier/bloc/select_cashier_bloc.dart';
import 'feature/default_page/select_currency/bloc/select_currency_bloc.dart';
import 'feature/default_page/select_year/bloc/select_year_bloc.dart';
import 'feature/navigation_button/presentation/bloc/navigation_notifier.dart';
import 'feature/profile/profile_bloc.dart';
import 'package:services_package/shared_core/notifications/app_notifier.dart';

final apiClient = GetIt.instance<ApiClient>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  initStandAlone();

  final apiClient = GetIt.instance<ApiClient>();
  final placeService = GetIt.instance<PlaceService>();
  final getSelectCashierUseCase = GetIt.instance<CashierSelectService>();
  final getSelectCurrencyUseCase = GetIt.instance<CurrencySelectService>();
  final getSelectYearUseCase = GetIt.instance<YearSelectService>();
  final getLanguageUseCase = GetIt.instance<LanguageService>();
  final storageService = GetIt.instance<StorageService>();
  final lang = await storageService.loadLanguage();

  final loginModule = await storageService.sqlLoadLoginSessionModel();
  final rootWidget = MultiBlocProvider(
    providers: [
      // ChangeNotifierProvider(
      //   create: (_) => NavigationNotifier(),
      //   lazy: false, // این خط اضافه شود
      // ),
      ChangeNotifierProvider(create: (_) => PageCacheProvider()),
      Provider<LoginService>(create: (_) => LoginService(client: apiClient)),
      Provider<PlaceBloc>(
        create: (_) => PlaceBloc(getPlaceUseCase: placeService),
      ),
      Provider<SelectCashierBloc>(
        create: (_) =>
            SelectCashierBloc(getSelectCashierUseCase: getSelectCashierUseCase),
      ),
      Provider<SelectCurrencyBloc>(
        create: (_) =>
            SelectCurrencyBloc(
              getSelectCurrencyUseCase: getSelectCurrencyUseCase,
            ),
      ),
      Provider<SelectYearBloc>(
        create: (_) =>
            SelectYearBloc(getSelectYearUseCase: getSelectYearUseCase),
      ),
      BlocProvider(create: (_) => ProfileBloc()),
      BlocProvider(
        create: (_) => LanguageBloc(getLanguageUseCase: getLanguageUseCase),
      ),
      BlocProvider(
        create: (_) =>
            PersonListBloc(personService: GetIt.instance<PersonService>()),
      ),
      BlocProvider(
        create: (_) => SearchPersonBloc(GetIt.instance<PersonRepository>()),
      ),
      BlocProvider(
        create: (_) =>
        GetIt.instance<MenuBloc>()
          ..add(LoadMenuEvent()),
      ),




    ],
    child: MainApp(
      initialLanguage: lang,
      messengerService: GetIt.instance<ExceptionHelperService>(),
    ),
  );
  runApp(
    ChangeNotifierProvider(
      lazy: false,
      create: (context) => PageCacheProvider(),
      child: Consumer<PageCacheProvider>(
        builder: (context, value, child) {
          return MainApp(
            initialLanguage: lang,
            messengerService: GetIt.instance<ExceptionHelperService>(),
          );
        },
      ),
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
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      locale: Locale(initialLanguage.languageCode ?? 'fa'),
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
      ),
      home: const MainAppScreen(),
      scrollBehavior: ScrollBehavior(),
    );
  }
}

class MainAppScreen extends StatelessWidget {
  const MainAppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isRTL = Localizations
        .localeOf(context)
        .languageCode == 'fa';

    return Consumer<PageCacheProvider>(
      builder: (context, notifier, child) {
        if (notifier.isSignOutNeed) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Restart.restartApp();
          });
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(backgroundColor: Colors.white),
            ),
          );
        }
        return
          // textDirection: isRTL ? TextDirection.rtl : TextDirection.ltr,
          _buildContent(context, notifier);

      },
    );
  }

  Widget _buildContent(BuildContext context, PageCacheProvider notifier) {
    if (notifier.isErrorState) {
      return _buildErrorWidget(notifier);
    }

    if (notifier.isSkeletonActive) {
      return notifier.getPage(NavButtonTabBarMode.skeletion);
    }

    switch (notifier.pageType  ) {
      case PageType.listGenerator:
        final isListGeneratorActive =
            (notifier.isListGeneratorActive?.values.last) ?? false;
        if (isListGeneratorActive) {
          return _buildListGeneratorContent(notifier, context);
        }
        return ErpNotFound();
      case PageType.formGenerator:
        final isFormGeneratorActive =
            notifier.isFormGeneratorActive?.values.first ?? false;
        if (isFormGeneratorActive) {
          return _buildFormGeneratorContent();
        }
        return ErpNotFound();
      case PageType.tabBar:
        return _buildMainContent(context, notifier);
      default:
        return ErpNotFound();
    }


    // حالت فرم جنریک فعال


  }

  Widget _buildListGeneratorContent(PageCacheProvider notifier,
      BuildContext context,) {
    return AdvancedRouter.buildPage(
      RouteData(
        path: notifier.isListGeneratorActive.keys.last ?? '' as String,
        location: 'vsa',
        queryParams: {},
        pathParams: {},
        arguments: [],
        pathEndsWithSlash: false,
        redirectedFrom: [],
        subLocation: '',
        navigatorKey: navigatorKey,
      ),
      context,
    ); // یا return YourListGeneratorWidget();
  }

  Widget _buildFormGeneratorContent() {
    // محتوای فرم جنریک
    return SizedBox(child: Text('Form Generator'));
  }

  Widget _buildMainContent(BuildContext context, PageCacheProvider notifier) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: notifier.appBarMode,
      body: Column(
        children: [
          if (notifier.errorMessages.length > 1) _buildErrorWidget(notifier),

          Expanded(
            child: Consumer<PageCacheProvider>(
              builder: (context, navNotifier, child) {
                return navNotifier.getPage(notifier.selectedTab) ??
                    const ErpNotFound();
              },
            ),
          ),

          AppNavigationButton(
            selectedTab: notifier.selectedTab,
            onTabSelected: (value) =>
                notifier.changePage(PageType.tabBar, route: null, tab: value),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorWidget(PageCacheProvider notifier) {
    return Scaffold(
      backgroundColor: Colors.red.withOpacity(0.1),

      body: Row(
        children: [
          const Icon(Icons.error, color: Colors.red),
          const SizedBox(width: 8),
          Expanded(child: Text(notifier.errorMessages.last ?? 'a')),
          IconButton(
            onPressed: notifier.clearError,
            icon: const Icon(Icons.close),
          ),
        ],
      ),
    );
  }
}

Widget buildERPApp({required Map<String, dynamic> loginDatas}) {
  if (loginDatas.isEmpty) return const SizedBox();

  if (loginDatas[SessionKeysExt(SessionKeys.language).key] == null) {
    loginDatas[SessionKeysExt(SessionKeys.language).key] = Language(
      languageCode: 'fa',
      smallName: 'fa',
      id: 0,
      bigName: 'IR',
      completeName: 'fa_IR',
    );
  }

  usePathUrlStrategy();
  final loginModuleResult = LoginModuleResult.success(
    user: user.UserDto.fromJson(
      loginDatas[SessionKeysExt(SessionKeys.user).key],
    ),
    token: loginDatas[SessionKeysExt(SessionKeys.token).key],
    networkMode:
    loginDatas[SessionKeysExt(SessionKeys.networkType).key] ?? 0 as int,
    cachedKey: '',
    language: Language.fromJson(
      loginDatas[SessionKeysExt(SessionKeys.language).key],
    ),
    managementAccount:
    (loginDatas[SessionKeysExt(SessionKeys.managementAccount).key]
    as List<dynamic>)
        .map(
          (e) =>
          login.ManagementAccounts.fromJson(e as Map<String, dynamic>),
    )
        .toList(),
    success:
    loginDatas[SessionKeysExt(SessionKeys.success).key] ?? false as bool,
    error: loginDatas[SessionKeysExt(SessionKeys.error).key] as String?,
    timestamp: loginDatas[SessionKeysExt(SessionKeys.timeStamp).key] != null
        ? DateTime.fromMillisecondsSinceEpoch(
      loginDatas[SessionKeysExt(SessionKeys.timeStamp).key] as int,
    )
        : DateTime.now(),
    selectedManagementAccount: login.ManagementAccounts.fromJson(
      loginDatas[SessionKeysExt(SessionKeys.selectedManagement).key],
    ),
  );

  if (!sl.isRegistered<AppNotifier>()) {
    final AppNotifier appNotifier = AppNotifier();
    AppNotifier.initialize(registerInGetIt: false, sl: sl);
    sl.registerSingleton<AppNotifier>(appNotifier);
  } else {
    sl.unregister<AppNotifier>();
    final AppNotifier appNotifier = AppNotifier();
    AppNotifier.initialize(registerInGetIt: false, sl: sl);
    sl.registerSingleton<AppNotifier>(appNotifier);
  }
  final appNotifier = sl<AppNotifier>();
  appNotifier.notifyInfo('Child ERP app started', crossApp: true);
  final storageService = GetIt.instance<StorageService>();

  if ((loginDatas[LoginRouter.isLoginModuleModel] ?? false) as bool == true &&
      loginDatas[LoginRouter.loginNavigator] != null &&
      loginDatas[LoginRouter
          .loginNavigator] is GuardedNavigationBuilder) {} else {}

  storageService.saveLoginSessionModel(loginModuleResult);

  final placeService = GetIt.instance<PlaceService>();
  final getSelectCashierUseCase = GetIt.instance<CashierSelectService>();
  final getSelectCurrencyUseCase = GetIt.instance<CurrencySelectService>();
  final getSelectYearUseCase = GetIt.instance<YearSelectService>();
  final getLanguageUseCase = GetIt.instance<LanguageService>();

  final a = storageService.sqlLoadLoginSessionModel().then(
        (value) => {print('b')},
  );
  final b = storageService.getDbPath().then(
        (isok) =>
    {
      {print('')},
    },
  );
  return MultiProvider(
    providers: [
      // ChangeNotifierProvider(
      //   create: (_) => NavigationNotifier(),
      //   lazy: false, // این خط اضافه شود
      // ),
      ChangeNotifierProvider(create: (_) => PageCacheProvider()),
      Provider<LoginService>(
        create: (_) => LoginService(client: GetIt.instance<ApiClient>()),
      ),
      Provider<PlaceBloc>(
        create: (_) => PlaceBloc(getPlaceUseCase: placeService),
      ),
      Provider<SelectCashierBloc>(
        create: (_) =>
            SelectCashierBloc(getSelectCashierUseCase: getSelectCashierUseCase),
      ),
      Provider<SelectCurrencyBloc>(
        create: (_) =>
            SelectCurrencyBloc(
              getSelectCurrencyUseCase: getSelectCurrencyUseCase,
            ),
      ),
      Provider<SelectYearBloc>(
        create: (_) =>
            SelectYearBloc(getSelectYearUseCase: getSelectYearUseCase),
      ),
      BlocProvider(
        create: (_) => LanguageBloc(getLanguageUseCase: getLanguageUseCase),
      ),
      BlocProvider(
        create: (_) =>
        GetIt.instance<MenuBloc>()
          ..add(LoadMenuEvent()),
      ),
      BlocProvider(create: (_) => ProfileBloc()),
      BlocProvider(
        create: (_) =>
            PersonListBloc(personService: GetIt.instance<PersonService>()),
      ),
      BlocProvider(
        create: (_) => SearchPersonBloc(GetIt.instance<PersonRepository>()),
      ),
    ],
    child: MainApp(
      initialLanguage:
      loginModuleResult.language ?? Language(languageCode: 'fa'),
      messengerService: GetIt.instance<ExceptionHelperService>(),
    ),
  );
}

class DynamicEntityApp extends StatelessWidget {
  final LoginModuleResult loginModuleResult;

  const DynamicEntityApp({super.key, required this.loginModuleResult});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: erpNavigator.routerConfig,
      debugShowCheckedModeBanner: false,
      locale: Locale((loginModuleResult.language)?.languageCode ?? 'fa'),
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
      scrollBehavior: ScrollBehavior(),
    );
  }
}

final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();
