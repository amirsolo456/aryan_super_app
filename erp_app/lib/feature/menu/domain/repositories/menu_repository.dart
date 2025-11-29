

import '../entities/menu_entity.dart';


abstract class MenuRepository {
  Future<List<MenuEntity>> getMenu();
}

