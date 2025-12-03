import 'package:models_package/Data/Auth/Menu/dto.dart';
import 'package:services_package/Interfaces/auth/imenu_service.dart';

import '../../api_client_service.dart';

class MenuService implements IMenuService {
  final ApiClient apiClient;

  MenuService(this.apiClient);

  @override
  Future<Response?> getMenu(Request request) async {
    final response = await apiClient
        .sendObjectRequestAsync<Response, ResponseData>(
          "api/auth/menu",
          HttpMethods.post,
          request,
          true,
          Exception('menu error'),
          (json) => Response.fromJson(json),
        );

    return response;
  }
}
