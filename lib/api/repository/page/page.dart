import 'package:event/api/network/page/page.dart';

class PageRepository {
  Future<dynamic> getPageListApiCall() async {
    return await PageNetwork.getPageList();
  }

  Future<dynamic> pageDeleteApiCall({String? pageID}) async {
    return await PageNetwork.pageDelete(pageID);
  }

  Future<dynamic> addPageApiCall({
    String? title,
    String? description,
    int? status,
  }) async {
    final body = {
      "title": title,
      "description": description,
      "status": status,
    };
    return await PageNetwork.addPage(body);
  }

  Future<dynamic> updatePageApiCall({
    String? title,
    String? description,
    int? status,
    String? pageID,
  }) async {
    final body = {
      "title": title,
      "description": description,
      "status": status,
    };
    return await PageNetwork.updatePage(body, pageID);
  }
}
