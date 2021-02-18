import 'package:Bina/Extracted/customText.dart';
import 'package:Bina/Extracted/productsCategories.dart';
import 'package:Bina/Model/Classes/ThemeColor.dart';
import 'package:flutter/material.dart';
import 'package:Bina/ConstFiles/constInitVar.dart';
import 'package:Bina/ConstFiles/Locale/Lang/Arabic.dart';
import 'package:Bina/ConstFiles/Locale/Lang/Kurdish.dart';
import 'dart:math';

class HomeShopping extends StatelessWidget {
  const HomeShopping(
      {@required this.productCategoriesList,
      @required this.themeChange,
      this.homeScroller,
      this.exhight});

  final DarkThemeProvider themeChange;
  final ScrollController homeScroller;
  final productCategoriesList;
  final exhight;

  @override
  Widget build(BuildContext context) {
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
                            onSubmitted: (String searchCase) =>
                                print(searchCase),
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
                    // Best Suggestion
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

    final productCate = ListView.builder(
      itemCount: categoryLen,
      scrollDirection: Axis.horizontal,
      itemBuilder: (_, int index) => Categories(
        productImg: pcl[index]["image"],
        productName: themeChange.langName
            ? pcl[index]["name_ar"]
            : pcl[index]["name_ku"],
      ),
    );

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
                  onPressed: () => print("Naivgated to more category loader"),
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
          SizedBox(height: 150, child: productCate)
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
