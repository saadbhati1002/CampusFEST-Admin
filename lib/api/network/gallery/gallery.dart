import 'package:event/api/http_manager.dart';
import 'package:event/model/common/common_model.dart';
import 'package:event/model/gallery/gallery_model.dart';

class GalleryNetwork {
  static const String galleryListUrl = 'e_admin_get_gallery.php';
  static const String galleryDeleteUrl =
      'e_admin_delete_gallery.php?gallery_id=';
  static const String addGalleryUrl = 'e_admin_add_gallery_image.php';
  static const String updateGalleryUrl =
      'e_admin_update_gallery.php?gallery_id=';

  static Future<dynamic> getGalleryList() async {
    final result = await httpManager.get(
      url: galleryListUrl,
    );
    GalleryRes response = GalleryRes.fromJson(result);
    return response;
  }

  static Future<dynamic> galleryDelete(params) async {
    final result =
        await httpManager.deleteWithToken(url: "$galleryDeleteUrl$params");
    CommonRes response = CommonRes.fromJson(result);
    return response;
  }

  static Future<dynamic> addGallery(params) async {
    final result = await httpManager.post(url: addGalleryUrl, data: params);

    CommonRes response = CommonRes.fromJson(result);
    return response;
  }

  static Future<dynamic> updateGallery(params, galleryID) async {
    final result =
        await httpManager.put(url: "$updateGalleryUrl$galleryID", data: params);

    CommonRes response = CommonRes.fromJson(result);
    return response;
  }
}
