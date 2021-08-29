import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper_app_flutter/service/provider/theme_provider.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Glory Wallpaper",
                style: TextStyle(
                  color: Provider.of<Settings>(context).isDarkMode
                      ? Colors.white
                      : Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.justify,
              ),
              Container(
                margin: EdgeInsets.only(top: 35, right: 10),
                width: 100,
                height: 100,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(60),
                  child: Image.asset(
                    'assets/darwlogo.png',
                    width: 100,
                    height: 100,
                  ),
                ),
              ),
            ],
          ),
          Text(
            "Glory Wallpaper Software \n was created in 2021. The app does  \n not share any of your \n information with \n third parties. You can  \n also read the copyright \n below. If you feel anything  \n about it, you can contact \n our customer service. Glory Wallpaper \n You can use similar images. \n ",
            style: TextStyle(
              fontSize: 18,
              color: Provider.of<Settings>(context).isDarkMode
                  ? Colors.white
                  : Colors.black,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          Divider(
            height: 10,
            thickness: 0.5,
            color: Colors.grey,
            indent: 12,
            endIndent: 12,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Image.asset('assets/terms.png'),
              Text(
                "Welcome to Glory Wallpaper! \n By accessing this website \n we assume you accept these terms \n and conditions. ",
                style: TextStyle(
                  fontSize: 18,
                  color: Provider.of<Settings>(context).isDarkMode
                      ? Colors.white
                      : Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Divider(
            height: 10,
            thickness: 0.5,
            color: Colors.grey,
            indent: 12,
            endIndent: 12,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Image.asset(
                'assets/privacy.png',
                width: 60,
                height: 60,
              ),
              Text(
                "Unless otherwise stated, \n Glory Wallpaper \n and/or its licensors own the \n intellectual \n property rights for \n all material on Glory Wallpaper.\n You may access this \n  from Glory Wallpaper \n for your own personal use \n subjected to restrictions \n set in these terms \n and conditions.",
                style: TextStyle(
                  fontSize: 18,
                  color: Provider.of<Settings>(context).isDarkMode
                      ? Colors.white
                      : Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
