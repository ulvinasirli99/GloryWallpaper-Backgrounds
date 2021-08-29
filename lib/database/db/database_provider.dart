import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:io' as io;
import 'package:wallpaper_app_flutter/database/db_model/favorite_model.dart';
import 'package:wallpaper_app_flutter/utils/global/constants.dart';

class Helper {
  static final Helper _instance = new Helper.internal();

  factory Helper() => _instance;

  static Database _db;

  Future<Database> get db async {
    if (_db != null) return _db;
    _db = await initDb();
    return _db;
  }

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "main.db");
    var theDb = await openDatabase(path, version: 10,
        onCreate: (Database db, int version) async {
      await db.execute('''
          create table $tableUser ( 
          $columnId integer primary key autoincrement, 
          $columnName text)
          ''');
    });
    return theDb;
  }

  Helper.internal();

  Future<Favorite> insertFav(Favorite user) async {
    var dbClient = await db;
    user.id = await dbClient.insert(tableUser, user.toMap());
    return user;
  }

  Future<int> delete(int id) async {
    var dbClient = await db;
    return await dbClient
        .delete(tableUser, where: '$columnId = ?', whereArgs: [id]);
  }

  Future deleteImageFav(String imgUrl) async {
    var dbClient = await db;
    return await dbClient
        .delete(tableUser, where: '$columnName = ?', whereArgs: [imgUrl]);
  }

  Future<List> getFavorites() async {
    List<Favorite> user = List();
    var dbClient = await db;
    List<Map> maps = await dbClient.query(tableUser,
        columns: [columnId, columnName], orderBy: '$columnId DESC');
    if (maps.length > 0) {
      maps.forEach((f) {
        user.add(Favorite.fromMap(f));
      });
    }
    return user;
  }

//! This is line image url in databasee check url
  Future hasData(String url) async {
    var dbClient = await db;
    final ret = await dbClient
        .rawQuery('SELECT * FROM $tableUser WHERE $columnName=?', [url]);
    if (ret.length == 0) {
      return false;
    } else {
      return true;
    }
  }

  Future close() async {
    var dbClient = await db;
    dbClient.close();
  }
}
