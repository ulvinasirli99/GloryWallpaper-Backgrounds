import 'package:get/get.dart';
import 'package:wallpaper_app_flutter/model/ringtone/pro_ringtone_model.dart';
import 'package:wallpaper_app_flutter/service/http/ringtone/pro_ringtone_service.dart';

class PremimumRingtoneController extends GetxController {
  
  var isLoadingValue = true.obs;

  PremimumRingtoneService premimumRingtoneService = PremimumRingtoneService();

  var prRingList = List<PremimumRingtoneModel>.empty(growable: true).obs;

  // Todo Initial Service for Start...
  Future<List<PremimumRingtoneModel>?> initalizePrRingListData(int pageNumber) async {
   
    isLoadingValue.value = true;

    var res = await premimumRingtoneService.getTrending(pageNumber);

    prRingList = res.obs;

    isLoadingValue.value = false;

    update();

    return prRingList;
 
  }

  // Todo This Controller is for Next Page Data Service...
  Future<List<PremimumRingtoneModel>?> nextPrRingListData(int pgNum) async {
 
    var res = await premimumRingtoneService.getTrending(++pgNum);
 
    prRingList.addAll(res);
 
    pgNum++;
 
    update();
 
    return prRingList;
 
  }


  //////////////////????************************************************************************?????\\\\\\\\\\\\\\\\\\
  
  // Todo Next this Point is for Search Pro Ringtone Data Service..........
  Future<List<PremimumRingtoneModel>?> bySearchProRingonteMethodFirst(String _initialQueryForm,int pgNum) async {
 
    var res = await premimumRingtoneService.getResults(_initialQueryForm, ++pgNum);
 
    isLoadingValue.value = true;

    prRingList = res.obs;

    isLoadingValue.value = false;

    update();

    return prRingList;
 
  }

   // Todo Next this Point is for Search Pro Ringtone Data Service..........
  Future<List<PremimumRingtoneModel>?> bySearchProRingonteNexPageMethod(String _initialQueryForm,int pgNum) async {
 
    var res = await premimumRingtoneService.getResults(_initialQueryForm, ++pgNum);
 
    prRingList.addAll(res);
 
    pgNum++;
 
    update();
 
    return prRingList;
 
  }


}