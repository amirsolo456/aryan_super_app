


// Ehsan Change

import 'package:models_package/Data/Default/mng/select/place/place.dart';
import 'package:services_package/Interfaces/iapi_service.dart';

import '../../../api_client_service.dart';

class PlaceService implements IApiService<Response, ResponseData, Request> {
  final ApiClient apiClient;

  PlaceService(this.apiClient);

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
      "api/mng/select/place",
      HttpMethods.post,
      request,
      true,
      Exception('place error'),
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
