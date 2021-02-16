import 'package:Bina/ConstFiles/constInitVar.dart';
import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  const CustomText({this.text, this.fontSize, this.color, this.fw});

  final double fontSize;
  final text;
  final Color color;
  final FontWeight fw;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          fontFamily: mainFont,
          fontSize: fontSize,
          color: color,
          fontWeight: fw),
      textAlign: TextAlign.center,
    );
  }
}
