import 'dart:async';

import 'package:Bina/ConstFiles/Locale/Lang/Arabic.dart';
import 'package:Bina/ConstFiles/Locale/Lang/Kurdish.dart';
import 'package:Bina/ConstFiles/constInitVar.dart';
import 'package:Bina/ConstFiles/routeStringVar.dart';
import 'package:Bina/Extracted/customText.dart';
import 'package:Bina/Extracted/productViewList.dart';
import 'package:Bina/Model/Classes/ThemeColor.dart';
import 'package:Bina/Model/gettingDiscounts.dart';
import 'package:Bina/Views/products.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

ScrollController _scrollController;
Discounts discountsProducts = Discounts();
List discountsProductLS = [];
Timer timer;

class DiscountedPage extends StatefulWidget {
  @override
  _DiscountedPageState createState() => _DiscountedPageState();
}

class _DiscountedPageState extends State<DiscountedPage> {
  @override
  void initState() {
    _scrollController = ScrollController();
    if (discountsProductLS.isEmpty) {
      timer = Timer.periodic(Duration(seconds: 3), (timer) {
        findDiscountProducts();
      });
    }
    findDiscountProducts();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    discountsProductLS = [];
    timer.cancel();
    super.dispose();
  }

  void findDiscountProducts() {
    discountsProducts
        .getAllDiscounts()
        .then((discount) => setState(() => discountsProductLS = discount));
  }

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);

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
                  expandedHeight: 20,
                  backgroundColor: mainBlue,
                  // It's null leading
                  flexibleSpace: ListView(
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      Column(
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              textDirection: TextDirection.rtl,
                              children: [
                                CustomText(
                                  text: themeChange.langName
                                      ? arabicLang["discountTitle"]
                                      : kurdishLang["discountTitle"],
                                  fw: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.white,
                                )
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
                color: themeChange.darkTheme ? darkBgColor : lightBgColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(34),
                  topRight: Radius.circular(34),
                ),
              ),
              // discountsProductLS[0]['products']
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 20),
                    ListView.builder(
                      shrinkWrap: true,
                      primary: false,
                      itemCount: discountsProductLS.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  textDirection: TextDirection.rtl,
                                  children: [
                                    CustomText(
                                      text: themeChange.langName
                                          ? discountsProductLS[index]["name_ar"]
                                          : discountsProductLS[index]
                                              ["name_ku"],
                                      fontSize: 18,
                                      fw: FontWeight.bold,
                                    ),
                                    CustomText(
                                      text:
                                          "${discountsProductLS[index]["code_discount"]} : کد تخفیف  ",
                                      color: Colors.grey[700],
                                      fontSize: 18,
                                      fw: FontWeight.bold,
                                    ),
                                  ],
                                ),
                                ListView.builder(
                                  shrinkWrap: true,
                                  primary: false,
                                  itemCount: discountsProductLS[index]
                                          ['products']
                                      .length,
                                  itemBuilder:
                                      (BuildContext context, int value) {
                                    var arLen = discountsProductLS[index]
                                            ['products'][value]["name_ar"]
                                        .length;
                                    var kurLen = discountsProductLS[index]
                                            ['products'][value]["name_ar"]
                                        .length;
                                    return GestureDetector(
                                      onTap: () {
                                        // print(discountsProductLS[index]
                                        //     ['products'][value]["id"]);
                                        Navigator.pushNamed(
                                          context,
                                          productViewPage,
                                          arguments: {
                                            "productId":
                                                discountsProductLS[index]
                                                    ['products'][value]["id"],
                                          },
                                        );
                                      },
                                      child: ProductViewList(
                                        themeChange: themeChange,
                                        imgNetSource: discountsProductLS[index]
                                            ['products'][value]["image"],
                                        productName: themeChange.langName
                                            ? discountsProductLS[index]
                                                        ['products'][value]
                                                    ["name_ar"]
                                                .substring(
                                                    0, arLen > 18 ? 18 : 10)
                                            : discountsProductLS[index]
                                                ['products'][value]["name_ku"],
                                        // .substring(0, kurLen),
                                        availablity: discountsProductLS[index]
                                            ['products'][value]["available"],
                                        productPrice: discountsProductLS[index]
                                            ['products'][value]["price"],
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
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
