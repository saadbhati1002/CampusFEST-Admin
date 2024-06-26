import 'package:event/api/network/faq_category/faq_category.dart';

class FaqCategoryRepository {
  Future<dynamic> getFaqCategoryListApiCall() async {
    return await FaqCategoryNetwork.getFaqCategoryList();
  }

  Future<dynamic> faqCategoryDeleteApiCall({String? userID}) async {
    return await FaqCategoryNetwork.faqCategoryDelete(userID);
  }

  Future<dynamic> addCategoryApiCall({
    String? title,
    int? status,
  }) async {
    final body = {
      "title": title,
      "status": status,
    };
    return await FaqCategoryNetwork.addFaqCategory(body);
  }
}
