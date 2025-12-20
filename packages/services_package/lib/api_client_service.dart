import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http/retry.dart';
import 'package:models_package/Base/base_request.dart'
    show BaseRequest, Defaults;
import 'package:models_package/Base/base_response.dart';
 import 'package:services_package/storage/domain/usecases/storage_service.dart';

import 'safe_exquter.dart';


typedef FromJson<T> = T Function(Map<String, dynamic> json);

abstract interface class IApiClient {
  Future<T?>
  sendRequestAsync<T extends BaseResponse<D>, D, C extends BaseRequest>(
    String url,
    HttpMethods method,
    C? data,
    bool? setToken,
    Exception? fallbackMessage,
    T Function(Map<String, dynamic>) fromJsonD,
  );

  Future<T?> sendObjectRequestAsync<T extends BaseResponse<D>, D>(
    String url,
    HttpMethods method,
    Object? data,
    bool? setToken,
    Exception? fallbackMessage,
    T Function(Map<String, dynamic>) fromJsonD,
  );
}

class ApiClient extends IApiClient {
  final StorageService storage;
  final ApiSettings appSettings;

  static bool _isRefreshing = false;
  static final _pendingRequests = <Future Function()>[];
  static final _loginUrl = "api/auth/login";

  ApiClient({required this.storage, required this.appSettings});

  late final http.Client _httpClient = RetryClient(http.Client());

  T returnDefaultValueOnException<T extends BaseResponse<D>, D>(
    T Function(Map<String, dynamic>) fromJsonD,
    String? message,
    int? httpStatus,
  ) {
    if (httpStatus == HttpStatus.unauthorized) {
      storage.signOut();
    }
    return fromJsonD({
      "Result": "Failed",
      "Error": message ?? "",
      "Data": [],
      "Status": httpStatus ?? 500,
    });
  }

  @override
  Future<T?> sendObjectRequestAsync<T extends BaseResponse<D>, D>(
    String url,
    HttpMethods method,
    Object? data,
    bool? setToken,
    Exception? fallbackMessage,
    T Function(Map<String, dynamic>) fromJsonD,
  ) async {
    T? result;
    try {
      String? token = null;
      if (setToken ?? false) {
        token = await _getTokenIfNeeded(true);
      }

      result = await _internalSendRequest<T, D>(
        url: url,
        method: method,
        data: data,
        token: token,
        fromJsonD: fromJsonD,
      );
    } catch (e) {
      result = returnDefaultValueOnException(
        fromJsonD,
        e.toString(),
        HttpStatus.unavailableForLegalReasons,
      );
    }
    return result;
  }

  // --------------------- Core SendRequest ---------------------
  @override
  Future<T?>
  sendRequestAsync<T extends BaseResponse<D>, D, C extends BaseRequest>(
    String url,
    HttpMethods method, // 'GET', 'POST', etc
    C? data,
    bool? setToken,
    Exception? fallbackMessage,
    T Function(Map<String, dynamic>) fromJsonD,
  ) async {
    T? result;
    try {
      data?.defaults = appSettings.appDefaults;
      String? token = null;
      if (setToken ?? false) {
        token = await _getTokenIfNeeded(true);
      }

      result = await _internalSendRequest<T, D>(
        url: url,
        method: method,
        data: data,
        token: token,
        fromJsonD: fromJsonD,
      );

      if (result != null &&
          (result.result == "Failed" || result.result == "Pending") &&
          (result.error == null || result.error!.isEmpty)) {}
    } catch (e) {
      returnDefaultValueOnException(
        fromJsonD,
        e.toString(),
        HttpStatus.unavailableForLegalReasons,
      );
    }
    return result;
  }

  // --------------------- Internal Request ---------------------
  Future<T?> _internalSendRequest<T extends BaseResponse<D>, D>({
    required String url,
    required HttpMethods method,
    Object? data,
    String? token,
    required T Function(Map<String, dynamic>) fromJsonD,
  }) async {
    try {
      String? baseUrl = appSettings.baseUrl;

      final executor = SafeExqueter<bool>.fromString(
        baseUrl,
        errorMessage: "Base URL خالیه",
      );

      final bool isBaseUrlValid = await executor.execute((baseUrl) async {
        return baseUrl != null && baseUrl.isNotEmpty;
      });

      if (!isBaseUrlValid) {
        return returnDefaultValueOnException(
          fromJsonD,
          "BaseUrl Is invalid",
          HttpStatus.unsupportedMediaType,
        );
      }

      // 2. Validate HTTP method
      if (method == HttpMethods.unknown) {
        return returnDefaultValueOnException(
          fromJsonD,
          "Method Is invalid",
          500,
        );
      }

      // 3. Prepare headers
      final headers = <String, String>{'Content-Type': 'application/json'};
      headers[HttpHeaders.cacheControlHeader] = 'no-cache';
      // 4. Handle token if needed

      if (token != null && token.isNotEmpty) {
        headers[HttpHeaders.authorizationHeader] = 'Bearer $token';
      }

      // 5. Prepare URI
      final uriBuilder = ApiUriBuilder(baseUrl);
      final Uri uri = uriBuilder.build(url);

      // 6. Prepare request body
      final String? body = data != null ? json.encode(data) : null;
      http.ClientException("test");
      // 7. Execute request
      final client = RetryClient(http.Client());
      http.Response response;
      switch (method) {
        case HttpMethods.get:
          response = await http.get(uri, headers: headers);
          break;
        case HttpMethods.post:
          response = await http.post(
            uri,
            headers: headers,
            body: body,
            encoding: Utf8Codec(allowMalformed: false),
          );
          break;
        case HttpMethods.put:
          response = await http.put(uri, headers: headers, body: body);
          break;
        case HttpMethods.delete:
          response = await http.delete(uri, headers: headers);
          break;
        default:
          return returnDefaultValueOnException(
            fromJsonD,

            "Unsupported HTTP method",
            HttpStatus.methodNotAllowed,
          );
      }

      if (response.statusCode == 401) {
        _pendingRequests.add(
          () async => await _internalSendRequest(
            url: url,
            method: method,
            fromJsonD: fromJsonD,
          ),
        );
        if (await refreshToken()) {
          final newToken = await _getTokenIfNeeded(true);
          if (newToken != null && newToken.isNotEmpty) {
            headers[HttpHeaders.authorizationHeader] = 'Bearer $newToken';

            return await _retryRequest<T, D>(
              client: client,
              uri: uri,
              method: method,
              headers: headers,
              body: body,
            );
          }
        } else {
          return returnDefaultValueOnException(
            fromJsonD,
            "UnAuthorized",
            HttpStatus.unauthorized,
          );
        }
        return returnDefaultValueOnException(
          fromJsonD,
          "Unsupported HTTP method",
          HttpStatus.unsupportedMediaType,
        );
      }
      try {
        final decoded = json.decode(response.body);

        if (decoded is Map<String, dynamic>) {
          return await fromJsonD(decoded) as T;
        } else {
          return await fromJsonD(decoded) as T;
        }
      } catch (e) {
        return returnDefaultValueOnException(fromJsonD, e.toString(), 500);
      }
      // 9. Parse successful response
    } catch (e) {
      return returnDefaultValueOnException(fromJsonD, e.toString(), 500);
    }
  }

  // Helper method for retrying requests
  Future<T> _retryRequest<T extends BaseResponse<D>, D>({
    required RetryClient client,
    required Uri uri,
    required HttpMethods method,
    required Map<String, String> headers,
    required String? body,
  }) async {
    http.Response response;

    switch (method) {
      case HttpMethods.get:
        return json.decode((await client.get(uri, headers: headers)).body);

      case HttpMethods.post:
        return json.decode((await client.post(uri, headers: headers)).body);

      case HttpMethods.put:
        return json.decode((await client.put(uri, headers: headers)).body);

      case HttpMethods.delete:
        return json.decode((await client.delete(uri, headers: headers)).body);

      default:
        throw Exception('Unsupported HTTP method');
    }
  }

  Future<bool> refreshToken() async {
    if (_isRefreshing) return false; // جلوگیری از parallel refresh
    _isRefreshing = true;
    bool success = false;

    try {
      final user = await storage.loadUser();
      final deviceToken = await storage.loadDeviceToken();

      if (user == null || (user.refreshToken?.isEmpty ?? true)) {
        return false;
      }

      final refreshRequest = {
        "ManagementAccountId": 1,
        "Grant_Type": "Refresh_Token",
        "Refresh_Token": user.refreshToken,
        "IsRefreshToken": true,
        "DeviceToken": deviceToken,
        "Token": user.token,
      };
      final uriBuilder = ApiUriBuilder(appSettings.baseUrl);
      final Uri uri = uriBuilder.build(_loginUrl);
      final response = await _httpClient.post(
        uri,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(refreshRequest),
      );

      if (response.statusCode != 200) {
        return false;
      }

      final content = jsonDecode(response.body);
      final newToken = content['access_token'] as String?;

      if (newToken != null && newToken.isNotEmpty) {
        user.token = newToken;
        await storage.saveUser(user);
        await storage.saveToken(newToken);
        success = true;

        // اجرای درخواست‌های صف‌بندی شده
        while (_pendingRequests.isNotEmpty) {
          await _pendingRequests.first.call();
          final pending = _pendingRequests.removeAt(0);
          await pending();
        }
      }
    } catch (e) {
      return false;
    } finally {
      _isRefreshing = false;
    }

    return _isRefreshing;
  }

  Future<T> enqueueRequest<T>(Future<T> Function() request) {
    final completer = Completer<T>();
    _pendingRequests.add(() async {
      try {
        final result = await request();
        completer.complete(result);
      } catch (e) {
        completer.completeError(e);
      }
    });
    return completer.future;
  }

  // --------------------- Token ---------------------
  Future<String?> _getTokenIfNeeded(bool includeToken) async {
    if (!includeToken) return null;
    final user = await storage.loadUser();
    if (user != null && isTokenValid(user.token ?? '')) return user.token;
    return await storage.loadToken();
  }

  bool isTokenValid(String token) => token.isNotEmpty;
}

class RequestQueue {
  final _queue = <Future Function()>[];
  bool _isRunning = false;

  void enqueue(Future Function() request) {
    _queue.add(request);
    _runNext();
  }

  Future<void> _runNext() async {
    if (_isRunning || _queue.isEmpty) return;
    _isRunning = true;

    while (_queue.isNotEmpty) {
      final request = _queue.removeAt(0);
      try {
        await request();
      } catch (e) {
        // handle or log error
      }
    }

    _isRunning = false;
  }
}

// ------------------------- Supporting Types -------------------------
enum HttpMethod { get, post, put, delete }

enum HttpMethods {
  get(1, 'Get'),
  post(2, 'Post'),
  put(3, 'Put'),
  delete(4, 'Delete'),
  unknown(-1, 'Unknown');

  final String prefix;
  final int priority;

  const HttpMethods(this.priority, this.prefix);
}

class RequestWrapper {
  final bool useAsQueryString;
  final Object? data;

  RequestWrapper({this.useAsQueryString = false, this.data});
}

// --------------------- Interfaces ---------------------

abstract class IExceptionNotifier {
  void raise(Exception ex, {String? context});
}

class ApiSettings {
  final String baseUrl;
  final String loginUrl;
  final Defaults appDefaults;
  final Duration timeOut;

  ApiSettings({
    required this.baseUrl,
    required this.loginUrl,
    required this.appDefaults,
    required this.timeOut,
  });
}

class ApiUriBuilder {
  final String baseUrl;

  ApiUriBuilder(this.baseUrl);

  Uri build(String endpoint) {
    // Clean up base URL
    String cleanedBase = baseUrl.trim();

    // Ensure it ends with slash for proper concatenation
    if (!cleanedBase.endsWith('/')) {
      cleanedBase = '$cleanedBase/';
    }

    final String fullUrl =
        '$cleanedBase${endpoint.replaceFirst(RegExp(r'^/'), '')}';

    return Uri.parse(fullUrl.replaceAll(RegExp(r'(?<!:)/+'), '/'));
  }
}
