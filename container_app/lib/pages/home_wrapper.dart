import 'package:container_app/pages/launcher_page.dart';
import 'package:container_app/pages/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:models_package/Base/language.dart';
import 'package:models_package/Base/login_module.dart';
import 'package:services_package/setup_services.dart';
import 'package:services_package/storage_service.dart';

class HomeWrapper extends StatefulWidget {
  const HomeWrapper({super.key});

  @override
  State<HomeWrapper> createState() => _HomeWrapperState();
}

class _HomeWrapperState extends State<HomeWrapper> {
  late Widget _currentScreen = SplashScreenPage(mode: 0, networkMode: 0);

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    try {
      final storageService = getIt.get<StorageService>();
      final token = await storageService.getToken();
      final user = await storageService.getUser();
      final lang = await storageService.getLanguage();
      final devToken = await storageService.getDeviceToken() ?? '';

      if (token != null && user != null) {
        final datas = await storageService.loadLoginSession();

        if (mounted) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => LauncherPage(loginSession: datas ?? {}),
            ),
          );
        }
      } else {
        if (mounted) {
          // _showLoginPage(
          //   netWorkMode: 0,
          //   deviceToken: devToken,
          //   locale: Locale(lang?.languageCode ?? 'fa'),
          // );
        }
      }
    } catch (e) {
      print('Error initializing app: $e');
      if (mounted) {
        setState(() {
          _currentScreen = _buildErrorScreen(e.toString());
        });
      }
    }
  }

  // void _showLoginPage({
  //   required int netWorkMode,
  //   required String deviceToken,
  //   required Locale locale,
  // }) {
  //   setState(() {
  //     _currentScreen = LoginPage(
  //       netMode: netWorkMode,
  //       deviceToken: deviceToken,
  //       locale: locale,
  //
  //     );
  //   });
  // }

  Future<void> _onLoginSuccess(LoginModuleResult result) async {
    try {
      final storageService = getIt.get<StorageService>();
      final saveResult = await storageService.setLoginSession(
        token: result.token!,
        language: Language(id: 0, languageCode: 'fa'),
        user: result.user!,
        loginResult: result,
        selectedManagement: result.selectedManagementAccount,
      );

      if (saveResult.isSuccess && mounted) {
        final datas = await storageService.loadLoginSession();
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => LauncherPage(loginSession: datas ?? {}),
          ),
        );
      } else {
        _showSnackBar('خطا در ذخیره اطلاعات: ${saveResult.message}');
      }
    } catch (e) {
      _showSnackBar('خطای سیستمی: $e');
    }
  }

  Widget _buildErrorScreen(String error) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, color: Colors.red, size: 50),
              const SizedBox(height: 20),
              Text(
                'خطا در راه‌اندازی برنامه',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 10),
              Text(
                error,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _initializeApp,
                child: const Text('تلاش مجدد'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _currentScreen;
  }
}
