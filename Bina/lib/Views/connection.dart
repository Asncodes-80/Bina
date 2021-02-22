import 'package:Bina/ConstFiles/constInitVar.dart';
import 'package:Bina/Extracted/customText.dart';
import 'package:Bina/Model/Classes/ThemeColor.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class ConnectionPage extends StatefulWidget {
  @override
  _ConnectionPageState createState() => _ConnectionPageState();
}

class _ConnectionPageState extends State<ConnectionPage> {
  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);

    return Scaffold(
        backgroundColor: themeChange.darkTheme ? darkBgColor : Colors.white,
        body: SafeArea(
            child: Center(
          child: Column(
            children: [
              Lottie.asset("assets/lottie/connectionLost.json"),
              CustomText(
                text: "Connection Failed",
              )
            ],
          ),
        )));
  }
}
