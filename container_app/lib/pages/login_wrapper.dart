import 'package:flutter/material.dart';
import 'package:login_module/login_page.dart';
import 'package:models_package/Base/login_module.dart';

import 'launcher_page.dart';

class LoginWrapper<T> {
  Future<T?> navigateToLogin(
    BuildContext context,
    String devToken,
    int networkMode,
  ) async {
    try {
      final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LoginPage(
            key: UniqueKey(),
            locale: const Locale('fa'),
            deviceToken: devToken,
            netMode: networkMode,
          ),
        ),
      );
      return result;
    } catch (e) {
      return null;
    }
  }

  Future<T?> navigateToLauncherPage(
    BuildContext context,
    Map<String, dynamic> sessionResult,
  ) async {
    try {
      final result = await Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              LauncherPage(key: UniqueKey(), loginSession: sessionResult),
        ),
      );
      return result;
    } catch (e) {
      return null;
    }
  }
}
