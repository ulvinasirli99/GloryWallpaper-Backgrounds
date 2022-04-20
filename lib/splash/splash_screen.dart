import 'dart:async';
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
  AnimationController? animationController;
  Animation<double>? animation;

  startTimeNextActivity() {
    var time = new Duration(seconds: 4);
    return new Timer(time, nextEnrolledPage);
  }

  nextEnrolledPage() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if(sharedPreferences.getBool("start")==true){
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => WallpaperPage(),
        ),
      );
    }else{
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => WelcomeScreen(),
        ),
      );
    }
  }

  final spinKit = SpinKitDancingSquare(
    color: Colors.white,
    size: 50,
  );

  @override
  void initState() {
    super.initState();
    animationController =
        new AnimationController(vsync: this, duration: Duration(seconds: 3));
    animation = new CurvedAnimation(
        parent: animationController!, curve: Curves.bounceIn);

    animation!.addListener(() => this.setState(() {}));
    animationController!.forward();

    startTimeNextActivity();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.indigoAccent.shade200,
                  Colors.indigoAccent.shade400,
                  Colors.indigoAccent,
                ],
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ScaleTransition(
                scale: Tween(begin: 0.6, end: 1.6).animate(
                  CurvedAnimation(
                    parent: animationController!,
                    curve: Curves.easeInCirc,
                  ),
                ),
                child: Container(
                  margin: EdgeInsets.only(bottom: 50),
                  width: 70,
                  height: 70,
                  child: Center(
                    child: spinKit,
                  ),
                ),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ScaleTransition(
                scale: Tween(begin: 1.6, end: 0.6).animate(
                  CurvedAnimation(
                    parent: animationController!,
                    curve: Curves.easeInCirc,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(60),
                  child: Image.asset(
                    'assets/darwlogo.png',
                    width: 120,
                    height: 120,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
