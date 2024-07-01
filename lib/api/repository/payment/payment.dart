import 'package:event/api/network/payment/payment.dart';

class PaymentRepository {
  Future<dynamic> getPaymentListApiCall() async {
    return await PaymentNetwork.getPaymentList();
  }

  Future<dynamic> updatePaymentApiCall({
    String? eventID,
    String? img,
    int? status,
    String? type,
    String? price,
    String? limit,
    String? paymentID,
  }) async {
    final body = {
      "eid": eventID,
      "type": type,
      "price": price,
      "tlimit": limit,
      "status": status,
    };
    return await PaymentNetwork.updatePayment(body, paymentID);
  }
}
