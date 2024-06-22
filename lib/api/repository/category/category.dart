import 'package:event/api/network/category/category.dart';

class CategoryRepository {
  Future<dynamic> getCategoryListApiCall() async {
    return await CategoryNetwork.getCategoryList();
  }

  Future<dynamic> categoryDeleteApiCall({String? userID}) async {
    return await CategoryNetwork.categoryDelete(userID);
  }
}
