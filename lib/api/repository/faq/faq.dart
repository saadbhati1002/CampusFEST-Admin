import 'package:event/api/network/faq/faq.dart';

class FaqRepository {
  Future<dynamic> getFaqListApiCall() async {
    return await FaqNetwork.getFaqList();
  }

  Future<dynamic> faqDeleteApiCall({String? userID}) async {
    return await FaqNetwork.faqDelete(userID);
  }

  Future<dynamic> addFaqApiCall({
    String? question,
    String? answer,
    String? catID,
    int? status,
  }) async {
    final body = {
      "fid": catID,
      "question": question,
      "answer": answer,
      "status": 1
    };
    return await FaqNetwork.addFaq(body);
  }

  Future<dynamic> updateFaqCategoryApiCall(
      {String? title, int? status, String? faqCategoryID}) async {
    final body = {
      "title": title,
      "status": status,
    };
    return await FaqNetwork.updateFaqCategory(body, faqCategoryID);
  }
}
