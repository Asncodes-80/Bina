import 'package:Bina/ConstFiles/Locale/Lang/Arabic.dart';
import 'package:Bina/ConstFiles/Locale/Lang/kurdish.dart';
import 'package:Bina/ConstFiles/constInitVar.dart';
import 'package:Bina/ConstFiles/routeStringVar.dart';
import 'package:Bina/Extracted/bottomBtn.dart';
import 'package:Bina/Model/Classes/ThemeColor.dart';
import 'package:Bina/Screens/tabsScreens/pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

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

    var line1AciveColor = pageIndex == 0 ? activeColor : notActiveColor;
    var line2AciveColor = pageIndex == 1 ? activeColor : notActiveColor;
    var line3AciveColor = pageIndex == 2 ? activeColor : notActiveColor;

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
              WelcomeToMarket(
                themeChange: themeChange.langName,
                line1: line1AciveColor,
                line2: line2AciveColor,
                line3: line3AciveColor,
              ),
              ChooseLang(
                themeChange: themeChange.langName,
                line1: line1AciveColor,
                line2: line2AciveColor,
                line3: line3AciveColor,
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
              ReadyToSign(
                themeChange: themeChange.langName,
                line1: line1AciveColor,
                line2: line2AciveColor,
                line3: line3AciveColor,
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

  void navigatedToMarket() {
    // Set new value in firstVisit (key) of flutter secure storage

    // Create New Table SQL base for user in saving products

    // Navigator.pushNamed(context, maino);
  }
}
