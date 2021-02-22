import 'package:Bina/ConstFiles/constInitVar.dart';
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
      height: 185,
      decoration: BoxDecoration(
        color: themeChange.darkTheme ? darkObjBgColor : Colors.white,
        borderRadius: BorderRadius.circular(15),
        image: DecorationImage(
          image: NetworkImage(imgNetSource),
          colorFilter: new ColorFilter.mode(
              Colors.black.withOpacity(0.7), BlendMode.srcOver),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            textDirection: TextDirection.rtl,
            children: [
              // Container(
              //   // margin: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              //   child: Image.network(
              //     imgNetSource,
              //     fit: BoxFit.cover,
              //     width: 100,
              //     height: 75,
              //   ),
              // ),
              Container(
                width: 250,
                margin: EdgeInsets.symmetric(horizontal: 7, vertical: 20),
                child: CustomText(
                  textAlign: TextAlign.right,
                  text: "$productName",
                  fontSize: 15,
                  color: Colors.white,
                  fw: FontWeight.bold,
                ),
              ),
            ],
          ),
          CustomText(
            text: availablity ? "موجود" : "ناموجود",
            fontSize: 16,
            color: availablity ? Colors.green : Colors.red,
            fw: FontWeight.bold,
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
