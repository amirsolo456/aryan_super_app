

import '../../domain/entities/menu_entity.dart';
import '../../domain/repositories/menu_repository.dart';
import '../datasource/menu_remote_datasource.dart';

class MenuRepositoryImpl implements MenuRepository {
  final MenuRemoteDataSource remoteDataSource;

  MenuRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<MenuEntity>> getMenu() async {

    final models = await remoteDataSource.getMenu();

    return models.map((e) => e.toEntity()).toList();
  }
}
