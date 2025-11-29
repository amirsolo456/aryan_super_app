// lib/app_assets.dart
import 'package:flutter/widgets.dart';
import 'package:resources_package/Resources/Assets/assets_manager.dart';

/// Centralized asset & font names.
/// Usage:
///   Image image = AppAssets.images.account(width: 24, height: 24);
///   TextStyle t = AppAssets.fonts.iransansX(size: 14, fontWeight: FontWeight.w700);
class AryanAppAssets {
  AryanAppAssets._();

  /// Font family names (as declared in pubspec.yaml)
  static _AppFonts get fonts => _AppFonts._();

  /// Image assets (paths + helpers)
  static _AppImages get images => _AppImages._();
}

/* ---------------------- FONTS ---------------------- */

class _AppFonts {
  const _AppFonts._();

  // fontFamily values must match the 'family' names in pubspec.yaml
  static const String IRANSansX = 'IRANSansX';
  static const String OpenSans = 'OpenSans';
  static const String IRANSansRegular = 'IRANSansRegular';
  static const String Yekan = 'Yekan';

  /// Convenience TextStyle factories
  TextStyle iransansX({
    double? size,
    FontWeight? fontWeight,
    Color? color,
    double? height,
    TextDecoration? decoration,
  }) => TextStyle(
    fontFamily: IRANSansX,
    fontSize: size,
    fontWeight: fontWeight,
    color: color,
    height: height,
    decoration: decoration,
  );

  TextStyle openSans({
    double? size,
    FontWeight? fontWeight,
    Color? color,
    double? height,
    TextDecoration? decoration,
  }) => TextStyle(
    fontFamily: OpenSans,
    fontSize: size,
    fontWeight: fontWeight,
    color: color,
    height: height,
    decoration: decoration,
  );

  TextStyle iransansRegular({
    double? size,
    FontWeight? fontWeight,
    Color? color,
  }) => TextStyle(
    fontFamily: IRANSansRegular,
    fontSize: size,
    fontWeight: fontWeight,
    color: color,
  );

  TextStyle yekan({double? size, FontWeight? fontWeight, Color? color}) =>
      TextStyle(
        fontFamily: Yekan,
        fontSize: size,
        fontWeight: fontWeight,
        color: color,
      );
}

/* ---------------------- IMAGES / ICONS ---------------------- */

class _AppImages {
  const _AppImages._();

  // Individual asset paths (match your pubspec.yaml)

  /// All paths (useful for pre-cache or for listing)
  static const List<String> all = <String>[
    AryanAssets.account,
    AryanAssets.activeAccount,
    AryanAssets.defaults,
    AryanAssets.activeDefaults,
    AryanAssets.menu,
    AryanAssets.activeMenu,
    AryanAssets.newItem,
    AryanAssets.activeNew,
    AryanAssets.opened,
    AryanAssets.activeOpened,
    AryanAssets.userInfo,
    AryanAssets.userDevices,
    AryanAssets.userSignOut,
    AryanAssets.userTitle,
    AryanAssets.userOtherAccounts,
    AryanAssets.userSettings,
    AryanAssets.userWallet,
    AryanAssets.userPasswordChange,
    AryanAssets.sort,
    AryanAssets.filterNone,
    AryanAssets.filterSigning,
    AryanAssets.refresh,
    AryanAssets.futures,
    AryanAssets.more,
    AryanAssets.paginationRight,
    AryanAssets.paginationLeft,
    AryanAssets.add,
    AryanAssets.aryanApp,
    AryanAssets.langIcon,
    AryanAssets.eyesClose,
    AryanAssets.eyesOpen,
    AryanAssets.smallGoCaret,
    AryanAssets.defaultImage,
    AryanAssets.defaultImage256Px,
  ];

  /// Map keyed by simple name (helps dynamic lookup)
  static final Map<String, String> byKey = <String, String>{
    'account': AryanAssets.account,
    'activeAccount': AryanAssets.activeAccount,
    'defaults': AryanAssets.defaults,
    'activeDefaults': AryanAssets.activeDefaults,
    'menu': AryanAssets.menu,
    'activeMenu': AryanAssets.activeMenu,
    'new': AryanAssets.newItem,
    'activeNew': AryanAssets.activeNew,
    'opened': AryanAssets.opened,
    'activeOpened': AryanAssets.activeOpened,
    'userInfo': AryanAssets.userInfo,
    'userDevices': AryanAssets.userDevices,
    'userSignOut': AryanAssets.userSignOut,
    'userTitle': AryanAssets.userTitle,
    'userOtherAccounts': AryanAssets.userOtherAccounts,
    'userSettings': AryanAssets.userSettings,
    'userWallet': AryanAssets.userWallet,
    'userPasswordChange': AryanAssets.userPasswordChange,
    'sort': AryanAssets.sort,
    'filterNone': AryanAssets.filterNone,
    'filterSigning': AryanAssets.filterSigning,
    'refresh': AryanAssets.refresh,
    'futures': AryanAssets.futures,
    'more': AryanAssets.more,
    'paginationRight': AryanAssets.paginationRight,
    'paginationLeft': AryanAssets.paginationLeft,
    'add': AryanAssets.add,
    'aryanApp': AryanAssets.aryanApp,
    'langIcon': AryanAssets.langIcon,
    'eyesClose': AryanAssets.eyesClose,
    'eyesOpen': AryanAssets.eyesOpen,
    'smallGoCaret': AryanAssets.smallGoCaret,
    'defaultImage': AryanAssets.defaultImage,
    'defaultImage256Px': AryanAssets.defaultImage256Px,
  };

  /// Shortcut to create an Image widget from a known path
  Image image(
    String path, {
    Key? key,
    double? width,
    double? height,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    String? semanticLabel,
    bool excludeFromSemantics = false,
  }) => Image.asset(
    path,
    package: 'resources_package',
    key: key,
    width: width,
    height: height,
    fit: fit,
    alignment: alignment,
    semanticLabel: semanticLabel,
    excludeFromSemantics: excludeFromSemantics,
  );

  /// Create Image by key name (returns a placeholder SizedBox if key not found)
  Widget imageByKey(
    String keyName, {
    Key? key,
    double? width,
    double? height,
    BoxFit? fit,
    String? semanticLabel,
  }) {
    final path = byKey[keyName];
    if (path == null) {
      // fallback widget (you can replace with your own placeholder)
      return SizedBox(width: width, height: height);
    }
    return Image.asset(
      path,
      package: 'resources_package',
      key: key,
      width: width,
      height: height,
      fit: fit,
      semanticLabel: semanticLabel,
    );
  }

  Widget imageByValue(
    String value, {
    Key? key,
    double? width,
    double? height,
    BoxFit? fit,
    String? semanticLabel,
  }) {
    final path = value;
    if (byKey.values.any((c) => c == value)) {
      return Image.asset(
        path,
        package: 'resources_package',
        key: key,
        width: width,
        height: height,
        fit: fit,
        semanticLabel: semanticLabel,
      );
    }
    return SizedBox(width: width, height: height);
  }
}
