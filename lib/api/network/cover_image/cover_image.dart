import 'package:event/api/http_manager.dart';
import 'package:event/model/common/common_model.dart';
import 'package:event/model/gallery/gallery_model.dart';

class CoverImageNetwork {
  static const String coverImageListUrl = 'e_admin_get_cover_image.php';
  static const String coverImageDeleteUrl =
      'e_admin_delete_cover_image.php?cover_id=';
  static const String addCoverImageUrl = 'e_admin_add_cover_image.php';
  static const String updateCoverImageUrl =
      'e_admin_update_cover_image.php?cover_id=';

  static Future<dynamic> getCoverImageList() async {
    final result = await httpManager.get(
      url: coverImageListUrl,
    );
    GalleryRes response = GalleryRes.fromJson(result);
    return response;
  }

  static Future<dynamic> coverImageDelete(params) async {
    final result =
        await httpManager.deleteWithToken(url: "$coverImageDeleteUrl$params");
    CommonRes response = CommonRes.fromJson(result);
    return response;
  }

  static Future<dynamic> addCoverImage(params) async {
    final result = await httpManager.post(url: addCoverImageUrl, data: params);

    CommonRes response = CommonRes.fromJson(result);
    return response;
  }

  static Future<dynamic> updateCoverImage(params, galleryID) async {
    final result = await httpManager.put(
        url: "$updateCoverImageUrl$galleryID", data: params);

    CommonRes response = CommonRes.fromJson(result);
    return response;
  }
}
