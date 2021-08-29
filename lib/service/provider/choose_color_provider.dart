import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper_app_flutter/service/provider/theme_provider.dart';

class ChooseColorProvider {
  /*
 this liine before Is a conustcutor fileds
 color and context
 */
  Color color;
  BuildContext context;

  ChooseColorProvider(this.color, this.context);

  //Todo is Home Bar State Color Theme
  chooseBottomNavigationbarStateHomeColorTheme(Color color) {
    color = Provider.of<Settings>(context).isDarkMode
        ? Colors.brown[800]
        : Colors.purple;
    return color;
  }

  //Todo is Search Bar State Color Theme
  chooseBottomNavigationbarStateSearchColorTheme(Color color) {
    color = Provider.of<Settings>(context).isDarkMode
        ? Colors.white
        : Colors.pink;
    return color;
  }

  //Todo is Category Bar State Color Theme
  chooseBottomNavigationbarStateCategoryColorTheme(Color color) {
    color =
        Provider.of<Settings>(context).isDarkMode
         ? Colors.blue 
         : Colors.orange;
    return color;
  }

  //Todo is Favorite Bar State Color Theme
  chooseBottomNavigationbarStatefavoriteColorTheme(Color color) {
    color =
        Provider.of<Settings>(context).isDarkMode 
        ? Colors.green
        : Colors.teal;
    return color;
  }

  //Todo is line searchPage textFiled Color
  chooseSearchPageTextFiled(Color color){
      color =
        Provider.of<Settings>(context).isDarkMode 
        ? Colors.red[300]
        : Colors.white;
    return color;
  }

  //Todo This is Color Setting in text color
  chooseSettingTextStyleColor(Color color){
    color =
        Provider.of<Settings>(context).isDarkMode 
        ? Colors.white
        : Colors.black;
    return color;
  }
}
