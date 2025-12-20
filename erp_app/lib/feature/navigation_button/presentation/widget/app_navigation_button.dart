// lib/core/navigation/custom_bottom_navigation.dart
import 'package:flutter/material.dart';
import 'package:models_package/Base/enums.dart';

class AppNavigationButton extends StatelessWidget {
  final NavButtonTabBarMode selectedTab;
  final ValueChanged<NavButtonTabBarMode> onTabSelected;
  static const double iconSize = 40;

  const AppNavigationButton({
    super.key,
    required this.selectedTab,
    required this.onTabSelected,
  });

  Widget _paddedIcon(String assetPath) {
    return Padding(
      padding: const EdgeInsets.only(top: 0),
      child: Image.asset(
        assetPath,
        width: iconSize,
        height: iconSize,
        package: 'resources_package',
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
          const SizedBox(height: 5),
          activeIcon,
        ],
      )
          : icon,
    );
  }

  @override
  Widget build(BuildContext context) {
    final tabs = {
      NavButtonTabBarMode.erpProfileTabMode: {
        'icon': _paddedIcon('assets/images/account.png'),
        'activeIcon': _paddedIcon('assets/images/activeaccount.png'),
      },
      NavButtonTabBarMode.erpDefaultTabMode: {
        'icon': _paddedIcon('assets/images/defaults.png'),
        'activeIcon': _paddedIcon('assets/images/activedefaults.png'),
      },
      NavButtonTabBarMode.erpOpenedTabMode: {
        'icon': _paddedIcon('assets/images/opened.png'),
        'activeIcon': _paddedIcon('assets/images/activeopened.png'),
      },
      NavButtonTabBarMode.erpNewTabMode: {
        'icon': _paddedIcon('assets/images/new.png'),
        'activeIcon': _paddedIcon('assets/images/activenew.png'),
      },
      NavButtonTabBarMode.erpMenuTabMode: {
        'icon': _paddedIcon('assets/images/menu.png'),
        'activeIcon': _paddedIcon('assets/images/activemenu.png'),
      },
    };

    final tabOrder = [
      NavButtonTabBarMode.erpProfileTabMode,
      NavButtonTabBarMode.erpDefaultTabMode,
      NavButtonTabBarMode.erpOpenedTabMode,
      NavButtonTabBarMode.erpNewTabMode,
      NavButtonTabBarMode.erpMenuTabMode,
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(10),
            blurRadius: 8,
            spreadRadius: 2,
            offset: const Offset(0, -2),
          ),
        ],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: tabOrder.map((tab) {
          final icons = tabs[tab]!;
          return _navItem(
            icon: icons['icon'] as Widget,
            activeIcon: icons['activeIcon'] as Widget,
            isActive: selectedTab == tab,
            onTap: () => onTabSelected(tab),
          );
        }).toList(),
      ),
    );
  }
}