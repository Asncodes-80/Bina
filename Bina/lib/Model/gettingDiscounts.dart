import 'package:Bina/Model/Classes/ApiAccess.dart';

class Discounts {
  ApiAccess api = ApiAccess();

  Future<List> getAllDiscounts() async {
    try {
      return await api.getAllDiscount();
    } catch (e) {
      return [];
    }
  }
}
