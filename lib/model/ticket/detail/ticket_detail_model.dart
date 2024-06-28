class TicketDetailRes {
  String? responseCode;
  String? result;
  String? responseMsg;
  TicketDetailData? ticketData;

  TicketDetailRes({responseCode, result, responseMsg, ticketData});

  TicketDetailRes.fromJson(Map<String, dynamic> json) {
    responseCode = json['ResponseCode'];
    result = json['Result'];
    responseMsg = json['ResponseMsg'];
    ticketData = json['TicketData'] != null
        ? TicketDetailData.fromJson(json['TicketData'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ResponseCode'] = responseCode;
    data['Result'] = result;
    data['ResponseMsg'] = responseMsg;
    if (ticketData != null) {
      data['TicketData'] = ticketData!.toJson();
    }
    return data;
  }
}

class TicketDetailData {
  String? ticketId;
  String? ticketTitle;
  String? startTime;
  String? eventAddress;
  String? eventAddressTitle;
  String? eventLatitude;
  String? eventLongitude;

  String? ticketUsername;
  String? ticketMobile;
  String? ticketEmail;
  String? ticketType;
  String? totalTicket;
  String? ticketSubtotal;
  String? ticketCouAmt;
  String? ticketWallAmt;
  String? ticketTax;
  String? ticketTotalAmt;
  String? ticketPMethod;
  String? ticketTransactionId;
  String? ticketStatus;

  TicketDetailData(
      {ticketId,
      ticketTitle,
      startTime,
      eventAddress,
      eventAddressTitle,
      eventLatitude,
      eventLongitude,
      ticketUsername,
      ticketMobile,
      ticketEmail,
      ticketType,
      totalTicket,
      ticketSubtotal,
      ticketCouAmt,
      ticketWallAmt,
      ticketTax,
      ticketTotalAmt,
      ticketPMethod,
      ticketTransactionId,
      ticketStatus});

  TicketDetailData.fromJson(Map<String, dynamic> json) {
    ticketId = json['ticket_id'];
    ticketTitle = json['ticket_title'];
    startTime = json['start_time'];
    eventAddress = json['event_address'];
    eventAddressTitle = json['event_address_title'];
    eventLatitude = json['event_latitude'];
    eventLongitude = json['event_longtitude'];

    ticketUsername = json['ticket_username'];
    ticketMobile = json['ticket_mobile'];
    ticketEmail = json['ticket_email'];
    ticketType = json['ticket_type'];
    totalTicket = json['total_ticket'];
    ticketSubtotal = json['ticket_subtotal'];
    ticketCouAmt = json['ticket_cou_amt'];
    ticketWallAmt = json['ticket_wall_amt'];
    ticketTax = json['ticket_tax'];
    ticketTotalAmt = json['ticket_total_amt'];
    ticketPMethod = json['ticket_p_method'];
    ticketTransactionId = json['ticket_transaction_id'];
    ticketStatus = json['ticket_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ticket_id'] = ticketId;
    data['ticket_title'] = ticketTitle;
    data['start_time'] = startTime;
    data['event_address'] = eventAddress;
    data['event_address_title'] = eventAddressTitle;
    data['event_latitude'] = eventLatitude;
    data['event_longtitude'] = eventLongitude;

    data['ticket_username'] = ticketUsername;
    data['ticket_mobile'] = ticketMobile;
    data['ticket_email'] = ticketEmail;
    data['ticket_type'] = ticketType;
    data['total_ticket'] = totalTicket;
    data['ticket_subtotal'] = ticketSubtotal;
    data['ticket_cou_amt'] = ticketCouAmt;
    data['ticket_wall_amt'] = ticketWallAmt;
    data['ticket_tax'] = ticketTax;
    data['ticket_total_amt'] = ticketTotalAmt;
    data['ticket_p_method'] = ticketPMethod;
    data['ticket_transaction_id'] = ticketTransactionId;
    data['ticket_status'] = ticketStatus;
    return data;
  }
}
