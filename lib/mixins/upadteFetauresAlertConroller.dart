import 'package:shared_preferences/shared_preferences.dart';

mixin UpdateFeaturesAlertController {
  SharedPreferences? prefs;
  //Todo Write Fetaures Local Storage
  writeUpdateFeaturesController() async {
    prefs = await SharedPreferences.getInstance();
    prefs!.setInt("writeValueOne", 1);
  }

  //Todo Read Fetaures Local Storage
  readUpdateFeaturesController() async {
    prefs = await SharedPreferences.getInstance();
    int val = prefs!.getInt("writeValueOne") ?? 0;
    return val;
  }
}
