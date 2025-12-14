// Ehsan Change

import 'package:models_package/Data/Default/Com/Select/Select_Year/select_year_dto.dart';
import '../../../Interfaces/backend_api_services/iapi_service.dart';
import '../../../api_client_service.dart';

class YearSelectService
    implements IApiService<Response, ResponseData, Request> {
  final ApiClient apiClient;

  YearSelectService(this.apiClient);

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
      "api/com/Select/YearSelect4Default",
      HttpMethods.post,
      request,
      true,
      Exception('YearSelect error'),
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
