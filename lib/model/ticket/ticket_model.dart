class TicketRes {
  String? responseCode;
  String? result;
  String? responseMsg;
  List<TicketData> tickets = [];

  TicketRes({responseCode, result, responseMsg, sponsors});

  TicketRes.fromJson(Map<String, dynamic> json) {
    responseCode = json['ResponseCode'];
    result = json['Result'];
    responseMsg = json['ResponseMsg'];
    if (json['tickets'] != null) {
      tickets = <TicketData>[];
      json['tickets'].forEach((v) {
        tickets.add(TicketData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ResponseCode'] = responseCode;
    data['Result'] = result;
    data['ResponseMsg'] = responseMsg;
    if (tickets.isNotEmpty) {
      data['tickets'] = tickets.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TicketData {
  String? id;
  String? eventName;
  String? userName;
  String? price;
  String? totalTicket;
  String? ticketType;
  String? userID;

  TicketData({id, eventName, userName, price, totalTicket, ticketType, userID});

  TicketData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    eventName = json['event_name'];
    userName = json['user_name'];
    price = json['price'];
    totalTicket = json['total_ticket'];
    ticketType = json['ticket_type'];
    userID = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['event_name'] = eventName;
    data['user_name'] = userName;
    data['price'] = price;
    data['total_ticket'] = totalTicket;
    data['ticket_type'] = ticketType;
    data['user_id'] = userID;
    return data;
  }
}
