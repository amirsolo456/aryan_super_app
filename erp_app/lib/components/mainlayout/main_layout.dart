import 'dart:async';

import 'package:flutter/material.dart';
import 'package:models_package/Base/enums.dart';
import 'package:services_package/page_cache_manager.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:ui_components_package/erp_app_componenets/mobile/Components/list_appbar.dart';

import '../../feature/add_new/add-new_page.dart';
import '../../feature/dashboard_page/dashboard/dashboard.dart';
import '../../feature/default_page/default_page.dart';
import '../../feature/menu/presentation/pages/menu_page.dart';
import '../../feature/open_page/Open_Page.dart';
import '../../feature/profile/profile.dart';

class MainLayoutPage extends StatefulWidget {
  const MainLayoutPage({super.key});

  @override
  State<MainLayoutPage> createState() => _MainLayoutPageState();
}

class _MainLayoutPageState extends State<MainLayoutPage> {
  NavButtonTabBarMode _selectedTab = NavButtonTabBarMode.dashboardTabMode;

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
  static double topPadding = 10;

  final Map<NavButtonTabBarMode, int> _tabToIndex = {
    NavButtonTabBarMode.menuTabMode: 0,
    NavButtonTabBarMode.newTabMode: 1,
    NavButtonTabBarMode.openedTabMode: 2,
    NavButtonTabBarMode.defaultTabMode: 3,
    NavButtonTabBarMode.profileTabMode: 4,
  };

  final Map<int, NavButtonTabBarMode> _indexToTab = {
    0: NavButtonTabBarMode.menuTabMode,
    1: NavButtonTabBarMode.newTabMode,
    2: NavButtonTabBarMode.openedTabMode,
    3: NavButtonTabBarMode.defaultTabMode,
    4: NavButtonTabBarMode.profileTabMode,
  };

  // لیست tabهای موجود در navigation bar
  // final List<NavButtonTabBarMode> _navigationTabs = [
  //   NavButtonTabBarMode.menuTabMode,
  //   NavButtonTabBarMode.newTabMode,
  //   NavButtonTabBarMode.openedTabMode,
  //   NavButtonTabBarMode.defaultTabMode,
  //   NavButtonTabBarMode.profileTabMode,
  // ];

  Widget _getPage(NavButtonTabBarMode? tab) {
    if (tab == null || tab == NavButtonTabBarMode.dashboardTabMode) {
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
        case NavButtonTabBarMode.dashboardTabMode:
          return const DashboardPage();

        case NavButtonTabBarMode.menuTabMode:
          // return const PersonListPage(refreshData: true);
          return MenuPage();
        // return MenuPage();

        case NavButtonTabBarMode.newTabMode:
          return const AddNewPage();

        case NavButtonTabBarMode.openedTabMode:
          return const OpenPage();

        case NavButtonTabBarMode.defaultTabMode:
          return const DefaultPage();

        case NavButtonTabBarMode.profileTabMode:
          return const ProfilePage(refreshData: true);

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
      _selectedTab = tab;
      _cacheManager.cleanCacheExcept(tab.value);
    });
  }

  PreferredSizeWidget _getAppBar(NavButtonTabBarMode tab) {
    switch (tab) {
      case NavButtonTabBarMode.menuTabMode:
        return ListAppBar(mode: AppBarsMode.erpPersonListMode);

      case NavButtonTabBarMode.newTabMode:
        return ListAppBar(mode: AppBarsMode.erpNewMode);

      case NavButtonTabBarMode.openedTabMode:
        return ListAppBar(mode: AppBarsMode.erpOpendMode);

      case NavButtonTabBarMode.defaultTabMode:
        return ListAppBar(mode: AppBarsMode.erpdefaultMode);

      case NavButtonTabBarMode.profileTabMode:
        return ListAppBar(mode: AppBarsMode.erpprofileMode);

      case NavButtonTabBarMode.dashboardTabMode:
      default:
        return ListAppBar(mode: AppBarsMode.erpdashboardMode);
    }
  }

  @override
  Widget build(BuildContext context) {
    final tabs = NavButtonTabBarMode.values;
    // final currentIndex = tabs.indexOf(_selectedTab);
    final currentIndex = _tabToIndex[_selectedTab] ?? 10;
    return Scaffold(
      appBar: _getAppBar(_selectedTab),
      body: SafeArea(child: _getPage(_selectedTab)),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white, // رنگ پس زمینه سفید
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.10), // سایه مشکی با آلفا 10%
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
              onTap: () => _onItemTapped(_indexToTab[4]!),
            ),

            //defaultIcon
            _navItem(
              icon: defaultIcon,
              activeIcon: activeDefaultIcon,
              isActive: currentIndex == 3,
              onTap: () => _onItemTapped(_indexToTab[3]!),
            ),

            //openedIcon
            _navItem(
              icon: openedIcon,
              activeIcon: activeOpenedIcon,
              isActive: currentIndex == 2,
              onTap: () => _onItemTapped(_indexToTab[2]!),
            ),

            //newIcon
            _navItem(
              icon: newIcon,
              activeIcon: activeNewIcon,
              isActive: currentIndex == 1,
              onTap: () => _onItemTapped(_indexToTab[1]!),
            ),

            //menuIcon
            _navItem(
              icon: menuIcon,
              activeIcon: activeMenuIcon,
              isActive: currentIndex == 0,
              onTap: () => _onItemTapped(_indexToTab[0]!),
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
                // خط که دقیقا به لبه بالا می‌چسبد
                Container(height: 2, width: 35, color: Colors.black),

                SizedBox(height: 5), // فاصله ۵ پیکسل بین خط و آیکن

                activeIcon,
              ],
            )
          : icon,
    );
  }
}
