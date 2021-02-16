import 'package:Bina/ConstFiles/constInitVar.dart';
import 'package:dio/dio.dart';

class ApiAccess {
  Dio dio = Dio();

  Future<List> getProvinces() async {
    Response res = await dio.get("$baseURL/provinces");
    return res.data;
  }
}
