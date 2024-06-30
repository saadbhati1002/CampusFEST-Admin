import 'package:event/api/http_manager.dart';
import 'package:event/model/common/common_model.dart';
import 'package:event/model/price_type/price_type_model.dart';

class PriceTypeNetwork {
  static const String priceTypeListUrl = 'e_admin_get_price_type.php';
  static const String priceTypeDeleteUrl =
      'e_admin_delete_price_type.php?price_type_id=';
  static const String addPriceTypeUrl = 'e_admin_add_price_type.php';
  static const String updatePriceTypeUrl =
      'e_admin_update_price_type.php?price_type_id=';

  static Future<dynamic> getPriceTypeList() async {
    final result = await httpManager.get(
      url: priceTypeListUrl,
    );
    PriceTypeRes response = PriceTypeRes.fromJson(result);
    return response;
  }

  static Future<dynamic> priceTypeDelete(params) async {
    final result =
        await httpManager.deleteWithToken(url: "$priceTypeDeleteUrl$params");
    CommonRes response = CommonRes.fromJson(result);
    return response;
  }

  static Future<dynamic> addPriceType(params) async {
    print(params);
    final result = await httpManager.post(url: addPriceTypeUrl, data: params);

    CommonRes response = CommonRes.fromJson(result);
    return response;
  }

  static Future<dynamic> updatePriceType(params, galleryID) async {
    final result = await httpManager.put(
        url: "$updatePriceTypeUrl$galleryID", data: params);

    CommonRes response = CommonRes.fromJson(result);
    return response;
  }
}
