import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:models_package/Base/base_request.dart';
import 'package:services_package/Interfaces/apiclient_middleware_service.dart';
import 'package:services_package/Interfaces/auth/imenu_service.dart';
import 'package:services_package/api_client_service.dart';

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
  // sl.registerFactory<StorageService>(() => StorageService());
  // sl.registerFactory<StorageService>(() => StorageService());

  final _storage = StorageService();
  final _defaults = Defaults();
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
  // sl.registerLazySingleton<MenuService>(() => MenuService(apiClient));
  sl.registerLazySingleton<ApiClientMiddlewareService>(
    () => ApiClientMiddlewareService(apiClient: apiClient),
  );
  sl.registerLazySingleton<NotificationService>(
    () => NotificationService(
      storage: _storage,
      refreshInterval: Duration(minutes: 5),
    ),
  );


}

void initPartition() {
  // Blocs

  final apiClient =  GetIt.I<ApiClient>();
  sl.registerFactory(() => MenuBloc(getMenuUseCase: sl<MenuService>()));
  sl.registerLazySingleton<MenuService>(() => MenuService(apiClient));
}
