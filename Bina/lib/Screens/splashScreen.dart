import 'dart:async';
import 'package:Bina/ConstFiles/constInitVar.dart';
import 'package:Bina/ConstFiles/routeStringVar.dart';
import 'package:Bina/Model/Classes/ThemeColor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);

    return Scaffold(
        backgroundColor: mainBlue,
        body: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Bina",
                style: TextStyle(
                  fontFamily: mainFont,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Icon(
                Icons.shopping_cart,
                color: Colors.white,
                size: 37,
              )
            ],
          ),
        ));
  }

  void startTimer() {
    Timer(Duration(milliseconds: 600), () {
      navigatedToShop();
    });
  }

  void navigatedToShop() async {
    final lSorage = FlutterSecureStorage();
    final firstVisit = await lSorage.read(key: "firstVisit");
    firstVisit != null
        ? Navigator.pushNamed(context, maino)
        : Navigator.pushNamed(context, welcomeIntroPage);
  }
}
