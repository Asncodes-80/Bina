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

  // if key is not null next level is going
  // level 2
  // get Method => user : with your username in top and password in top with this endpoint https://bahoz.ir/rest-auth/user/
  // for getting our pk key from my new user that i register after afew seconds !!

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
}
