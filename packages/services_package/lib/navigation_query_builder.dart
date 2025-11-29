import 'dart:async';

import 'package:flutter/material.dart';

class NavigationQueryBuilderService {
  static const String headKey = "head";
  static const String bodyKey = "body";
  static const String footerKey = "footer";
  static const String headParams = "headParams";
  static const String bodyParams = "bodyParams";
  static const String footerParams = "footerParams";
  static const String maniHost = "///mainpage";
  static const String xManiHost = "///Xmainpage";
  static const String hasSpecialDataKey = "hasSpecialDataKey";

  static double width = 0;

  static final Map<Type, Map<String, dynamic>> _navQueryParamsHolder = {};

  // استفاده از Stream برای event handling
  static final StreamController<String> _navigationStreamController =
      StreamController<String>.broadcast();

  static Stream<String> get onNavigationStarted =>
      _navigationStreamController.stream;

  // متد build که گم شده بود
  static String build(String route) {
    try {
      final stringParams = _navQueryParamsHolder[String] ?? {};
      final query = stringParams.entries
          .map((entry) => '${entry.key}=${Uri.encodeComponent(entry.value)}')
          .join('&');

      return query.isNotEmpty ? '$route?$query' : route;
    } catch (e) {
      debugPrint('Error in build: $e');
      return route;
    }
  }

  static Map<String, T> getAll<T>() {
    try {
      final typeMap = _navQueryParamsHolder[T] ?? {};
      return Map<String, T>.from(typeMap.cast<String, T>());
    } catch (e) {
      debugPrint('Error in getAll: $e');
      return {};
    }
  }

  static NavigationQueryBuilderService setRegion(
    String region,
    String viewName, {
    bool isSpecial = false,
  }) {
    try {
      _updateNavParams<String>(region, viewName);

      if (isSpecial) {
        return setRegionParameter<bool>(region, hasSpecialDataKey, isSpecial);
      }
      return NavigationQueryBuilderService();
    } catch (e) {
      debugPrint('Error in setRegion: $e');
      return NavigationQueryBuilderService();
    }
  }

  static NavigationQueryBuilderService setRegionParameter<T>(
    String region,
    String key,
    T value,
  ) {
    try {
      final fullKey = "$region.$key";
      _updateNavParams<T>(fullKey, value);
    } catch (e) {
      debugPrint('Error in setRegionParameter: $e');
    }
    return NavigationQueryBuilderService();
  }

  static bool hasSpecial() {
    bool result = false;
    final key = "$bodyKey.$hasSpecialDataKey";

    try {
      final boolParams = _navQueryParamsHolder[bool] ?? {};
      if (boolParams.containsKey(key)) {
        result = boolParams[key] as bool;
      }
    } catch (e) {
      debugPrint('Error in hasSpecial: $e');
    } finally {
      if (result) {
        _navQueryParamsHolder[bool]?.remove(key);
      }
    }
    return result;
  }

  static bool goto([String mainHost = ""]) {
    bool success = false;

    try {
      String host = maniHost;
      final route = build(host); // حالا متد build موجود است

      try {
        // ارسال event از طریق Stream
        _navigationStreamController.add(route);
        debugPrint('Route: $route');
        success = true;
      } catch (e) {
        _navigationStreamController.addError(e);
        success = false;
      }

      final mediaQuery = MediaQueryData.fromView(
        WidgetsBinding.instance.window,
      );
      width = mediaQuery.size.width;

      if (width >= 700) {
        host = xManiHost;
      }
    } catch (e) {
      debugPrint('Error in goto: $e');
    }

    return success;
  }

  // متدهای کمکی
  static void _updateNavParams<T>(String key, T value) {
    _navQueryParamsHolder[T] ??= {};
    _navQueryParamsHolder[T]![key] = value;
  }

  static void _sendMessage(String message) {
    debugPrint('Message sent: $message');
  }

  static void _sendError(Object error) {
    debugPrint('Error sent: $error');
  }

  // متد برای پاک کردن داده‌ها
  static void clear<T>() {
    _navQueryParamsHolder.remove(T);
  }

  // متد برای پاک کردن همه داده‌ها
  static void clearAll() {
    _navQueryParamsHolder.clear();
  }
}
