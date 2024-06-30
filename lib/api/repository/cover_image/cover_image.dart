import 'package:event/api/network/cover_image/cover_image.dart';

class CoverImageRepository {
  Future<dynamic> getCoverImageListApiCall() async {
    return await CoverImageNetwork.getCoverImageList();
  }

  Future<dynamic> coverImageDeleteApiCall({String? coverImageID}) async {
    return await CoverImageNetwork.coverImageDelete(coverImageID);
  }

  Future<dynamic> addCoverImageApiCall({
    String? eventID,
    String? img,
    int? status,
  }) async {
    final body = {
      "eid": eventID,
      "img": img ?? "",
      "status": status,
    };
    return await CoverImageNetwork.addCoverImage(body);
  }

  Future<dynamic> updateCoverImageApiCall({
    String? eventID,
    String? img,
    int? status,
    String? galleryID,
  }) async {
    final body = {
      "eid": eventID,
      "img": img ?? "",
      "status": status,
    };
    return await CoverImageNetwork.updateCoverImage(body, galleryID);
  }
}
