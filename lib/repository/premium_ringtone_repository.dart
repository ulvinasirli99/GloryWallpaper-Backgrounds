import 'package:wallpaper_app_flutter/model/ringtone/pro_ringtone_model.dart';
import 'package:wallpaper_app_flutter/service/http/ringtone/pro_ringtone_service.dart';

class PremiumRingtoneRepository {

  
  // Todo PremimumRingtoneService Initazlized...
  PremimumRingtoneService premimumRingtoneService = PremimumRingtoneService();
 
  // Todo Premimum Get Trending Ringonte Repository
  Future<List<PremimumRingtoneModel>> getTrending(int page) async {
 
    List<PremimumRingtoneModel> modelList =
 
        await premimumRingtoneService.getTrending(page);
 
    return modelList;
 
  }

  // Todo Premimum Get Results Ringtone Repository
  Future<List<PremimumRingtoneModel>> getResults(String query, int page) async {
 
    List<PremimumRingtoneModel> modelList =
 
        await premimumRingtoneService.getResults(query, page);
 
    return modelList;
 
  }

}
