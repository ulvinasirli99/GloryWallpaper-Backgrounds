import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:wallpaper_app_flutter/utils/global/constants.dart';

import '../../../model/local/image_model.dart';

class ApiProvider {
  Future<ImageModel> getImages(int count) async {
    final response = await http.get(
        Uri.parse('${apiUrl}editors_choice=true&per_page=$count'));
    if (response.statusCode == 200) {
      return ImageModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to get images');
    }
  }

  Future<ImageModel> getSearchedImages(String query, int page) async {
    final response = await http.get(Uri.parse('${apiUrl}q=$query&page=$page'));
    if (response.statusCode == 200) {
      return ImageModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to get images');
    }
  }
}
