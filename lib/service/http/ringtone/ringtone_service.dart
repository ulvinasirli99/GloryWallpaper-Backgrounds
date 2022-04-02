import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:wallpaper_app_flutter/constants/endpoints.dart';
import 'package:wallpaper_app_flutter/model/ringtone/ringonte_model.dart';
import 'package:wallpaper_app_flutter/service/http_exception/http_exception.dart';

class RingtoneService {
  
  Future<List<LocalMusicModel>?> openLocalRingtonesMethod() async {
  
    final response = await http.get(
  
      Uri.parse(localMusicListUrl),
  
    );
  
    try {
  
      if (response.statusCode == 200) {
        
        Logger().v("Response Body : "+response.body.toString());
        
        var ringtoneData = jsonDecode(response.body);

        return ringtoneData
        
            .map<LocalMusicModel>(
        
                (jsonBody) => LocalMusicModel.fromJson(jsonBody))
        
            .toList();
    
      } else {
        
        Logger(level: Level.error).e(
        
            "Ringtone Error Response Code : " + response.statusCode.toString());
      
      }
    
    } catch (e) {
    
      var exception = HttpException(e.toString());
    
      Logger().e("Ringtone Catch Error : " + exception.toString());
    
    }

    return null;
  
  }

}
