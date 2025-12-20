import 'dart:async';

import 'package:flutter/material.dart';
import 'package:models_package/Base/enums.dart';
import 'package:services_package/page_cache_manager.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:ui_components_package/erp_app_componenets/mobile/Components/erp_appbar.dart';
import 'package:models_package/Data/Auth/Menu/dto.dart';

import '../../feature/add_new/add-new_page.dart';
import 'package:erp_app/feature/auth/menu/pages/menu_page.dart';
import 'package:erp_app/feature/dashboard_page/page/dashboard.dart';
import 'package:erp_app/feature/default_page/pages/default_page.dart';
import 'package:erp_app/feature/open_page/Open_Page.dart';

class MainLayoutPage extends StatefulWidget {
  final NavButtonTabBarMode tab;

  const MainLayoutPage({super.key, required this.tab});

  @override
  State<MainLayoutPage> createState() => _MainLayoutPageState(
    selectedTab: NavButtonTabBarMode.values.firstWhere((c) => c == tab),
  );
}

class _MainLayoutPageState extends State<MainLayoutPage> {
  _MainLayoutPageState({required this.selectedTab});

  NavButtonTabBarMode selectedTab = NavButtonTabBarMode.erpNotFound;

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
    'assets/images/opened.png',
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
    NavButtonTabBarMode.erpMenuTabMode: 0,
    NavButtonTabBarMode.erpNewTabMode: 1,
    NavButtonTabBarMode.erpOpenedTabMode: 2,
    NavButtonTabBarMode.erpDefaultTabMode: 3,
    NavButtonTabBarMode.erpProfileTabMode: 4,
  };

  final Map<int, NavButtonTabBarMode> _indexToTab = {
    0: NavButtonTabBarMode.erpMenuTabMode,
    1: NavButtonTabBarMode.erpNewTabMode,
    2: NavButtonTabBarMode.erpOpenedTabMode,
    3: NavButtonTabBarMode.erpDefaultTabMode,
    4: NavButtonTabBarMode.erpProfileTabMode,
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

          //Ehsan Change
          //Sample data Like menu dto

          return OpenedPage(items: [ResponseData.fromJson(
            const         {
              "MenuId": 1,
              "Icon": "<svg width=\"20\" height=\"20\" viewBox=\"0 0 20 20\" fill=\"none\" xmlns=\"http://www.w3.org/2000/svg\">\r\n<path d=\"M10 9.16667V13.3333M10 17.5C5.85786 17.5 2.5 14.1421 2.5 10C2.5 5.85786 5.85786 2.5 10 2.5C14.1421 2.5 17.5 5.85786 17.5 10C17.5 14.1421 14.1421 17.5 10 17.5ZM10.0415 6.66667V6.75L9.9585 6.75016V6.66667H10.0415Z\" stroke=\"#585858\" stroke-linecap=\"round\" stroke-linejoin=\"round\"/>\r\n</svg>",
              "ActionType": 0,
              "MenuDesc": "اطلاعات پایه",
              "IconUrl": "http://216.65.200.216:9000/icons/BaseInformation.png",
              "MenuType": 0,
              "ActionId": 0,
              "RepoId": 0,
              "SubMenus": [
                {
                  "MenuId": 2,
                  "Icon": "<svg width=\"14\" height=\"14\" viewBox=\"0 0 14 14\" fill=\"none\" xmlns=\"http://www.w3.org/2000/svg\">\r\n<path d=\"M7 4C5.34315 4 4 5.34315 4 7C4 8.65685 5.34315 10 7 10C8.65685 10 10 8.65685 10 7C10 5.34315 8.65685 4 7 4Z\" fill=\"#767676\" stroke=\"#B1B1B1\" stroke-width=\"0.5\" stroke-linecap=\"round\" stroke-linejoin=\"round\"/>\r\n</svg>",
                  "ActionType": 0,
                  "MenuDesc": "عمومی",
                  "IconUrl": "http://216.65.200.216:9000/icons/",
                  "FatherId": 1,
                  "MenuType": 0,
                  "ActionId": 0,
                  "RepoId": 0,
                  "SubMenus": [
                    {
                      "MenuId": 4,
                      "Icon": "<svg width=\"13\" height=\"13\" viewBox=\"0 0 13 13\" fill=\"none\" xmlns=\"http://www.w3.org/2000/svg\">\r\n<path d=\"M6.49967 4.33337C5.30306 4.33337 4.33301 5.30342 4.33301 6.50004C4.33301 7.69666 5.30306 8.66671 6.49967 8.66671C7.69629 8.66671 8.66634 7.69666 8.66634 6.50004C8.66634 5.30342 7.69629 4.33337 6.49967 4.33337Z\" stroke=\"#B1B1B1\" stroke-linecap=\"round\" stroke-linejoin=\"round\"/>\r\n</svg>",
                      "ActionType": 1,
                      "MenuDesc": "اشخاص و شرکت ها",
                      "IconUrl": "http://216.65.200.216:9000/icons/",
                      "FatherId": 2,
                      "SystemId": 106,
                      "MenuType": 1,
                      "WebLink": "com/personList",
                      "AppLink": "Com/PersonList",
                      "ActionId": 269,
                      "RepoId": 106045,
                      "SubMenus": []
                    },
                    {
                      "MenuId": 18,
                      "Icon": "<svg width=\"13\" height=\"13\" viewBox=\"0 0 13 13\" fill=\"none\" xmlns=\"http://www.w3.org/2000/svg\">\r\n<path d=\"M6.49967 4.33337C5.30306 4.33337 4.33301 5.30342 4.33301 6.50004C4.33301 7.69666 5.30306 8.66671 6.49967 8.66671C7.69629 8.66671 8.66634 7.69666 8.66634 6.50004C8.66634 5.30342 7.69629 4.33337 6.49967 4.33337Z\" stroke=\"#B1B1B1\" stroke-linecap=\"round\" stroke-linejoin=\"round\"/>\r\n</svg>",
                      "ActionType": 1,
                      "MenuDesc": "سال مالی",
                      "IconUrl": "http://216.65.200.216:9000/icons/",
                      "FatherId": 2,
                      "SystemId": 106,
                      "MenuType": 1,
                      "WebLink": "com/yearList",
                      "AppLink": "com/yearList",
                      "ActionId": 385,
                      "RepoId": 106066,
                      "SubMenus": []
                    },
                    {
                      "MenuId": 19,
                      "Icon": "<svg width=\"13\" height=\"13\" viewBox=\"0 0 13 13\" fill=\"none\" xmlns=\"http://www.w3.org/2000/svg\">\r\n<path d=\"M6.49967 4.33337C5.30306 4.33337 4.33301 5.30342 4.33301 6.50004C4.33301 7.69666 5.30306 8.66671 6.49967 8.66671C7.69629 8.66671 8.66634 7.69666 8.66634 6.50004C8.66634 5.30342 7.69629 4.33337 6.49967 4.33337Z\" stroke=\"#B1B1B1\" stroke-linecap=\"round\" stroke-linejoin=\"round\"/>\r\n</svg>",
                      "ActionType": 1,
                      "MenuDesc": "مرکز هزینه",
                      "IconUrl": "http://216.65.200.216:9000/icons/",
                      "FatherId": 2,
                      "SystemId": 106,
                      "MenuType": 1,
                      "WebLink": "com/costCenterList",
                      "AppLink": "com/costCenterList",
                      "ActionId": 121,
                      "RepoId": 106015,
                      "SubMenus": []
                    },
                    {
                      "MenuId": 21,
                      "Icon": "<svg width=\"13\" height=\"13\" viewBox=\"0 0 13 13\" fill=\"none\" xmlns=\"http://www.w3.org/2000/svg\">\r\n<path d=\"M6.49967 4.33337C5.30306 4.33337 4.33301 5.30342 4.33301 6.50004C4.33301 7.69666 5.30306 8.66671 6.49967 8.66671C7.69629 8.66671 8.66634 7.69666 8.66634 6.50004C8.66634 5.30342 7.69629 4.33337 6.49967 4.33337Z\" stroke=\"#B1B1B1\" stroke-linecap=\"round\" stroke-linejoin=\"round\"/>\r\n</svg>",
                      "ActionType": 1,
                      "MenuDesc": "حسابهای بانکی",
                      "IconUrl": "http://216.65.200.216:9000/icons/",
                      "FatherId": 2,
                      "SystemId": 106,
                      "MenuType": 1,
                      "WebLink": "com/bankAccountList",
                      "AppLink": "com/bankAccountList",
                      "ActionId": 389,
                      "RepoId": 106067,
                      "SubMenus": []
                    },
                    {
                      "MenuId": 22,
                      "Icon": "<svg width=\"13\" height=\"13\" viewBox=\"0 0 13 13\" fill=\"none\" xmlns=\"http://www.w3.org/2000/svg\">\r\n<path d=\"M6.49967 4.33337C5.30306 4.33337 4.33301 5.30342 4.33301 6.50004C4.33301 7.69666 5.30306 8.66671 6.49967 8.66671C7.69629 8.66671 8.66634 7.69666 8.66634 6.50004C8.66634 5.30342 7.69629 4.33337 6.49967 4.33337Z\" stroke=\"#B1B1B1\" stroke-linecap=\"round\" stroke-linejoin=\"round\"/>\r\n</svg>",
                      "ActionType": 1,
                      "MenuDesc": "پروژه",
                      "IconUrl": "http://216.65.200.216:9000/icons/",
                      "FatherId": 2,
                      "SystemId": 106,
                      "MenuType": 1,
                      "WebLink": "com/projectList",
                      "AppLink": "com/projectList",
                      "ActionId": 289,
                      "RepoId": 106051,
                      "SubMenus": []
                    },
                    {
                      "MenuId": 38,
                      "Icon": "<svg width=\"13\" height=\"13\" viewBox=\"0 0 13 13\" fill=\"none\" xmlns=\"http://www.w3.org/2000/svg\">\r\n<path d=\"M6.49967 4.33337C5.30306 4.33337 4.33301 5.30342 4.33301 6.50004C4.33301 7.69666 5.30306 8.66671 6.49967 8.66671C7.69629 8.66671 8.66634 7.69666 8.66634 6.50004C8.66634 5.30342 7.69629 4.33337 6.49967 4.33337Z\" stroke=\"#B1B1B1\" stroke-linecap=\"round\" stroke-linejoin=\"round\"/>\r\n</svg>",
                      "ActionType": 1,
                      "MenuDesc": "بانک",
                      "IconUrl": "http://216.65.200.216:9000/icons/",
                      "FatherId": 2,
                      "SystemId": 106,
                      "MenuType": 1,
                      "WebLink": "com/bankList",
                      "AppLink": "com/bankList",
                      "ActionId": 73,
                      "RepoId": 106004,
                      "SubMenus": []
                    },
                    {
                      "MenuId": 168,
                      "Icon": "<svg width=\"13\" height=\"13\" viewBox=\"0 0 13 13\" fill=\"none\" xmlns=\"http://www.w3.org/2000/svg\">\r\n<path d=\"M6.49967 4.33337C5.30306 4.33337 4.33301 5.30342 4.33301 6.50004C4.33301 7.69666 5.30306 8.66671 6.49967 8.66671C7.69629 8.66671 8.66634 7.69666 8.66634 6.50004C8.66634 5.30342 7.69629 4.33337 6.49967 4.33337Z\" stroke=\"#B1B1B1\" stroke-linecap=\"round\" stroke-linejoin=\"round\"/>\r\n</svg>",
                      "ActionType": 1,
                      "MenuDesc": "نرخ ارز",
                      "IconUrl": "http://216.65.200.216:9000/icons/Currency.png",
                      "FatherId": 2,
                      "SystemId": 106,
                      "MenuType": 1,
                      "WebLink": "com/currencyRateList",
                      "AppLink": "com/currencyRateList",
                      "ActionId": 642,
                      "RepoId": 106070,
                      "SubMenus": []
                    },
                    {
                      "MenuId": 302,
                      "Icon": "<svg width=\"13\" height=\"13\" viewBox=\"0 0 13 13\" fill=\"none\" xmlns=\"http://www.w3.org/2000/svg\">\r\n<path d=\"M6.49967 4.33337C5.30306 4.33337 4.33301 5.30342 4.33301 6.50004C4.33301 7.69666 5.30306 8.66671 6.49967 8.66671C7.69629 8.66671 8.66634 7.69666 8.66634 6.50004C8.66634 5.30342 7.69629 4.33337 6.49967 4.33337Z\" stroke=\"#B1B1B1\" stroke-linecap=\"round\" stroke-linejoin=\"round\"/>\r\n</svg>",
                      "ActionType": 1,
                      "MenuDesc": "تقویم",
                      "IconUrl": "http://216.65.200.216:9000/icons/",
                      "FatherId": 2,
                      "SystemId": 106,
                      "MenuType": 1,
                      "WebLink": "com/calendarList",
                      "ActionId": 89,
                      "RepoId": 106007,
                      "SubMenus": []
                    }
                  ]
                },
                {
                  "MenuId": 137,
                  "Icon": "<svg width=\"14\" height=\"14\" viewBox=\"0 0 14 14\" fill=\"none\" xmlns=\"http://www.w3.org/2000/svg\">\r\n<path d=\"M7 4C5.34315 4 4 5.34315 4 7C4 8.65685 5.34315 10 7 10C8.65685 10 10 8.65685 10 7C10 5.34315 8.65685 4 7 4Z\" fill=\"#767676\" stroke=\"#B1B1B1\" stroke-width=\"0.5\" stroke-linecap=\"round\" stroke-linejoin=\"round\"/>\r\n</svg>",
                  "ActionType": 0,
                  "MenuDesc": "کالا",
                  "IconUrl": "http://216.65.200.216:9000/icons/",
                  "FatherId": 1,
                  "MenuType": 0,
                  "ActionId": 0,
                  "RepoId": 0,
                  "SubMenus": [
                    {
                      "MenuId": 80,
                      "Icon": "<svg width=\"13\" height=\"13\" viewBox=\"0 0 13 13\" fill=\"none\" xmlns=\"http://www.w3.org/2000/svg\">\r\n<path d=\"M6.49967 4.33337C5.30306 4.33337 4.33301 5.30342 4.33301 6.50004C4.33301 7.69666 5.30306 8.66671 6.49967 8.66671C7.69629 8.66671 8.66634 7.69666 8.66634 6.50004C8.66634 5.30342 7.69629 4.33337 6.49967 4.33337Z\" stroke=\"#B1B1B1\" stroke-linecap=\"round\" stroke-linejoin=\"round\"/>\r\n</svg>",
                      "ActionType": 1,
                      "MenuDesc": "گروه کالا",
                      "IconUrl": "http://216.65.200.216:9000/icons/",
                      "FatherId": 137,
                      "SystemId": 106,
                      "MenuType": 1,
                      "WebLink": "com/goodsCategory",
                      "ActionId": 181,
                      "RepoId": 106027,
                      "SubMenus": []
                    },
                    {
                      "MenuId": 82,
                      "Icon": "<svg width=\"13\" height=\"13\" viewBox=\"0 0 13 13\" fill=\"none\" xmlns=\"http://www.w3.org/2000/svg\">\r\n<path d=\"M6.49967 4.33337C5.30306 4.33337 4.33301 5.30342 4.33301 6.50004C4.33301 7.69666 5.30306 8.66671 6.49967 8.66671C7.69629 8.66671 8.66634 7.69666 8.66634 6.50004C8.66634 5.30342 7.69629 4.33337 6.49967 4.33337Z\" stroke=\"#B1B1B1\" stroke-linecap=\"round\" stroke-linejoin=\"round\"/>\r\n</svg>",
                      "ActionType": 1,
                      "MenuDesc": "واحدهای اندازه‌گیری",
                      "IconUrl": "http://216.65.200.216:9000/icons/",
                      "FatherId": 137,
                      "SystemId": 106,
                      "MenuType": 1,
                      "WebLink": "com/unitOfMeasurement",
                      "ActionId": 253,
                      "RepoId": 106043,
                      "SubMenus": []
                    },
                    {
                      "MenuId": 101,
                      "Icon": "<svg width=\"13\" height=\"13\" viewBox=\"0 0 13 13\" fill=\"none\" xmlns=\"http://www.w3.org/2000/svg\">\r\n<path d=\"M6.49967 4.33337C5.30306 4.33337 4.33301 5.30342 4.33301 6.50004C4.33301 7.69666 5.30306 8.66671 6.49967 8.66671C7.69629 8.66671 8.66634 7.69666 8.66634 6.50004C8.66634 5.30342 7.69629 4.33337 6.49967 4.33337Z\" stroke=\"#B1B1B1\" stroke-linecap=\"round\" stroke-linejoin=\"round\"/>\r\n</svg>",
                      "ActionType": 1,
                      "MenuDesc": "کالا",
                      "IconUrl": "http://216.65.200.216:9000/icons/",
                      "Config": "{\r\n  \"fieldKey\": \"GoodsId\",\r\n  \"staticKey\": \"MoadianCode\",\r\n  \"deleteUrl\": \"/api/com/delete/goods/goodsAdjustments\",\r\n  \"createUrl\": \"/api/com/insert/goods/goodsAdjustments\",\r\n  \"updateUrl\": \"/api/com/update/goods/goodsAdjustments\",\r\n  \"listConfig\": null,\r\n  \"formConfig\": {\r\n    \"fields\": [\r\n      {\r\n        \"name\": \"MoadianCode\",\r\n        \"caption\": \"کد مودیان\",\r\n        \"help\": \"این فیلد الزامی  می باشد\",\r\n        \"type\": \"text\",\r\n        \"rules\": [\r\n          { \"required\": false, \"message\": \"این فیلد الزامی است\" }\r\n        ],\r\n        \"placeHolder\": \"\",\r\n        \"order\": 1\r\n      },\r\n      {\r\n        \"name\": \"LegalFunds\",\r\n        \"caption\": \"سایر وجوه قانونی\",\r\n        \"help\": \"این فیلد الزامی  می باشد\",\r\n        \"type\": \"checkbox\",\r\n        \"rules\": [\r\n          { \"required\": false, \"message\": \"این فیلد الزامی است\" }\r\n        ],\r\n        \"placeHolder\": \"\",\r\n        \"order\": 2\r\n      },\r\n      {\r\n        \"name\": \"LegalFundsRate\",\r\n        \"caption\": \"نرخ وجوه قانونی\",\r\n        \"help\": \"این فیلد الزامی  می باشد\",\r\n        \"type\": \"number\",\r\n        \"rules\": [\r\n          { \"required\": false, \"message\": \"این فیلد الزامی است\" }\r\n        ],\r\n        \"placeHolder\": \"\",\r\n        \"order\": 3\r\n      },\r\n      {\r\n        \"name\": \"TaxFunds\",\r\n        \"caption\": \"سایر مالیات\",\r\n        \"help\": \"این فیلد الزامی  می باشد\",\r\n        \"type\": \"checkbox\",\r\n        \"rules\": [\r\n          { \"required\": false, \"message\": \"این فیلد الزامی است\" }\r\n        ],\r\n        \"placeHolder\": \"\",\r\n        \"order\": 4\r\n      },\r\n      {\r\n        \"name\": \"TaxFundsRate\",\r\n        \"caption\": \"نرخ سایر مالیات\",\r\n        \"help\": \"این فیلد الزامی  می باشد\",\r\n        \"type\": \"number\",\r\n        \"rules\": [\r\n          { \"required\": false, \"message\": \"این فیلد الزامی است\" }\r\n        ],\r\n        \"placeHolder\": \"\",\r\n        \"order\": 5\r\n      }\r\n    ]\r\n  },\r\n  \"actions\": [\r\n    {\r\n      \"MenuId\": null,\r\n      \"Icon\": \"<svg xmlns=\\\"http://www.w3.org/2000/svg\\\" width=\\\"18\\\" height=\\\"18\\\" viewBox=\\\"0 0 15 15\\\" fill=\\\"none\\\"><path d=\\\"M5.50015 2H3.40015C2.56007 2 2.13972 2 1.81885 2.16349C1.5366 2.3073 1.3073 2.5366 1.16349 2.81885C1 3.13972 1 3.56007 1 4.40015V11.6001C1 12.4402 1 12.86 1.16349 13.1809C1.3073 13.4632 1.5366 13.6929 1.81885 13.8367C2.1394 14 2.55925 14 3.39768 14H10.6023C11.4408 14 11.86 14 12.1805 13.8367C12.4628 13.6929 12.6929 13.4629 12.8367 13.1807C13 12.8601 13 12.4408 13 11.6023V9.5M10 2.75L5.5 7.25V9.5H7.75L12.25 5M10 2.75L12.25 0.5L14.5 2.75L12.25 5M10 2.75L12.25 5\\\" stroke=\\\"#585858\\\" stroke-linecap=\\\"round\\\" stroke-linejoin=\\\"round\\\"/></svg>\",\r\n      \"ActionId\": null,\r\n      \"MenuDesc\": \"ویرایش\",\r\n      \"key\": \"ویرایش\",\r\n      \"FatherId\": null,\r\n      \"MenuType\": null,\r\n      \"loggedInUserId\": null\r\n    },\r\n    {\r\n      \"MenuId\": null,\r\n      \"Icon\": \"<svg xmlns=\\\"http://www.w3.org/2000/svg\\\" width=\\\"22\\\" height=\\\"22\\\" viewBox=\\\"0 0 22 22\\\" fill=\\\"none\\\"><path d=\\\"M1 7.56907C1 6.37289 1.48238 5.63982 2.48063 5.08428L6.58987 2.79744C8.7431 1.59915 9.81971 1 11 1C12.1803 1 13.2569 1.59915 15.4101 2.79744L19.5194 5.08428C20.5176 5.63982 21 6.3729 21 7.56907C21 7.89343 21 8.05561 20.9646 8.18894C20.7785 8.88945 20.1437 9 19.5307 9H2.46928C1.85627 9 1.22152 8.88944 1.03542 8.18894C1 8.05561 1 7.89343 1 7.56907Z\\\" stroke=\\\"#585858\\\" stroke-width=\\\"1.5\\\"/><path d=\\\"M3 9V17.5M7 9V17.5\\\" stroke=\\\"#585858\\\" stroke-width=\\\"1.5\\\"/><path d=\\\"M10 17.5H4C2.34315 17.5 1 18.8431 1 20.5C1 20.7761 1.22386 21 1.5 21H10\\\" stroke=\\\"#585858\\\" stroke-width=\\\"1.5\\\" stroke-linecap=\\\"round\\\"/><path d=\\\"M20.5 13.5L13.5 20.5\\\" stroke=\\\"#585858\\\" stroke-width=\\\"1.5\\\" stroke-linecap=\\\"round\\\" stroke-linejoin=\\\"round\\\"/><circle cx=\\\"14.25\\\" cy=\\\"14.25\\\" r=\\\"0.75\\\" stroke=\\\"#585858\\\" stroke-width=\\\"1.5\\\"/><circle cx=\\\"19.75\\\" cy=\\\"19.75\\\" r=\\\"0.75\\\" stroke=\\\"#585858\\\" stroke-width=\\\"1.5\\\"/></svg>\",\r\n      \"ActionId\": null,\r\n      \"MenuDesc\": \"حذف\",\r\n      \"key\": \"حذف\",\r\n      \"FatherId\": null,\r\n      \"MenuType\": null,\r\n      \"WebLink\": \"\",\r\n      \"loggedInUserId\": null\r\n    }\r\n  ]\r\n}\r\n",
                      "FatherId": 137,
                      "SystemId": 106,
                      "MenuType": 1,
                      "WebLink": "com/goodList",
                      "ActionId": 193,
                      "RepoId": 106023,
                      "SubMenus": []
                    },
                    {
                      "MenuId": 110,
                      "Icon": "<svg width=\"13\" height=\"13\" viewBox=\"0 0 13 13\" fill=\"none\" xmlns=\"http://www.w3.org/2000/svg\">\r\n<path d=\"M6.49967 4.33337C5.30306 4.33337 4.33301 5.30342 4.33301 6.50004C4.33301 7.69666 5.30306 8.66671 6.49967 8.66671C7.69629 8.66671 8.66634 7.69666 8.66634 6.50004C8.66634 5.30342 7.69629 4.33337 6.49967 4.33337Z\" stroke=\"#B1B1B1\" stroke-linecap=\"round\" stroke-linejoin=\"round\"/>\r\n</svg>",
                      "ActionType": 1,
                      "MenuDesc": "مشخصات اضافی کالا",
                      "IconUrl": "http://216.65.200.216:9000/icons/",
                      "FatherId": 137,
                      "SystemId": 106,
                      "MenuType": 1,
                      "WebLink": "com/goodPropertiesList",
                      "ActionId": 197,
                      "RepoId": 106030,
                      "SubMenus": []
                    },
                    {
                      "MenuId": 117,
                      "Icon": "<svg width=\"13\" height=\"13\" viewBox=\"0 0 13 13\" fill=\"none\" xmlns=\"http://www.w3.org/2000/svg\">\r\n<path d=\"M6.49967 4.33337C5.30306 4.33337 4.33301 5.30342 4.33301 6.50004C4.33301 7.69666 5.30306 8.66671 6.49967 8.66671C7.69629 8.66671 8.66634 7.69666 8.66634 6.50004C8.66634 5.30342 7.69629 4.33337 6.49967 4.33337Z\" stroke=\"#B1B1B1\" stroke-linecap=\"round\" stroke-linejoin=\"round\"/>\r\n</svg>",
                      "ActionType": 1,
                      "MenuDesc": "ویژگی کالا",
                      "IconUrl": "http://216.65.200.216:9000/icons/",
                      "FatherId": 137,
                      "SystemId": 106,
                      "MenuType": 1,
                      "WebLink": "com/goodVariantList",
                      "ActionId": 369,
                      "RepoId": 106062,
                      "SubMenus": []
                    }
                  ]
                },
                {
                  "MenuId": 244,
                  "Icon": "<svg width=\"14\" height=\"14\" viewBox=\"0 0 14 14\" fill=\"none\" xmlns=\"http://www.w3.org/2000/svg\">\r\n<path d=\"M7 4C5.34315 4 4 5.34315 4 7C4 8.65685 5.34315 10 7 10C8.65685 10 10 8.65685 10 7C10 5.34315 8.65685 4 7 4Z\" fill=\"#767676\" stroke=\"#B1B1B1\" stroke-width=\"0.5\" stroke-linecap=\"round\" stroke-linejoin=\"round\"/>\r\n</svg>",
                  "ActionType": 0,
                  "MenuDesc": "تنظیمات",
                  "IconUrl": "http://216.65.200.216:9000/icons/Setting.png",
                  "FatherId": 1,
                  "MenuType": 0,
                  "ActionId": 0,
                  "RepoId": 0,
                  "SubMenus": [
                    {
                      "MenuId": 245,
                      "Icon": "<svg width=\"13\" height=\"13\" viewBox=\"0 0 13 13\" fill=\"none\" xmlns=\"http://www.w3.org/2000/svg\">\r\n<path d=\"M6.49967 4.33337C5.30306 4.33337 4.33301 5.30342 4.33301 6.50004C4.33301 7.69666 5.30306 8.66671 6.49967 8.66671C7.69629 8.66671 8.66634 7.69666 8.66634 6.50004C8.66634 5.30342 7.69629 4.33337 6.49967 4.33337Z\" stroke=\"#B1B1B1\" stroke-linecap=\"round\" stroke-linejoin=\"round\"/>\r\n</svg>",
                      "ActionType": 1,
                      "MenuDesc": "شرکت ها",
                      "IconUrl": "http://216.65.200.216:9000/icons/",
                      "FatherId": 244,
                      "SystemId": 207,
                      "MenuType": 1,
                      "WebLink": "mng/place",
                      "AppLink": "mng/place",
                      "ActionId": 393,
                      "RepoId": 207003,
                      "SubMenus": []
                    }
                  ]
                }
              ]
            },

          )

          ],);

          //Ehsan Change


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
    final currentIndex = _tabToIndex[selectedTab] ?? 10;
    return Scaffold(
      appBar: _getAppBar(selectedTab),
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
                Container(height: 2, width: 35, color: Colors.black),
                SizedBox(height: 5),
                activeIcon,
              ],
            )
          : icon,
    );
  }
}
