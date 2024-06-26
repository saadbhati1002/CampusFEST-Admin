import 'package:event/api/http_manager.dart';

import 'package:event/model/common/common_model.dart';
import 'package:event/model/faq_category/faq_category_model.dart';

class FaqCategoryNetwork {
  static const String faqCategoryListUrl = 'e_admin_get_faq_category.php';
  static const String faqCategoryDeleteUrl =
      'e_admin_faq_category_delete.php?category_id=';
  static const String addFaqCategoryUrl = 'e_admin_add_faq_category.php';
  static const String updateFaqCategoryUrl =
      'e_admin_faq_category_update.php?category_id=';

  static Future<dynamic> getFaqCategoryList() async {
    final result = await httpManager.get(
      url: faqCategoryListUrl,
    );
    FaqCategoryRes response = FaqCategoryRes.fromJson(result);
    return response;
  }

  static Future<dynamic> faqCategoryDelete(params) async {
    final result =
        await httpManager.deleteWithToken(url: "$faqCategoryDeleteUrl$params");
    CommonRes response = CommonRes.fromJson(result);
    return response;
  }

  static Future<dynamic> addFaqCategory(params) async {
    final result = await httpManager.post(url: addFaqCategoryUrl, data: params);

    CommonRes response = CommonRes.fromJson(result);
    return response;
  }

  static Future<dynamic> updateFaqCategory(params, faqCategoryId) async {
    final result = await httpManager.put(
        url: "$updateFaqCategoryUrl$faqCategoryId", data: params);

    CommonRes response = CommonRes.fromJson(result);
    return response;
  }
}
