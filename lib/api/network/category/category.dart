import 'package:event/api/http_manager.dart';
import 'package:event/model/category/category_model.dart';

class CategoryNetwork {
  static const String categoryListUrl = 'e_admin_get_categories.php';
  static Future<dynamic> getCategoryList() async {
    final result = await httpManager.get(
      url: categoryListUrl,
    );

    CategoryRes response = CategoryRes.fromJson(result);
    return response;
  }
}
