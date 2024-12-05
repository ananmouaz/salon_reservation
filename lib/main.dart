import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:salon_reservation/features/user/presentation/pages/login_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/constants/app_colors.dart';
import 'core/constants/app_keys.dart';
import 'core/constants/constants.dart';
import 'core/notification/notification_messaging.dart';
import 'core/utils/di.dart';
import 'core/utils/service_locator.dart';
import 'core/utils/shared_perefrences/shared_perefrences_helper.dart';
import 'features/home/presentation/pages/splash_page.dart';

final AppPreferences _appPreferences = instance<AppPreferences>();

class Startup {
  static Future<void> setup() async {
    await Messaging.initFCM();
    ServiceLocator.registerModels();
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  HttpOverrides.global = new MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Startup.setup();
  await Firebase.initializeApp();
  await initAppModule();


  Locale? startLocale;
  _appPreferences.setLanguage(Constants.defaultLanguage);
  startLocale = Constants.languages[Constants.defaultLanguage];
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) => runApp(EasyLocalization(
      startLocale: startLocale,
      supportedLocales: Constants.languages.values.toList(),
      fallbackLocale: const Locale('ar'),
      path: "assets/lang",
      child: const Responsive())
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void rebuildAllChildren(BuildContext context) {
    void rebuild(Element el) {
      el.markNeedsBuild();
      el.visitChildren(rebuild);
    }
    (context as Element).visitChildren(rebuild);
  }

  @override
  Widget build(BuildContext context) {
    rebuildAllChildren(context);
    return MaterialApp(
      navigatorKey: AppKeys.navigatorKey,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      title: 'Book it Beauté',
      theme: ThemeData(
          useMaterial3: true,
          appBarTheme: const AppBarTheme(surfaceTintColor: Colors.white,),
          colorScheme: const ColorScheme.highContrastLight(),
          canvasColor: Colors.white,
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
              selectedItemColor: AppColors.secondary
          )
      ),
      home: _buildHome(context),
    );
  }
}

Widget _buildHome(BuildContext context) {
  if (_appPreferences.hasAccessToken()) {
    return const SplashScreen();
  } else {
    return const LoginPage();
  }
}

class Responsive extends StatelessWidget {
  const Responsive({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(428, 1028),
      builder: (context, child) => const MyApp(),
    );
  }
}

