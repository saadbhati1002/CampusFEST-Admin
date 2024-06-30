import 'package:event/api/network/price_type/price_type.dart';

class PriceTypeRepository {
  Future<dynamic> getPriceTypeListApiCall() async {
    return await PriceTypeNetwork.getPriceTypeList();
  }

  Future<dynamic> priceTypeDeleteApiCall({String? priceTypeID}) async {
    return await PriceTypeNetwork.priceTypeDelete(priceTypeID);
  }

  Future<dynamic> addPriceTypeApiCall({
    String? eventID,
    String? type,
    String? price,
    String? limit,
    int? status,
  }) async {
    final body = {
      "eid": eventID,
      "type": type,
      "price": price,
      "tlimit": limit,
      "status": status,
    };
    return await PriceTypeNetwork.addPriceType(body);
  }

  Future<dynamic> updatePriceTypeApiCall({
    String? eventID,
    String? img,
    int? status,
    String? type,
    String? price,
    String? limit,
    String? priceTypeID,
  }) async {
    final body = {
      "eid": eventID,
      "type": type,
      "price": price,
      "tlimit": limit,
      "status": status,
    };
    return await PriceTypeNetwork.updatePriceType(body, priceTypeID);
  }
}
