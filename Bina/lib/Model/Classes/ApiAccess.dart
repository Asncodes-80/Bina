import 'dart:convert';

import 'package:Bina/ConstFiles/constInitVar.dart';
import 'package:dio/dio.dart';

class ApiAccess {
  Dio dio = Dio();

  // ============================Auth Level Registration: ============================
  // Level 1:
  // with basic auth user: admin pass: admin  and
  // post the https://bahoz.ir/rest-auth/registration/
  // by => going to body raw data json format username, password1, password2
  // start to post and will get a token as a user key

  Future<String> basicAuthUserSubmissionFirst({username, pass, rePass}) async {
    String adminUsername = "admin";
    String adminPassword = "admin";
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$adminUsername:$adminPassword'));

    dio.options.headers['content-Type'] = 'application/json';
    dio.options.headers["authorization"] = basicAuth;
    Response res = await dio.post("$baseURL/rest-auth/registration/", data: {
      "username": username,
      "password1": pass,
      "password2": rePass,
    });
    print("This is $res");

    return res.data["key"];
  }

  // if key is not null next level is going
  // level 2
  // get Method => user : with your username in top and password in top with this endpoint https://bahoz.ir/rest-auth/user/
  // for getting our pk key from my new user that i register after afew seconds !!

  // This Func called level 2 can be use in level 1 of user login!!
  Future<int> basicAuthUserSubmissionSecond({username, pass}) async {
    String basicUsername = username;
    String basicPassword = pass;
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$basicUsername:$basicPassword'));
    // print(dio.options.headers["Authorization"] = basicAuth);
    dio.options.headers['content-Type'] = 'application/json';
    dio.options.headers["authorization"] = basicAuth;
    Response res = await dio.get("$baseURL/rest-auth/user/");
    return res.data["pk"];
  }

  // if pk id is not null and next level
  // Level 3
  //  use the level 2 username and passsword in basic auth
  //  next of using all use this data in endpoint post => https://bahoz.ir/account_infos/ with following json format key : val
  //{
  //     "user": 22, // use my pk user id
  //     "fname": "Ahmad",
  //     "lname": "Ahmadi",
  //     "phone_number": "0987654321",
  //     "province": 2,
  //     "address": "askdnksndks"
  // }

  Future<dynamic> basicAuthUserSubmissionThired(
      {username,
      pass,
      int uPK,
      fullname,
      phone,
      province,
      address,
      avatarImg}) async {
    // print("$username / $pass");
    // print("$uPK / $fullname");
    // print("$phone / $province");
    // print("$avatarImg");
    String basicUsername = username;
    String basicPassword = pass;
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$basicUsername:$basicPassword'));

    dio.options.headers['content-Type'] = 'application/json';
    dio.options.headers["authorization"] = basicAuth;

    // var formData = FormData.fromMap({
    //   "user": uPK,
    //   "full_name": fullname,
    //   "phone_number": phone,
    //   "province": province,
    //   "address": address
    // "profile_image":
    //     await MultipartFile.fromFile(avatarImg.path, filename: "avatar.png")
    // });
    // Response res = await dio.post("$baseURL/account_infos/", data: formData);
    Response res = await dio.post("$baseURL/account_infos/", data: {
      "user": uPK,
      "full_name": fullname,
      "phone_number": phone,
      "province": province,
      "address": address,
      // "profile_image": avatarImg
    });
    print("fuck");

    print(res.data);
    return res.data;
  }

  // Level 4
  Future<List<dynamic>> getttingUserAccountInfo({uPK}) async {
    Response res = await dio.get("$baseURL/show_me_account_infos/?user=$uPK");
    return res.data;
  }

  // End of all registration

  // ============================Auth Level authenticated user by username and password: ============================
  // Level 1:
  // with basic auth user: admin pass: admin  and
  // post the https://bahoz.ir/rest-auth/registration/
  // by => going to body raw data json format username, password1, password2
  // start to post and will get a token as a user key
  // if key is not null go to next level and will get pk user id

  // Level 2
  // https://bahoz.ir/show_me_account_infos/?user=pkId
  // and enjoy

  Future<List> getProvinces() async {
    Response res = await dio.get("$baseURL/provinces");
    return res.data;
  }

  Future<List> getCategories() async {
    Response categories = await dio.get("$baseURL/categories");
    return categories.data;
  }

  Future<List> getAllDiscount() async {
    Response discounts = await dio.get("$baseURL/discounts");
    return discounts.data;
  }

  Future<List> getProductsByCatId({catId}) async {
    Response productsCate = await dio.get("$baseURL/products/?category=$catId");
    return productsCate.data;
  }

  Future<List> viewProductById({productId}) async {
    Response productShow = await dio.get("$baseURL/products/?id=$productId");
    return productShow.data;
  }

  Future<List> searchProductByNamed({searchKey}) async {
    // String apiEndpointArabic = "$baseURL/products/?name_ar=$searchKey";
    // String apiEndpointKurdi = "$baseURL/products/?name_ku=$searchKey";
    // if (langBool) {
    //   Response productShow = await dio.get(apiEndpointArabic);
    //   return productShow.data;
    // } else {
    //   Response productShow = await dio.get(apiEndpointKurdi);
    //   return productShow.data;
    // }
    Response productSearched =
        await dio.get("$baseURL/search_products/?search=$searchKey");
    return productSearched.data;
  }

  Future<void> sendingUserOders({userId, productId, productCount, sum}) async {
    await dio.post("$baseURL/orders/", data: {
      "user": userId,
      "product": productId,
      "count": productCount,
      "sum": sum
    });
  }

  Future<dynamic> gettingOrderLengthByUserId({uId}) async {
    Response res = await dio.get("$baseURL/orders/?user=$uId");
    return res.data.length;
  }
}
