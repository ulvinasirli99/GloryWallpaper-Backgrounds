import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:wallpaper_app_flutter/model/pro/img_model_pro.dart';

class ProImageApiProvider {
  Future<ImgModelPro> getProImages(int count) async {
    final response = await http
        .get("https://api.pexels.com/v1/search?query=colors&page=$count", headers: {
      "Authorization":
          "563492ad6f91700001000001170a1aaf91314c06aa81a16c22e20d18"
    });
    if (response.statusCode == 200) {
      return ImgModelPro.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to get images');
    }
  }
  Future<ImgModelPro> getSearchedProImages(String query,int page) async {
    final response = await http
        .get("https://api.pexels.com/v1/search?query=$query&per_page=30&page=$page", headers: {
      "Authorization":
      "563492ad6f91700001000001170a1aaf91314c06aa81a16c22e20d18"
    });
    if (response.statusCode == 200) {
      return ImgModelPro.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to get images');
    }
  }
}
