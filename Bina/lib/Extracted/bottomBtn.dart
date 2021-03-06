import 'package:flutter/material.dart';
import 'package:Bina/ConstFiles/constInitVar.dart';

class BottomButton extends StatelessWidget {
  const BottomButton({this.text, this.color, this.onTapped});

  final String text;
  final color;
  final Function onTapped;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Material(
        elevation: 10.0,
        borderRadius: BorderRadius.circular(8.0),
        color: color,
        child: MaterialButton(
            padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            onPressed: onTapped,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  text,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: mainFont,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
                Icon(
                  Icons.chevron_right,
                  color: Colors.white,
                )
              ],
            )),
      ),
    );
  }
}
