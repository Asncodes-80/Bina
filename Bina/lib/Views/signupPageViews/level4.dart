import 'package:Bina/ConstFiles/Locale/Lang/Arabic.dart';
import 'package:Bina/ConstFiles/Locale/Lang/Kurdish.dart';
import 'package:Bina/Controllers/Location.dart';
import 'package:Bina/Extracted/textField.dart';
import 'package:flutter/material.dart';

import 'package:geolocator/geolocator.dart';
import 'package:geocoder/geocoder.dart';

class UserLocation extends StatelessWidget {
  const UserLocation({this.themeChange, this.address, this.onChangeAddress});

  final bool themeChange;
  final String address;
  final Function onChangeAddress;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 40),
            Image.asset(
              "assets/images/userLocation.png",
              width: 250,
            ),
            SizedBox(height: 40),
            TextFields(
                lblText: themeChange
                    ? arabicLang["address"]
                    : kurdishLang["address"],
                initValue: address,
                keyType: TextInputType.name,
                textFieldIcon: Icons.location_pin,
                textInputType: false,
                readOnly: false,
                // errText:
                //     emptyTextFieldErrEmail == null ? null : emptyTextFieldMsg,
                onChangeText: onChangeAddress),
          ],
        ),
      ),
    );
  }
}
