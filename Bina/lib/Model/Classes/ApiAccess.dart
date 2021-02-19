import 'package:Bina/ConstFiles/constInitVar.dart';
import 'package:dio/dio.dart';

class ApiAccess {
  Dio dio = Dio();

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
