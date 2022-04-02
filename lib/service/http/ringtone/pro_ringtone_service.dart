import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:wallpaper_app_flutter/constants/endpoints.dart';
import 'package:wallpaper_app_flutter/model/ringtone/pro_ringtone_model.dart';

class PremimumRingtoneService {
  // Todo Zedge Get Trending Ringtone.....
  Future<List<PremimumRingtoneModel>> getTrending(int page) async {
  
    print(Endpoints.trending(page));
  
    var response = await http.post(
  
      Uri.parse(Endpoints.url),
  
      headers: {"Content-Type": "application/json"},
  
      body: Endpoints.trending(page),
  
    );
  
    log(response.body);
  
    if (response.statusCode == 200)
  
      return (json.decode(response.body)["data"]["browseAsUgc"]["items"]
  
              as List)
  
          .map((i) => PremimumRingtoneModel.fromJson(i))
  
          .toList();
  
    else
  
      return [];
  
  }

  //Todo Zedge Get Result Search with Query Ringtone...
  Future<List<PremimumRingtoneModel>> getResults(String query, int page) async {
  
    var response = await http.post(Uri.parse(Endpoints.url),
  
        headers: {"Content-Type": "application/json"},
  
        body: Endpoints.searchWithQuery(query, page));
  
    if (response.statusCode == 200)
  
      return (json.decode(response.body)["data"]["searchAsUgc"]["items"]
  
              as List)
  
          .map((i) => PremimumRingtoneModel.fromJson(i))
  
          .toList();
  
    else
  
      return [];
  
  }
}


