import 'dart:async';
import 'dart:io';
import 'package:Bina/ConstFiles/Locale/Lang/arabic.dart';
import 'package:Bina/ConstFiles/Locale/Lang/kurdish.dart';
import 'package:Bina/ConstFiles/constInitVar.dart';
import 'package:Bina/ConstFiles/routeStringVar.dart';
import 'package:Bina/Controllers/Location.dart';
import 'package:Bina/Controllers/flusher.dart';
import 'package:Bina/Controllers/imageSourcePicker.dart';
import 'package:Bina/Controllers/validator.dart';
import 'package:Bina/Extracted/customText.dart';
import 'package:Bina/Model/auth/sanityCheck.dart';
import 'package:Bina/Model/gettingProvinces.dart';
import 'package:Bina/Extracted/bottomBtn.dart';
import 'package:Bina/Model/Classes/ThemeColor.dart';
import 'package:Bina/Model/sqflite.dart';
import 'package:Bina/Views/signupPageViews/level1.dart';
import 'package:Bina/Views/signupPageViews/level2.dart';
import 'package:Bina/Views/signupPageViews/level3.dart';
import 'package:Bina/Views/signupPageViews/level4.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

// SQFLITE DB CLASSES
UserBasket basket = UserBasket();
MySaved saved = MySaved();

// image settings for resize and ready to base64 Format
ImgManipulate imgModifire = ImgManipulate();
UserRegisteration uRegister = UserRegisteration();

dynamic themeChange;
int pageIndex = 0;
var _pageContoller;
bool protectedPassword = true;
var showMePass;
Timer timer;

// Level 1 var
String fullname;
String username;
List provinceLs = [];
int _provinceVal;
var _provinceValSelected = "";
File imgSource;
String localAvatar = "";

// Level 2 var
String phoneNumber;

// Level 3 var
String password;
String rePassword;

// Level 4 var
String address;

CurrentUserLocation cul = CurrentUserLocation();
GettingAPIAsyncList gettingAPIAsync = GettingAPIAsyncList();

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  @override
  void initState() {
    // pageIndex = 0;
    // provinceLs = [];
    // _provinceValSelected = "";
    // phoneNumber = "";
    // protectedPassword = true;
    // showMePass = Icons.remove_red_eye;
    // password = "";
    // rePassword = "";
    gettingAPIAsync.getProvinces().then((provincesLs) {
      setState(() {
        provinceLs = provincesLs;
      });
    });
    timer = Timer.periodic(Duration(seconds: 10), (timer) {
      gettingAPIAsync.getProvinces().then((provincesLs) {
        setState(() {
          provinceLs = provincesLs;
        });
      });
    });
    cul.getLocation().then((value) {
      setState(() {
        address = value;
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    pageIndex = 0;
    fullname = "";
    username = "";
    imgSource = null;
    _provinceValSelected = "";
    phoneNumber = "";
    protectedPassword = true;
    showMePass = Icons.remove_red_eye;
    password = "";
    rePassword = "";
    address = "";
    timer.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _pageContoller = PageController();

    themeChange = Provider.of<DarkThemeProvider>(context);
    // print(address);

    // Specify button next in Arabic and Kurdish
    final submissionBtnText =
        themeChange.langName ? arabicLang["next"] : kurdishLang["next"];
    // Specify entery in Main Market page
    final goToMarket =
        themeChange.langName ? arabicLang["loginNow"] : kurdishLang["loginNow"];
    // User can enter in specific function
    final textInNavigatorBtn = pageIndex == 3 ? goToMarket : submissionBtnText;

    // Pick IMAGE
    Future galleryViewer(ImageSource changeType) async {
      final image = await ImagePicker.pickImage(
          source: changeType, imageQuality: 50, maxHeight: 500, maxWidth: 500);
      setState(() {
        imgSource = image;
      });
    }

    List dropItemList = provinceLs != []
        ? provinceLs.map(
            (province) {
              return DropdownMenuItem(
                value: province["id"],
                onTap: () {
                  setState(() {
                    print(province["id"]);
                    _provinceVal = province["id"];
                    _provinceValSelected = themeChange.langName
                        ? province["name_ar"]
                        : province["name_ku"];
                  });
                },
                child: CustomText(
                  text: themeChange.langName
                      ? province["name_ar"]
                      : province["name_ku"],
                ),
              );
            },
          ).toList()
        : [];

    List<Widget> signupPages = [
      InfoLevel1(
        darkTheme: themeChange.darkTheme,
        langName: themeChange.langName,
        initUsername: username,
        onChangeUsername: (onChangeUsername) {
          setState(() {
            // emptyTextFieldErrPersonalCode = null;
            username = onChangeUsername;
          });
        },
        initFullname: fullname,
        provinces: provinceLs != [] ? provinceLs : [],
        dropItem: provinceLs != [] ? dropItemList : [],
        imgSource: imgSource,
        dropItemSelected: _provinceValSelected,
        pickImage: () {
          galleryViewer(ImageSource.gallery);
        },
        onChangeFullname: (onChangeFullname) {
          setState(() {
            // emptyTextFieldErrPersonalCode = null;
            fullname = onChangeFullname;
          });
        },
        aw1Pressed: () => setState(() => localAvatar = "assets/images/aw1.png"),
        aw2Pressed: () => setState(() => localAvatar = "assets/images/aw2.png"),
        aw3Pressed: () => setState(() => localAvatar = "assets/images/aw3.png"),
        aw4Pressed: () => setState(() => localAvatar = "assets/images/aw4.png"),
      ),
      PhoneSection(
        themeChanged: themeChange.langName,
        phoneNum: phoneNumber,
        onChangePhoneNumber: (phone) =>
            setState(() => phoneNumber = phone.completeNumber),
      ),
      PrivacySection(
        themeChange: themeChange.langName,
        protectedPassword: protectedPassword,
        password: password,
        rePassword: rePassword,
        showMePass: showMePass,
        passChanged: (pass) => setState(() => password = pass),
        rePassChanged: (rePass) => setState(() => rePassword = rePass),
        hidePasswordIconPressed: () {
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
      ),
      UserLocation(
        themeChange: themeChange.langName,
        address: address,
        onChangeAddress: (onChangeAddre) =>
            setState(() => address = onChangeAddre),
      ),
    ];

    return WillPopScope(
      // ignore: missing_return
      onWillPop: () {
        if (pageIndex <= 3 && pageIndex > 0) {
          _pageContoller.animateToPage(pageIndex -= 1,
              duration: Duration(milliseconds: 600), curve: Curves.decelerate);
        } else if (pageIndex == 0) {
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: PageView(
            controller: _pageContoller,
            onPageChanged: (index) {
              setState(() {
                pageIndex = index;
              });
            },
            children: signupPages,
          ),
        ),
        bottomNavigationBar: BottomButton(
          onTapped: () => pageIndex == 3
              ? navigatedToMarket(
                  avatar: localAvatar,
                  fullname: fullname,
                  username: username,
                  province: _provinceVal,
                  phoneNo: phoneNumber,
                  pass: password,
                  rePass: rePassword,
                  address: address)
              : nextPageNavigator(),
          color: actionCt,
          text: textInNavigatorBtn,
        ),
      ),
    );
  }

  void nextPageNavigator() {
    setState(() {
      pageIndex += 1;
    });
    _pageContoller.animateToPage(pageIndex,
        duration: Duration(milliseconds: 600), curve: Curves.decelerate);
  }

  Future<void> navigatedToMarket(
      {avatar,
      fullname,
      username,
      province,
      phoneNo,
      String pass,
      String rePass,
      address}) async {
    Validator validate = Validator();
    if (fullname != "" &&
        username != "" &&
        province != "" &&
        phoneNo != "" &&
        pass != "" &&
        rePass != "" &&
        address != "") {
      bool validatePassword = validate.passwordRegex(pass);
      bool validateRePassword = validate.passwordRegex(rePass);
      if (pass.length > 6 && rePass.length > 6) {
        if (validatePassword && validateRePassword) {
          if (pass == rePass) {
            // print(
            //     "$fullname -  $username - $province, $phoneNo, $pass,  $rePass, $address $avatar");
            // print(formData);
            // print(_imgSource64);

            bool registerResult = await uRegister.userRegistration(
                avatar: avatar,
                username: username,
                fullname: fullname,
                phoneNo: phoneNo,
                password: pass,
                repassword: rePass,
                province: province,
                address: address);

            if (registerResult) {
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
                      ? arabicLang["signupFaildDsc"]
                      : kurdishLang["signupFaildDsc"],
                  title: themeChange.langName
                      ? arabicLang["signupFaildTitle"]
                      : kurdishLang["signupFaildTitle"]);
            }
          } else {
            showStatusInCaseOfFlush(
                context: context,
                icon: Icons.vpn_key_sharp,
                iconColor: actionCt,
                msg: themeChange.langName
                    ? arabicLang["notCorespondPassword"]
                    : kurdishLang["notCorespondPassword"],
                title: "");
          }
        } else {
          // Password is not valid
          print("Password is not valid");
          showStatusInCaseOfFlush(
              context: context,
              icon: Icons.vpn_key_sharp,
              iconColor: actionCt,
              msg: themeChange.langName
                  ? arabicLang["complexPass"]
                  : kurdishLang["complexPass"],
              title: "");
        }
      } else {
        // password Length is not enough
        print("password Length is not enough");
        showStatusInCaseOfFlush(
            context: context,
            icon: Icons.low_priority,
            iconColor: actionCt,
            msg: themeChange.langName
                ? arabicLang["moreThan6Pass"]
                : kurdishLang["moreThan6Pass"],
            title: "");
      }
    } else {
      // Some form is empty
      print("Some form is empty");
      showStatusInCaseOfFlush(
          context: context,
          icon: Icons.format_align_left,
          iconColor: actionCt,
          msg: themeChange.langName
              ? arabicLang["emptyField"]
              : kurdishLang["emptyField"],
          title: "");
    }
  }
}
