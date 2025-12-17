import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:models_package/Base/enums.dart';
import 'package:navigation_builder/navigation_builder.dart';
import 'package:restart_app/restart_app.dart';
import 'package:services_package/Repo_ViewId/repo_view_id.dart';
import 'package:services_package/com/person/person_service.dart';
import 'package:services_package/page_cache_manager.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:ui_components_package/erp_app_componenets/mobile/Components/erp_appbar.dart';
import 'package:ui_components_package/erp_app_componenets/mobile/Components/erp_not_found.dart';
import 'package:models_package/Data/Com/Person/dto.dart' as person;
import '../../feature/add_new/add-new_page.dart';
import '../../feature/auth/menu/pages/menu_page.dart';
import '../../feature/dashboard_page/page/dashboard.dart';
import '../../feature/default_page/pages/default_page.dart';
import '../../feature/open_page/Open_Page.dart';
import '../../feature/redux/generic_lists/erp_store/models/field_display_config.dart';
import '../../feature/redux/generic_lists/erp_store/models/generic_list_entity_state.dart';
import '../../feature/redux/generic_lists/ui/generic_list_page.dart';

class MainLayoutPage extends StatefulWidget {
  final NavButtonTabBarMode tab;

  const MainLayoutPage({super.key, required this.tab});

  @override
  State<MainLayoutPage> createState() =>
      _MainLayoutPageState(
        selectedTab: NavButtonTabBarMode.values.firstWhere((c) => c == tab),
      );
}

class _MainLayoutPageState extends State<MainLayoutPage> {
  _MainLayoutPageState({required this.selectedTab});

  NavButtonTabBarMode selectedTab;

  late final Widget accountIcon = _paddedIcon('assets/images/account.png');
  late final Widget activeAccountIcon = _paddedIcon(
    'assets/images/activeaccount.png',
  );

  late final Widget defaultIcon = _paddedIcon('assets/images/defaults.png');
  late final Widget activeDefaultIcon = _paddedIcon(
    'assets/images/activedefaults.png',
  );

  late final Widget menuIcon = _paddedIcon('assets/images/menu.png');
  late final Widget activeMenuIcon = _paddedIcon(
    'assets/images/activemenu.png',
  );

  late final Widget openedIcon = _paddedIcon('assets/images/opened.png');
  late final Widget activeOpenedIcon = _paddedIcon(
    'assets/images/activeopened.png',
  );

  late final Widget newIcon = _paddedIcon('assets/images/new.png');
  late final Widget activeNewIcon = _paddedIcon('assets/images/activenew.png');

  final Map<int, Widget> _pageCache = {};
  late final PageCacheManager _cacheManager = PageCacheManager(
    maxAge: const Duration(minutes: 5),
  );

  final Map<int, bool> _showSkeleton = {};
  final Map<int, Timer> _skeletonTimers = {};
  static double size = 40;

  final Map<NavButtonTabBarMode, int> _tabToIndex = {
    NavButtonTabBarMode.erpMenuTabMode: NavButtonTabBarMode.erpMenuTabMode
        .value,
    NavButtonTabBarMode.erpNewTabMode: NavButtonTabBarMode.erpNewTabMode.value,
    NavButtonTabBarMode.erpOpenedTabMode: NavButtonTabBarMode.erpOpenedTabMode
        .value,
    NavButtonTabBarMode.erpDefaultTabMode: NavButtonTabBarMode.erpDefaultTabMode
        .value,
    NavButtonTabBarMode.erpProfileTabMode: NavButtonTabBarMode.erpProfileTabMode
        .value,
  };

  final Map<int, NavButtonTabBarMode> _indexToTab = {
    NavButtonTabBarMode.erpMenuTabMode.value: NavButtonTabBarMode
        .erpMenuTabMode,
    NavButtonTabBarMode.erpNewTabMode.value: NavButtonTabBarMode.erpNewTabMode,
    NavButtonTabBarMode.erpOpenedTabMode.value: NavButtonTabBarMode
        .erpOpenedTabMode,
    NavButtonTabBarMode.erpDefaultTabMode.value: NavButtonTabBarMode
        .erpDefaultTabMode,
    NavButtonTabBarMode.erpProfileTabMode.value: NavButtonTabBarMode
        .erpProfileTabMode,
  };

  Widget _getPage(NavButtonTabBarMode? tab) {
    if (tab == null || tab == NavButtonTabBarMode.erpDashboardTabMode) {
      return const DashboardPage();
    }

    if (_pageCache.containsKey(tab.value)) {
      _showSkeleton[tab.value] = _showSkeleton[tab.value] ?? false;

      return Skeletonizer(
        enabled: _showSkeleton[tab.value] ?? false,
        child: _pageCache[tab.value]!,
      );
    }
    final rawPage = _cacheManager.getOrCreate(tab.value, () {
      switch (tab) {
        case NavButtonTabBarMode.erpDashboardTabMode:
          return const DashboardPage();

        case NavButtonTabBarMode.erpMenuTabMode:
          return const MenuPage();

        case NavButtonTabBarMode.erpNewTabMode:
          return const AddNewPage();

        case NavButtonTabBarMode.erpOpenedTabMode:
          return const OpenPage();

        case NavButtonTabBarMode.erpDefaultTabMode:
          return const DefaultPage();

        default:
          return Center(child: Text("صفحه ${(tab.value ?? 0)}"));
      }
    });
    _pageCache[tab.value] = rawPage;
    _showSkeleton[tab.value] = true;
    _skeletonTimers[tab.value]?.cancel();
    _skeletonTimers[tab.value] = Timer(const Duration(milliseconds: 400), () {
      if (!mounted) return;
      setState(() {
        _showSkeleton[tab!.value] = false;
      });
    });
    return Skeletonizer(enabled: true, child: rawPage);
  }

  Widget _paddedIcon(String assetPath) {
    return Padding(
      padding: EdgeInsets.only(top: 0),
      child: Image.asset(
        assetPath,
        width: size,
        height: size,
        package: 'resources_package',
      ),
    );
  }

  void _onItemTapped(NavButtonTabBarMode tab) {
    setState(() {
      selectedTab = tab;
      _cacheManager.cleanCacheExcept(tab.value);
    });
  }

  PreferredSizeWidget _getAppBar(NavButtonTabBarMode tab) {
    switch (tab) {
      case NavButtonTabBarMode.erpMenuTabMode:
        return ErpAppBar(mode: AppBarsMode.erpMenuMode);

      case NavButtonTabBarMode.erpNewTabMode:
        return ErpAppBar(mode: AppBarsMode.erpNewMode);

      case NavButtonTabBarMode.erpOpenedTabMode:
        return ErpAppBar(mode: AppBarsMode.erpOpenedMode);

      case NavButtonTabBarMode.erpDefaultTabMode:
        return ErpAppBar(mode: AppBarsMode.erpDefaultMode);

      case NavButtonTabBarMode.erpProfileTabMode:
        return ErpAppBar(mode: AppBarsMode.erpProfileMode);

      case NavButtonTabBarMode.erpGenericListTabMode:
        return ErpAppBar(mode: AppBarsMode.erpGenericList);

      case NavButtonTabBarMode.erpGenericFormTabMode:
        return ErpAppBar(mode: AppBarsMode.erpGenericForm);
      case NavButtonTabBarMode.erpDashboardTabMode:
      default:
        return ErpAppBar(mode: AppBarsMode.erpDashboardMode);
    }
  }

  @override
  Widget build(BuildContext context) {
    final tabs = NavButtonTabBarMode.values;
    final currentIndex = _tabToIndex[selectedTab] ?? NavButtonTabBarMode.erpNotFound;
    return Scaffold(
      // appBar: _getAppBar(selectedTab),
      body: SafeArea(child: _getPage(selectedTab)),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(10),
              blurRadius: 8,
              spreadRadius: 2,
              offset: Offset(0, -2),
            ),
          ],
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
          ),
        ),
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            //activeAccountIcon
            _navItem(
              icon: accountIcon,
              activeIcon: activeAccountIcon,
              isActive: currentIndex == 4,
              onTap: () => _onItemTapped(_indexToTab[NavButtonTabBarMode.erpProfileTabMode.value]!),
            ),

            //defaultIcon
            _navItem(
              icon: defaultIcon,
              activeIcon: activeDefaultIcon,
              isActive: currentIndex == 3,
              onTap: () => _onItemTapped(_indexToTab[NavButtonTabBarMode.erpDefaultTabMode.value]!),
            ),

            //openedIcon
            _navItem(
              icon: openedIcon,
              activeIcon: activeOpenedIcon,
              isActive: currentIndex == 2,
              onTap: () => _onItemTapped(_indexToTab[NavButtonTabBarMode.erpOpenedTabMode.value]!),
            ),

            //newIcon
            _navItem(
              icon: newIcon,
              activeIcon: activeNewIcon,
              isActive: currentIndex == 1,
              onTap: () => _onItemTapped(_indexToTab[NavButtonTabBarMode.erpNewTabMode.value]!),
            ),

            //menuIcon
            _navItem(
              icon: menuIcon,
              activeIcon: activeMenuIcon,
              isActive: currentIndex == 0,
              onTap: () => _onItemTapped(_indexToTab[NavButtonTabBarMode.erpMenuTabMode.value]!),
            ),
          ],
        ),
      ),
    );
  }

  Widget _navItem({
    required Widget icon,
    required Widget activeIcon,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: isActive
          ? Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(height: 2, width: 35, color: Colors.black),
          SizedBox(height: 5),
          activeIcon,
        ],
      )
          : icon,
    );
  }
}
