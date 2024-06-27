import 'package:event/api/http_manager.dart';

import 'package:event/model/common/common_model.dart';

import 'package:event/model/page/page_model.dart';

class PageNetwork {
  static const String pageListUrl = 'e_admin_get_pages.php';
  static const String pageDeleteUrl = 'e_admin_delete_page.php?page_id=';
  static const String addPageUrl = 'e_admin_add_page.php';
  static const String updatePageUrl = 'e_admin_update_page.php?page_id=';

  static Future<dynamic> getPageList() async {
    final result = await httpManager.get(
      url: pageListUrl,
    );
    PageRes response = PageRes.fromJson(result);
    return response;
  }

  static Future<dynamic> pageDelete(params) async {
    final result =
        await httpManager.deleteWithToken(url: "$pageDeleteUrl$params");
    CommonRes response = CommonRes.fromJson(result);
    return response;
  }

  static Future<dynamic> addPage(params) async {
    final result = await httpManager.post(url: addPageUrl, data: params);

    CommonRes response = CommonRes.fromJson(result);
    return response;
  }

  static Future<dynamic> updatePage(params, pageId) async {
    final result =
        await httpManager.put(url: "$updatePageUrl$pageId", data: params);

    CommonRes response = CommonRes.fromJson(result);
    return response;
  }
}
