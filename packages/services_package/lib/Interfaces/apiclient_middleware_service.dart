// -------------------- Api Middleware --------------------
import 'package:models_package/Data/Com/Person/dto.dart';
import 'package:models_package/Data/Auth/Menu/dto.dart' as menu;

import '../api_client_service.dart';
import 'fake_data_service.dart';

class ApiClientMiddlewareService {
  final ApiClient apiClient;

  ApiClientMiddlewareService({required this.apiClient});

  Future<Response> sendRequestWithFallback(
    String url,
    HttpMethods method, {
    Request? request,
    bool setToken = false,
  }) async {
    if (apiClient.appSettings.baseUrl.isEmpty ||
        apiClient.appSettings.baseUrl == '') {
      await Future.delayed(Duration(seconds: 2));
      return FakeDataService.getFakePersons();
    }
    try {
      final response = await apiClient
          .sendRequestAsync<Response, ResponseData, Request>(
            url,
            method,
            request ?? Request(),
            setToken,
            Exception("خطا در دریافت اطلاعات"),
          );
      return response ?? FakeDataService.getFakePersons();
    } catch (e) {
      return FakeDataService.getFakePersons();
    }
  }

  Future<menu.Response> sendRequestForMenuWithFallback(
      String url,
      HttpMethods method, {
        menu.Request? request,
        bool setToken = false,
      }) async {
    if (apiClient.appSettings.baseUrl.isEmpty ||
        apiClient.appSettings.baseUrl == '') {
      await Future.delayed(Duration(seconds: 2));
      return FakeMenuDataService.getFakeMenu();
    }
    try {
      // final response = await apiClient
      //     .sendRequestAsync<Response, ResponseData, Request>(
      //   url,
      //   method,
      //   request ?? menu.Request(),
      //   setToken,
      //   Exception("خطا در دریافت اطلاعات"),
      // );
      return FakeMenuDataService.getFakeMenu();
    } catch (e) {
      return FakeMenuDataService.getFakeMenu();
    }
  }
}
