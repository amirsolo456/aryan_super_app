import 'dart:io';
import 'package:erp_app/feature/redux/generic_lists/erp_store/models/field_display_config.dart';
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
import 'package:models_package/Data/Com/Person/dto.dart' as person;
import 'package:navigation_builder/navigation_builder.dart';
import 'package:provider/provider.dart';
import 'package:resources_package/l10n/app_localizations.dart';
import 'package:restart_app/restart_app.dart';
import 'package:services_package/Repo_ViewId/repo_view_id.dart';
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
import 'package:ui_components_package/erp_app_componenets/mobile/Components/erp_appbar.dart';
import 'package:ui_components_package/erp_app_componenets/mobile/Components/erp_not_found.dart';
import 'package:ui_components_package/erp_app_componenets/mobile/Expanders/list_datas_expander.dart';
import 'components/mainlayout/main_layout.dart';
import 'core/messengers_services/exception_helper_service.dart';
import 'core/network/custom_http_override.dart';
import 'core/network/injection_container.dart';
import 'data/models/login_module_model.dart';
import 'feature/auth/menu/bloc/menu_bloc.dart';
import 'feature/auth/menu/bloc/menu_event.dart';
import 'feature/auth/menu/pages/menu_page.dart';
import 'feature/com/person/domain/repositories/person_repository.dart';
import 'feature/com/person/presentation/blocs/person_bloc/person_list_bloc.dart';
import 'feature/com/person/presentation/blocs/search_person_bloc/search_person_bloc.dart';
import 'feature/com/person/presentation/features/person_list_page.dart';
import 'feature/com/person/presentation/widgets/person_list_nav.dart';
import 'feature/default_page/Language/bloc/language_bloc.dart';
import 'feature/default_page/Place/bloc/place_bloc.dart';
import 'feature/default_page/select_cashier/bloc/select_cashier_bloc.dart';
import 'feature/default_page/select_currency/bloc/select_currency_bloc.dart';
import 'feature/default_page/select_year/bloc/select_year_bloc.dart';
import 'feature/profile/profile_bloc.dart';
import 'feature/redux/generic_lists/erp_store/actions/generic_list_entity_actions.dart';
import 'feature/redux/generic_lists/erp_store/middleware/api_middleware.dart';
import 'feature/redux/generic_lists/erp_store/models/generic_list_entity_state.dart';
import 'feature/redux/generic_lists/erp_store/reducers/list_reducer.dart';

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
      Provider<LoginService>(create: (_) => LoginService(client: apiClient)),
      Provider<PlaceBloc>(
        create: (_) => PlaceBloc(getPlaceUseCase: placeService),
      ),
      Provider<SelectCashierBloc>(
        create: (_) =>
            SelectCashierBloc(getSelectCashierUseCase: getSelectCashierUseCase),
      ),
      Provider<SelectCurrencyBloc>(
        create: (_) => SelectCurrencyBloc(
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
        create: (_) => GetIt.instance<MenuBloc>()..add(LoadMenuEvent()),
      ),
    ],
    child: MainApp(
      initialLanguage: lang,
      messengerService: GetIt.instance<ExceptionHelperService>(),
    ),
  );

  AppErrorHandler.initializeErrorHandlers(rootWidget);
}

final erpNavigator = NavigationBuilder.create(
  routes: {
    '/signOut': (RouteData data) {
      Restart.restartApp().then((isok) => {print('ok')});
      return const SizedBox();
    },
    '/': (RouteData data) =>
        const MainLayoutPage(tab: NavButtonTabBarMode.erpOpenedTabMode),
    '/GenericList/Com/PersonList': (RouteData data) {
      // final path = data.pathParams['path'] ?? '';
      // final repoViewId = int.tryParse(data.queryParams['repoViewId'] ?? '0') ?? 0;
      //
      // print('Path: $path, repoViewId: $repoViewId');
      // if (path.contains('Com')) {
      return Builder(
        builder: (context) {
          final repoViewId = AppConstants().PersonListRepoViewId;
          return GenericEntityScreen<person.ResponseData>(
            screenTitle: 'لیست اشخاص',
            fieldConfigs: [
              FieldDisplayConfig(
                label: 'نام',
                valueGetter: (p) => p.displayName ?? '',
              ),
              FieldDisplayConfig(
                label: 'ایمیل',
                valueGetter: (p) => p.firstName ?? '',
              ),
            ],
            enableSearch: true,
            enableSorting: true,
            enablePagination: true,
            customItemBuilder: (person) {
              return PersonExpander(person: person);
            },
            onFetchData: () async {
              try {
                final response = await GetIt.instance<PersonService>().get(
                  person.Request(repoViewId: repoViewId), // اینجا اصلاح شد
                  (json) => person.Response.fromJson(json),
                );

                final result =
                    await GenericListEntityState<
                      person.Response,
                      person.ResponseData,
                      person.Request
                    >(
                      request: person.Request(repoViewId: repoViewId),
                      response: response,
                      fetchData: response?.data ?? [],
                      fields: [],
                    );
                return result;
              } catch (e) {
                print('Error in onFetchData: $e');
                throw e;
              }
            },
          );
        },
      );
    },
    '/notFound': (RouteData data) => const ErpNotFound(),
    '/home/*': (RouteData data) => data.redirectTo('/'),
  },
  ignoreUnknownRoutes: true,
  // pageBuilder: (MaterialPageArgument arg) => (c) =>  Page<dynamic>(name: 'p',arguments: arg,canPop: true),


  initialLocation: '/',
  shouldUseCupertinoPage: true,
  unknownRoute: (route) => Scaffold(appBar: AppBar(), body: const SizedBox()),
  builder: (Widget outlet) => Scaffold(
    appBar: ErpAppBar(mode: AppBarsMode.erpGenericList),
    body: outlet,
  ),
  transitionsBuilder: (context, anim, secAnim, child) =>
      FadeTransition(opacity: anim, child: child),
  transitionDuration: const Duration(milliseconds: 2500),
  debugPrintWhenRouted: true,
);

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
    return MaterialApp.router(
      routerConfig: erpNavigator.routerConfig,
      debugShowCheckedModeBanner: false,
      locale: Locale(initialLanguage.languageCode ?? 'fa'),
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      // title: 'Erp',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
      ),
      // scrollBehavior: ScrollBehavior(),
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

  final storageService = GetIt.instance<StorageService>();

  if ((loginDatas[LoginRouter.isLoginModuleModel] ?? false) as bool == true &&
      loginDatas[LoginRouter.loginNavigator] != null &&
      loginDatas[LoginRouter.loginNavigator] is GuardedNavigationBuilder) {
  } else {}

  storageService.saveLoginSessionModel(loginModuleResult);
  final a = storageService.sqlLoadLoginSessionModel().then(
    (value) => {print('b')},
  );
  final b = storageService.getDbPath().then(
    (isok) => {
      {print('')},
    },
  );
  return MultiProvider(
    providers: [
      Provider<LoginService>(
        create: (_) => LoginService(client: GetIt.instance<ApiClient>()),
      ),
      BlocProvider(
        create: (_) => GetIt.instance<MenuBloc>()..add(LoadMenuEvent()),
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
