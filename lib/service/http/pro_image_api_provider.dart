import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:wallpaper_app_flutter/model/pro/img_model_pro.dart';
import 'package:wallpaper_app_flutter/utils/global/constants.dart';

class ProImageApiProvider {
 
  Future<ImgModelPro> getProImages(int count) async {
 
    final response = await http.get(
 
       Uri.parse( "https://api.pexels.com/v1/search?query=colors&page=$count"),
 
        headers: {
 
          "Authorization": realPexelKey,
 
        });
 
    if (response.statusCode == 200) {
 
      return ImgModelPro.fromJson(jsonDecode(response.body));
 
 
    } else {
 
      throw Exception('Failed to get Pexel Images');
 
    }
 
  }


  Future<ImgModelPro> getSearchedProImages(String query, int page) async {

    final response = await http.get(

       Uri.parse( "https://api.pexels.com/v1/search?query=$query&per_page=30&page=$page"),

        headers: {

          "Authorization": realPexelKey,

        });

    if (response.statusCode == 200) {

      return ImgModelPro.fromJson(jsonDecode(response.body));

    } else {

      throw Exception('Failed to get Pexel Images');

    }

  }

}
