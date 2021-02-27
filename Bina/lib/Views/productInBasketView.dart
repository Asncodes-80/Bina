import 'dart:async';

import 'package:Bina/ConstFiles/Locale/Lang/Arabic.dart';
import 'package:Bina/ConstFiles/Locale/Lang/Kurdish.dart';
import 'package:Bina/ConstFiles/constInitVar.dart';
import 'package:Bina/Controllers/flusher.dart';
import 'package:Bina/Extracted/customText.dart';
import 'package:Bina/Model/Classes/ThemeColor.dart';
import 'package:Bina/Model/categories.dart';
import 'package:Bina/Model/sqflite.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:Bina/Extracted/customText.dart';

// SQFLITE DB CLASSE
UserBasket basket = UserBasket();

Map<String, Object> basketParam = {};
int count = 1;
int userCount = 1;

var productPrice = 0.0;

class ProductInBasketView extends StatefulWidget {
  @override
  _ProductInBasketViewState createState() => _ProductInBasketViewState();
}

class _ProductInBasketViewState extends State<ProductInBasketView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    basketParam = {};
    count = 1;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    basketParam = ModalRoute.of(context).settings.arguments;

    setState(() {
      userCount = basketParam['count'];
    });

    // print(basketParam['count'] is int ? int : "String");

    // final productPriceWithCount = productPrice * count;
    final productTitle =
        themeChange.langName ? basketParam['name_ar'] : basketParam['name_kur'];

    // Details
    final firstContainer = Container(
        width: double.infinity,
        height: 300,
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        decoration: BoxDecoration(
          color: themeChange.darkTheme ? darkObjBgColor : Colors.white,
          borderRadius: BorderRadius.circular(34.0),
        ),
        child: Container(
          margin: EdgeInsets.only(top: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 30),
                child: CustomText(
                  text: "$productTitle",
                  fontSize: 20,
                  fw: FontWeight.bold,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 20),
                child: CustomText(
                  text:
                      "${themeChange.langName ? arabicLang["Dollar"] : kurdishLang["Dollar"]} ${basketParam['price']}",
                  color: Colors.green,
                  fontSize: 18,
                  fw: FontWeight.bold,
                ),
              ),
              CustomText(
                text:
                    "${themeChange.langName ? arabicLang['passtCount'] : kurdishLang['passtCount']} $userCount",
                color: Colors.green,
                fontSize: 18,
                fw: FontWeight.bold,
              ),
              SizedBox(height: 10),
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
                          onTap: () =>
                              setState(() => count >= 1 ? count += 1 : 0),
                        ),
                      ),
                    ),
                  ),
                  CustomText(
                    text: "$count",
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
              image: NetworkImage(basketParam['img']),
              fit: BoxFit.cover,
            ),
          ),
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
                      children: [firstContainer],
                    ),
                  ),
              childCount: 1),
        )
      ],
    );

    final productDetailsWidget =
        basketParam['name_ar'] != {} ? productDetails : loadingLottie;

    final BottomCalculatorPrice = basketParam['name_ar'] != {}
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
                          "${basketParam['price']} ${themeChange.langName ? arabicLang["Dollar"] : kurdishLang["Dollar"]}",
                      fw: FontWeight.bold,
                      fontSize: 20,
                    ),
                    MaterialButton(
                      onPressed: () async {
                        var result = await basket.updateMyBasket(
                          id: basketParam["id"],
                          count: count,
                        );
                        if (result) {
                          Navigator.pop(context);
                          showStatusInCaseOfFlush(
                              context: context,
                              icon: Icons.edit,
                              iconColor: Colors.green,
                              msg: themeChange.langName
                                  ? arabicLang["productEdited"]
                                  : kurdishLang["productEdited"],
                              title: themeChange.langName
                                  ? arabicLang["successProcess"]
                                  : kurdishLang["successProcess"]);
                        } else {
                          showStatusInCaseOfFlush(
                              context: context,
                              icon: Icons.edit,
                              iconColor: Colors.red,
                              msg: themeChange.langName
                                  ? arabicLang["problemInEdit"]
                                  : kurdishLang["problemInEdit"],
                              title: themeChange.langName
                                  ? arabicLang["errorTitle"]
                                  : kurdishLang["errorTitle"]);
                        }
                      },
                      color: actionCt,
                      height: 45,
                      minWidth: 200,
                      child: Row(
                        children: [
                          CustomText(
                            text: themeChange.langName
                                ? arabicLang["editProduct"]
                                : kurdishLang["editProduct"],
                            color: Colors.white,
                            fw: FontWeight.bold,
                            fontSize: 15,
                          ),
                          SizedBox(width: 20),
                          Icon(
                            Icons.add_shopping_cart_outlined,
                            color: Colors.white,
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
