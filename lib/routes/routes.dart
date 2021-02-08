import 'package:flutter/material.dart';
import 'package:imccalculator/pages/main_screen.dart';
import 'package:imccalculator/pages/splash_screen.dart';

class Routes {
  final Map<String, Widget Function(BuildContext)> appRoutes =
      <String, Widget Function(BuildContext)>{
    RoutesUtils.splash: (_) => SplashScreenCustom(),

    // RoutesUtils.login: (_) => LoginScreen(),
    // RoutesUtils.statistic: (_) => LoginWebview(),
    RoutesUtils.home: (_) => MainScreen(),
  };
}

class RoutesUtils {
  static const String login = '/login';
  static const String splash = '/splash';
  static const String home = '/home';
  static const String statistic = '/statistics';
}
