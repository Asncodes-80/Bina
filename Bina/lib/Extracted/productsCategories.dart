import 'package:Bina/ConstFiles/constInitVar.dart';
import 'package:flutter/material.dart';

import 'customText.dart';

class Categories extends StatelessWidget {
  const Categories({this.productImg, this.productName});

  final String productImg;
  final String productName;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      height: 140,
      margin: EdgeInsets.symmetric(horizontal: 7),
      decoration: BoxDecoration(
        color: productsBgColor,
        borderRadius: BorderRadius.circular(7),
      ),
      child: Column(
        children: [
          Container(
            width: 100,
            height: 90,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.0),
                  // spreadRadius: 2,
                  // blurRadius: 7,
                  offset: Offset(0, 1), // changes position of shadow
                ),
              ],
              image: DecorationImage(
                // TODO Will Getting on API (NETWORK IMAGE)
                image: NetworkImage(productImg),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 10),
          CustomText(
            text: productName,
            color: Colors.white,
            fontSize: 12,
            fw: FontWeight.bold,
          )
        ],
      ),
    );
  }
}
