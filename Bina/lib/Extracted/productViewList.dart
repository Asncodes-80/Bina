import 'package:Bina/Extracted/customText.dart';
import 'package:Bina/Model/Classes/ThemeColor.dart';
import 'package:flutter/material.dart';

class ProductViewList extends StatelessWidget {
  const ProductViewList({
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
                  // Row(
                  //   children: [
                  //     MaterialButton(
                  //       onPressed: () {},
                  //       color: actionCt,
                  //       child: CustomText(
                  //         text: "خرید",
                  //         fontSize: 16,
                  //         color: Colors.white,
                  //         fw: FontWeight.bold,
                  //       ),
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
            child: Row(
              children: [
                CustomText(
                  text: "$productPrice",
                  fontSize: 12,
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
