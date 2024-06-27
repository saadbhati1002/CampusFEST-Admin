import 'package:event/api/http_manager.dart';

import 'package:event/model/common/common_model.dart';
import 'package:event/model/faq/faq_model.dart';

class FaqNetwork {
  static const String faqListUrl = 'e_admin_get_faq.php';
  static const String faqDeleteUrl = 'e_admin_delete_faq.php?faq_id=';
  static const String addFaqUrl = 'e_admin_add_faq.php';
  static const String updateFaqCategoryUrl =
      'e_admin_faq_category_update.php?category_id=';

  static Future<dynamic> getFaqList() async {
    final result = await httpManager.get(
      url: faqListUrl,
    );
    FaqRes response = FaqRes.fromJson(result);
    return response;
  }

  static Future<dynamic> faqDelete(params) async {
    final result =
        await httpManager.deleteWithToken(url: "$faqDeleteUrl$params");
    CommonRes response = CommonRes.fromJson(result);
    return response;
  }

  static Future<dynamic> addFaq(params) async {
    final result = await httpManager.post(url: addFaqUrl, data: params);

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
