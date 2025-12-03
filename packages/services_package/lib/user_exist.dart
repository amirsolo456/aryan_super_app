import 'package:get_it/get_it.dart';
import 'package:models_package/Data/Auth/User/dto.dart';

import 'Interfaces/iuser_exist.dart';
import 'api_client_service.dart';

class UserExistService extends IUserExistService {
  static final ApiClient _apiClientr = GetIt.instance<ApiClient>();

  @override
  Future<Response?> CheckIfExist(Request request) async {
    Response? responseData = Response();
    try {
      responseData = await _apiClientr
          .sendObjectRequestAsync<Response, ResponseData>(
            "api/auth/user/exist",
            HttpMethods.post,
            request,
            false,
            Exception(""),
            (json) =>
                Response.fromJson(json, (item) => ResponseData.fromJson(item)),
          );
    } catch (ex) {}

    return responseData;
  }
}
