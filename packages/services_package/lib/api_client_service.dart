import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http/retry.dart';
import 'package:http_exception/http_exception.dart';
import 'package:models_package/Base/base_request.dart'
    show BaseRequest, Defaults;
import 'package:models_package/Base/base_response.dart';
import 'package:services_package/api_exception_service.dart';
import 'package:services_package/storage_service.dart';

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
  );

  Future<T?> sendObjectRequestAsync<T extends BaseResponse<D>, D>(
    String url,
    HttpMethods method,
    Object? data,
    bool? setToken,
    Exception? fallbackMessage,
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

  @override
  Future<T?> sendObjectRequestAsync<T extends BaseResponse<D>, D>(
    String url,
    HttpMethods method,
    Object? data,
    bool? setToken,
    Exception? fallbackMessage,
  ) async {
    T? result;
    try {
      Object defaults = appSettings.appDefaults;
      result = await _internalSendRequest<T, D>(
        url: url,
        method: method,
        data: data,
        setToken: setToken,
      );

      if (result != null &&
          (result.result == "Failed" || result.result == "Pending") &&
          (result.error == null || result.error!.isEmpty)) {
        // await _exceptionHandler(fallbackMessage ?? Exception("خطا"));
      }
    } catch (e) {
      result =
          BaseResponse<D>.error(e is Exception ? e : Exception(e.toString()))
              as T;
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
  ) async {
    T? result;
    try {
      data?.defaults = appSettings.appDefaults;
      result = await _internalSendRequest<T, D>(
        url: url,
        method: method,
        data: data,
        setToken: setToken,
      );

      if (result != null &&
          (result.result == "Failed" || result.result == "Pending") &&
          (result.error == null || result.error!.isEmpty)) {
        // await _exceptionHandler(fallbackMessage ?? Exception("خطا"));
      }
    } catch (e) {
      result =
          BaseResponse<D>.error(e is Exception ? e : Exception(e.toString()))
              as T;
    }
    return result;
  }

  // --------------------- Internal Request ---------------------
  Future<T?> _internalSendRequest<T extends BaseResponse<D>, D>({
    required String url,
    required HttpMethods method,
    Object? data,
    bool? setToken,
  }) async {
    final T finalReslt =
        BaseResponse<D>.error(Exception('خطایی رخ داده است')) as T;
    http.Response response;

    try {
      final executor = SafeExqueter<bool>.fromString(
        baseUrl,
        errorMessage: "Base URL خالیه",
      );

      final bool isValid = await executor.execute((val) async {
        return val != null && val.isNotEmpty;
      });
      if (!isValid) {
        finalReslt.exception = Exception("Base URL invalid");
        return finalReslt;
      }

      final bool isBaseUrlValid = await executor.execute((baseUrl) async {
        return baseUrl != null && baseUrl.isNotEmpty;
      });
      if (isBaseUrlValid == false) {
        finalReslt.exception = Exception("BaseUrl Is invalid");
        return finalReslt;
      }

      final Uri uri = Uri.https('$baseUrl$url');
      final client = RetryClient(http.Client());
      final headers = <String, String>{'Content-Type': 'application/json'};
      final bool useToken = setToken ?? false;

      if (useToken) {
        final token = await _getTokenIfNeeded(setToken ?? true);
        bool hasToken = await executor.execute((token) async {
          return token != null && token.isNotEmpty;
        });
        if (hasToken == false) {
          finalReslt.exception = Exception("Token invalid");
          return finalReslt;
        }
        headers[HttpHeaders.authorizationHeader] = 'Bearer $token';
      }

      bool httpmothod = await executor.execute((method) async {
        return method != null && method != HttpMethods.unknown;
      });
      if (httpmothod == false) {
        finalReslt.exception = Exception("Methos Is invalid");
        return finalReslt;
      }

      switch (method.prefix) {
        case 'Get':
          response = await client.get(uri, headers: headers);
          break;
        case 'Post':
          response = await client.post(
            uri,
            headers: headers,
            body: data?.toString(),
          );
          break;
        case "Put":
          response = await client.put(
            uri,
            headers: headers,
            body: data?.toString(),
          );
          break;
        case "Delete":
          response = await client.delete(uri, headers: headers);
          break;
        default:
          finalReslt.exception = Exception('Unsupported HTTP method');
          return finalReslt;
      }

      HttpException? exception = apiExceptionValidator(response);
      if (exception != null) {
        if (exception.httpStatus.code == UnauthorizedHttpException) {
          final tcs = Completer<T?>();
          _pendingRequests.add(() async {
            final result = await sendObjectRequestAsync<T, D>(
              url,
              method,
              data,
              setToken,
              Exception(),
            );
            if (!tcs.isCompleted) tcs.complete(result);
          });

          if (await refreshToken()) {
            return await tcs.future;
          }
        }
      }
      return await json.decode(response.body) as T;
    } catch (e) {
      return BaseResponse<D>.error(e is Exception ? e : Exception(e.toString()))
          as T;
    }
  }

  Future<bool> refreshToken() async {
    if (_isRefreshing) return false; // جلوگیری از parallel refresh
    _isRefreshing = true;
    bool success = false;

    try {
      final user = await storage.getUser();
      final deviceToken = await storage.getDeviceToken();

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

      final response = await _httpClient.post(
        Uri.parse(_loginUrl),
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
        await storage.setUser(user);
        await storage.setToken(newToken);
        success = true;

        // اجرای درخواست‌های صف‌بندی شده
        while (_pendingRequests.isNotEmpty) {
          final pending = _pendingRequests.removeAt(0);
          await pending();
        }
      }
    } catch (e) {
      // اینجا می‌توانید Exception handler خودتون رو فراخوانی کنید
      print('Refresh token failed: $e');
      return false;
    } finally {
      _isRefreshing = false;
    }

    return success;
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
    final user = await storage.getUser();
    if (user != null && isTokenValid(user.token ?? '')) return user.token;
    return await storage.getToken();
  }

  bool isTokenValid(String token) => token.isNotEmpty;

  //   // ------------------------- Exception Handling -------------------------
  //   Future<void> _exceptionHandler(dynamic ex) async {
  //     if (ex is Exception) {
  //       /*
  //       notifier.raise(ex, context: context);
  // */
  //     } else {
  //       /*
  //       notifier.raise(Exception(ex.toString()), context: context);
  // */
  //     }
  //   }
  //
  //   Future<void> _exceptionHandlerHttpStatus(int statusCode) async {
  //     switch (statusCode) {
  //       case 401:
  //         /*
  //         notifier.raise(Exception("توکن منقضی شده"), context: "401");
  // */
  //         break;
  //       case 500:
  //         /*        notifier.raise(
  //           Exception("خطا در اتصال یا پاسخ نامعتبر از سرور"),
  //           context: "500",
  //         );*/
  //         break;
  //       case 408:
  //         /*
  //         notifier.raise(Exception("درخواست منقضی شد (Timeout)"));
  // */
  //         break;
  //       case 502:
  //         /*
  //         notifier.raise(Exception("خطا در پردازش داده‌ها"));
  // */
  //         break;
  //       default:
  //         break;
  //     }
  //   }
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

String baseUrl = '';

// --------------------- Interfaces ---------------------

abstract class IExceptionNotifier {
  void raise(Exception ex, {String? context});
}

class ApiSettings {
  final String baseUrl;
  final String loginUrl;
  final Defaults appDefaults;

  ApiSettings({
    required this.baseUrl,
    required this.loginUrl,
    required this.appDefaults,
  });
}
