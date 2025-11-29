import 'otp_service.dart';
import 'storage_service.dart';
import 'user_exist.dart';
import 'package:get_it/get_it.dart';

import 'package:models_package/Base/base_request.dart';
import 'Interfaces/apiclient_middleware_service.dart';
import 'api_client_service.dart';
import 'device_token_service.dart';
import 'login_service.dart';

final getIt = GetIt.instance;

void setupServices() {
  final _storage = StorageService();
  final _defaults = Defaults();
  final _apisetting = ApiSettings(


    baseUrl: 'https://216.65.200.215/',
    loginUrl: 'api/auth/login',
    appDefaults: _defaults,
  );

  getIt.registerSingleton<StorageService>(_storage);

  final apiClient = ApiClient(storage: _storage, appSettings: _apisetting);
  final _otp = OtpService(apiClient);
  getIt.registerSingleton<ApiSettings>(_apisetting);
  getIt.registerSingleton<ApiClient>(apiClient);
  getIt.registerSingleton<OtpService>(_otp);
  getIt.registerSingleton<UserExistService>(UserExistService());
  getIt.registerSingleton<NotificationService>(
    NotificationService(storage: _storage),
  );

  getIt.registerSingleton<LoginService>(
    LoginService(client: apiClient, storage: StorageService()),
  );

  getIt.registerSingleton<ApiClientMiddlewareService>(
    ApiClientMiddlewareService(apiClient: apiClient),
  );
}
