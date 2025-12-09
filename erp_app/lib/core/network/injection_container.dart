import 'package:erp_app/core/list_generic/presentation/features/generic_page.dart';
import 'package:erp_app/feature/person/domain/repositories/person_repository.dart';
import 'package:erp_app/feature/person/presentation/blocs/person_bloc/person_list_bloc.dart';
import 'package:erp_app/feature/person/presentation/blocs/search_person_bloc/search_person_bloc.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:models_package/Base/base_request.dart';
import 'package:models_package/Data/Auth/Menu/dto.dart' as menu;
import 'package:models_package/Data/Com/Person/dto.dart' as person_list;
import 'package:services_package/Interfaces/front_helper_services/isnackbar_service.dart' as snack_bar;
import 'package:services_package/api_client_service.dart';
import 'package:services_package/api_service.dart';

import 'package:services_package/auth/menu/menu_service.dart';
import 'package:services_package/com/person/person_service.dart';
import 'package:services_package/device_token_service.dart';
import 'package:services_package/extension/exception_handler_service.dart';
import 'package:services_package/login_service.dart';
import 'package:services_package/otp_service.dart';
import 'package:services_package/storage_service.dart';
import 'package:services_package/user_exist.dart';
import 'package:ui_components_package/erp_app_componenets/mobile/Buttons/absoluted_button.dart';
import 'package:ui_components_package/erp_app_componenets/mobile/Expanders/list_datas_expander.dart';

import '../../feature/menu/bloc/menu_bloc.dart';
import '../messengers_services/exception_helper_service.dart';
import '../messengers_services/snackbar_service.dart';

final sl = GetIt.instance;

void initStandAlone() {
  final _storage = StorageService();
  final _defaults = Defaults(
    placeId: 1,
    yearId: 1403,
    languageId: 2,
    managementAccountId: 1,
  );
  final _apisetting = ApiSettings(
    baseUrl: 'https://216.65.200.215/',
    loginUrl: 'api/auth/login',
    timeOut: Duration(seconds: 40),
    appDefaults: _defaults,
  );

  // Providers
  if (!sl.isRegistered<StorageService>()) {
    sl.registerSingleton<StorageService>(_storage);
  }

  if (!sl.isRegistered<ApiSettings>()) {
    sl.registerLazySingleton<ApiSettings>(() => _apisetting);
  }

  if (!sl.isRegistered<ApiClient>()) {
    sl.registerLazySingleton<ApiClient>(
      () => ApiClient(storage: _storage, appSettings: _apisetting),
    );
  }
  final apiClient = ApiClient(storage: _storage, appSettings: _apisetting);

  if (!sl.isRegistered<OtpService>()) {
    sl.registerLazySingleton<OtpService>(() => OtpService(apiClient));
  }
  if (!sl.isRegistered<UserExistService>()) {
    sl.registerLazySingleton<UserExistService>(
      () => UserExistService(apiClientr: apiClient),
    );
  }

  if (!sl.isRegistered<NotificationService>()) {
    sl.registerLazySingleton<NotificationService>(
      () => NotificationService(
        storage: _storage,
        refreshInterval: Duration(minutes: 5),
      ),
    );
  }

  if (!sl.isRegistered<PersonRepository>()) {
    sl.registerLazySingleton(() => PersonRepository());
  }


  if (!sl.isRegistered<ExceptionHelperService>()) {
    sl.registerLazySingleton<ExceptionHelperService>(
          () => ExceptionHelperService(),
    );
  }

  final messengerService = sl<ExceptionHelperService>();
  AppErrorHandler.registerMessengerService(messengerService);


  sl.registerLazySingleton<snack_bar.ISnackbarService>(() => SnackBarService());

  if (!sl.isRegistered<LoginService>()) {
    sl.registerLazySingleton<LoginService>(
      () => LoginService(client: apiClient, storage: _storage),
    );
  }

  if (!sl
      .isRegistered<
        ApiService<menu.Response, menu.ResponseData, menu.Request>
      >()) {
    sl.registerFactory(
      () => ApiService<menu.Response, menu.ResponseData, menu.Request>,
    );
  }

  if (!sl.isRegistered<MenuService>()) {
    sl.registerFactory<MenuService>(() => MenuService(apiClient));
  }
  if (!sl.isRegistered<MenuBloc>()) {
    sl.registerFactory(
      () => MenuBloc(getMenuUseCase: GetIt.instance<MenuService>()),
    );
  }




  // if (!sl.isRegistered<SnackBarService>()) {
  //   sl.registerFactory<SnackBarService>(() => SnackBarService());
  // }

  if (!sl.isRegistered<SearchPersonBloc>()) {
    sl.registerFactory(() => SearchPersonBloc(sl.get<PersonRepository>()));
  }

  if (!sl.isRegistered<PersonService>()) {
    sl.registerFactory(() => PersonService(apiClient));
  }

  if (!sl.isRegistered<PersonListBloc>()) {
    sl.registerFactory(
      () => PersonListBloc(personService: sl<PersonService>()),
    );
  }

  // if (!sl.isRegistered<GenericBloc>()) {
  //   sl.registerFactory(
  //     () =>
  //         GenericBloc<
  //           person_list.Response,
  //           person_list.ResponseData,
  //           person_list.Request
  //         >,
  //   );
  // }

  if (!sl.isRegistered<GenericPage>()) {
    sl.registerFactory(
      () =>
          GenericPage<
            SearchPersonBloc,
            person_list.Response,
            person_list.ResponseData,
            person_list.Request
          >(
            createBloc: () => SearchPersonBloc(sl.get<PersonRepository>()),
            builder: (context, state, bloc) {
              return Scaffold(
                appBar: AppBar(
                  title: const Text('Users'),
                  actions: [
                    IconButton(
                      icon: const Icon(Icons.refresh),
                      onPressed: () => state.props,
                    ),
                  ],
                ),
                body: Scaffold(
                  body: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 10,
                        ),
                        child: ListView.builder(
                          itemCount: state.props.length,
                          itemBuilder: (context, index) {
                            return PersonExpander(person: state.props[index]);
                          },
                        ),
                      ),
                      AbsoultNewButton(),
                    ],
                  ),
                ),
              );
            },
          ),
    );
  }

}
