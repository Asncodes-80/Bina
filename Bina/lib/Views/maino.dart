import 'package:Bina/ConstFiles/Locale/Lang/Arabic.dart';
import 'package:Bina/ConstFiles/Locale/Lang/Kurdish.dart';
import 'package:Bina/ConstFiles/constInitVar.dart';
import 'package:Bina/Extracted/customText.dart';
import 'package:Bina/Model/Classes/ThemeColor.dart';
import 'package:Bina/Model/categories.dart';
import 'package:Bina/Views/tabsScreens/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

int tabBarIndex;
var _pageController;
ProductCategories productCategories = ProductCategories();

// Home page vars
List productsCategoriesLs = [];

// for Controll of scrolling in stack page usage
ScrollController homeScrollController;
final double expandedHight = 150.0;

class Maino extends StatefulWidget {
  @override
  _MainoState createState() => _MainoState();
}

class _MainoState extends State<Maino> {
  @override
  void initState() {
    tabBarIndex = 0;
    _pageController = PageController();
    homeScrollController = ScrollController();
    homeScrollController.addListener(() => setState(() => {}));

    productCategories
        .getCats()
        .then((pC) => setState(() => productsCategoriesLs = pC));

    super.initState();
  }

  @override
  void dispose() {
    homeScrollController.dispose();
    super.dispose();
  }

  // For all Scroller Stack
  double get top {
    double res = expandedHight;
    if (homeScrollController.hasClients) {
      double offset = homeScrollController.offset;
      if (offset < (res - kToolbarHeight)) {
        res -= offset;
      } else {
        res = kToolbarHeight;
      }
    }
    return res;
  }

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);

    return WillPopScope(
      onWillPop: () =>
          SystemChannels.platform.invokeMethod('SystemNavigator.pop'),
      child: Scaffold(
        backgroundColor: mainBlue,
        body: PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: _pageController,
          onPageChanged: (index) => setState(() => tabBarIndex = index),
          children: [
            HomeShopping(
                themeChange: themeChange,
                homeScroller: homeScrollController,
                exhight: expandedHight,
                productCategoriesList: productsCategoriesLs),
            Container(
              child: CustomText(
                  text: themeChange.langName
                      ? arabicLang["search"]
                      : kurdishLang["search"]),
            ),
            Container(
              child: Text(""),
            ),
            Container(
              child: CustomText(
                  text: themeChange.langName
                      ? arabicLang["saved"]
                      : kurdishLang["saved"]),
            ),
            Container(
              child: CustomText(
                  text: themeChange.langName
                      ? arabicLang["profile"]
                      : kurdishLang["profile"]),
            ),
          ],
        ),
        bottomNavigationBar: ClipRRect(
          borderRadius: BorderRadius.only(
              // topLeft: Radius.circular(30),
              // topRight: Radius.circular(30),
              ),
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              backgroundColor: mainBlue,
              selectedItemColor: Colors.black,
              unselectedItemColor: HexColor('#FFFFFF'),
              selectedIconTheme: IconThemeData(color: Colors.black),
              iconSize: 25,
              unselectedIconTheme: IconThemeData(size: 23),
              selectedFontSize: 14,
              unselectedFontSize: 14,
              currentIndex: tabBarIndex,
              onTap: (indexValue) {
                setState(() {
                  tabBarIndex = indexValue;
                  _pageController.animateToPage(tabBarIndex,
                      duration: Duration(milliseconds: 3), curve: Curves.ease);
                  // print(tabBarIndex);
                });
              },
              items: [
                BottomNavigationBarItem(
                  title: CustomText(
                      text: themeChange.langName
                          ? arabicLang["home"]
                          : kurdishLang["home"]),
                  icon: Icon(
                    Icons.home_filled,
                  ),
                ),
                BottomNavigationBarItem(
                  title: CustomText(
                      text: themeChange.langName
                          ? arabicLang["search"]
                          : kurdishLang["search"]),
                  icon: Icon(
                    Icons.search,
                  ),
                ),
                BottomNavigationBarItem(
                  title: Container(
                    child: Text(""),
                  ),
                  icon: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 30,
                    child: Icon(
                      Icons.shopping_cart_outlined,
                      // color: Colors.white,
                    ),
                  ),
                ),
                BottomNavigationBarItem(
                  title: CustomText(
                      text: themeChange.langName
                          ? arabicLang["saved"]
                          : kurdishLang["saved"]),
                  icon: Icon(Icons.turned_in_not),
                ),
                BottomNavigationBarItem(
                  title: CustomText(
                      text: themeChange.langName
                          ? arabicLang["profile"]
                          : kurdishLang["profile"]),
                  icon: Icon(Icons.account_circle_outlined),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
