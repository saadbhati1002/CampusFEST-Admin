class PriceTypeRes {
  String? responseCode;
  String? result;
  String? responseMsg;
  List<PriceTypeData> priceType = [];

  PriceTypeRes({responseCode, result, responseMsg, priceType});

  PriceTypeRes.fromJson(Map<String, dynamic> json) {
    responseCode = json['ResponseCode'];
    result = json['Result'];
    responseMsg = json['ResponseMsg'];
    if (json['price_type'] != null) {
      priceType = <PriceTypeData>[];
      json['price_type'].forEach((v) {
        priceType.add(PriceTypeData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ResponseCode'] = responseCode;
    data['Result'] = result;
    data['ResponseMsg'] = responseMsg;
    if (priceType.isNotEmpty) {
      data['price_type'] = priceType.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PriceTypeData {
  String? id;
  String? eventName;
  String? type;
  String? price;
  String? ticketLimit;
  String? ticketBook;
  String? status;
  String? eventID;

  PriceTypeData({id, eventName, type, price, ticketLimit, ticketBook, status});

  PriceTypeData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    eventName = json['event_name'];
    type = json['type'];
    price = json['price'];
    ticketLimit = json['tlimit'];
    ticketBook = json['ticket_book'];
    status = json['status'];
    eventID = json['event_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['event_name'] = eventName;
    data['type'] = type;
    data['price'] = price;
    data['tlimit'] = ticketLimit;
    data['ticket_book'] = ticketBook;
    data['status'] = status;
    return data;
  }
}
