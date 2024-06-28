import 'package:event/api/network/sponsor/sponsor.dart';

class SponsorRepository {
  Future<dynamic> getSponsorListApiCall() async {
    return await SponsorNetwork.getSponsorList();
  }

  Future<dynamic> sponsorDeleteApiCall({String? sponsorID}) async {
    return await SponsorNetwork.sponsorDelete(sponsorID);
  }

  Future<dynamic> addSponsorApiCall({
    String? eventID,
    String? img,
    String? title,
    int? status,
  }) async {
    final body = {
      "eid": eventID,
      "img": img ?? "",
      "title": title,
      "status": status,
    };
    return await SponsorNetwork.addSponsor(body);
  }

  Future<dynamic> updateSponsorApiCall({
    String? eventID,
    String? img,
    int? status,
    String? sponsorID,
    String? title,
  }) async {
    final body = {
      "eid": eventID,
      "img": img ?? "",
      "title": title,
      "status": status,
    };
    return await SponsorNetwork.updateSponsor(body, sponsorID);
  }
}
