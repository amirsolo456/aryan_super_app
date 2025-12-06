import 'package:container_app/pages/splash_screen.dart';
import 'package:erp_app/main.dart' as erp_app;
import 'package:flutter/material.dart';

class ShellApp extends StatelessWidget {
  final Map<String, dynamic> loginSession;

  const ShellApp({super.key, required this.loginSession});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Super App Launcher',
      home: LauncherPage(loginSession: loginSession),
      theme: ThemeData(primarySwatch: Colors.blue),
    );
  }
}

class LauncherPage extends StatelessWidget {
  final Map<String, dynamic> loginSession;

  LauncherPage({super.key, required this.loginSession});

  @override
  Widget build(BuildContext context) {
    final options = <_AppOption>[
      _AppOption(
        'Login Page',
        Icons.login,
        () => SplashScreenPage(mode: 1, networkMode: 0),
      ),
      _AppOption('ERP App', Icons.business, () {
        return erp_app.buildERPApp(loginDatas: loginSession);
      }),
      _AppOption(
        'Other',
        Icons.widgets,
        () => const Scaffold(body: Center(child: Text('Other App'))),
      ),
    ];
    return Scaffold(
      appBar: AppBar(title: const Text('Super App Launcher')),
      body: GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(16),
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        children: options.map((opt) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => opt.builder()),
              );
            },
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(opt.icon, size: 50, color: Colors.blue),
                  const SizedBox(height: 8),
                  Text(opt.name, style: const TextStyle(fontSize: 18)),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _AppOption {
  final String name;
  final IconData icon;
  final Widget Function() builder;

  _AppOption(this.name, this.icon, this.builder);
}
