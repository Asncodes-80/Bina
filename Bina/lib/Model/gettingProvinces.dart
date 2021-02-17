import 'package:Bina/Model/Classes/ApiAccess.dart';

ApiAccess api = ApiAccess();

class GettingAPIAsyncList {
  Future<List> getProvinces() async {
    return await api.getProvinces();
  }
}
