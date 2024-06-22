import 'package:event/api/http_manager.dart';
import 'package:event/model/category/category_model.dart';
import 'package:event/model/common/common_model.dart';

class CategoryNetwork {
  static const String categoryListUrl = 'e_admin_get_categories.php';
  static const String categoryDeleteUrl =
      'e_admin_category_delete.php?category_id=';
  static Future<dynamic> getCategoryList() async {
    final result = await httpManager.get(
      url: categoryListUrl,
    );
    CategoryRes response = CategoryRes.fromJson(result);
    return response;
  }

  static Future<dynamic> categoryDelete(params) async {
    final result =
        await httpManager.deleteWithToken(url: "$categoryDeleteUrl$params");
    CommonRes response = CommonRes.fromJson(result);
    return response;
  }
}
