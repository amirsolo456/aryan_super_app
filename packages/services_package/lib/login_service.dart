import 'setup_services.dart';
import 'storage_service.dart';

import 'package:models_package/Data/Auth/Login/dto.dart';
import 'Interfaces/ilogin_service.dart';
import 'api_client_service.dart';

class LoginService implements ILoginService {
  late ApiClient _client;
  late StorageService _storage;
  late List<_LoginRequestCache> _loginRequestCache = [];

  LoginService({required ApiClient client, required StorageService storage}) {
    _client = getIt.get<ApiClient>();
    _storage = getIt.get<StorageService>();
    _loginRequestCache = <_LoginRequestCache>[];
  }

  @override
  Future<LoginResponse?> login(LoginRequest loginRequest) async {
    LoginResponse? result;
    try {
      final response = await _client
          .sendObjectRequestAsync<LoginResponse, ResponseData>(
            'api/auth/login',
            HttpMethods.post,
            loginRequest,
            false,
            Exception('خطا در ورود'),
          );

      result = response;
      if (result != null) {
        if (result.result != null &&
            result.result!.toLowerCase().contains('failed')) {
          return result;
        }

        final cacheKey =
            '${DateTime.now().millisecondsSinceEpoch}_${1000 + (DateTime.now().millisecondsSinceEpoch % 9000)}';

        final cache = _LoginRequestCache(
          loginRequest: loginRequest,
          tPrimary: cacheKey,
        );

        result.cacheKey = cacheKey;
        _loginRequestCache.add(cache);
      }
    } catch (ex) {}
    return result;
  }

  @override
  Future<LoginResponseNextStep?> nextLogin(
    String cacheKey,
    ManagementAccounts management,
  ) async {
    LoginResponseNextStep? result;
    _LoginRequestCache? requestCache;

    try {
      requestCache = _loginRequestCache.firstWhere(
        (c) => c.tPrimary == cacheKey,
        orElse: () => _LoginRequestCache.empty(),
      );

      if (requestCache.isEmpty) {
        requestCache = null;
      }

      if (requestCache != null) {
        requestCache.loginRequest.managementAccountId =
            management.managementAccountId;

        result = await _client
            .sendObjectRequestAsync<LoginResponseNextStep, ResponseData>(
              'api/auth/login',
              HttpMethods.post,
              requestCache.loginRequest,
              false,
              null,
            );
      }
    } catch (ex) {
      // _notifier.raise(this, ex);
      requestCache = null;
    } finally {
      if (requestCache != null) {
        _loginRequestCache.remove(requestCache);
      }
    }

    return result;
  }
}

class _LoginRequestCache {
  final LoginRequest loginRequest;
  final String tPrimary;

  _LoginRequestCache({required this.loginRequest, required this.tPrimary});

  bool get isEmpty => tPrimary.isEmpty;

  factory _LoginRequestCache.empty() =>
      _LoginRequestCache(loginRequest: LoginRequest(), tPrimary: '');
}
