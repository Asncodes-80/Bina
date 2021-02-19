import 'package:Bina/ConstFiles/routeStringVar.dart';
import 'package:Bina/Extracted/customText.dart';
import 'package:Bina/Extracted/productsCategories.dart';
import 'package:Bina/Model/Classes/ThemeColor.dart';
import 'package:flutter/material.dart';
import 'package:Bina/ConstFiles/constInitVar.dart';
import 'package:Bina/ConstFiles/Locale/Lang/Arabic.dart';
import 'package:Bina/ConstFiles/Locale/Lang/Kurdish.dart';

import 'package:lottie/lottie.dart';

class HomeShopping extends StatelessWidget {
  const HomeShopping(
      {@required this.productCategoriesList,
      @required this.themeChange,
      this.homeScroller,
      this.exhight,
      this.onSearchSumbitKey});

  final DarkThemeProvider themeChange;
  final ScrollController homeScroller;
  final productCategoriesList;
  final exhight;
  final onSearchSumbitKey;

  @override
  Widget build(BuildContext context) {
    // print("This is DISCOUNTS ${discountsProduct[0]["products"]}");

    return SafeArea(
      child: Stack(
        children: [
          NestedScrollView(
            controller: homeScroller,
            headerSliverBuilder: (context, value) {
              return [
                SliverAppBar(
                  pinned: true,
                  expandedHeight: exhight,
                  backgroundColor: mainBlue,
                  leading: Container(
                    margin: EdgeInsets.all(10),
                    child: ClipOval(
                      child: Material(
                        color: Colors.blue, // button color
                        child: InkWell(
                          splashColor: Colors.blue[300], // inkwell color
                          child: SizedBox(
                              width: 40,
                              height: 40,
                              child: Image.asset(
                                  "assets/images/isgpp_avatar_placeholder.png")),
                          onTap: () => print("sds"),
                        ),
                      ),
                    ),
                  ),
                  flexibleSpace: ListView(
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      Column(
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              textDirection: TextDirection.rtl,
                              children: [
                                CustomText(
                                  text: themeChange.langName
                                      ? "😊 ${arabicLang["welcomeTitle"]}"
                                      : kurdishLang["welcomeTitle"],
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              textDirection: TextDirection.rtl,
                              children: [
                                CustomText(
                                  text: themeChange.langName
                                      ? arabicLang["welcomeSubTitle"]
                                      : kurdishLang["welcomeSubTitle"],
                                  fontSize: 18,
                                  color: Colors.white,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: TextField(
                            // TODO (Sreach Case will go to searching page)
                            onSubmitted: onSearchSumbitKey,
                            decoration: InputDecoration(
                              hintStyle: TextStyle(fontSize: 17),
                              hintText: themeChange.langName
                                  ? arabicLang["searchBar"]
                                  : kurdishLang["searchBar"],
                              suffixIcon: Icon(Icons.search),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.all(16),
                            ),
                          ),
                        ),
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
                    // Ready Categories or more...
                    ReadyProductsCategory(
                        themeChange: themeChange, pcl: productCategoriesList),
                    Container(
                      width: double.infinity,
                      height: 177,
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.6),
                            spreadRadius: 2,
                            blurRadius: 7,
                            offset: Offset(0, 1), // changes position of shadow
                          ),
                        ],
                        image: DecorationImage(
                          image: AssetImage("assets/images/neonDiscount.jpg"),
                          colorFilter: new ColorFilter.mode(
                              Colors.black.withOpacity(0.3), BlendMode.srcOver),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: FlatButton(
                        onPressed: () =>
                            Navigator.pushNamed(context, discountPage),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 5),
                              child: Row(
                                textDirection: TextDirection.rtl,
                                children: [
                                  CustomText(
                                    text: themeChange.langName
                                        ? arabicLang["discountTitle"]
                                        : kurdishLang["discountTitle"],
                                    color: Colors.white,
                                    fontSize: 30,
                                    fw: FontWeight.bold,
                                  ),
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
                                        ? arabicLang["discountSubtitle"]
                                        : kurdishLang["discountSubtitle"],
                                    color: Colors.white,
                                    fontSize: 30,
                                    fw: FontWeight.bold,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
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

class ReadyProductsCategory extends StatelessWidget {
  const ReadyProductsCategory({
    this.pcl,
    @required this.themeChange,
  });

  final DarkThemeProvider themeChange;
  final List pcl;

  @override
  Widget build(BuildContext context) {
    final finalPCLLength = pcl.length > 6 ? pcl.length / 2 : pcl.length;
    final int categoryLen = (finalPCLLength.round());

    final loadCategory = ListView.builder(
      itemCount: categoryLen,
      scrollDirection: Axis.horizontal,
      itemBuilder: (_, int index) => GestureDetector(
        onTap: () => Navigator.pushNamed(context, productsPage, arguments: {
          "cateId": pcl[index]["id"],
          "cateName": themeChange.langName
              ? pcl[index]["name_ar"]
              : pcl[index]["name_ku"]
        }),
        child: Categories(
          productImg: pcl[index]["image"],
          productName: themeChange.langName
              ? pcl[index]["name_ar"]
              : pcl[index]["name_ku"],
        ),
      ),
    );

    final takeLottieLoading = Lottie.asset("assets/lottie/loading.json");

    final productCate = pcl.isEmpty ? takeLottieLoading : loadCategory;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      width: double.infinity,
      height: 265,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(34),
      ),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              textDirection: TextDirection.rtl,
              children: [
                CustomText(
                  text: themeChange.langName
                      ? arabicLang["catergories"]
                      : kurdishLang["catergories"],
                  fw: FontWeight.bold,
                  fontSize: 18,
                ),
                FlatButton(
                  minWidth: 10,
                  onPressed: () =>
                      Navigator.pushNamed(context, moreCategoriesPage),
                  child: CustomText(
                    text: themeChange.langName
                        ? arabicLang["moreCategory"]
                        : kurdishLang["moreCategory"],
                    color: actionCt,
                    fw: FontWeight.bold,
                    fontSize: 18,
                  ),
                )
              ],
            ),
          ),
          CustomDivider(),
          SizedBox(height: 10),
          Container(
            margin: EdgeInsets.only(left: 15),
            child: SizedBox(
              height: 150,
              child: productCate,
            ),
          )
        ],
      ),
    );
  }
}

class CustomDivider extends StatelessWidget {
  // const CustomDivider({
  // });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Divider(
        height: 10,
        thickness: 1,
      ),
    );
  }
}
