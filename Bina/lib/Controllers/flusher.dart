import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:Bina/ConstFiles/constInitVar.dart';

void showStatusInCaseOfFlush({context, String msg, title, icon, iconColor}) {
  Flushbar(
    margin: EdgeInsets.all(8),
    borderRadius: 8,
    backgroundColor: darkBar,
    flushbarPosition: FlushbarPosition.TOP,
    titleText: Text(
      title,
      textAlign: TextAlign.right,
      textDirection: TextDirection.rtl,
      style: TextStyle(
          fontFamily: mainFont,
          fontWeight: FontWeight.bold,
          color: Colors.white),
    ),
    messageText: Text(msg,
        textAlign: TextAlign.right,
        textDirection: TextDirection.rtl,
        style:
            TextStyle(fontFamily: mainFont, color: Colors.white, fontSize: 20)),
    icon: Icon(
      icon,
      size: 28.0,
      color: iconColor,
      textDirection: TextDirection.ltr,
    ),
    duration: Duration(seconds: 10),
  )..show(context);
}
