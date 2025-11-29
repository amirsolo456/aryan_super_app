


import '../entities/menu_entity.dart';
import '../repositories/menu_repository.dart';


class GetMenuUseCase {
  final MenuRepository repository;


  GetMenuUseCase(this.repository);


  Future<List<MenuEntity>> call() async => await repository.getMenu();
}

