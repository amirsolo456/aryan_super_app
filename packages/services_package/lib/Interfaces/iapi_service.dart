import 'package:models_package/Base/base_request.dart';
import 'package:models_package/Base/base_response.dart';

abstract class IApiService<
  T extends BaseResponse<D>,
  D,
  C extends BaseRequest
> {
  Future<T?> get(C request, T Function(Map<String, dynamic>) fromJsonD);

  Future<T?> insert(C request, T Function(Map<String, dynamic>) fromJsonD);

  Future<T?> update(C request, T Function(Map<String, dynamic>) fromJsonD);

  Future<T?> delete(C request, T Function(Map<String, dynamic>) fromJsonD);
}
