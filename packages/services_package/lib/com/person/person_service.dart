import 'package:models_package/Base/base_request.dart';
import 'package:models_package/Data/Com/Person/dto.dart';
import 'package:services_package/Interfaces/backend_api_services/iapi_service.dart';

import '../../api_client_service.dart';

class PersonService extends IApiService<Response, ResponseData, Request> {
  final ApiClient apiClient;
  final String getUrl = "api/com/select/person";

  PersonService(this.apiClient);

  @override
  Future<Response> delete(
    BaseRequest request,
    Response Function(Map<String, dynamic>) fromJsonD,
  ) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<Response?> get(
    BaseRequest request,
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
    BaseRequest request,
    Response Function(Map<String, dynamic>) fromJsonD,
  ) {
    // TODO: implement insert
    throw UnimplementedError();
  }

  @override
  Future<Response?> update(
    BaseRequest request,
    Response Function(Map<String, dynamic>) fromJsonD,
  ) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
