import 'package:erp_app/main.dart' as erp_app;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:models_package/Base/language.dart';
import 'package:ui_components_package/erp_app_componenets/common/Buttons/language_button_standalone/language_button_stand_alone_cubit.dart';



class ShellApp extends StatelessWidget {
  const ShellApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Super App Launcher',
      home: LauncherPage(),
      theme: ThemeData(primarySwatch: Colors.blue),
    );
  }
}

class LauncherPage extends StatelessWidget {
  LauncherPage({super.key});


  Language _localeToLanguage(Locale locale) {
    final lang = locale.languageCode;
    final country = locale.countryCode ?? '';
    final smallName = lang;
    final completeName = country.isNotEmpty ? '${lang}_$country' : lang;
    final bigName = country;
    final id = lang == 'fa' ? 0 : 1;

    return Language(id: id, smallName: smallName, completeName: completeName, bigName: bigName);
  }


  @override
  Widget build(BuildContext context) {
    final locale = context.watch<LanguageButtonStandAloneCubit>().state;
    final languageModel = _localeToLanguage(locale);
    final options = <_AppOption>[
      _AppOption('Login Page', Icons.login, () => LauncherPage()),
      _AppOption('ERP App', Icons.business, () {
        return erp_app.buildERPApp(languageModel);
      }),
      _AppOption('Other', Icons.widgets, () => const Scaffold(body: Center(child: Text('Other App')))),
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
