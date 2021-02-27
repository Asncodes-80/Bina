import 'dart:async';

import 'package:Bina/ConstFiles/Locale/Lang/Arabic.dart';
import 'package:Bina/ConstFiles/Locale/Lang/Kurdish.dart';
import 'package:Bina/ConstFiles/constInitVar.dart';
import 'package:Bina/ConstFiles/routeStringVar.dart';
import 'package:Bina/Controllers/flusher.dart';
import 'package:Bina/Extracted/customText.dart';
import 'package:Bina/Model/Classes/ThemeColor.dart';
import 'package:Bina/Model/categories.dart';
import 'package:Bina/Model/sqflite.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:Bina/Extracted/customText.dart';

// SQFLITE DB CLASSES
UserBasket basket = UserBasket();
MySaved saved = MySaved();

Map<String, Object> productParam;
Timer timer;
ProductCategories pcs = ProductCategories();
List productInfo = [];
int count = 1;

class ProductView extends StatefulWidget {
  @override
  _ProductViewState createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  @override
  void initState() {
    productParam = {};
    if (productInfo.isEmpty) {
      timer = Timer.periodic(Duration(seconds: 1), (timer) {
        findContentProductInfo();
      });
    }

    findContentProductInfo();
    super.initState();
  }

  void findContentProductInfo() {
    pcs
        .getProductInfo(productionId: productParam['productId'])
        .then((value) => setState(() => productInfo = value));
  }

  @override
  void dispose() {
    productParam = {};
    productInfo = [];
    count = 1;
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    productParam = ModalRoute.of(context).settings.arguments;

    // print(count);

    // print(productInfo[0]["id"]);

    final productPrice =
        productInfo.isEmpty ? 0 : double.parse(productInfo[0]['price']);
    final productPriceWithCount = productPrice * count;
    final productTitle = themeChange.langName
        ? productInfo.isEmpty
            ? ""
            : productInfo[0]['name_ar']
        : productInfo.isEmpty
            ? ""
            : productInfo[0]['name_ku'];

    // Details
    final firstContainer = Container(
        width: double.infinity,
        height: 220,
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        decoration: BoxDecoration(
          color: themeChange.darkTheme ? darkObjBgColor : Colors.white,
          borderRadius: BorderRadius.circular(34.0),
        ),
        child: Container(
          margin: EdgeInsets.only(top: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                width: 300,
                child: CustomText(
                  text: "$productTitle",
                  fontSize: 18,
                  fw: FontWeight.bold,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 20),
                child: CustomText(
                  text:
                      "${themeChange.langName ? arabicLang["Dollar"] : kurdishLang["Dollar"]} $productPrice",
                  color: Colors.green,
                  fontSize: 18,
                  fw: FontWeight.bold,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                textDirection: TextDirection.rtl,
                children: [
                  Container(
                    margin: EdgeInsets.all(10),
                    child: ClipOval(
                      child: Material(
                        color: Colors.blue, // button color
                        child: InkWell(
                          splashColor: Colors.blue[300], // inkwell color
                          child: SizedBox(
                              width: 40,
                              height: 40,
                              child: Icon(
                                Icons.add,
                                color: Colors.white,
                              )),
                          onTap: () => setState(
                              () => count >= 1 && count < 200 ? count += 1 : 0),
                        ),
                      ),
                    ),
                  ),
                  CustomText(
                    text: "${count}",
                    color: Colors.green,
                    fontSize: 18,
                    fw: FontWeight.bold,
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: ClipOval(
                      child: Material(
                        color: Colors.blue, // button color
                        child: InkWell(
                          splashColor: Colors.blue[300], // inkwell color
                          child: SizedBox(
                              width: 40,
                              height: 40,
                              child: Icon(
                                Icons.remove,
                                color: Colors.white,
                              )),
                          onTap: () =>
                              setState(() => count > 1 ? count -= 1 : 0),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ));

    final secondContainer = Container(
      width: double.infinity,
      height: 226,
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        color: mainBlue,
        borderRadius: BorderRadius.circular(34.0),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              child: Row(
                textDirection: TextDirection.rtl,
                children: [
                  CustomText(
                    text: themeChange.langName
                        ? arabicLang["description"]
                        : kurdishLang["description"],
                    color: Colors.white,
                    fontSize: 20,
                    fw: FontWeight.bold,
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
                child: Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 50),
                  child: CustomText(
                    color: Colors.white,
                    textAlign: TextAlign.right,
                    fontSize: 18,
                    text: themeChange.langName
                        ? productInfo.isEmpty
                            ? ""
                            : productInfo[0]["description_ar"]
                        : productInfo.isEmpty
                            ? ""
                            : productInfo[0]["description_ku"],
                  ),
                ),
              ],
            ))
          ],
        ),
      ),
    );

    final loadingLottie = Center(
      child: Lottie.asset("assets/lottie/loading.json"),
    );

    final productDetails = CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 400.0,
          floating: false,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            centerTitle: true,
            background: Image(
              image: NetworkImage(
                  productInfo.isEmpty ? "" : productInfo[0]['image']),
              fit: BoxFit.cover,
            ),
          ),
          actions: [
            productInfo.isNotEmpty
                ? productInfo[0]['image_sliders'].isEmpty
                    ? SizedBox()
                    : FlatButton(
                        onPressed: () => Navigator.pushNamed(context, moreImage,
                            arguments: {
                              "images": productInfo.isEmpty
                                  ? []
                                  : productInfo[0]['image_sliders']
                            }),
                        child: Icon(
                          Icons.photo_library_outlined,
                          color: Colors.black,
                        ),
                      )
                : SizedBox(),
            FlatButton(
              onPressed: () async {
                var result = await saved.addSave(
                  id: productInfo[0]["id"],
                  img: productInfo[0]["image"],
                  name_ar: productInfo[0]["name_ar"],
                  name_kur: productInfo[0]["name_ku"],
                  price: productInfo[0]["price"],
                );
                if (result) {
                  showStatusInCaseOfFlush(
                      context: context,
                      icon: Icons.turned_in_not,
                      iconColor: Colors.green,
                      msg: themeChange.langName
                          ? arabicLang["productSaved"]
                          : kurdishLang["productSaved"],
                      title: "");
                } else {
                  showStatusInCaseOfFlush(
                      context: context,
                      icon: Icons.close,
                      iconColor: Colors.red,
                      msg: themeChange.langName
                          ? arabicLang["saveIncounterErrTitle"]
                          : kurdishLang["saveIncounterErrTitle"],
                      title: themeChange.langName
                          ? arabicLang["saveIncounterErrDesc"]
                          : kurdishLang["saveIncounterErrDesc"]);
                }
              },
              child: Icon(
                Icons.turned_in_not,
                color: Colors.black,
              ),
            ),
          ],
          leading: Container(
            margin: EdgeInsets.all(10),
            child: FlatButton(
              onPressed: () => Navigator.pop(context),
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
              (context, index) => Container(
                    child: Column(
                      children: [firstContainer, secondContainer],
                    ),
                  ),
              childCount: 1),
        )
      ],
    );

    final productDetailsWidget =
        productInfo.isEmpty ? loadingLottie : productDetails;

    final BottomCalculatorPrice = productInfo.isNotEmpty
        ? ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
            child: Container(
              height: 85,
              color: themeChange.darkTheme ? darkObjBgColor : Colors.white,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      text:
                          "${productPriceWithCount} ${themeChange.langName ? arabicLang["Dollar"] : kurdishLang["Dollar"]}",
                      fw: FontWeight.bold,
                      fontSize: 18,
                    ),
                    MaterialButton(
                      // minWidth: ,
                      onPressed: () async {
                        // print("pId : ${productInfo[0]["id"]}");
                        // print("image : ${productInfo[0]["image"]}");
                        // print(
                        //     "name : ${themeChange.langName ? productInfo[0]["name_ar"] : productInfo[0]["name_ku"]}");
                        // print("price : ${productInfo[0]["price"]}");
                        // print("count : $count");

                        // print(productPriceWithCount);

                        var result = await basket.addMyBasket(
                          id: productInfo[0]["id"],
                          img: productInfo[0]["image"],
                          name_ar: productInfo[0]["name_ar"],
                          name_kur: productInfo[0]["name_ku"],
                          price: productInfo[0]["price"],
                          count: count,
                        );
                        if (result) {
                          showStatusInCaseOfFlush(
                              context: context,
                              icon: Icons.add,
                              iconColor: Colors.green,
                              msg: themeChange.langName
                                  ? arabicLang["successBasketDsc"]
                                  : kurdishLang["successBasketDsc"],
                              title: themeChange.langName
                                  ? arabicLang["successBasketTitle"]
                                  : kurdishLang["successBasketTitle"]);
                        } else {
                          showStatusInCaseOfFlush(
                              context: context,
                              icon: Icons.close,
                              iconColor: Colors.red,
                              msg: themeChange.langName
                                  ? arabicLang["rapititionBasketAdderDsc"]
                                  : kurdishLang["rapititionBasketAdderDsc"],
                              title: themeChange.langName
                                  ? arabicLang["rapititionBasketAdderTitle"]
                                  : kurdishLang["rapititionBasketAdderTitle"]);
                        }
                      },
                      color: actionCt,
                      height: 45,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: themeChange.langName ? 15 : 0),
                            child: CustomText(
                              text: themeChange.langName
                                  ? arabicLang["addMyBasket"]
                                  : kurdishLang["addMyBasket"],
                              color: Colors.white,
                              fw: FontWeight.bold,
                              fontSize: 13,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            child: Icon(
                              Icons.add_shopping_cart_outlined,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        : null;

    return Scaffold(
        body: productDetailsWidget, bottomNavigationBar: BottomCalculatorPrice);
  }
}

// CustomText(
// text: themeChange.langName
//     ? productInfo.isEmpty
//         ? ""
//         : productInfo[0]['name_ar']
//     : productInfo.isEmpty
//         ? ""
//         : productInfo[0]['name_ku'],
// color: Colors.black,
// fontSize: 20,
//   fw: FontWeight.bold,
// ),
