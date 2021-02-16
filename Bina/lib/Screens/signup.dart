import 'package:Bina/ConstFiles/Locale/Lang/arabic.dart';
import 'package:Bina/ConstFiles/Locale/Lang/kurdish.dart';
import 'package:Bina/ConstFiles/constInitVar.dart';
import 'package:Bina/Controllers/gettingProvinces.dart';
import 'package:Bina/Extracted/bottomBtn.dart';
import 'package:Bina/Extracted/customText.dart';
import 'package:Bina/Model/Classes/ThemeColor.dart';
import 'package:Bina/Screens/signupPageViews/level1.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

int pageIndex;
var _pageContoller = PageController();

// Level 1 var

String fullname;
List provinceLs = [];

GettingProvincesList getProvinces = GettingProvincesList();

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  @override
  void initState() {
    pageIndex = 0;
    _pageContoller = PageController();

    getProvinces.getProvinces().then((provincesLs) {
      setState(() {
        provinceLs = provincesLs;
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);

    // print(provinceLs[0]["name_ar"]);

    // Specify button next in Arabic and Kurdish
    final submissionBtnText =
        themeChange.langName ? arabicLang["next"] : kurdishLang["next"];
    // Specify entery in Main Market page
    final goToMarket = themeChange.langName
        ? arabicLang["signinLater"]
        : kurdishLang["signinLater"];
    // User can enter in specific function
    final textInNavigatorBtn = pageIndex == 3 ? goToMarket : submissionBtnText;

    return WillPopScope(
      onWillPop: () {
        if (pageIndex <= 3 && pageIndex > 0) {
          _pageContoller.animateToPage(pageIndex -= 1,
              duration: Duration(milliseconds: 600), curve: Curves.decelerate);
        } else if (pageIndex == 0) {
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: PageView(
            controller: _pageContoller,
            onPageChanged: (index) {
              setState(() {
                pageIndex = index;
              });
            },
            children: [
              InfoLevel1(
                darkTheme: themeChange.darkTheme,
                langName: themeChange.langName,
                provinces: provinceLs,
                onChangeFullname: (onChangeUsername) {
                  setState(() {
                    // emptyTextFieldErrPersonalCode = null;
                    fullname = onChangeUsername;
                  });
                },
              ),
              Container(
                child: Text("Phone Number"),
              ),
              Container(
                child: Text("Password"),
              ),
              Container(
                child: Text("Location"),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomButton(
          onTapped: () =>
              pageIndex == 3 ? navigatedToMarket() : nextPageNavigator(),
          color: actionCt,
          text: textInNavigatorBtn,
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
