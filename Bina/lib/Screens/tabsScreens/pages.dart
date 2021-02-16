import 'package:Bina/ConstFiles/constInitVar.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:Bina/Extracted/customText.dart';
import 'package:Bina/ConstFiles/Locale/Lang/Arabic.dart';
import 'package:Bina/ConstFiles/Locale/Lang/kurdish.dart';

class WelcomeToMarket extends StatelessWidget {
  const WelcomeToMarket({this.themeChange, this.line1, this.line2, this.line3});

  final bool themeChange;
  final line1;
  final line2;
  final line3;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              "assets/images/temporary.png",
              width: double.infinity,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
              child: CustomText(
                text: themeChange
                    ? arabicLang["welcome"]
                    : kurdishLang["welcome"],
                color: Colors.black,
                fontSize: 25,
                fw: FontWeight.bold,
              ),
            ),
            SizedBox(height: 60),
            BottomStatusLines(
                line1AciveColor: line1,
                line2AciveColor: line2,
                line3AciveColor: line3)
          ],
        ),
      ),
    );
  }
}

class ChooseLang extends StatelessWidget {
  const ChooseLang(
      {this.themeChange,
      this.line1,
      this.line2,
      this.line3,
      this.kurdishPressed,
      this.arabicPressed});

  final themeChange;

  final line1;
  final line2;
  final line3;
  final Function kurdishPressed;
  final Function arabicPressed;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              "assets/images/temporary.png",
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 30),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: CustomText(
                text: themeChange
                    ? arabicLang["chooseLanguage"]
                    : kurdishLang["chooseLanguage"],
                color: Colors.black,
                fontSize: 30,
                // fw: FontWeight.bold,
              ),
            ),
            SizedBox(height: 60),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: kurdishPressed,
                  child: Column(
                    children: [
                      Image.asset(
                        "assets/images/kurdishFlag.png",
                        width: 100,
                      ),
                      SizedBox(height: 20),
                      CustomText(
                        text: "کوردی",
                        color: Colors.black,
                        fontSize: 20,
                        fw: FontWeight.bold,
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: arabicPressed,
                  child: Column(
                    children: [
                      Image.asset(
                        "assets/images/iraqFlag.png",
                        width: 100,
                      ),
                      SizedBox(height: 20),
                      CustomText(
                        text: "عربی",
                        color: Colors.black,
                        fontSize: 20,
                        fw: FontWeight.bold,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),
            BottomStatusLines(
                line1AciveColor: line1,
                line2AciveColor: line2,
                line3AciveColor: line3)
          ],
        ),
      ),
    );
  }
}

class ReadyToSign extends StatelessWidget {
  const ReadyToSign({this.line1, this.line2, this.line3, this.themeChange});

  final themeChange;
  final line1;
  final line2;
  final line3;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              "assets/images/readyToLogin.png",
              width: 250,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: CustomText(
                text: themeChange
                    ? arabicLang["accountEntry"]
                    : kurdishLang["accountEntry"],
                color: Colors.black,
                fontSize: 30,
                // fw: FontWeight.bold,
              ),
            ),
            MaterialButton(
              onPressed: () {},
              color: actionCt,
              child: CustomText(
                text:
                    themeChange ? arabicLang["signup"] : kurdishLang["signup"],
                color: Colors.white,
                fontSize: 15,
              ),
            ),
            MaterialButton(
              onPressed: () {},
              color: actionCt,
              child: CustomText(
                text: themeChange
                    ? arabicLang["loginNow"]
                    : kurdishLang["loginNow"],
                color: Colors.white,
                fontSize: 15,
              ),
            ),
            SizedBox(height: 10),
            BottomStatusLines(
                line1AciveColor: line1,
                line2AciveColor: line2,
                line3AciveColor: line3)
          ],
        ),
      ),
    );
  }
}

class BottomStatusLines extends StatelessWidget {
  const BottomStatusLines({
    Key key,
    @required this.line1AciveColor,
    @required this.line2AciveColor,
    @required this.line3AciveColor,
  }) : super(key: key);

  final HexColor line1AciveColor;
  final HexColor line2AciveColor;
  final HexColor line3AciveColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.minimize,
            color: line1AciveColor,
            size: 40,
          ),
          Icon(
            Icons.minimize,
            color: line2AciveColor,
            size: 40,
          ),
          Icon(
            Icons.minimize,
            color: line3AciveColor,
            size: 40,
          ),
        ],
      ),
    );
  }
}
