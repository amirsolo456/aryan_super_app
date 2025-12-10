


// Ehsan Change

import 'package:models_package/Data/Default/mng/select/Language/Language.dart';
import 'package:services_package/Interfaces/iapi_service.dart';

import '../../../api_client_service.dart';

class LanguageService implements IApiService<Response, ResponseData, Request> {
  final ApiClient apiClient;
  final int RepoViewId;

  LanguageService(this.apiClient, {required this.RepoViewId});

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
      "api/mng/select/language",
      HttpMethods.post,
      request,
      true,
      Exception('Language error'),
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
