import 'dart:async';

import 'package:Bina/ConstFiles/Locale/Lang/Arabic.dart';
import 'package:Bina/ConstFiles/Locale/Lang/Kurdish.dart';
import 'package:Bina/ConstFiles/constInitVar.dart';
import 'package:Bina/ConstFiles/routeStringVar.dart';
import 'package:Bina/Extracted/customText.dart';
import 'package:Bina/Extracted/productsCategories.dart';
import 'package:Bina/Model/Classes/ThemeColor.dart';
import 'package:Bina/Model/categories.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

ScrollController _scrollController;
final double expandedHight = 150.0;
Timer timer;

ProductCategories productCategories = ProductCategories();

List productsCategoriesLs = [];

class MoreCategories extends StatefulWidget {
  @override
  _MoreCategoriesState createState() => _MoreCategoriesState();
}

class _MoreCategoriesState extends State<MoreCategories> {
  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(() => setState(() => {}));
    timer = Timer.periodic(Duration(seconds: 10), (timer) {
      finderFunction();
    });
    finderFunction();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    timer.cancel();
    super.dispose();
  }

  void finderFunction() {
    productCategories
        .getCats()
        .then((pC) => setState(() => productsCategoriesLs = pC));
  }

  double get top {
    double res = expandedHight;
    if (_scrollController.hasClients) {
      double offset = _scrollController.offset;
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

    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight) / 4;
    final double itemWidth = size.width;

    return Scaffold(
      backgroundColor: mainBlue,
      body: Stack(
        children: [
          NestedScrollView(
            controller: _scrollController,
            headerSliverBuilder: (context, value) {
              return [
                SliverAppBar(
                  pinned: true,
                  expandedHeight: 40,
                  backgroundColor: mainBlue,
                  flexibleSpace: ListView(
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      Column(
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              textDirection: TextDirection.rtl,
                              children: [
                                CustomText(
                                  text: themeChange.langName
                                      ? arabicLang["catergories"]
                                      : kurdishLang["catergories"],
                                  fontSize: 20,
                                  fw: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ];
            },
            body: Container(
              decoration: BoxDecoration(
                color: lightBgColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(34),
                  topRight: Radius.circular(34),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 20),
                    // Ready more Categories
                    MoreCategory(
                      themeChange: themeChange,
                      productsCategoriesLs: productsCategoriesLs,
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MoreCategory extends StatelessWidget {
  const MoreCategory({
    this.productsCategoriesLs,
    @required this.themeChange,
  });

  final DarkThemeProvider themeChange;
  final List productsCategoriesLs;

  @override
  Widget build(BuildContext context) {
    final loadLottie = Lottie.asset("assets/lottie/loading.json");
    final readCategoryList = GridView.builder(
      shrinkWrap: true,
      primary: false,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        // TODO TEST IN HORIZONTAL SIZE PROBLEM
        childAspectRatio: MediaQuery.of(context).size.width /
            (MediaQuery.of(context).size.height / 1.4),
      ),
      itemBuilder: (_, index) => GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, productsPage, arguments: {
            "cateId": productsCategoriesLs[index]["id"],
            "cateName": themeChange.langName
                ? productsCategoriesLs[index]["name_ar"]
                : productsCategoriesLs[index]["name_ku"],
          });
        },
        child: Categories(
          productImg: productsCategoriesLs[index]["image"],
          productName: themeChange.langName
              ? productsCategoriesLs[index]["name_ar"]
              : productsCategoriesLs[index]["name_ku"],
        ),
      ),
      itemCount: productsCategoriesLs.length,
    );

    final getList =
        productsCategoriesLs.isEmpty ? loadLottie : readCategoryList;

    return getList;
  }
}
