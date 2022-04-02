// To parse this JSON data, do
//
//     final localMusicModel = localMusicModelFromJson(jsonString);

import 'dart:convert';

List<LocalMusicModel> localMusicModelFromJson(String str) =>
    List<LocalMusicModel>.from(
        json.decode(str).map((x) => LocalMusicModel.fromJson(x)));

String localMusicModelToJson(List<LocalMusicModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LocalMusicModel {
  LocalMusicModel({
    this.musicName,
  });

  String? musicName;

  factory LocalMusicModel.fromJson(Map<String, dynamic> json) =>
      LocalMusicModel(
        musicName: json["musicName"],
      );

  Map<String, dynamic> toJson() => {
        "musicName": musicName,
      };
}
