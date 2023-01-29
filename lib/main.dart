// ignore_for_file: avoid_print

import 'dart:convert'; // For jsonDecode

import 'package:app_port_cap/app/controllers/index.dart';
import 'package:app_port_cap/app/resources/resources.dart';
import 'package:app_port_cap/app/system/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For rootBundle
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:json_theme/json_theme.dart';

import 'app/auxiliary/auxiliary.dart';
import 'app/views/views.dart';
import 'app/widgets/index.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseFirestore.instance.settings = const Settings(
      persistenceEnabled: false,
      sslEnabled: false,
      cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED);
  // FirebaseFirestore.instance.disableNetwork();

  if (!kIsWeb) {
    FlutterError.onError = (errorDetails) {
      FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
    };
    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };
  }
  await FirebaseAppCheck.instance.activate(
    webRecaptchaSiteKey: 'recaptcha-v3-site-key',
  );
  await GetStorage.init();
  await init();
  await writeDeviceId();
  final themeStr =
      await rootBundle.loadString('assets/themes/appainter_theme.json');
  final themeJson = jsonDecode(themeStr);
  final theme = ThemeDecoder.decodeThemeData(themeJson)!;

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((_) {
    runApp(MyApp(theme: theme));
  });
}

Future<void> init() async {
  // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);

  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: GlobalColors.transparent));
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
  Get.put<AuthController>(AuthController());
  Get.put<LanguageController>(LanguageController());
}

Future<void> writeDeviceId() async {
  final datastore = GetStorage();
  String devId = Globals.getDeviceId().toString();
  if (datastore.read('deviceId') != null) {
    devId = datastore.read('deviceId');
  } else {
    datastore.write("deviceId", devId);
  }
}

class MyApp extends StatelessWidget {
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);
  final ThemeData theme;

  const MyApp({Key? key, required this.theme}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ThemeController.to.getThemeModeFromStore();

    return ConnectivityAppWrapper(
      app: GetBuilder<LanguageController>(
        builder: (languageController) => Loading(
          child: GetMaterialApp(
              debugShowCheckedModeBanner: false,
              translations: LocaleString(),
              locale: languageController.getLocale,
              navigatorObservers: [observer],
              defaultTransition: Transition.fade,
              title: 'TTC Network Capacity',
              theme: theme,
              unknownRoute: GetPage(name: '/', page: () => const SplashUI()),
              initialRoute: "/",
              getPages: AppRoutes.routes),
        ),
      ),
    );
  }
}
