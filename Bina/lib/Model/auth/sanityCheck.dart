import 'dart:io';

import 'package:Bina/Model/Classes/ApiAccess.dart';
import 'package:Bina/Model/Classes/userInfoLDS.dart';
import 'package:dio/dio.dart';

ApiAccess api = ApiAccess();
SavingData LDS = SavingData();

class UserRegisteration {
  // Converting to bool
  Future<bool> userRegistration(
      {avatar,
      username,
      fullname,
      province,
      phoneNo,
      password,
      repassword,
      address}) async {
    try {
      try {
        await api.basicAuthUserSubmissionFirst(
            username: username, pass: password, rePass: repassword);
      } catch (e) {
        print("This is $e");
      }
      int pkId = await api.basicAuthUserSubmissionSecond(
          username: username, pass: password);

      print("This is Pk id $pkId");

      // print("$username / $password/ $repassword");

      try {
        await api.basicAuthUserSubmissionThired(
            uPK: pkId,
            username: username,
            pass: password,
            fullname: fullname,
            phone: phoneNo,
            province: province,
            address: address,
            avatarImg: avatar);
      } catch (e) {
        print("This is thired $e");
      }

      List<dynamic> userInfo = await api.getttingUserAccountInfo(uPK: pkId);
      // print(userInfo[0]['user']['id']);
      // print(userInfo[0]['user']['username']);
      // print(userInfo[0]['profile_image']);
      // print(userInfo[0]['full_name']);
      // print(userInfo[0]['phone_number']);
      // print(userInfo[0]['address']);
      // print(userInfo[0]['province']['name_ar']);
      // print(userInfo[0]['province']['name_ku']);

      print(userInfo);

      bool ldsSavingResult = await LDS.LDS(
          userId: userInfo[0]['user']['id'].toString(),
          username: userInfo[0]['user']['username'],
          avatar: userInfo[0]['profile_image'],
          fullname: userInfo[0]['full_name'],
          phone: userInfo[0]['phone_number'],
          address: userInfo[0]['address'],
          province_ar: userInfo[0]['province']['name_ar'],
          province_ku: userInfo[0]['province']['name_ku']);

      return ldsSavingResult;
    } catch (e) {
      print(e);
      return false;
    }
  }
}

class UserLogin {
  Future<bool> gettingLogin({username, password}) async {
    try {
      int userPKId = await api.basicAuthUserSubmissionSecond(
          username: username, pass: password);

      List<dynamic> userInfo = await api.getttingUserAccountInfo(uPK: userPKId);
      // print(userInfo[0]['user']['id']);
      // print(userInfo[0]['user']['username']);
      // print(userInfo[0]['profile_image']);
      // print(userInfo[0]['full_name']);
      // print(userInfo[0]['phone_number']);
      // print(userInfo[0]['address']);
      // print(userInfo[0]['province']['name_ar']);
      // print(userInfo[0]['province']['name_ku']);

      bool ldsSavingResult = await LDS.LDS(
          userId: userInfo[0]['user']['id'].toString(),
          username: userInfo[0]['user']['username'],
          avatar: userInfo[0]['profile_image'],
          fullname: userInfo[0]['full_name'],
          phone: userInfo[0]['phone_number'],
          address: userInfo[0]['address'],
          province_ar: userInfo[0]['province']['name_ar'],
          province_ku: userInfo[0]['province']['name_ku']);

      return ldsSavingResult;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
