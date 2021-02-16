import 'package:Bina/ConstFiles/routeStringVar.dart';
import 'package:flutter/material.dart';

// Screens
import 'package:Bina/Screens/splashScreen.dart';
import 'package:Bina/Screens/WelcomeIntroPage.dart';
import 'package:Bina/Screens/maino.dart';

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
    }
  }
}
