import 'package:models_package/Data/dashboard/dashboard_dto.dart';
import 'package:services_package/Interfaces/backend_api_services/iapi_service.dart';

import '../../api_client_service.dart';

class DashboardService
    implements IApiService<Response, DashboardModel, Request> {
  final ApiClient apiClient;

  DashboardService(this.apiClient);

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
    return await apiClient.sendRequestAsync<Response, DashboardModel, Request>(
      "dashboard",
      HttpMethods.get,
      request,
      true,
      Exception('menu error'),
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
