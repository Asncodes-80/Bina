import 'package:Bina/ConstFiles/Locale/Lang/Arabic.dart';
import 'package:Bina/ConstFiles/Locale/Lang/Kurdish.dart';
import 'package:Bina/Extracted/customText.dart';
import 'package:Bina/Extracted/textField.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class InfoLevel1 extends StatelessWidget {
  const InfoLevel1(
      {this.darkTheme, this.langName, this.onChangeFullname, this.provinces});

  final bool darkTheme;
  final bool langName;
  final Function onChangeFullname;
  final List provinces;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset("assets/images/signupPeople.png"),
            TextFields(
                lblText:
                    langName ? arabicLang["fullname"] : kurdishLang["fullname"],
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
                  // hint: _dropDownValue == null
                  //     ? BuildingsCustomText(
                  //         text: setBuildingText,
                  //         textColor: themeChange.darkTheme
                  //             ? Colors.white
                  //             : Colors.grey,
                  //       )
                  //     : BuildingsCustomText(
                  //         text: _dropDownFaValue,
                  //         textColor: themeChange.darkTheme
                  //             ? Colors.white
                  //             : Colors.grey,
                  //       ),
                  isExpanded: true,
                  iconSize: 30.0,
                  // icon: DropdownIcon(),
                  dropdownColor: HexColor("#7280C6"),
                  items: provinces.map(
                    (province) {
                      return DropdownMenuItem(
                        value: province["id"],
                        onTap: () {
                          // setState(() {
                          //   _dropDownFaValue = val['name_fa'];
                          // });
                        },
                        child: CustomText(
                          text: langName
                              ? province["name_ar"]
                              : province["name_ku"],
                        ),
                      );
                    },
                  ).toList(),
                  onChanged: (val) {
                    // setState(
                    //   () {
                    //     _dropDownValue = val;
                    //     print(_dropDownValue);
                    //     print(_dropDownFaValue);
                    //   },
                    // );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
