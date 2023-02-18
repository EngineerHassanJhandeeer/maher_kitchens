import 'dart:async';

import 'package:flutter/material.dart';
import 'package:khan_foods/Screens/Home_Screen.dart';
import 'package:khan_foods/Screens/LogIn_Screen.dart';

import 'package:shared_preferences/shared_preferences.dart';

class SplashServices {
  void login(
    BuildContext context,
  ) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    bool? check = pref.getBool('islogin');
    if (check == null) {
      Timer(Duration(seconds: 5), () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LogInPageScreen(),
            ));
      });
    } else if (check == true) {
      Timer(Duration(seconds: 3), () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HomePageScreen(),
            ));
      });
    }
  }
}
