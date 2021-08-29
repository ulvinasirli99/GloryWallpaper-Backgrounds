import 'package:flutter/material.dart';
import 'package:flutter_cmoon_icons/flutter_cmoon_icons.dart';

class VisblePhone extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      width: 100,
      height: 150,
      child: Stack(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 90, right: 20, left: 20),
            width: MediaQuery.of(context).size.width,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(40),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Icon(
                    IconMoon.icon_google_plus,
                    size: 30,
                    color: Colors.redAccent,
                  ),
                ),
                Text(
                  "Say Ok Google",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[700],
                    decoration: TextDecoration.none,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.only(
                bottom: 130,
                right: 20,
                left: 20,
              ),
              width: MediaQuery.of(context).size.width,
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Icon(
                    IconMoon.icon_facebook,
                    size: 47,
                    color: Colors.blue,
                  ),
                  Icon(
                    IconMoon.icon_whatsapp,
                    size: 47,
                    color: Colors.green,
                  ),
                  Icon(
                    IconMoon.icon_telegram,
                    size: 47,
                    color: Colors.blue[400],
                  ),
                  Icon(
                    IconMoon.icon_google,
                    color: Colors.red,
                     size: 47,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
