import 'dart:async';

import 'package:Bina/ConstFiles/Locale/Lang/Arabic.dart';
import 'package:Bina/ConstFiles/Locale/Lang/Kurdish.dart';
import 'package:Bina/ConstFiles/constInitVar.dart';
import 'package:Bina/ConstFiles/routeStringVar.dart';
import 'package:Bina/Extracted/customText.dart';
import 'package:Bina/Model/Classes/ThemeColor.dart';
import 'package:Bina/Model/categories.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

ScrollController _scrollController;
Map<String, Object> cateParam = {};
Timer timer;
// Model Class getting product by category getProductsByCateId
ProductCategories pcs = ProductCategories();

List products = [];

class ProductsPage extends StatefulWidget {
  @override
  _ProductsPageState createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(() => setState(() => {}));
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      findContent();
    });
    findContent();
    super.initState();
  }

  void findContent() {
    pcs
        .getProductsByCateId(categoryId: cateParam["cateId"])
        .then((value) => setState(() => products = value));
  }

  @override
  void dispose() {
    _scrollController.dispose();
    timer.cancel();
    cateParam = {};
    products = [];
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    cateParam = ModalRoute.of(context).settings.arguments;

    // print();

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
                                  text: cateParam["cateName"],
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
                color: themeChange.darkTheme ? darkBgColor : lightBgColor,
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
                    ProductsInGrid(
                        productsLs: products, themeChange: themeChange),
                    // ProductViewer(),
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

class ProductViewer extends StatelessWidget {
  const ProductViewer({
    this.productImg,
    this.themeChange,
    this.productName,
    this.productAvailable,
    this.productPrice,
  });
  final DarkThemeProvider themeChange;

  final String productImg;
  final String productName;
  final bool productAvailable;
  final String productPrice;

  @override
  Widget build(BuildContext context) {
    // print(themeChange.darkTheme);
    return Container(
      width: 180,
      // height: 300,
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: themeChange.darkTheme ? darkObjBgColor : Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Image.network(
            productImg,
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 10),
          Container(
            width: 100,
            child: CustomText(
              text: "$productName",
              fontSize: 14,
              fw: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Divider(
            height: 2,
            thickness: 1,
          ),
          CustomText(
            text: productAvailable
                ? themeChange.langName
                    ? arabicLang["available"]
                    : kurdishLang["available"]
                : themeChange.langName
                    ? arabicLang["unAvailable"]
                    : kurdishLang["unAvailable"],
            fontSize: 15,
            fw: FontWeight.bold,
            color: productAvailable ? Colors.green : Colors.red,
          ),
          CustomText(
            text:
                "$productPrice ${themeChange.langName ? arabicLang["Dollar"] : kurdishLang["Dollar"]}",
            fontSize: 20,
            fw: FontWeight.bold,
            color: Colors.green,
          ),
        ],
      ),
    );
  }
}

class ProductsInGrid extends StatelessWidget {
  const ProductsInGrid({this.productsLs, this.themeChange});

  final List productsLs;
  final DarkThemeProvider themeChange;

  @override
  Widget build(BuildContext context) {
    final loadLottie = Lottie.asset("assets/lottie/loading.json");
    final readCategoryList = GridView.builder(
      shrinkWrap: true,
      primary: false,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        // TODO CHANGE THE ASPECT RATIO IN HORIZONTAL
        childAspectRatio: MediaQuery.of(context).size.width /
            (MediaQuery.of(context).size.height),
      ),
      itemBuilder: (_, index) => GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, productViewPage, arguments: {
            "productId": productsLs[index]['id'],
          });
          // print(productsLs[index]['id']);
        },
        child: ProductViewer(
          themeChange: themeChange,
          productImg: productsLs[index]['image'],
          productName: productsLs.isEmpty
              ? ""
              : themeChange.langName
                  ? productsLs[index]['name_ar']
                  : productsLs[index]['name_ku'],
          productAvailable: productsLs[index]['available'],
          productPrice: productsLs[index]['price'],
        ),
      ),
      itemCount: productsLs.length,
    );

    final usageProducts = productsLs.isEmpty ? loadLottie : readCategoryList;

    return usageProducts;
  }
}
