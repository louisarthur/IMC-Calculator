import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:imccalculator/routes/routes.dart';
import 'package:imccalculator/util/theme.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  runApp(MaterialApp(
    theme: ThemeCustom().theme,
    debugShowCheckedModeBanner: false,
    routes: Routes().appRoutes,
    initialRoute: RoutesUtils.splash,
  ));
}
