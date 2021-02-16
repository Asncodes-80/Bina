import 'package:Bina/ConstFiles/Locale/Lang/Arabic.dart';
import 'package:Bina/ConstFiles/Locale/Lang/Kurdish.dart';
import 'package:Bina/ConstFiles/constInitVar.dart';
import 'package:Bina/ConstFiles/routeStringVar.dart';
import 'package:Bina/Extracted/bottomBtn.dart';
import 'package:Bina/Extracted/customText.dart';
import 'package:Bina/Extracted/textField.dart';
import 'package:Bina/Model/Classes/ThemeColor.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

String username;
String password;
bool protectedPassword;
IconData showMePass;

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  void initState() {
    username = "";
    password = "";
    showMePass = Icons.remove_red_eye;
    protectedPassword = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset("assets/images/loginPeople.png"),
              SizedBox(height: 20),
              CustomText(
                text: themeChange.langName
                    ? arabicLang["loginToAccount"]
                    : kurdishLang["loginToAccount"],
                fontSize: titleTextSize,
                fw: FontWeight.bold,
              ),
              SizedBox(height: 30),
              TextFields(
                lblText: themeChange.langName
                    ? arabicLang["emailOrPhone"]
                    : kurdishLang["emailOrPhone"],
                textFieldIcon: Icons.account_circle,
                textInputType: false,
                readOnly: false,
                // errText:
                //     emptyTextFieldErrEmail == null ? null : emptyTextFieldMsg,
                onChangeText: (onChangeUsername) {
                  setState(() {
                    // emptyTextFieldErrPersonalCode = null;
                    username = onChangeUsername;
                  });
                },
              ),
              SizedBox(height: 20),
              TextFields(
                lblText: themeChange.langName
                    ? arabicLang["password"]
                    : kurdishLang["password"],
                maxLen: 20,
                readOnly: false,
                // errText: emptyTextFieldErrPassword == null
                //     ? null
                //     : emptyTextFieldMsg,
                textInputType: protectedPassword,
                textFieldIcon:
                    password == "" ? Icons.vpn_key_outlined : showMePass,
                iconPressed: () {
                  setState(() {
                    protectedPassword
                        ? protectedPassword = false
                        : protectedPassword = true;
                    // Changing eye icon pressing
                    showMePass == Icons.remove_red_eye
                        ? showMePass = Icons.remove_red_eye_outlined
                        : showMePass = Icons.remove_red_eye;
                  });
                },
                onChangeText: (onChangePassword) {
                  setState(() {
                    // emptyTextFieldErrPassword = null;
                    password = onChangePassword;
                  });
                },
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15),
                child: FlatButton(
                  onPressed: () => Navigator.pushNamed(context, signup),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CustomText(
                        text: themeChange.langName
                            ? arabicLang["signupInLogin"]
                            : kurdishLang["signupInLogin"],
                        color: actionCt,
                        fontSize: subTitleTextSize,
                        fw: FontWeight.bold,
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomButton(
          color: actionCt,
          onTapped: () {
            // will come to save
          },
          text: themeChange.langName
              ? arabicLang["loginMian"]
              : kurdishLang["loginMian"]),
    );
  }
}
