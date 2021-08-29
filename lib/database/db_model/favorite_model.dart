import 'package:wallpaper_app_flutter/utils/global/constants.dart';

class Favorite {
  int id;
  String name;

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{columnName: name};
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }

  Favorite();

  Favorite.fromMap(Map<String, dynamic> map) {
    id = map[columnId];
    name = map[columnName];
  }
}
