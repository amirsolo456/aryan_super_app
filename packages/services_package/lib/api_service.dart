import 'package:models_package/Base/base_request.dart';
import 'package:models_package/Base/base_response.dart';

import 'Interfaces/backend_api_services/iapi_service.dart';
import 'api_client_service.dart';

class ApiService<T extends BaseResponse<D>, D, C extends BaseRequest>
    implements IApiService<T, D, C> {
  final ApiClient clientService;

  ApiService({required this.clientService});

  @override
  Future<T?> delete(
    C request,
    T Function(Map<String, dynamic>) fromJsonD,
  ) async {
    try {
      return clientService.sendRequestAsync<T, D, C>(
        request.url,
        HttpMethods.delete,
        request,
        false,
        Exception(""),
        fromJsonD,
      );
    } catch (ex) {
      return BaseResponse<D>().error! as T?;
    }
  }

  @override
  Future<T?> get(C request, T Function(Map<String, dynamic>)? fromJsonD) async {
    try {
      return clientService.sendRequestAsync<T, D, C>(
        request.url,
        HttpMethods.get,
        request,
        false,
        Exception(""),
        fromJsonD,
      );
    } catch (ex) {
      return BaseResponse<D>().error! as T?;
    }
  }

  @override
  Future<T?> insert(
    C request,
    T Function(Map<String, dynamic>) fromJsonD,
  ) async {
    try {
      return clientService.sendRequestAsync<T, D, C>(
        request.url,
        HttpMethods.post,
        request,
        false,
        Exception(""),
        fromJsonD,
      );
    } catch (ex) {
      return BaseResponse<D>().error! as T?;
    }
  }

  @override
  Future<T?> update(
    C request,
    T Function(Map<String, dynamic>) fromJsonD,
  ) async {
    try {
      return clientService.sendRequestAsync<T, D, C>(
        request.url,
        HttpMethods.put,
        request,
        false,
        Exception(""),
        fromJsonD,
      );
    } catch (ex) {
      return BaseResponse<D>().error! as T?;
    }
  }
}
