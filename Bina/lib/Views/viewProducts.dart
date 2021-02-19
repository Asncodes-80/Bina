import 'dart:async';

import 'package:Bina/ConstFiles/Locale/Lang/Arabic.dart';
import 'package:Bina/ConstFiles/Locale/Lang/Kurdish.dart';
import 'package:Bina/ConstFiles/constInitVar.dart';
import 'package:Bina/Extracted/customText.dart';
import 'package:Bina/Model/Classes/ThemeColor.dart';
import 'package:Bina/Model/categories.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:Bina/Extracted/customText.dart';

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
      timer = Timer.periodic(Duration(seconds: 2), (timer) {
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

    print(count);

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
        height: 200,
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(34.0),
        ),
        child: Container(
          margin: EdgeInsets.only(top: 50),
          child: Column(
            children: [
              CustomText(
                text: "$productTitle",
                fontSize: 20,
                fw: FontWeight.bold,
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 15),
                child: CustomText(
                  text: "دلار $productPrice",
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
                              () => count >= 1 && count < 10 ? count += 1 : 0),
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
                    text: "توضیحات",
                    color: Colors.white,
                    fontSize: 20,
                    fw: FontWeight.bold,
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
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
              color: Colors.white,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      text: "${productPriceWithCount} دلار",
                      fw: FontWeight.bold,
                      fontSize: 20,
                    ),
                    MaterialButton(
                      onPressed: () {
                        print(productInfo[0]["id"]);
                        print(productInfo[0]["image"]);
                        print(productInfo[0]["name"]);
                        print(count);
                        print(productInfo[0]["price"]);
                        print(productPriceWithCount);
                      },
                      color: actionCt,
                      height: 45,
                      child: Row(
                        children: [
                          CustomText(
                            text: "افزودن به سبد من",
                            color: Colors.white,
                            fw: FontWeight.bold,
                            fontSize: 15,
                          ),
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
