import 'package:Bina/ConstFiles/Locale/Lang/Arabic.dart';
import 'package:Bina/ConstFiles/Locale/Lang/Kurdish.dart';
import 'package:Bina/Extracted/textField.dart';
import 'package:flutter/material.dart';

class PrivacySection extends StatelessWidget {
  const PrivacySection(
      {this.themeChange,
      this.protectedPassword,
      this.password,
      this.rePassword,
      this.showMePass,
      this.passChanged,
      this.rePassChanged,
      this.hidePasswordIconPressed});

  final bool themeChange;
  final bool protectedPassword;
  final String password;
  final String rePassword;
  final showMePass;
  final Function passChanged;
  final Function rePassChanged;
  final Function hidePasswordIconPressed;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 40),
            Image.asset(
              "assets/images/privacy.png",
              width: 250,
            ),
            // First once password
            TextFields(
              lblText: themeChange
                  ? arabicLang["password"]
                  : kurdishLang["password"],
              keyType: TextInputType.emailAddress,
              maxLen: 20,
              readOnly: false,
              // errText: emptyTextFieldErrPassword == null
              //     ? null
              //     : emptyTextFieldMsg,
              textInputType: protectedPassword,
              textFieldIcon: password == ""
                  ? Icons.vpn_key_outlined
                  : Icons.remove_red_eye,
              iconPressed: hidePasswordIconPressed,

              onChangeText: passChanged,
            ),
            // Cofirm Pasword
            TextFields(
              lblText: themeChange
                  ? arabicLang["rePassword"]
                  : kurdishLang["rePassword"],
              keyType: TextInputType.emailAddress,
              maxLen: 20,
              readOnly: false,
              // errText: emptyTextFieldErrPassword == null
              //     ? null
              //     : emptyTextFieldMsg,
              textInputType: protectedPassword,
              textFieldIcon: password == ""
                  ? Icons.vpn_key_outlined
                  : Icons.remove_red_eye,
              iconPressed: hidePasswordIconPressed,

              onChangeText: passChanged,
            ),
          ],
        ),
      ),
    );
  }
}
