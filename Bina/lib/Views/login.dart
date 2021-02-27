import 'package:Bina/ConstFiles/Locale/Lang/Arabic.dart';
import 'package:Bina/ConstFiles/Locale/Lang/Kurdish.dart';
import 'package:Bina/ConstFiles/constInitVar.dart';
import 'package:Bina/ConstFiles/routeStringVar.dart';
import 'package:Bina/Controllers/flusher.dart';
import 'package:Bina/Extracted/bottomBtn.dart';
import 'package:Bina/Extracted/customText.dart';
import 'package:Bina/Extracted/textField.dart';
import 'package:Bina/Model/Classes/ThemeColor.dart';
import 'package:Bina/Model/auth/sanityCheck.dart';
import 'package:Bina/Model/sqflite.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';

// SQFLITE DB CLASSES
UserBasket basket = UserBasket();
MySaved saved = MySaved();

String username;
String password;
bool protectedPassword;
IconData showMePass;

UserLogin uLogin = UserLogin();

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
    protectedPassword = true;
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
                keyType: TextInputType.emailAddress,
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
                keyType: TextInputType.emailAddress,
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
          onTapped: () async {
            bool loginResult = await uLogin.gettingLogin(
                username: username, password: password);

            if (loginResult) {
              // Preparing local storage db
              basket.createBasket();
              saved.createSaved();
              final lSorage = FlutterSecureStorage();
              await lSorage.write(key: "firstVisit", value: "ACTIVE");
              // Check if first view app
              var basketList = await basket.readMyBasket();
              if (basketList.isEmpty) {
                Navigator.pushNamed(context, maino);
              } else {
                Navigator.popUntil(context, ModalRoute.withName(maino));
              }
            } else {
              showStatusInCaseOfFlush(
                context: context,
                icon: Icons.close,
                iconColor: Colors.red,
                msg: themeChange.langName
                    ? arabicLang["loginFailedDsc"]
                    : kurdishLang["loginFailedDsc"],
                title: themeChange.langName
                    ? arabicLang["loginFailed"]
                    : kurdishLang["loginFailed"],
              );
            }
          },
          text: themeChange.langName
              ? arabicLang["loginMian"]
              : kurdishLang["loginMian"]),
    );
  }
}
