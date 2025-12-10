


// Ehsan Change

import 'package:models_package/Data/Default/trh/select/select_cashier.dart';
import 'package:services_package/Interfaces/iapi_service.dart';

import '../../../api_client_service.dart';

class CashierSelectService implements IApiService<Response, ResponseData, Request> {
  final ApiClient apiClient;
  final int RepoViewId;

  CashierSelectService(this.apiClient, {required this.RepoViewId});

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
      "api/trh/select/cashier4SelectOption",
      HttpMethods.post,
      request,
      true,
      Exception('Cashier error'),
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
