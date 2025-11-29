import '../../domain/entities/menu_entity.dart';

class MenuModel extends MenuEntity {
  // subMenus را به صورت List<MenuModel> تعریف می‌کنیم
  final List<MenuModel> modelSubMenus;

  MenuModel({
    required int menuId,
    required String icon,
    required String menuDesc,
    required String iconUrl,
    required int actionType,
    required int menuType,
    required int actionId,
    required int repoId,
    required this.modelSubMenus,
  }) : super(
    menuId: menuId,
    icon: icon,
    menuDesc: menuDesc,
    iconUrl: iconUrl,
    actionType: actionType,
    menuType: menuType,
    actionId: actionId,
    repoId: repoId,
    // تبدیل List<MenuModel> به List<MenuEntity>
    subMenus: modelSubMenus.map((e) => e.toEntity()).toList(),
  );

  // ساخت مدل از JSON
  factory MenuModel.fromJson(Map<String, dynamic> json) {
    var subMenusJson = json['SubMenus'] as List<dynamic>?;

    List<MenuModel> subMenuModels = subMenusJson == null
        ? []
        : subMenusJson.map((e) => MenuModel.fromJson(e)).toList();

    return MenuModel(
      menuId: json['MenuId'],
      icon: json['Icon'] ?? '',
      menuDesc: json['MenuDesc'] ?? '',
      iconUrl: json['IconUrl'] ?? '',
      actionType: json['ActionType'] ?? 0,
      menuType: json['MenuType'] ?? 0,
      actionId: json['ActionId'] ?? 0,
      repoId: json['RepoId'] ?? 0,
      modelSubMenus: subMenuModels,
    );
  }

  // تبدیل مدل به Entity
  MenuEntity toEntity() {
    return MenuEntity(
      menuId: menuId,
      icon: icon,
      menuDesc: menuDesc,
      iconUrl: iconUrl,
      actionType: actionType,
      menuType: menuType,
      actionId: actionId,
      repoId: repoId,
      subMenus: modelSubMenus.map((e) => e.toEntity()).toList(),
    );
  }
}
