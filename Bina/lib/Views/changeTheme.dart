import 'package:Bina/ConstFiles/Locale/Lang/Arabic.dart';
import 'package:Bina/ConstFiles/Locale/Lang/Kurdish.dart';
import 'package:Bina/Extracted/customText.dart';
import 'package:Bina/Model/Classes/ThemeColor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:list_tile_switch/list_tile_switch.dart';
import 'package:provider/provider.dart';

class ChangeTheme extends StatefulWidget {
  @override
  _ChangeThemeState createState() => _ChangeThemeState();
}

class _ChangeThemeState extends State<ChangeTheme> {
  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    SystemChrome.setSystemUIOverlayStyle(themeChange.darkTheme
        ? SystemUiOverlayStyle.light
        : SystemUiOverlayStyle.dark);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Icon(Icons.arrow_back_ios),
                    ),
                    CustomText(
                      text: "بازگشت",
                      fontSize: 18,
                      fw: FontWeight.w400,
                    )
                  ],
                ),
              ),
              Directionality(
                textDirection: TextDirection.rtl,
                child: ListTileSwitch(
                    value: themeChange.darkTheme,
                    onChanged: (bool value) => setState(() {
                          themeChange.darkTheme = value;
                        }),
                    title: CustomText(
                      textAlign: TextAlign.right,
                      text: themeChange.langName
                          ? arabicLang["themeChange"]
                          : kurdishLang["themeChange"],
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
