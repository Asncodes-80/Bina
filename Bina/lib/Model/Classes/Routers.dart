import 'package:Bina/ConstFiles/routeStringVar.dart';
import 'package:flutter/material.dart';

// Screens
import 'package:Bina/Screens/splashScreen.dart';
import 'package:Bina/Screens/WelcomeIntroPage.dart';
import 'package:Bina/Screens/maino.dart';
import 'package:Bina/Screens/login.dart';
import 'package:Bina/Screens/signup.dart';

class AppRouters {
  static Route<dynamic> allRouters(RouteSettings settings) {
    switch (settings.name) {
      case splashScreen:
        return MaterialPageRoute(builder: (_) => SplashScreen());
        break;
      case welcomeIntroPage:
        return MaterialPageRoute(builder: (_) => WelcomeIntroPage());
        break;
      case maino:
        return MaterialPageRoute(builder: (_) => Maino());
        break;

      case signup:
        return MaterialPageRoute(builder: (_) => Signup());
        break;

      case login:
        return MaterialPageRoute(builder: (_) => Login());
        break;
    }
  }
}
