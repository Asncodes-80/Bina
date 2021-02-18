import 'package:Bina/Model/Classes/ApiAccess.dart';

ApiAccess api = ApiAccess();

class GettingAPIAsyncList {
  Future<List> getProvinces() async {
    try {
      return await api.getProvinces();
    } catch (e) {
      return [];
    }
  }
}
