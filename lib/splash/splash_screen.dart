import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wallpaper_app_flutter/pages/main/pages/wallpaper_page.dart';
import 'package:wallpaper_app_flutter/pages/onboarding/screen/welcome_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation<double> animation;

  startTimeNextActivity() {
    var time = new Duration(seconds: 4);
    return new Timer(time, nextEnrolledPage);
  }

  nextEnrolledPage() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool baseResult = preferences.getBool("start");
    if (baseResult == true) {
      return Navigator.pushReplacement(
        context,
        new MaterialPageRoute(
          builder: (BuildContext context) => WallpaperPage(),
        ),
      );
    } else {
      return Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => WelcomeScreen(),
        ),
      );
    }
  }

  final spinKit = SpinKitCubeGrid(
    color: Colors.white,
    size: 40,
  );

  @override
  void initState() {
    super.initState();
    animationController =
        new AnimationController(vsync: this, duration: Duration(seconds: 4));
    animation =
        new CurvedAnimation(parent: animationController, curve: Curves.easeOut);

    animation.addListener(() => this.setState(() {}));
    animationController.forward();

    startTimeNextActivity();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigoAccent[400],
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          new Column(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 50),
                width: 70,
                height: 70,
                child: Center(
                  child: spinKit,
                ),
              ),
            ],
          ),
          new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(60),
                child: Image.asset(
                  'assets/darwlogo.png',
                  width: animation.value * 120,
                  height: animation.value * 120,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
