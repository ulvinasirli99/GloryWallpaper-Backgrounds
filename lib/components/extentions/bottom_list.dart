import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:wallpaper_app_flutter/state/provider/choose_color_provider.dart';

List<SalomonBottomBarItem> bottomItemList(
    ChooseColorProvider colorProvider, Color color) {
  return [
    SalomonBottomBarItem(
      icon: Icon(Icons.home),
      title: Text("Home"),
      selectedColor:
          colorProvider.chooseBottomNavigationbarStateHomeColorTheme(color),
    ),
    SalomonBottomBarItem(
      icon: Icon(Icons.search),
      title: Text("Search"),
      selectedColor:
          colorProvider.chooseBottomNavigationbarStateSearchColorTheme(color),
    ),

    /// Search
    SalomonBottomBarItem(
      icon: Icon(Icons.category_rounded),
      title: Text("Category"),
      selectedColor:
          colorProvider.chooseBottomNavigationbarStateCategoryColorTheme(color),
    ),

    /// Profile
    SalomonBottomBarItem(
      icon: Icon(Icons.favorite_border),
      title: Text("Favorite"),
      selectedColor:
          colorProvider.chooseBottomNavigationbarStatefavoriteColorTheme(color),
    ),
  ];
}
