


// Ehsan Change

import 'package:models_package/Data/Default/Com/Select/Select_Currency/select_currency.dart';
import 'package:services_package/Interfaces/iapi_service.dart';

import '../../../api_client_service.dart';

class CurrencySelectService implements IApiService<Response, ResponseData, Request> {
  final ApiClient apiClient;

  CurrencySelectService(this.apiClient);

  @override
  Future<Response?> delete(
      Request request,
      Response Function(Map<String, dynamic>) fromJsonD,
      ) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<Response?> get(
      Request request,
      Response Function(Map<String, dynamic>) fromJsonD,
      ) async {
    return await apiClient.sendRequestAsync<Response, ResponseData, Request>(
      "api/com/Select/currency4bankAccount",
      HttpMethods.post,
      request,
      true,
      Exception('Currency error'),
          (json) => Response.fromJson(json),
    );
  }

  @override
  Future<Response?> insert(
      Request request,
      Response Function(Map<String, dynamic>) fromJsonD,
      ) {
    // TODO: implement insert
    throw UnimplementedError();
  }

  @override
  Future<Response?> update(
      Request request,
      Response Function(Map<String, dynamic>) fromJsonD,
      ) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
