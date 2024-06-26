import 'package:event/api/http_manager.dart';

import 'package:event/model/common/common_model.dart';
import 'package:event/model/faq_category/faq_category_model.dart';

class FaqCategoryNetwork {
  static const String faqCategoryListUrl = 'e_admin_get_faq_category.php';
  static const String categoryDeleteUrl =
      'e_admin_category_delete.php?category_id=';
  static const String addCategoryUrl = 'e_admin_add_category.php';
  static const String updateCategoryUrl =
      'e_admin_update_category.php?category_id=';

  static Future<dynamic> getFaqCategoryList() async {
    final result = await httpManager.get(
      url: faqCategoryListUrl,
    );
    FaqCategoryRes response = FaqCategoryRes.fromJson(result);
    return response;
  }

  static Future<dynamic> categoryDelete(params) async {
    final result =
        await httpManager.deleteWithToken(url: "$categoryDeleteUrl$params");
    CommonRes response = CommonRes.fromJson(result);
    return response;
  }

  static Future<dynamic> addCategory(params) async {
    final result = await httpManager.post(url: addCategoryUrl);

    CommonRes response = CommonRes.fromJson(result);
    return response;
  }
}
