import 'package:event/api/http_manager.dart';
import 'package:event/model/common/common_model.dart';
import 'package:event/model/payment/payment_model.dart';

class PaymentNetwork {
  static const String paymentListUrl = 'e_admin_get_payments_list.php';

  static const String updatePaymentUrl =
      'e_admin_update_payment.php?payment_id=';

  static Future<dynamic> getPaymentList() async {
    final result = await httpManager.get(
      url: paymentListUrl,
    );
    PaymentRes response = PaymentRes.fromJson(result);
    return response;
  }

  static Future<dynamic> updatePayment(params, paymentID) async {
    final result =
        await httpManager.put(url: "$updatePaymentUrl$paymentID", data: params);

    CommonRes response = CommonRes.fromJson(result);
    return response;
  }
}
