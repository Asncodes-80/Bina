import 'dart:async';

import 'package:Bina/ConstFiles/Locale/Lang/Arabic.dart';
import 'package:Bina/ConstFiles/Locale/Lang/Kurdish.dart';
import 'package:Bina/ConstFiles/constInitVar.dart';
import 'package:Bina/ConstFiles/routeStringVar.dart';
import 'package:Bina/Extracted/customText.dart';
import 'package:Bina/Model/Classes/ThemeColor.dart';
import 'package:Bina/Model/categories.dart';
import 'package:Bina/Views/products.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

ScrollController _scrollController;
ProductCategories pcs = ProductCategories();
Map<String, Object> searchParm = {};
List searchProduct = [];
Timer timer;

class SearchResult extends StatefulWidget {
  @override
  _SearchResultState createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  @override
  void initState() {
    _scrollController = ScrollController();
    if (searchProduct.isEmpty)
      timer = Timer.periodic(Duration(seconds: 3), (timer) {
        getSearchedProduct();
      });
    getSearchedProduct();

    super.initState();
  }

  void getSearchedProduct() {
    pcs
        .searchProducts(searchKey: searchParm["searchKey"])
        .then((value) => setState(() => searchProduct = value));
  }

  @override
  void dispose() {
    _scrollController.dispose();
    searchProduct = [];
    searchParm = {};
    timer.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    searchParm = ModalRoute.of(context).settings.arguments;

    final loadLottie = Lottie.asset("assets/lottie/loading.json");
    final readCategoryList = GridView.builder(
      shrinkWrap: true,
      primary: false,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        // TODO CHANGE THE ASPECT RATIO IN HORIZONTAL
        childAspectRatio: MediaQuery.of(context).size.width /
            (MediaQuery.of(context).size.height / 1.2),
      ),
      itemBuilder: (_, index) => GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, productViewPage, arguments: {
            "productId": searchProduct[index]['id'],
          });
          // print(productsLs[index]['id']);
        },
        child: ProductViewer(
          productImg: searchProduct[index]['image'],
          productName: searchProduct.isEmpty
              ? ""
              : themeChange.langName
                  ? searchProduct[index]['name_ar'].substring(0, 18)
                  : searchProduct[index]['name_ku'].substring(0),
          productAvailable: searchProduct[index]['available'],
          productPrice: searchProduct[index]['price'],
        ),
      ),
      itemCount: searchProduct.length,
    );

    final usageProducts = searchProduct.isEmpty ? loadLottie : readCategoryList;

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
                  expandedHeight: 80,
                  backgroundColor: mainBlue,
                  // It's null leading
                  // leading:2
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
                                  text: searchParm["searchKey"],
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
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 20),
                    usageProducts,
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
