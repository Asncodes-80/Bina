import 'dart:io';

import 'package:Bina/ConstFiles/Locale/Lang/Arabic.dart';
import 'package:Bina/ConstFiles/Locale/Lang/Kurdish.dart';
import 'package:Bina/ConstFiles/constInitVar.dart';
import 'package:Bina/Extracted/customText.dart';
import 'package:Bina/Extracted/textField.dart';
import 'package:flutter/material.dart';

class InfoLevel1 extends StatelessWidget {
  const InfoLevel1(
      {this.darkTheme,
      this.langName,
      this.initUsername,
      this.onChangeUsername,
      this.initFullname,
      this.onChangeFullname,
      this.imgSource,
      this.pickImage,
      this.provinces,
      this.tapOnDropMenuItem,
      this.dropItem,
      this.dropItemSelected});

  final bool darkTheme;
  final bool langName;
  final String initFullname;
  final String initUsername;
  final File imgSource;
  final Function pickImage;
  final Function onChangeFullname;
  final Function onChangeUsername;
  final List provinces;
  final Function tapOnDropMenuItem;
  final List dropItem;
  final String dropItemSelected;

  @override
  Widget build(BuildContext context) {
    final dropHint = langName
        ? CustomText(
            text: arabicLang["state"],
          )
        : Text(kurdishLang["state"]);

    final textHint =
        dropItemSelected != "" ? CustomText(text: dropItemSelected) : dropHint;

    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset("assets/images/signupPeople.png"),
            CircleAvatar(
              radius: 70,
              backgroundImage: imgSource != null
                  ? FileImage(imgSource)
                  : AssetImage("assets/images/isgpp_avatar_placeholder.png"),
              child: Container(
                margin: EdgeInsets.only(top: 90, left: 80),
                child: ClipOval(
                  child: Material(
                    color: Colors.blue, // button color
                    child: InkWell(
                      splashColor: Colors.black, // inkwell color
                      child: SizedBox(
                          width: 46,
                          height: 46,
                          child: Icon(
                            Icons.add_circle_outline,
                            color: Colors.white,
                          )),
                      onTap: pickImage,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            TextFields(
                initValue: initUsername,
                lblText: "username",
                // langName ? arabicLang["fullname"] : kurdishLang["fullname"],
                keyType: TextInputType.name,
                textFieldIcon: Icons.account_circle,
                textInputType: false,
                readOnly: false,
                // errText:
                //     emptyTextFieldErrEmail == null ? null : emptyTextFieldMsg,
                onChangeText: onChangeUsername),
            SizedBox(height: 20),
            TextFields(
                initValue: initFullname,
                lblText:
                    langName ? arabicLang["fullname"] : kurdishLang["fullname"],
                keyType: TextInputType.name,
                textFieldIcon: Icons.account_circle,
                textInputType: false,
                readOnly: false,
                // errText:
                //     emptyTextFieldErrEmail == null ? null : emptyTextFieldMsg,
                onChangeText: onChangeFullname),
            Directionality(
              textDirection: TextDirection.rtl,
              child: Container(
                width: double.infinity,
                height: 70,
                margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: DropdownButton(
                  hint: textHint,
                  isExpanded: true,
                  iconSize: 30.0,
                  icon: Icon(
                    Icons.location_city_outlined,
                    color: actionCt,
                  ),
                  // dropdownColor: HexColor("#7280C6"),
                  items: dropItem,
                  onChanged: (val) {},
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
