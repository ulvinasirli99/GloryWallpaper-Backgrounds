import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:wallpaper_app_flutter/pages/main/widget/dialog/di/custom_alert_dialog.dart';

class EditToImageSetWallpaper extends StatelessWidget {
  final Uint8List imageData;

  const EditToImageSetWallpaper({Key key, this.imageData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Image.memory(
              imageData,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 40,
            right: 25,
            child: Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: Icon(
                  Icons.home,
                  size: 35,
                  color: Colors.white,
                ),
                onPressed: () {
                  setScreenSetWallaperDialog(context);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  void setScreenSetWallaperDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomAlertDialog(
          content: Container(
            width: MediaQuery.of(context).size.width / 1.2,
            height: 200,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Set Wallpaper",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                GestureDetector(
                  onTap: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.mobile_screen_share),
                        onPressed: () {},
                      ),
                      Text(
                        "ALL SCREEN",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.purple,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.phonelink_lock),
                        onPressed: () {},
                      ),
                      Text(
                        "HOME SCREEN",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.purple,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.phone_android),
                        onPressed: () {},
                      ),
                      Text(
                        "LOCK SCREEN",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.purple,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
