import 'dart:async';

import 'package:Bina/ConstFiles/Locale/Lang/Arabic.dart';
import 'package:Bina/ConstFiles/Locale/Lang/Kurdish.dart';
import 'package:Bina/ConstFiles/constInitVar.dart';
import 'package:Bina/ConstFiles/routeStringVar.dart';
import 'package:Bina/Controllers/flusher.dart';
import 'package:Bina/Extracted/customText.dart';
import 'package:Bina/Model/Classes/ThemeColor.dart';
import 'package:Bina/Model/categories.dart';
import 'package:Bina/Model/gettingDiscounts.dart';
import 'package:Bina/Model/sqflite.dart';
import 'package:Bina/Views/tabsScreens/favorite.dart';
import 'package:Bina/Views/tabsScreens/home.dart';
import 'package:Bina/Views/tabsScreens/myBasket.dart';
import 'package:Bina/Views/tabsScreens/preferences.dart';
import 'package:Bina/Views/tabsScreens/searching.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';

// SQFLITE DB CLASSES
UserBasket basket = UserBasket();
MySaved saved = MySaved();

int tabBarIndex;
var _pageController;
Timer timer;
// Classes
ProductCategories productCategories = ProductCategories();
Discounts discountsProducts = Discounts();
ProductCategories pcs = ProductCategories();

// Home page vars
List productsCategoriesLs = [];
List discountsProductLS = [];

// search page
String searchKey = "";
List searchedProduct = [];

// My Basket
List myBasketProductList = [];
List myBasketSumPrice = [];

// Saved
List mySavedProductList = [];

// for Controll of scrolling in stack page usage
ScrollController homeScrollController;
final double expandedHight = 150.0;

// Search
ScrollController _search;

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
    _search = ScrollController();
    homeScrollController.addListener(() => setState(() => {}));

    timer = Timer.periodic(Duration(seconds: 3), (timer) {
      findContent();
    });
    findContent();
    super.initState();
  }

  @override
  void dispose() {
    homeScrollController.dispose();
    searchedProduct = [];
    _search.dispose();
    timer.cancel();
    super.dispose();
  }

  void findContent() async {
    productCategories
        .getCats()
        .then((pC) => setState(() => productsCategoriesLs = pC));
    // Getting all Discounts products
    discountsProducts
        .getAllDiscounts()
        .then((discount) => setState(() => discountsProductLS = discount));
    pcs
        .searchProducts(searchKey: searchKey)
        .then((value) => setState(() => searchedProduct = value));

    // Show user Basket
    final userBasket = await basket.readMyBasket();
    setState(() => myBasketProductList = userBasket);

    // Get all price
    final gettingSumPrice = await basket.getSumOfProductPrice();
    setState(() => myBasketSumPrice = gettingSumPrice);

    // Show user Saved Products
    final userSaved = await saved.readMySaved();
    setState(() => mySavedProductList = userSaved);
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

    // print("This is DISCOUNTS ${discountsProductLS[0]["name_ar"]}");

    // print(myBasketProductList[2]["price"]);

    print(myBasketSumPrice);

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
              productCategoriesList: productsCategoriesLs,
              // discountsProduct:
              //     discountsProductLS.isEmpty ? [] : discountsProductLS,
              onSearchSumbitKey: (String searchCase) {
                if (searchCase.length != 0)
                  Navigator.pushNamed(context, searchResultPage, arguments: {
                    "currentLang": themeChange.langName,
                    "searchKey": searchCase,
                  });
                else if (searchCase == "")
                  showStatusInCaseOfFlush(
                      context: context,
                      msg: "نمیتوان خالی جست و جو کرد",
                      title: "",
                      icon: Icon(Icons.text_fields),
                      iconColor: Colors.orange);
              },
            ),
            Search(
                themeChange: themeChange,
                scrollController: _search,
                searchResult: searchedProduct,
                // When Click to submit search key
                onSearchSubmision: (String searchCase) {
                  setState(() {
                    searchedProduct = [];
                    searchKey = searchCase;
                  });
                }),
            MyBasket(
              themeChange: themeChange,
              scrollController: _search,
              productInBascket: myBasketProductList,
              sumPrice:
                  myBasketSumPrice.isNotEmpty ? myBasketSumPrice[0]['sum'] : "",
            ),
            Saved(
              themeChange: themeChange,
              scrollController: _search,
              userDidSave: mySavedProductList,
            ),
            Preferences(themeChange: themeChange, scrollController: _search),
          ],
        ),
        bottomNavigationBar: Directionality(
          textDirection: TextDirection.rtl,
          child: Container(
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(.1))
            ]),
            child: SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
                child: GNav(
                  rippleColor: Colors.blue,
                  hoverColor: Colors.blue[800],
                  gap: 10,
                  activeColor: Colors.white,
                  iconSize: 20,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  duration: Duration(milliseconds: 400),
                  textStyle: TextStyle(
                    fontSize: 9,
                    fontFamily: mainFont,
                    color: Colors.white,
                  ),
                  tabBackgroundColor: activeColor,
                  tabs: [
                    GButton(
                      icon: Icons.home_filled,
                      text: themeChange.langName
                          ? arabicLang["home"]
                          : kurdishLang["home"],
                    ),
                    GButton(
                      icon: Icons.search,
                      text: themeChange.langName
                          ? arabicLang["search"]
                          : kurdishLang["search"],
                    ),
                    GButton(
                      icon: Icons.shopping_cart_outlined,
                      text: themeChange.langName
                          ? arabicLang["search"]
                          : kurdishLang["search"],
                    ),
                    GButton(
                      icon: Icons.turned_in_not,
                      text: themeChange.langName
                          ? arabicLang["saved"]
                          : kurdishLang["saved"],
                    ),
                    GButton(
                      icon: Icons.account_circle_outlined,
                      text: themeChange.langName
                          ? arabicLang["profile"]
                          : kurdishLang["profile"],
                    ),
                  ],
                  selectedIndex: tabBarIndex,
                  onTabChange: (indexValue) {
                    setState(() {
                      tabBarIndex = indexValue;
                      _pageController.animateToPage(tabBarIndex,
                          duration: Duration(milliseconds: 3),
                          curve: Curves.ease);
                      // print(tabBarIndex);
                    });
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
