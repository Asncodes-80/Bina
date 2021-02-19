import 'dart:async';

import 'package:Bina/ConstFiles/Locale/Lang/Arabic.dart';
import 'package:Bina/ConstFiles/Locale/Lang/Kurdish.dart';
import 'package:Bina/ConstFiles/constInitVar.dart';
import 'package:Bina/Extracted/customText.dart';
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

    // print(discountsProductLS[0]['products'][0]["name_ar"]);

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
                color: lightBgColor,
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
                                    return DiscountProductsView(
                                      themeChange: themeChange,
                                      imgNetSource: discountsProductLS[index]
                                          ['products'][value]["image"],
                                      productName: themeChange.langName
                                          ? discountsProductLS[index]
                                                  ['products'][value]["name_ar"]
                                              .substring(0, 25)
                                          : discountsProductLS[index]
                                                  ['products'][value]["name_ku"]
                                              .substring(0, 25),
                                      availablity: discountsProductLS[index]
                                          ['products'][value]["available"],
                                      productPrice: discountsProductLS[index]
                                          ['products'][value]["price"],
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

class DiscountProductsView extends StatelessWidget {
  const DiscountProductsView({
    this.imgNetSource,
    this.productName,
    this.availablity,
    this.productPrice,
    @required this.themeChange,
  });

  final DarkThemeProvider themeChange;
  final String imgNetSource;
  final String productName;
  final bool availablity;
  final productPrice;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
      width: double.infinity,
      height: 122,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(15)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            textDirection: TextDirection.rtl,
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                child: Image.network(
                  imgNetSource,
                  fit: BoxFit.cover,
                  width: 74,
                  height: 74,
                ),
              ),
              Column(
                children: [
                  CustomText(
                    text: "...$productName",
                    fontSize: 16,
                    fw: FontWeight.bold,
                  ),
                  CustomText(
                    text: availablity ? "موجود" : "ناموجود",
                    fontSize: 16,
                    color: availablity ? Colors.green : Colors.red,
                    fw: FontWeight.bold,
                  ),
                  Row(
                    children: [
                      MaterialButton(
                        onPressed: () {},
                        color: actionCt,
                        child: CustomText(
                          text: "خرید",
                          fontSize: 16,
                          color: Colors.white,
                          fw: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
            child: Row(
              children: [
                CustomText(
                  text: productPrice,
                  fontSize: 18,
                  color: Colors.green,
                  fw: FontWeight.bold,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
