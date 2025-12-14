import 'package:container_app/pages/launcher_page.dart';
import 'package:container_app/pages/splash_screen.dart';
import 'package:erp_app/core/network/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:services_package/storage/domain/usecases/storage_service.dart';

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
      final storageService = sl.get<StorageService>();
      final token = await storageService.loadToken();
      final user = await storageService.loadUser();
      final lang = await storageService.loadLanguage();
      final devToken = await storageService.loadDeviceToken() ?? '';

      if (token != null && user != null) {
        final datas = await storageService.loadLoginSessionModel();

        if (mounted) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => LauncherPage(loginSession: datas.toJson() ?? {}),
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


  @override
  Widget build(BuildContext context) {
    return _currentScreen;
  }
}
