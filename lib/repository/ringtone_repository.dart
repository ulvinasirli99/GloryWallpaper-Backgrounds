import 'package:logger/logger.dart';
import 'package:wallpaper_app_flutter/model/ringtone/ringonte_model.dart';
import 'package:wallpaper_app_flutter/service/http/ringtone/ringtone_service.dart';

class RingtoneRepository {
  
  var ringtoneService = RingtoneService();
  
  Future<List<LocalMusicModel>> requestRingtoneRepo() async {
  
    List<LocalMusicModel> ringtoneList = [];
  
    ringtoneList = (await ringtoneService.openLocalRingtonesMethod())!;
  
    Logger(level: Level.info)
  
        .i('RingtoneRepository Initalized : ' + ringtoneList.toString());
  
    return ringtoneList;
  
  }

}
