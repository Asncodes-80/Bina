import 'Classes/ApiAccess.dart';

class ProductCategories {
  ApiAccess api = ApiAccess();
  Future<List> getCats() async {
    try {
      return await api.getCategories();
    } catch (e) {
      print("FROM GET CATEGORIES $e");
      return [];
    }
  }

  Future<List> getProductsByCateId({categoryId}) async {
    try {
      return await api.getProductsByCatId(catId: categoryId);
    } catch (e) {
      print("FROM GET PRODUC WITH CATEGORIES $e");
      return [];
    }
  }

  Future<List> getProductInfo({productionId}) async {
    try {
      return await api.viewProductById(productId: productionId);
    } catch (e) {
      print("GET PRODUCT INFO $e");
      return [];
    }
  }

  Future<List> searchProducts({searchKey}) async {
    try {
      return await api.searchProductByNamed(searchKey: searchKey);
    } catch (e) {
      print("FROM SEARCH PRODUCT $e");
      return [];
    }
  }
}
