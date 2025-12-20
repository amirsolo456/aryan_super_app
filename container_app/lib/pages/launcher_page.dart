import 'package:container_app/pages/splash_screen.dart';
import 'package:erp_app/core/network/injection_container.dart';
import 'package:erp_app/feature/default_page/Language/bloc/language_bloc.dart';
import 'package:erp_app/feature/default_page/Place/bloc/place_bloc.dart';
import 'package:erp_app/feature/default_page/pages/default_selection_state__bloc.dart';
import 'package:erp_app/feature/default_page/select_cashier/bloc/select_cashier_bloc.dart';
import 'package:erp_app/feature/default_page/select_currency/bloc/select_currency_bloc.dart';
import 'package:erp_app/feature/default_page/select_year/bloc/select_year_bloc.dart';
import 'package:erp_app/main.dart' as erp_app;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:services_package/api_client_service.dart';

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

              //Ehsan Change

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => MultiBlocProvider(
                    providers: [

                      //Ehsan Chage
                      BlocProvider(
                        create: (_) => DefaultSelectionBloc(sl<ApiSettings>()),
                      ),
                      //Ehsan Chage


                      BlocProvider<PlaceBloc>(create: (_) => sl<PlaceBloc>()),
                      BlocProvider<SelectCashierBloc>(create: (_) => sl<SelectCashierBloc>()),
                      BlocProvider<SelectCurrencyBloc>(create: (_) => sl<SelectCurrencyBloc>()),
                      BlocProvider<SelectYearBloc>(create: (_) => sl<SelectYearBloc>()),
                      BlocProvider<LanguageBloc>(create: (_) => sl<LanguageBloc>()),
                    ],
                    child: opt.builder(), // اینجا DefaultPage یا صفحه ERP App فراخوانی میشه
                  ),
                ),
              );

              //Ehsan Change

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
