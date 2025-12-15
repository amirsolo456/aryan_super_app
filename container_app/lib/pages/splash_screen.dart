import 'dart:core';

import 'package:erp_app/core/network/injection_container.dart';
import 'package:erp_app/data/models/login_module_model.dart';
import 'package:flutter/material.dart';
import 'package:models_package/Base/enums.dart';
import 'package:models_package/Base/language.dart';
import 'package:models_package/Base/login_module.dart';
import 'package:navigation_builder/navigation_builder.dart';
import 'package:services_package/storage/domain/usecases/storage_service.dart';
import 'package:ui_components_package/erp_app_componenets/common/aryan_logo.dart';
import 'login_wrapper.dart';

class SplashScreenPage extends StatefulWidget {
  final int mode;
  final int networkMode;

  const SplashScreenPage({
    super.key,
    required this.mode,
    required this.networkMode,
  });

  @override
  State<SplashScreenPage> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreenPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _translateY;
  late Animation<double> _opacity;
  final storageService = sl.get<StorageService>();
  bool _loaderVisible = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    storageService.waitUntilDbBuild().then(
      (db) => {
        if (db != null && db.isOpen)
          {
            storageService.sqlLoadLoginSessionModel().then(
              (loginSession) => {
                if (loginSession.token == null || !loginSession.success)
                  {
                    storageService.loadDeviceToken().then(
                      (isOk) => {
                        if (isOk.isNotEmpty)
                          {
                            LoginWrapper()
                                .navigateToLogin(
                                  context,
                                  isOk,
                                  widget.networkMode,
                                )
                                .then(
                                  (loginSuccess) => {
                                    if (loginSuccess != null)
                                      {
                                        storageService
                                            .saveLoginSessionModel(
                                              LoginModuleResult.success(
                                                token: loginSuccess.token ?? "",
                                                user: loginSuccess.user!,
                                                error: loginSuccess.error,
                                                success: loginSuccess.success!,
                                                timestamp: loginSuccess.timestamp,
                                                networkMode: 0,
                                                language: loginSession.language ?? Language(id: 0),
                                                selectedManagementAccount: loginSuccess.selectedManagementAccount,
                                                cachedKey: '',
                                                managementAccount: [],
                                              ),
                                            )
                                            .then(
                                              (_) => {
                                                storageService.sqlLoadLoginSessionModel().then((loaded) => {LoginWrapper().navigateToLauncherPage(context, loaded.toJson(),
                                                            ),
                                                      },
                                                    ),
                                              },
                                            ),
                                      }
                                    else
                                      {
                                        LoginWrapper()
                                            .navigateToLauncherPage(
                                              context,
                                              loginSession.toJson(),
                                            )
                                            .then((isLauncherOk) => {}),
                                      },
                                  },
                                ),
                          },
                      },
                    ),
                  }
                else
                  {
                    LoginWrapper()
                        .navigateToLauncherPage(context, loginSession.toJson())
                        .then((isLauncherOk) => {}),
                  },
              },
            ),
          }
        else
          throw 'Db is NULL',
      },
    );
  }

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _translateY = Tween<double>(
      begin: 100,
      end: -100,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _opacity = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    if (!mounted) return;

    if (widget.mode == 1) {
      storageService.removeLoginSessionModel();
    }
    Future.delayed(const Duration(seconds: 5));
    _startAnimation();
  }

  void _startAnimation() async {
    try {
      await Future.delayed(const Duration(milliseconds: 1000));
      if (!mounted) return;

      await _controller.forward();

      if (!mounted) return;

      setState(() => _loaderVisible = true);
    } catch (e) {}
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Transform.translate(
                offset: Offset(0, _translateY.value),
                child: Opacity(opacity: _opacity.value, child: AryanLogo()),
              ),
              const SizedBox(height: 40),
              if (_loaderVisible)
                const CircularProgressIndicator(
                  color: Colors.black,
                  strokeAlign: 3,
                  padding: EdgeInsetsGeometry.all(5),
                  strokeCap: StrokeCap.round,
                  trackGap: 1,
                  strokeWidth: 3,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

// --- نسخهٔ Builder (زنجیره‌ای) برای استفادهٔ راحت ---
// class GuardedNavigationBuilderBuilder {
//   final GuardedNavigationBuilder _inner = GuardedNavigationBuilder();
//
//   GuardedNavigationBuilderBuilder routes(
//     Map<String, Widget Function(RouteData)> r,
//   ) {
//     _inner.routes = r;
//     return this;
//   }
//
//   GuardedNavigationBuilderBuilder unknownRoute(Widget Function(RouteData) r) {
//     _inner.unknownRoute = r;
//     return this;
//   }
//
//   GuardedNavigationBuilderBuilder initialLocation(String loc) {
//     _inner.initialLocation = loc;
//     return this;
//   }
//
//   GuardedNavigationBuilderBuilder transitionsBuilder(
//     RouteTransitionsBuilder tb,
//   ) {
//     _inner.transitionsBuilder = tb;
//     return this;
//   }
//
//   GuardedNavigationBuilderBuilder transitionDuration(Duration d) {
//     _inner.transitionDuration = d;
//     return this;
//   }
//
//   GuardedNavigationBuilderBuilder debugPrint(bool v) {
//     _inner.debugPrintWhenRouted = v;
//     return this;
//   }
//
//   GuardedNavigationBuilder build() => _inner;
// }
