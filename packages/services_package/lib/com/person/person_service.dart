import 'package:models_package/Base/base_request.dart';
import 'package:models_package/Base/base_response.dart';
import 'package:services_package/Interfaces/iapi_service.dart';

import '../../api_client_service.dart';

class PersonService extends IApiService {
  final ApiClient apiClient;
  final String getUrl = "api/com/select/person";

  PersonService(this.apiClient);

  @override
  Future<BaseResponse<dynamic>?> delete(
    BaseRequest request,
    BaseResponse<dynamic> Function(Map<String, dynamic>) fromJsonD,
  ) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<BaseResponse<dynamic>?> get(
    BaseRequest request,
    BaseResponse<dynamic> Function(Map<String, dynamic>) fromJsonD,
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
  Future<BaseResponse<dynamic>?> insert(
    BaseRequest request,
    BaseResponse<dynamic> Function(Map<String, dynamic>) fromJsonD,
  ) {
    // TODO: implement insert
    throw UnimplementedError();
  }

  @override
  Future<BaseResponse<dynamic>?> update(
    BaseRequest request,
    BaseResponse<dynamic> Function(Map<String, dynamic>) fromJsonD,
  ) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
