import 'package:Bina/ConstFiles/Locale/Lang/Arabic.dart';
import 'package:Bina/ConstFiles/Locale/Lang/Kurdish.dart';
import 'package:Bina/ConstFiles/constInitVar.dart';
import 'package:Bina/ConstFiles/routeStringVar.dart';
import 'package:Bina/Controllers/flusher.dart';
import 'package:Bina/Extracted/customText.dart';
import 'package:Bina/Extracted/productInBasket.dart';
import 'package:Bina/Model/Classes/ThemeColor.dart';
import 'package:Bina/Model/sqflite.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

UserBasket myBasket = UserBasket();
FlutterSecureStorage fss = FlutterSecureStorage();

class MyBasket extends StatelessWidget {
  const MyBasket({
    this.themeChange,
    this.scrollController,
    this.productInBascket,
    this.sumPrice,
  });

  final DarkThemeProvider themeChange;
  final scrollController;
  final List productInBascket;
  final sumPrice;

  @override
  Widget build(BuildContext context) {
    final sumPricer = sumPrice is List ? "" : sumPrice;

    void orderDecision() async {
      // get user from Flutter secure storage
      final username = await fss.read(key: "username");
      // If user is empty
      if (username == null)
        // Navigated to login
        Navigator.pushNamed(context, login);
      // else
      else {
        // Send all orders to Server
        print(productInBascket);
      }
    }

    final basketList = ListView.builder(
      shrinkWrap: true,
      primary: false,
      itemCount: productInBascket.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, productBasketView, arguments: {
              "id": productInBascket[index]['id'],
              "img": productInBascket[index]['img'],
              "name_ar": productInBascket[index]['name_ar'],
              "name_kur": productInBascket[index]['name_kur'],
              "price": productInBascket[index]['price'],
              "count": productInBascket[index]['count'],
            });
            // print("This is ${productInBascket[index]['name_kur']}");
          },
          child: Slidable(
            actionPane: SlidableDrawerActionPane(),
            actionExtentRatio: 0.25,
            child: Container(
                color: Colors.white,
                child: ProductInBasket(
                  themeChange: themeChange,
                  productPrice: productInBascket[index]['price'],
                  imgNetSource: productInBascket[index]['img'],
                  productName: themeChange.langName
                      ? productInBascket[index]['name_ar']
                      : productInBascket[index]['name_kur'],
                  count: productInBascket[index]['count'],
                )),
            secondaryActions: <Widget>[
              IconSlideAction(
                caption: 'حذف',
                color: Colors.red,
                icon: Icons.delete,
                onTap: () async {
                  var delProc = await myBasket.delProductBasket(
                      id: productInBascket[index]['id']);
                  if (delProc)
                    showStatusInCaseOfFlush(
                        context: context,
                        icon: Icons.delete,
                        iconColor: Colors.green,
                        msg: "محصول مورد نظر حذف شد",
                        title: "حذف از سبد من");
                  else {
                    showStatusInCaseOfFlush(
                        context: context,
                        icon: Icons.close,
                        iconColor: Colors.red,
                        msg: "این کالا یک بار حذف شده است",
                        title: "مشکلی در حذف کالا");
                  }
                },
              ),
            ],
          ),
        );
      },
    );
    final lottie = Lottie.asset("assets/lottie/emptyLoading.json");

    final baskets = productInBascket.isEmpty ? lottie : basketList;

    final submitOrders = productInBascket.isEmpty
        ? CustomText(
            text: "شما کالایی را انتخاب نکرده اید",
          )
        : Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: MaterialButton(
              onPressed: () => orderDecision(),
              minWidth: double.infinity,
              height: 60,
              color: actionCt,
              child: Row(
                textDirection: TextDirection.rtl,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    fw: FontWeight.bold,
                    text: "خرید",
                    color: Colors.white,
                  ),
                  CustomText(
                    fw: FontWeight.bold,
                    text: "مجموع $sumPricer دلار",
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          );

    return Stack(
      children: [
        NestedScrollView(
          controller: scrollController,
          headerSliverBuilder: (context, value) {
            return [
              SliverAppBar(
                pinned: true,
                expandedHeight: 20,
                backgroundColor: mainBlue,
                // It's null leading
                leading: Container(
                  margin: EdgeInsets.all(10),
                ),
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
                                    ? arabicLang["myBasket"]
                                    : kurdishLang["myBasket"],
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
                  baskets,
                  submitOrders,
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}