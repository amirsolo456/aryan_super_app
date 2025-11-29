class MenuEntity {
  final int menuId;
  final String icon;
  final String menuDesc;
  final String iconUrl;
  final int actionType;
  final int menuType;
  final int actionId;
  final int repoId;
  final List<MenuEntity> subMenus;


  MenuEntity({
    required this.menuId,
    required this.icon,
    required this.menuDesc,
    required this.iconUrl,
    required this.actionType,
    required this.menuType,
    required this.actionId,
    required this.repoId,
    required this.subMenus,
  });
}