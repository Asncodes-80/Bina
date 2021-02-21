import 'package:Bina/Extracted/customText.dart';
import 'package:Bina/Model/Classes/ThemeColor.dart';
import 'package:flutter/material.dart';

class ProductInBasket extends StatelessWidget {
  const ProductInBasket({
    this.imgNetSource,
    this.productName,
    this.count,
    this.productPrice,
    @required this.themeChange,
  });

  final DarkThemeProvider themeChange;
  final String imgNetSource;
  final String productName;
  final int count;
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
                    text:
                        "...${productName.length > 10 ? productName.substring(0, 10) : productName}",
                    fontSize: 16,
                    fw: FontWeight.bold,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: CustomText(
                      text: count != null ? "$count : تعداد" : "",
                      fontSize: 16,
                      color: Colors.green,
                      fw: FontWeight.bold,
                    ),
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
