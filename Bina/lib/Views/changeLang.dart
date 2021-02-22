import 'package:Bina/ConstFiles/Locale/Lang/Arabic.dart';
import 'package:Bina/ConstFiles/Locale/Lang/Kurdish.dart';
import 'package:Bina/ConstFiles/constInitVar.dart';
import 'package:Bina/Extracted/customText.dart';
import 'package:Bina/Model/Classes/ThemeColor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class ChangeLang extends StatefulWidget {
  @override
  _ChangeLangState createState() => _ChangeLangState();
}

class _ChangeLangState extends State<ChangeLang> {
  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);

    SystemChrome.setSystemUIOverlayStyle(themeChange.darkTheme
        ? SystemUiOverlayStyle.light
        : SystemUiOverlayStyle.dark);

    return Scaffold(
      body: SafeArea(
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
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                textDirection: TextDirection.rtl,
                children: [
                  CustomText(
                    text: themeChange.langName
                        ? arabicLang["chooseLanguage"]
                        : kurdishLang["chooseLanguage"],
                    fontSize: bottomBtnSize,
                    fw: FontWeight.bold,
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() => themeChange.langName = false);
                    Navigator.pop(context);
                  },
                  child: Column(
                    children: [
                      Image.asset(
                        "assets/images/kurdishFlag.png",
                        width: 100,
                      ),
                      SizedBox(height: 20),
                      CustomText(
                        text: "کوردی",
                        fontSize: 20,
                        fw: FontWeight.bold,
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() => themeChange.langName = true);
                    Navigator.pop(context);
                  },
                  child: Column(
                    children: [
                      Image.asset(
                        "assets/images/iraqFlag.png",
                        width: 100,
                      ),
                      SizedBox(height: 20),
                      CustomText(
                        text: "عربی",
                        fontSize: titleTextSize,
                        fw: FontWeight.bold,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
