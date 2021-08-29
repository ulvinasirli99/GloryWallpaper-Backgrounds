import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> showNotificationMediaStyle(String imageName) async {
  var androidPlatformChannelSpecifics = AndroidNotificationDetails(
    'media channel id',
    'media channel name',
    'media channel description',
    color: Colors.red,
    enableLights: true,
    largeIcon: DrawableResourceAndroidBitmap('mipmap/ic_launcher'),
    styleInformation: MediaStyleInformation(),
  );
  var platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics, iOS: null);
  await flutterLocalNotificationsPlugin.show(
      0, imageName, 'Dowloaded', platformChannelSpecifics);
}
/*
   Todo This is line before swipe notification

   and upd the noptification image notification "#"

*/

showNotification(String imageName) async {
  var android = new AndroidNotificationDetails('id', 'channel ', 'description',
      priority: Priority.high, importance: Importance.max);
  var iOS = new IOSNotificationDetails();
  var platform = new NotificationDetails(android: android, iOS: iOS);
  await flutterLocalNotificationsPlugin.show(
      0, imageName, 'Download Image Successfully', platform,
      payload: 'Dowloaded');
}
