import 'package:container_app/pages/launcher_page.dart';
import 'package:container_app/pages/splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login_module/login_page.dart';
import 'package:models_package/Base/login_module.dart';
import 'package:models_package/Data/Auth/User/dto.dart';
import 'package:services_package/setup_services.dart';
import 'package:services_package/storage_service.dart';

class HomeWrapper extends StatefulWidget {
  const HomeWrapper({super.key});

  @override
  State<HomeWrapper> createState() => _HomeWrapperState();
}

class _HomeWrapperState extends State<HomeWrapper> {
  UserDto? _currentUser;
  bool _isCheckingLogin = true;

  @override
  void initState() {
    super.initState();
    _checkExistingLogin();
  }

  Future<void> _checkExistingLogin() async {
    try {
      final storageService = getIt.get<StorageService>();
      final token = await storageService.getToken();
      final user = await storageService.getUser();

      if (token != null && user != null) {
        setState(() {
          _currentUser = user;
          _isCheckingLogin = false;
        });
      } else {
        setState(() {
          _isCheckingLogin = false;
        });

        WidgetsBinding.instance.addPostFrameCallback((_) {
          _openLoginModule();
        });
      }
    } catch (e) {
      print('Error checking login: $e');
      setState(() {
        _isCheckingLogin = false;
      });
      // در صورت خطا هم مستقیماً به لاگین برو
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _openLoginModule();
      });
    }
  }

  Future<void> _openLoginModule() async {
    final result = await Navigator.of(context).push<LoginModuleResult>(
      MaterialPageRoute(
        builder: (context) => LoginPage(),
        fullscreenDialog: true,
      ),
    );


    if (result != null && result.success) {
      await _handleSuccessfulLogin(result);
    } else if (result != null && !result.success) {

      _handleLoginError(result);
      _openLoginModule();
    } else {


      _openLoginModule();
    }
  }

  Future<void> _handleSuccessfulLogin(LoginModuleResult result) async {
    try {
      final storageService = getIt.get<StorageService>();
      // await storageService.setToken(result.token!);
      // await storageService.setUser(result.user!);


      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LauncherPage()),
      );
    } catch (e) {
      print('Error handling successful login: $e');
      _openLoginModule();
    }
  }

  void _handleLoginError(LoginModuleResult result) {
    // نمایش خطا به کاربر
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(result.error ?? 'خطا در ورود'),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    if (_isCheckingLogin) {
      return const SplashScreenPage ();
    }

    if (_currentUser != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => LauncherPage()),
        );
      });
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: 20),
            Text(
              'در حال انتقال...',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}