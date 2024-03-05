import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hidayah_tv_ad/locator.dart';
import 'package:hidayah_tv_ad/ui/route_navigation.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  HttpOverrides.global = MyHttpOverrides();

  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.immersiveSticky,
  );

  setupLocator();
  runApp(MaterialApp(
    builder: BotToastInit(),
    navigatorObservers: [BotToastNavigatorObserver()],
    navigatorKey: GlobalNavigationService.globalNavigatorKey,
    debugShowCheckedModeBanner: false,
    title: 'Qad powered by Hidayah Smart Solutions',
    initialRoute: RouteNavigation.splashScreen,
    onGenerateRoute: RouteNavigation.generateRoute,
  ));
}
