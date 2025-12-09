import 'package:models_package/Data/Auth/User/dto.dart';

import 'Interfaces/backend_api_services/iapi_service.dart';
import 'api_client_service.dart';

class UserExistService extends IApiService<Response, ResponseData, Request> {
  final ApiClient apiClientr;

  UserExistService({required this.apiClientr});

  @override
  Future<Response?> CheckIfExist(Request request) async {
    Response? responseData = Response();
    try {} catch (ex) {}

    return responseData;
  }

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
    return await apiClientr.sendRequestAsync<Response, ResponseData, Request>(
      "api/auth/user/exist",
      HttpMethods.post,
      request,
      false,
      Exception(""),
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
