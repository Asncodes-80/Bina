import 'package:Bina/Model/Classes/ApiAccess.dart';

ApiAccess api = ApiAccess();

class GettingProvincesList {
  Future<List> getProvinces() async {
    return await api.getProvinces();
  }
}
