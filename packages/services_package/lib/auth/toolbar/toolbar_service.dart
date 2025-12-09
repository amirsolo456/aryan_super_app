import 'package:models_package/Data/Auth/Menu/dto.dart';
import 'package:services_package/Interfaces/backend_api_services/iapi_service.dart';

import '../../api_client_service.dart';

class ToolbarService implements IApiService<Response, ResponseData, Request> {
  final ApiClient apiClient;
  final String getUrl = "api/menu/gettoolbardata";

  ToolbarService(this.apiClient);

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
    return await apiClient.sendRequestAsync(
      getUrl,
      HttpMethods.post,
      request,
      true,
      null,
      fromJsonD,
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
