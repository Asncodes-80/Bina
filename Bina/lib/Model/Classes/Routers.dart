import 'package:Bina/ConstFiles/routeStringVar.dart';
import 'package:flutter/material.dart';

// Screens
import 'package:Bina/Screens/splashScreen.dart';

class AppRouters {
  static Route<dynamic> allRouters(RouteSettings settings) {
    switch (settings.name) {
      case splashScreen:
        return MaterialPageRoute(builder: (_) => SplashScreen());
    }
  }
}
