import 'dart:io';

import 'package:dio/dio.dart';
import 'package:event/api/network/category/category.dart';

class CategoryRepository {
  Future<dynamic> getCategoryListApiCall() async {
    return await CategoryNetwork.getCategoryList();
  }

  Future<dynamic> categoryDeleteApiCall({String? userID}) async {
    return await CategoryNetwork.categoryDelete(userID);
  }

  Future<dynamic> addCategoryApiCall(
      {String? title, int? status, File? image, File? coverImage}) async {
    final body = FormData.fromMap({
      "title": title,
      "status": status,
      "image": await MultipartFile.fromFile(image!.path,
          filename: image.path.split('/').last),
      "cover_img": await MultipartFile.fromFile(coverImage!.path,
          filename: coverImage.path.split('/').last),
    });
    return await CategoryNetwork.addCategory(body);
  }
}
