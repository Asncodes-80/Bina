import 'package:Bina/Model/Classes/LangStatus.dart';
import 'package:Bina/Model/Classes/ThemeColor.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);

    return Scaffold(
      backgroundColor: HexColor("#28AE61"),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text("Salam"),
            ],
          ),
        ),
      ),
    );
  }
}
