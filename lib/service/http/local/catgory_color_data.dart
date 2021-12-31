import 'package:flutter/material.dart';
import 'package:wallpaper_app_flutter/model/local/catgory_color_model.dart';

List<CatgoryColorModel> getCatgoryColors() {
  List<CatgoryColorModel> catgories = List.empty(growable: true);
  CatgoryColorModel model = CatgoryColorModel();

  // 1
  model.categorieName = 'Red';
  model.colorName = Colors.red;
  catgories.add(model);
  model = new CatgoryColorModel();

  //2
  model.categorieName = 'Green';
  model.colorName = Colors.green;
  catgories.add(model);
  model = new CatgoryColorModel();

  //3
  model.categorieName = 'Yellow';
  model.colorName = Colors.yellow;
  catgories.add(model);
  model = new CatgoryColorModel();

  //4
  model.categorieName = 'Black';
  model.colorName = Colors.black;
  catgories.add(model);
  model = new CatgoryColorModel();

  //5
  model.categorieName = 'Orange';
  model.colorName = Colors.orange;
  catgories.add(model);
  model = new CatgoryColorModel();

  //6
  model.categorieName = 'Indigo';
  model.colorName = Colors.indigo;
  catgories.add(model);
  model = new CatgoryColorModel();

  //7
  model.categorieName = 'Grey';
  model.colorName = Colors.grey;
  catgories.add(model);
  model = new CatgoryColorModel();

  //8
  model.categorieName = 'Blue';
  model.colorName = Colors.blue;
  catgories.add(model);
  model = new CatgoryColorModel();

  //9
  model.categorieName = 'Teal';
  model.colorName = Colors.teal;
  catgories.add(model);
  model = new CatgoryColorModel();

  //10
  model.categorieName = 'Pink';
  model.colorName = Colors.pink;
  catgories.add(model);
  model = new CatgoryColorModel();

  //11
  model.categorieName = 'Cyan';
  model.colorName = Colors.cyan;
  catgories.add(model);
  model = new CatgoryColorModel();

  //12
  model.categorieName = 'Purple';
  model.colorName = Colors.purple;
  catgories.add(model);
  model = new CatgoryColorModel();

  // return catgory List.....
  return catgories;
}