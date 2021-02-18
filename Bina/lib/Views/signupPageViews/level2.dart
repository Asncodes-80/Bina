import 'package:Bina/ConstFiles/Locale/Lang/Arabic.dart';
import 'package:Bina/ConstFiles/Locale/Lang/Kurdish.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class PhoneSection extends StatelessWidget {
  const PhoneSection(
      {this.themeChanged, this.phoneNum, this.onChangePhoneNumber});

  final bool themeChanged;

  final String phoneNum;
  final Function onChangePhoneNumber;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              "assets/images/addingPhoneNumber.png",
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: IntlPhoneField(
                  initialValue: phoneNum,
                  decoration: InputDecoration(
                    labelText: themeChanged
                        ? arabicLang["phoneNumber"]
                        : kurdishLang["phoneNumber"],
                    border: OutlineInputBorder(
                      borderSide: BorderSide(),
                    ),
                  ),
                  initialCountryCode: 'IQ',
                  onChanged: onChangePhoneNumber),
            )
          ],
        ),
      ),
    );
  }
}
