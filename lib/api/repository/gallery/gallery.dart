import 'package:event/api/network/gallery/gallery.dart';

class GalleryRepository {
  Future<dynamic> getGalleryListApiCall() async {
    return await GalleryNetwork.getGalleryList();
  }

  Future<dynamic> galleryDeleteApiCall({String? galleryID}) async {
    return await GalleryNetwork.galleryDelete(galleryID);
  }

  Future<dynamic> addGalleryApiCall({
    String? eventID,
    String? img,
    int? status,
  }) async {
    final body = {
      "eid": eventID,
      "img": img ?? "",
      "status": status,
    };
    return await GalleryNetwork.addGallery(body);
  }

  Future<dynamic> updateGalleryApiCall({
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
    return await GalleryNetwork.updateGallery(body, galleryID);
  }
}
