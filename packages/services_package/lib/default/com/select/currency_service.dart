// Ehsan Change

import 'package:models_package/Data/Default/Com/Select/Select_Currency/currency_dto.dart';

import '../../../Interfaces/backend_api_services/iapi_service.dart';
import '../../../api_client_service.dart';

class CurrencySelectService
    implements IApiService<CurrencyResponse, ResponseData, CurrencyRequest> {
  final ApiClient apiClient;

  CurrencySelectService(this.apiClient);

  @override
  Future<CurrencyResponse?> delete(
    CurrencyRequest request,
    CurrencyResponse Function(Map<String, dynamic>) fromJsonD,
  ) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<CurrencyResponse?> get(
    CurrencyRequest request,
    CurrencyResponse Function(Map<String, dynamic>) fromJsonD,
  ) async {
    return await apiClient
        .sendRequestAsync<CurrencyResponse, ResponseData, CurrencyRequest>(
          "api/com/Select/currency4bankAccount",
          HttpMethods.post,
          request,
          true,
          Exception('Currency error'),
          (json) => CurrencyResponse.fromJson(json),
        );
  }

  @override
  Future<CurrencyResponse?> insert(
    CurrencyRequest request,
    CurrencyResponse Function(Map<String, dynamic>) fromJsonD,
  ) {
    // TODO: implement insert
    throw UnimplementedError();
  }

  @override
  Future<CurrencyResponse?> update(
    CurrencyRequest request,
    CurrencyResponse Function(Map<String, dynamic>) fromJsonD,
  ) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
