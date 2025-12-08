import 'package:erp_app/core/navigation/navigation_service.dart';
import 'package:get_it/get_it.dart';
import 'package:models_package/Base/base_request.dart';
import 'package:models_package/Data/Auth/Menu/dto.dart' as menu;
import 'package:models_package/Data/Com/Person/dto.dart' as person_list;
import 'package:services_package/Interfaces/apiclient_middleware_service.dart';
import 'package:services_package/Interfaces/iapi_service.dart';
import 'package:services_package/api_client_service.dart';
import 'package:services_package/api_service.dart';

import 'package:services_package/auth/menu/menu_service.dart';
import 'package:services_package/device_token_service.dart';
import 'package:services_package/login_service.dart';
import 'package:services_package/otp_service.dart';
import 'package:services_package/storage_service.dart';
import 'package:services_package/user_exist.dart';

import '../../feature/menu/bloc/menu_bloc.dart';
import 'api_client.dart';

final sl = GetIt.instance;

void initStandAlone() {
  final _storage = StorageService();
  final _defaults = Defaults(
    placeId: 1,
    yearId: 1403,
    languageId: 2,
    managementAccountId: 1,
  );
  final _apisetting = ApiSettings(
    baseUrl: 'https://216.65.200.215/',
    loginUrl: 'api/auth/login',
    appDefaults: _defaults,
  );

  // Providers
  sl.registerSingleton<StorageService>(_storage);
  final apiClient = ApiClient(storage: _storage, appSettings: _apisetting);
  final _otp = OtpService(apiClient);
  sl.registerLazySingleton<ApiSettings>(() => _apisetting);
  sl.registerLazySingleton<ApiClient>(
    () => ApiClient(storage: _storage, appSettings: _apisetting),
  );
  sl.registerLazySingleton<OtpService>(() => _otp);
  sl.registerLazySingleton<UserExistService>(() => UserExistService());
  sl.registerLazySingleton<NavigationService>(() => NavigationService());
  sl.registerLazySingleton<IApiService>(() => ApiService());
  sl.registerLazySingleton<ApiClientMiddlewareService>(
    () => ApiClientMiddlewareService(apiClient: apiClient),
  );
  sl.registerLazySingleton<NotificationService>(
    () => NotificationService(
      storage: _storage,
      refreshInterval: Duration(minutes: 5),
    ),
  );

  sl.registerLazySingleton<LoginService>(
    () => LoginService(client: apiClient, storage: _storage),
  );
}

void initPartition() {
  // Blocs

  final apiClient = GetIt.I<ApiClient>();
  sl.registerFactory(() => MenuBloc(getMenuUseCase: sl<MenuService>()));
  sl.registerFactory(() => IApiService<menu.Response, menu.ResponseData, menu.Request>);
  sl.registerFactory(() => IApiService<person_list.Response, person_list.ResponseData, person_list.Request>);
}
