import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wallpaper_app_flutter/widget/global/toasts.dart';

 Future<void> shareText(String text) async {
    try {
      Share.text('Glory Wallpaper',
          text, 'text/plain');
    } catch (e) {
      print('error: $e');
    }
  }

Future<void> shareImageFromUrl(String imgUrl) async {
  try {
    var request = await HttpClient().getUrl(
      Uri.parse(imgUrl),
    );
    var responseResult = await request.close();
    Uint8List bytes = await consolidateHttpClientResponseBytes(responseResult);
    await Share.file('Glory Wallpaper', 'amlog.jpg', bytes, 'image/jpg');
  } catch (e) {
    print("_share Image From Url Error : $e");
  }
}

PremiumGloryGet() async {
  ///This is url the play store rate us
  ///A url launcUrl url web and playstore oritantion
  const url =
      'https://play.google.com/store/apps/details?id=glory.tool.gloryproproduct';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    error('Error.Try again');
  }
}
