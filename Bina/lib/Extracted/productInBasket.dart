import 'package:Bina/ConstFiles/Locale/Lang/Arabic.dart';
import 'package:Bina/ConstFiles/Locale/Lang/Kurdish.dart';
import 'package:Bina/ConstFiles/constInitVar.dart';
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
      width: double.infinity,
      height: 160,
      decoration: BoxDecoration(
          color: themeChange.darkTheme ? darkObjBgColor : Colors.white,
          borderRadius: BorderRadius.circular(15)),
      child: Column(
        children: [
          Row(
            textDirection: TextDirection.rtl,
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 15),
                child: Image.network(
                  imgNetSource,
                  // fit: BoxFit.cover,
                  width: 100,
                  height: 100,
                ),
              ),
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    width: 180,
                    child: CustomText(
                      text: "$productName",
                      fontSize: 16,
                      fw: FontWeight.bold,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: CustomText(
                      text: count != null
                          ? "$count : ${themeChange.langName ? arabicLang["countInProduct"] : kurdishLang["countInProduct"]}"
                          : "",
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
