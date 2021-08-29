import 'dart:async';
import 'package:battery/battery.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cmoon_icons/flutter_cmoon_icons.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wallpaper_app_flutter/localizations/app_localizations.dart';
import 'package:wallpaper_app_flutter/pages/navPage/ui/about.dart';
import 'package:wallpaper_app_flutter/service/provider/choose_color_provider.dart';
import 'package:wallpaper_app_flutter/utils/global/constants.dart';
import 'package:wallpaper_app_flutter/widget/global/toasts.dart';

import '../../../service/provider/theme_provider.dart';

class Setting extends StatefulWidget {
  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  bool lessData = false;
  bool _darkTheme = false;
  Battery _battery = Battery();
  BatteryState _batteryState;
  AppUpdateInfo _updateInfo;
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();
  int batteryLevel;
  StreamSubscription<BatteryState> _batteryStateSubciption;
  // AdmobBannerSize bannerSize;
  Color color;
  String cacheSizeInMemory = "a";

  @override
  void initState() {
    super.initState();
    setState(() {
      _batteryStateSubciption =
          _battery.onBatteryStateChanged.listen((BatteryState state) {
        setState(() {
          _batteryState = state;
        });
      });
    });
    getBatterylevelState();

    //? This is Ads Service Initazlize
    // bannerSize = AdmobBannerSize.BANNER;

    //Todo this is line search page suggetions history data
    getSuggetionsHistoryData();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  void showSnack(String text) {
    if (_scaffoldKey.currentContext != null) {
      ScaffoldMessenger.of(_scaffoldKey.currentContext)
          .showSnackBar(SnackBar(content: Text(text)));
    }
  }

  Future<void> getBatterylevelState() async {
    final int batteryLev = await _battery.batteryLevel;
    setState(() {
      batteryLevel = batteryLev;
    });
  }

  // void handleEvent(
  //     AdmobAdEvent event, Map<String, dynamic> args, String adType) {
  //   switch (event) {
  //     case AdmobAdEvent.loaded:
  //       print("Loaded");
  //       break;
  //     case AdmobAdEvent.opened:
  //       print("Opend");
  //       break;
  //     case AdmobAdEvent.closed:
  //       print("Closed");
  //       break;
  //     case AdmobAdEvent.failedToLoad:
  //       print("Failed");
  //       break;
  //     default:
  //   }
  // }

  @override
  void dispose() {
    super.dispose();
    if (_batteryStateSubciption != null) {
      _batteryStateSubciption.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    ChooseColorProvider colorProvider = ChooseColorProvider(color, context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          ApplicationLocalizations.of(context).translate('setting'),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: ListView(
          children: <Widget>[
            SwitchListTile(
              inactiveTrackColor: Colors.green,
              activeTrackColor: Colors.blue,
              inactiveThumbColor: Colors.yellow,
              activeColor: Colors.red,
              title: Text(
                ApplicationLocalizations.of(context).translate('dark_mode'),
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: colorProvider.chooseSettingTextStyleColor(color),
                ),
              ),
              value: Provider.of<Settings>(context).isDarkMode,
              onChanged: (value) {
                changeTheme(
                  Provider.of<Settings>(context, listen: false).isDarkMode
                      ? false
                      : true,
                  context,
                );
              },
              secondary: const Icon(
                Icons.lightbulb,
                size: 30,
                color: Colors.redAccent,
              ),
            ),
            Divider(
              height: 20,
              thickness: 0,
              color: Colors.grey,
              indent: 12,
              endIndent: 12,
            ),
            SwitchListTile(
              inactiveTrackColor: Colors.green,
              activeTrackColor: Colors.blue,
              inactiveThumbColor: Colors.yellow,
              activeColor: Colors.red,
              title: Text(
                ApplicationLocalizations.of(context).translate('affor_network'),
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: colorProvider.chooseSettingTextStyleColor(color),
                ),
              ),
              value: Provider.of<Settings>(context).isAffordableNetwork,
              onChanged: (value) {
                changeNetwrok(
                  Provider.of<Settings>(context, listen: false)
                          .isAffordableNetwork
                      ? false
                      : true,
                  context,
                );
              },
              secondary: const Icon(
                Icons.data_usage,
                size: 30,
                color: Colors.redAccent,
              ),
            ),
            Divider(
              height: 20,
              thickness: 0,
              color: Colors.grey,
              indent: 12,
              endIndent: 12,
            ),
            ListTile(
              title: Text(
                ApplicationLocalizations.of(context).translate('battery_usage'),
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: colorProvider.chooseSettingTextStyleColor(color),
                ),
              ),
              leading: Icon(
                Icons.battery_unknown,
                size: 30,
                color: Colors.green,
              ),
              subtitle: Text(
                batteryLevel.toString() + " %",
                style: TextStyle(fontSize: 18, color: Colors.teal),
              ),
              trailing: Padding(
                padding: const EdgeInsets.only(right: 12),
                child: Icon(
                  Icons.info_outline,
                  size: 30,
                  color: Colors.green,
                ),
              ),
            ),
            Divider(
              height: 20,
              thickness: 0,
              color: Colors.grey,
              indent: 12,
              endIndent: 12,
            ),
            ListTile(
              onTap: () async {
                SharedPreferences prefrences =
                    await SharedPreferences.getInstance();
                prefrences.remove("suggestions_list");
                setState(() {
                  cacheSizeInMemory = "0.0 KB";
                });
              },
              leading: Icon(
                Icons.history,
                size: 30,
                color: Colors.redAccent,
              ),
              title: Text(
                ApplicationLocalizations.of(context).translate('clear_history'),
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: colorProvider.chooseSettingTextStyleColor(color),
                ),
              ),
              trailing: Text(
                cacheSizeInMemory,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: colorProvider.chooseSettingTextStyleColor(color),
                ),
              ),
            ),
            Divider(
              height: 20,
              thickness: 0,
              color: Colors.grey,
              indent: 12,
              endIndent: 12,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AboutPage()));
              },
              child: ListTile(
                title: Text(
                  ApplicationLocalizations.of(context).translate('about_app'),
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: colorProvider.chooseSettingTextStyleColor(color),
                  ),
                ),
                leading: Icon(
                  IconMoon.icon_abbrobotstudio,
                  size: 30,
                  color: Colors.redAccent,
                ),
                trailing: IconButton(
                  icon: Icon(
                    Icons.arrow_forward_ios,
                    size: 30,
                    color: Provider.of<Settings>(context).isDarkMode
                        ? Colors.teal
                        : Colors.redAccent,
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => AboutPage()));
                  },
                ),
              ),
            ),
            Divider(
              height: 20,
              thickness: 0,
              color: Colors.grey,
              indent: 12,
              endIndent: 12,
            ),
            GestureDetector(
              onTap: () {
                //Call you playstore link rate us
                rateUsPlayStoreUrl();
              },
              child: ListTile(
                title: Text(
                  ApplicationLocalizations.of(context).translate('rate_app'),
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: colorProvider.chooseSettingTextStyleColor(color),
                  ),
                ),
                leading: Icon(
                  Icons.star,
                  size: 30,
                  color: Colors.redAccent,
                ),
                trailing: IconButton(
                  icon: Icon(
                    Icons.arrow_forward_ios,
                    size: 30,
                    color: Provider.of<Settings>(context).isDarkMode
                        ? Colors.teal
                        : Colors.redAccent,
                  ),
                  onPressed: () {
                    rateUsPlayStoreUrl();
                  },
                ),
              ),
            ),
            Divider(
              height: 20,
              thickness: 0,
              color: Colors.grey,
              indent: 12,
              endIndent: 12,
            ),
            //Todo Update App...(Check for update for app[this current version.........])
            GestureDetector(
              onTap: _updateInfo?.updateAvailability ==
                      UpdateAvailability.updateAvailable
                  ? () {
                      InAppUpdate.performImmediateUpdate()
                          .catchError((e) => showSnack(e.toString()));
                    }
                  : null,
              child: ListTile(
                title: Text(
                  ApplicationLocalizations.of(context).translate('app_version'),
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: colorProvider.chooseSettingTextStyleColor(color),
                  ),
                ),
                leading: Icon(
                  Icons.refresh_sharp,
                  size: 30,
                  color: Colors.redAccent,
                ),
                trailing: IconButton(
                  icon: Icon(
                    Icons.repeat,
                    size: 30,
                    color: Provider.of<Settings>(context).isDarkMode
                        ? Colors.teal
                        : Colors.redAccent,
                  ),
                  onPressed: _updateInfo?.updateAvailability ==
                          UpdateAvailability.updateAvailable
                      ? () {
                          InAppUpdate.performImmediateUpdate()
                              .catchError((e) => showSnack(e.toString()));
                        }
                      : null,
                ),
              ),
            ),
            Divider(
              height: 20,
              thickness: 0,
              color: Colors.grey,
              indent: 12,
              endIndent: 12,
            ),
            //! This is line begin Admob Banner ....
            // Container(
            //   width: MediaQuery.of(context).size.width,
            //   height: 120,
            //   child: AdmobBanner(
            //     adUnitId: BANNER_ID,
            //     adSize: AdmobBannerSize.LARGE_BANNER,
            //     listener: (AdmobAdEvent event, Map<String, dynamic> args) {
            //       handleEvent(event, args, 'Banner');
            //     },
            //     onBannerCreated: (AdmobBannerController controller) {
            //       // Dispose is called automatically for you when Flutter removes the banner from the widget tree.
            //       // Normally you don't need to worry about disposing this yourself, it's handled.
            //       // If you need direct access to dispose, this is your guy!
            //       // controller.dispose();
            //     },
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  void changeTheme(bool set, BuildContext context) {
    ///Call setDarkMode method inside our Settings ChangeNotifier class to
    ///Notify all the listeners of the change.
    Provider.of<Settings>(context, listen: false).setDarkMode(set);
  }

  void changeNetwrok(bool set, BuildContext context) {
    ///Call setNetworkAffordable method inside our AfforadbleNetwork ChangeNotifier class to
    ///Notify all the listeners of the change.
    Provider.of<Settings>(context, listen: false).setAffordableNetwork(set);
  }

  rateUsPlayStoreUrl() async {
    ///This is url the play store rate us
    ///A url launcUrl url web and playstore oritantion
    const url =
        'https://play.google.com/store/apps/details?id=master.tool.glorywallpaper';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      error('Error.Try again');
    }
  }

  void getSuggetionsHistoryData() async {
    var prefs = await SharedPreferences.getInstance();
    List<String> suggestions =
        prefs.getStringList('suggestions_list') ?? List<String>();
    var getCount = (suggestions.length * 9) / 4;
    if (getCount <= 50) {
      cacheSizeInMemory = getCount.toString() + " KB";
    } else if (getCount > 50) {
      cacheSizeInMemory = getCount.toString() + " MB";
    } else if (getCount == null) {
      cacheSizeInMemory = "No Data";
    }
  }
}
