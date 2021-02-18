import 'Classes/ApiAccess.dart';

class ProductCategories {
  ApiAccess api = ApiAccess();
  Future<List> getCats() async {
    try {
      return await api.getCategories();
    } catch (e) {
      return [];
    }
  }
}
