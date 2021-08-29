import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Class that contains all your app settings
/// This is Provioder is a network low and high use
class AfforDableNetwork extends ChangeNotifier {
  final SharedPreferences sharedPreferences;

  AfforDableNetwork(this.sharedPreferences);

  bool get isAffordableNetwork => sharedPreferences?.getBool("affoNet") ?? false;

  void setAffordableNetwork(bool value) {
    sharedPreferences?.setBool("affoNet", value);
    notifyListeners();
  }
}
