import 'package:Bina/ConstFiles/Locale/Lang/Arabic.dart';
import 'package:Bina/ConstFiles/Locale/Lang/kurdish.dart';
import 'package:Bina/ConstFiles/constInitVar.dart';
import 'package:Bina/ConstFiles/routeStringVar.dart';
import 'package:Bina/Extracted/bottomBtn.dart';
import 'package:Bina/Model/Classes/ThemeColor.dart';
import 'package:Bina/Model/sqflite.dart';
import 'package:Bina/Views/welcomePageViews/pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';

// SQFLITE DB CLASSES
UserBasket basket = UserBasket();
MySaved saved = MySaved();

int pageIndex;
var _pageContoller = PageController();

class WelcomeIntroPage extends StatefulWidget {
  @override
  _WelcomeIntroPageState createState() => _WelcomeIntroPageState();
}

class _WelcomeIntroPageState extends State<WelcomeIntroPage> {
  @override
  void initState() {
    pageIndex = 0;
    _pageContoller = PageController();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);

    // Specify button next in Arabic and Kurdish
    final submissionBtnText =
        themeChange.langName ? arabicLang["next"] : kurdishLang["next"];
    // Specify entery in Main Market page
    final goToMarket = themeChange.langName
        ? arabicLang["signinLater"]
        : kurdishLang["signinLater"];
    // User can enter in specific function
    final textInNavigatorBtn = pageIndex == 2 ? goToMarket : submissionBtnText;

    return WillPopScope(
      onWillPop: () {
        if (pageIndex <= 2 && pageIndex > 0) {
          _pageContoller.animateToPage(pageIndex -= 1,
              duration: Duration(milliseconds: 600), curve: Curves.decelerate);
        } else if (pageIndex == 0) {
          SystemChannels.platform.invokeMethod('SystemNavigator.pop');
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: PageView(
            physics: NeverScrollableScrollPhysics(),
            controller: _pageContoller,
            onPageChanged: (index) {
              setState(() {
                pageIndex = index;
              });
            },
            children: [
              ChooseLang(
                themeChange: themeChange.langName,
                arabicPressed: () {
                  print("Arabic");
                  setState(() {
                    themeChange.langName = true;
                  });
                },
                kurdishPressed: () {
                  print("Kurdish");
                  setState(() {
                    themeChange.langName = false;
                  });
                },
              ),
              WelcomeToMarket(
                themeChange: themeChange.langName,
              ),
              ReadyToSign(
                themeChange: themeChange.langName,
                signupPressed: () => Navigator.pushNamed(context, signup),
                loginPressed: () => Navigator.pushNamed(context, login),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomButton(
          text: textInNavigatorBtn,
          color: actionCt,
          onTapped: () {
            pageIndex == 2 ? navigatedToMarket() : nextPageNavigator();
          },
        ),
      ),
    );
  }

  void nextPageNavigator() {
    setState(() {
      pageIndex += 1;
    });
    _pageContoller.animateToPage(pageIndex,
        duration: Duration(milliseconds: 600), curve: Curves.decelerate);
  }

  void navigatedToMarket() async {
    // Set new value in firstVisit (key) of flutter secure storage
    final lSorage = FlutterSecureStorage();
    await lSorage.write(key: "firstVisit", value: "ACTIVE");

    // Create New Table SQL base for user in saving products
    basket.createBasket();
    saved.createSaved();

    Navigator.pushNamed(context, maino);
  }
}
