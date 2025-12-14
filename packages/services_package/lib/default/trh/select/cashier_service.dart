// Ehsan Change

import 'package:models_package/Data/Default/trh/select/select_option_dto.dart';
import '../../../Interfaces/backend_api_services/iapi_service.dart';
import '../../../api_client_service.dart';

class CashierSelectService
    implements
        IApiService<
          SelectOptionResponse,
          SelectOptionData,
          SelectOptionRequest
        > {
  final ApiClient apiClient;
  final int RepoViewId;

  CashierSelectService(this.apiClient, {required this.RepoViewId});

  @override
  Future<SelectOptionResponse?> delete(
    SelectOptionRequest request,
    SelectOptionResponse Function(Map<String, dynamic>) fromJsonD,
  ) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<SelectOptionResponse?> get(
    SelectOptionRequest request,
    SelectOptionResponse Function(Map<String, dynamic>) fromJsonD,
  ) async {
    return await apiClient.sendRequestAsync<
      SelectOptionResponse,
      SelectOptionData,
      SelectOptionRequest
    >(
      "api/trh/select/cashier4SelectOption",
      HttpMethods.post,
      request,
      true,
      Exception('Cashier error'),
      (json) => SelectOptionResponse.fromJson(json),
    );
  }

  @override
  Future<SelectOptionResponse?> insert(
    SelectOptionRequest request,
    SelectOptionResponse Function(Map<String, dynamic>) fromJsonD,
  ) {
    // TODO: implement insert
    throw UnimplementedError();
  }

  @override
  Future<SelectOptionResponse?> update(
    SelectOptionRequest request,
    SelectOptionResponse Function(Map<String, dynamic>) fromJsonD,
  ) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
