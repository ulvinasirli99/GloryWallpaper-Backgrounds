import 'package:shared_preferences/shared_preferences.dart';

Future<bool> networkDataaffordableSave(String name,bool netvalue) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.setBool(name, netvalue);
}

Future<bool> darkModeSaveInstance(bool mode) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool("darkModeSave", mode);
  return prefs.setBool("darkModeSave", mode);
}

Future<List> favoriteDataUsage(List favDataUsage) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setStringList("favList", favDataUsage);
}
