import 'dart:io';

import 'package:Bina/ConstFiles/Locale/Lang/Arabic.dart';
import 'package:Bina/ConstFiles/Locale/Lang/Kurdish.dart';
import 'package:Bina/ConstFiles/constInitVar.dart';
import 'package:Bina/ConstFiles/routeStringVar.dart';
import 'package:Bina/Extracted/customText.dart';
import 'package:Bina/Model/Classes/ThemeColor.dart';
import 'package:Bina/Model/sqflite.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

UserBasket myBasket = UserBasket();
MySaved mySaved = MySaved();

class Preferences extends StatelessWidget {
  const Preferences({
    this.scrollController,
    @required this.themeChange,
    this.fullname,
    this.provinceName,
    this.avatarImg,
  });

  final fullname;
  final provinceName;
  final DarkThemeProvider themeChange;
  final ScrollController scrollController;
  final String avatarImg;

  @override
  Widget build(BuildContext context) {
    final profileObject = fullname != null
        ? SquareAvatar(
            avatarImg: avatarImg,
            userNameLimited: fullname != null ? fullname[0] : "",
            fullname: fullname != null ? fullname : "",
          )
        : SizedBox(height: 1);

    final loginBtn = fullname != null
        ? Container(
            margin: EdgeInsets.symmetric(vertical: 20),
            child: FlatButton(
              onPressed: () => Alert(
                context: context,
                type: AlertType.warning,
                title: themeChange.langName
                    ? arabicLang["logoutQuestion"]
                    : kurdishLang["logoutQuestion"],
                desc: themeChange.langName
                    ? arabicLang["logoutQuestionDsc"]
                    : kurdishLang["logoutQuestionDsc"],
                style: AlertStyle(
                    backgroundColor:
                        themeChange.darkTheme ? darkBar : Colors.white,
                    titleStyle: TextStyle(
                      fontFamily: mainFont,
                    ),
                    descStyle: TextStyle(fontFamily: mainFont)),
                buttons: [
                  DialogButton(
                    child: Text(
                      themeChange.langName
                          ? arabicLang["allow"]
                          : kurdishLang["allow"],
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontFamily: mainFont),
                    ),
                    onPressed: () async {
                      final lStorage = FlutterSecureStorage();
                      await lStorage.deleteAll();
                      await myBasket.refreshBasketByEmpty();
                      await mySaved.refreshSavedByEmpty();
                      exit(0);
                    },
                    width: 120,
                  ),
                  DialogButton(
                    child: Text(
                      themeChange.langName
                          ? arabicLang["deny"]
                          : kurdishLang["deny"],
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontFamily: mainFont),
                    ),
                    onPressed: () => Navigator.pop(context),
                    width: 120,
                  )
                ],
              ).show(),
              child: CustomText(
                text: themeChange.langName
                    ? arabicLang["logout"]
                    : kurdishLang["logout"],
                color: Colors.red,
                fw: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          )
        : Container(
            margin: EdgeInsets.symmetric(vertical: 20),
            child: FlatButton(
                onPressed: () => Navigator.pushNamed(context, login),
                color: Colors.green,
                minWidth: 100,
                height: 50,
                child: CustomText(
                  text: themeChange.langName
                      ? arabicLang["loginNow"]
                      : kurdishLang["loginNow"],
                  color: Colors.white,
                  fontSize: 16,
                  fw: FontWeight.bold,
                )),
          );
    return Stack(
      children: [
        NestedScrollView(
          controller: scrollController,
          headerSliverBuilder: (context, value) {
            return [
              SliverAppBar(
                pinned: true,
                expandedHeight: 20,
                backgroundColor: mainBlue,
                // It's null leading
                leading: Container(
                  margin: EdgeInsets.all(10),
                ),
                flexibleSpace: ListView(
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    Column(
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            textDirection: TextDirection.rtl,
                            children: [
                              CustomText(
                                text: themeChange.langName
                                    ? arabicLang["profile"]
                                    : kurdishLang["profile"],
                                fw: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.white,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ];
          },
          body: Container(
            decoration: BoxDecoration(
              color: themeChange.darkTheme ? darkBgColor : lightBgColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(34),
                topRight: Radius.circular(34),
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 20),

                  // Square Avatar
                  profileObject,
                  SizedBox(height: 40),

                  // Options
                  Container(
                    width: double.infinity,
                    height: 300,
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color:
                          themeChange.darkTheme ? darkObjBgColor : Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        PreferencesSettings(
                          themeChange: themeChange,
                          item: "changeLanguage",
                          titleItem: "titleThemeChange",
                          iconName: Icons.language,
                          iconBgColor: languageBgColor,
                          changerFunction: () =>
                              Navigator.pushNamed(context, changeLangPage),
                        ),
                        Divider(height: 2, thickness: 1),
                        PreferencesSettings(
                          themeChange: themeChange,
                          item: "themeChange",
                          titleItem: "titleThemeChange",
                          iconName: Icons.nightlight_round,
                          iconBgColor: appearanceBgColors,
                          changerFunction: () =>
                              Navigator.pushNamed(context, changeThemePage),
                        ),
                      ],
                    ),
                  ),
                  loginBtn,
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class PreferencesSettings extends StatelessWidget {
  const PreferencesSettings(
      {this.themeChange,
      this.item,
      this.iconName,
      this.iconBgColor,
      this.titleItem,
      this.changerFunction});

  final DarkThemeProvider themeChange;
  final String item;
  final iconName;
  final iconBgColor;
  final String titleItem;
  final Function changerFunction;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: ListTile(
          onTap: changerFunction,
          title: CustomText(
              textAlign: TextAlign.right,
              text:
                  themeChange.langName ? arabicLang[item] : kurdishLang[item]),
          subtitle: CustomText(
              textAlign: TextAlign.right,
              text: themeChange.langName
                  ? arabicLang[titleItem]
                  : kurdishLang[titleItem]),
          leading: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: iconBgColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              iconName,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

class SquareAvatar extends StatelessWidget {
  const SquareAvatar({this.userNameLimited, this.fullname, this.avatarImg});

  final String userNameLimited;
  final String fullname;
  final String avatarImg;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 150,
          height: 150,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: avatarImg != null ? Colors.transparent : Colors.blue[800],
            borderRadius: BorderRadius.circular(25),
          ),
          child: avatarImg != null
              ? CircleAvatar(
                  radius: 60,
                  backgroundImage: AssetImage(avatarImg),
                )
              : CustomText(
                  text: userNameLimited,
                  fontSize: 50,
                  color: Colors.white,
                ),
        ),
        SizedBox(height: 10),
        CustomText(
          text: fullname,
          fontSize: 18,
        ),
        // GestureDetector(
        //   // Preferences Settings
        //   onTap: () => print("Go to Setting name"),
        //   child: CustomText(
        //     text: "Change your Preferences",
        //     fontSize: 14,
        //     color: Colors.grey,
        //   ),
        // ),
      ],
    );
  }
}
