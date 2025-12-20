import 'dart:io';
import 'package:container_app/pages/splash_screen.dart';
import 'package:erp_app/core/network/injection_container.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:services_package/shared_core/notifications/app_notifier.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:login_module/services/login_manager_service.dart';
import 'package:login_module/services/snackbar_service.dart';
import 'package:resources_package/Resources/Theme/theme_manager.dart';
import 'package:resources_package/l10n/app_localizations.dart';
import 'package:services_package/shared_core/notifications/enums.dart';
import 'package:services_package/storage/domain/usecases/storage_service.dart';
import 'package:ui_components_package/erp_app_componenets/common/Buttons/language_button_standalone/language_button_stand_alone_cubit.dart';

import 'app_notifier.dart';
import 'data/enums.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  initStandAlone();

  // final AppNotifier appNotifier = AppNotifier();
  // // AppNotifier.initialize(registerInGetIt: true, sl: sl);
  // if (!sl.isRegistered<AppNotifier>()) {
  //   sl.registerSingleton<AppNotifier>(appNotifier);
  // } else {
  //   sl.unregister<AppNotifier>();
  //   sl.registerSingleton<AppNotifier>(appNotifier);
  // }

  if (!sl.isRegistered<LoginModuleManager>()) {
    sl.registerLazySingleton(() => LoginModuleManager());
  }

  if (!sl.isRegistered<SnackBarService>()) {
    sl.registerLazySingleton<SnackBarService>(() => SnackBarService());
  }
  // final notifier = sl<AppNotifier>();
  // notifier.sendRequestToOtherApp(
  //   method: 'child_app_channel',
  //   timeout: Duration(seconds: 5),
  //   params: [],
  // );

  // تنظیم کانال برای دریافت از اپ فرزند
  // const MethodChannel('parent_app_channel').setMethodCallHandler((call) async {
  //   if (call.method == 'notification') {
  //     final data = call.arguments as Map<String, dynamic>;
  //     notifier.receiveFromOtherApp(data);
  //   }
  //   return null;
  // });

  Locale initialLocale = Locale('fa');

  ThemeManager.init();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyDaFoQ1BufZNuUKKYrVfnoAPjVytggLeJY",
      appId: "1:511210742680:android:a754014ad3e3daefab81ed",
      messagingSenderId: "511210742680",
      projectId: "aryanerp-e996e",
      databaseURL: "https://aryanerp-e996e-default-rtdb.firebaseio.com",
      storageBucket: "aryanerp-e996e.firebasestorage.app",
      androidClientId:
          "511210742680-xxxxxxxxxxxxxxxxxxxxxxxxxxxx.apps.googleusercontent.com",
    ),
  );

  try {
    String? token = await FirebaseMessaging.instance.getToken();
    if (token != null && token.isNotEmpty) {
      final storageService = sl.get<StorageService>();
      await storageService.saveDeviceToken(token);
      final _lang = await storageService.loadLanguage();

      initialLocale = Locale(_lang.languageCode ?? 'fa');
    }
  } catch (e) {
    debugPrint('Error in token/setup: $e');
    initialLocale = Locale('fa');
  }

  runApp(
    ParentAppScreen(
      initialLocal: Locale(initialLocale.languageCode),
      networkMode: 0,
    ),
  );
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class ParentAppScreen extends StatefulWidget {
  final Locale initialLocal;
  final int networkMode;

  const ParentAppScreen({
    required this.initialLocal,
    required this.networkMode,
  });

  @override
  State<ParentAppScreen> createState() => _ParentAppScreenState();
}

class _ParentAppScreenState extends State<ParentAppScreen>
    with AppNotifierMixin {

  @override
  void initState() {
    super.initState();

    // گوش دادن به نوتیفیکیشن‌های خاص از اپ فرزند
    addTypedNotificationListener(NotificationType.errorOccurred, (
      notification,
    ) {

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('خطا از اپ فرزند: ${notification.message}'),
          backgroundColor: Colors.red,
        ),
      );
    });

    addTypedNotificationListener(NotificationType.sessionExpired, (
      notification,
    ) {

      const MethodChannel('parent_to_child_channel').invokeMethod('relogin');
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: true,
      create: (_) => LanguageButtonStandAloneCubit(
        initialLocale: widget.initialLocal,
        storage: sl.get<StorageService>(),
      ),
      child: BlocBuilder<LanguageButtonStandAloneCubit, Locale>(
        builder: (context, locale) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            locale: locale,
            supportedLocales: const [Locale('fa', 'IR'), Locale('en', 'US')],
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            theme: ThemeColorsManager(.light).aryanTheme,
            darkTheme: ThemeColorsManager(.dark).aryanTheme,
            themeMode: ThemeManager.themeMode,
            home: SplashScreenPage(mode: 1, networkMode: widget.networkMode),
          );
        },
      ),
    );
  }

  // ارسال دستور به اپ فرزند
  void _sendCommandToChild() {
    notifyApp(
      type: NotificationType.customEvent,
      message: 'Command from parent',
      payload: {'command': 'refresh', 'data': 'some_data'},
      crossApp: true, // ارسال به اپ فرزند
    );
  }
}
