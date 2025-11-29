import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import '../../feature/menu/data/datasource/menu_remote_datasource.dart';
import '../../feature/menu/data/repositories/menu_repository_impl.dart';
import '../../feature/menu/domain/repositories/menu_repository.dart';
import '../../feature/menu/domain/usecases/get_menu.dart';
import '../../feature/menu/presentation/bloc/menu_bloc.dart';
import 'api_client.dart';

final sl = GetIt.instance;

void init() {
  // Core
  sl.registerLazySingleton<ApiClient>(() => ApiClient(http.Client()));

  // Data sources
  sl.registerLazySingleton<MenuRemoteDataSource>(
    () => MenuRemoteDataSourceImpl(sl<ApiClient>()),
  );

  // Repository
  sl.registerLazySingleton<MenuRepository>(
    () => MenuRepositoryImpl(sl<MenuRemoteDataSource>()),
  );

  // Use case
  sl.registerLazySingleton(() => GetMenuUseCase(sl<MenuRepository>()));

  // Bloc
  sl.registerFactory(() => MenuBloc(getMenuUseCase: sl<GetMenuUseCase>()));
}
