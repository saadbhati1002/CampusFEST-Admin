import 'package:event/api/http_manager.dart';
import 'package:event/model/common/common_model.dart';
import 'package:event/model/sponsor/sponsor_model.dart';

class SponsorNetwork {
  static const String sponsorListUrl = 'e_admin_get_sponsors.php';
  static const String sponsorDeleteUrl =
      'e_admin_delete_sponsor.php?sponsor_id=';
  static const String addSponsorUrl = 'e_admin_add_sponsor.php';
  static const String updateSponsorUrl =
      'e_admin_update_sponsor.php?sponsor_id=';

  static Future<dynamic> getSponsorList() async {
    final result = await httpManager.get(
      url: sponsorListUrl,
    );
    SponsorRes response = SponsorRes.fromJson(result);
    return response;
  }

  static Future<dynamic> sponsorDelete(params) async {
    final result =
        await httpManager.deleteWithToken(url: "$sponsorDeleteUrl$params");
    CommonRes response = CommonRes.fromJson(result);
    return response;
  }

  static Future<dynamic> addSponsor(params) async {
    final result = await httpManager.post(url: addSponsorUrl, data: params);

    CommonRes response = CommonRes.fromJson(result);
    return response;
  }

  static Future<dynamic> updateSponsor(params, sponsorID) async {
    final result =
        await httpManager.put(url: "$updateSponsorUrl$sponsorID", data: params);

    CommonRes response = CommonRes.fromJson(result);
    return response;
  }
}
