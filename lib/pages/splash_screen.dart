import 'package:flutter/material.dart';
import 'package:imccalculator/pages/login_screen.dart';
import 'package:imccalculator/pages/main_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splashscreen/splashscreen.dart';

class SplashScreenCustom extends StatefulWidget {
  @override
  _SplashScreenCustomState createState() => _SplashScreenCustomState();
}

class _SplashScreenCustomState extends State<SplashScreenCustom> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  bool hasCredentials = false;
  bool sex;
  String name;

  @override
  void initState() {
    verifyCredentials();
    super.initState();
  }

  Future<void> verifyCredentials() async {
    final SharedPreferences prefs = await _prefs;
    String credentials = prefs.getString('credentials');
    bool gender = prefs.getBool('sex');

    setState(() {
      if (credentials != null && gender != null) {
        hasCredentials = true;
        sex = gender;
        name = credentials;
      } else {
        hasCredentials = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    print(hasCredentials);
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        SplashScreen(
          seconds: 5,
          navigateAfterSeconds: hasCredentials
              ? MainScreen(userName: name, sex: sex)
              : LoginScreen(),
          useLoader: false,
          backgroundColor: Color(0xFF0000000),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'images/splash.png',
            ),
          ],
        )
      ],
    );
  }
}
