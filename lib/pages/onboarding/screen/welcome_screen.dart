import 'dart:io';
import 'package:device_info/device_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wallpaper_app_flutter/pages/onboarding/components/bg.dart';
import 'package:wallpaper_app_flutter/splash/splash_screen.dart';
import 'package:wallpaper_app_flutter/pages/main/pages/wallpaper_page.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  Size _size;
  double _appbarSize;
  int _nOfpages = 3;
  int _currentPage = 0;
  PageController _controller = PageController(initialPage: 0);
  DeviceInfoPlugin infoPlugin = DeviceInfoPlugin();
  AndroidDeviceInfo androidDeviceInfo;
  String deviceModel;
  String deviceSdkVersion;

  getDeviceInfo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    deviceModel = androidInfo.model;
    deviceSdkVersion = androidInfo.id;
    print('Running on ${androidInfo.model}');
  }

  Future<bool> buttonNextActivityStartButton() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var btnStart = preferences.setBool("start", true);
    return btnStart;
  }

  List<Widget> _buildIndicators() {
    List<Widget> wlist = [];
    for (int i = 0; i < _nOfpages; i++) {
      wlist.add((i == _currentPage) ? _indicator(true) : _indicator(false));
    }

    return wlist;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      height: 8.0,
      width: 8.0,
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: isActive ? Colors.white : Colors.white54,
          borderRadius: BorderRadius.all(Radius.circular(12.0))),
    );
  }

  void _setPageState(int page) {
    setState(() {
      _currentPage = page;
    });
  }

  void _moveToNextPage() {
    _controller.jumpToPage(_currentPage + 1);
  }

  void _skipToNextPage() {
    _controller.jumpToPage(_currentPage + 3);
  }

  void _sysTemUIConfig() {
    SystemChrome.setEnabledSystemUIOverlays([]);
  }

  @override
  void initState() {
    super.initState();
    _sysTemUIConfig();
    getDeviceInfo();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;
    _appbarSize = MediaQuery.of(context).padding.top;
    return Scaffold(
      body: Background(
        childWidget: _body(),
      ),
    );
  }

  Widget _body() {
    return SizedBox.expand(
      child: Container(
        height: _size.height,
//        color: Colors.blue,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.topRight,
                margin: EdgeInsets.only(top: _appbarSize),
//                color: Colors.blue,
                child: FlatButton(
//                  color: Colors.white,
                  child: Text(
                    'Skip',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () => {_skipToNextPage()},
                ),
              ),
              Container(
                height: _size.height / 1.7, //we will make the height dynamic
//                color: Colors.amber,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: PageView(
                    controller: _controller,
                    onPageChanged: (value) => _setPageState(value),
                    physics: ClampingScrollPhysics(),
                    children: <Widget>[
                      //Todo More than 2 million
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.all_inclusive,
                            size: 95,
                            color: Colors.white,
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          Text(
                            'Welcome to Glory Wallpaper',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'More than 2 million wallpapers',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      //Todo This is line Eye catching page 
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.ac_unit,
                            size: 95,
                            color: Colors.white,
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          Text(
                            'Eye-catching design',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Easy operation and multi-function',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      //Todo Device Info Page Onboarding
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.phone_android,
                            size: 95,
                            color: Colors.white,
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            "Device Info",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            '$deviceModel',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "$deviceSdkVersion",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Container(
//                color: Colors.lightGreen,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _buildIndicators(),
                ),
              ),
              Container(
                child: Expanded(
                  child: Container(
//                    color: Colors.indigo,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ButtonTheme(
                          minWidth: 100,
                          height: 45,
                          child: (_currentPage != _nOfpages - 1)
                              ? OutlineButton(
                                  shape: StadiumBorder(),
                                  borderSide: BorderSide(color: Colors.white),
                                  child: Text(
                                    'Continue',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  onPressed: () => _moveToNextPage(),
                                )
                              : FlatButton(
                                  color: Colors.green,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(24.0),
                                    ),
                                  ),
                                  child: Text(
                                    'Start',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  onPressed: () async {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                WallpaperPage()));
                                    buttonNextActivityStartButton();
                                  },
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
