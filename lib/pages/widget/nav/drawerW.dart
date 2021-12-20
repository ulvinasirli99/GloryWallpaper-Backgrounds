import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wallpaper_app_flutter/localizations/app_localizations.dart';
import 'package:wallpaper_app_flutter/pages/main/pages/favorite.dart';
import 'package:wallpaper_app_flutter/pages/main/pages/home.dart';
import 'package:wallpaper_app_flutter/pages/main/widget/dialog/di/custom_relase_dialog.dart';
import 'package:wallpaper_app_flutter/pages/navPage/ui/about.dart';
import 'package:wallpaper_app_flutter/pages/navPage/ui/feedback.dart';
import 'package:wallpaper_app_flutter/pages/navPage/ui/settings.dart';
import 'package:wallpaper_app_flutter/pages/widget/popup/menu_item.dart';
import 'package:wallpaper_app_flutter/service/provider/theme_provider.dart';
import 'package:wallpaper_app_flutter/utils/global/constants.dart';
import 'package:wallpaper_app_flutter/utils/share/share.dart';
import 'ads_no_widget.dart';

class DrawerWidegts extends Drawer {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.lightBlue[600],
      width: MediaQuery.of(context).size.width - 40,
      height: MediaQuery.of(context).size.height,
      child: ListView(
        children: <Widget>[
          Container(
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(25),
                  topLeft: Radius.circular(15)),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.lightBlue[400],
                  Colors.lightBlue[600],
                  Colors.lightBlue[700],
                  Colors.lightBlue[800]
                ],
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(60),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage("darwlogo.png"),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 1,
                ),
                Row(
                  children: [
                    Text(
                      "Glory",
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      width: 7,
                    ),
                    Text(
                      "Wall",
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        "paper",
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.redAccent[700],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: Provider.of<Settings>(context).isDarkMode
                    ? [
                        Colors.black,
                        Colors.black,
                      ]
                    : [
                        Colors.lightBlue.shade400,
                        Colors.indigo.shade400,
                        Colors.blue.shade400,
                      ],
              ),
            ),
            height: MediaQuery.of(context).size.height,
            child: LayoutBuilder(
              builder:
                  (BuildContext context, BoxConstraints viewportConstraints) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: viewportConstraints.maxHeight,
                    ),
                    child: Column(
                      children: <Widget>[
                        MenuItem(
                          icon: Icons.home,
                          color: Color(0xff388e3c),
                          title: ApplicationLocalizations.of(context)
                              .translate('home'),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Home(),
                              ),
                            );
                          },
                        ),
                        MenuItem(
                          color: Color(0xffff3d00),
                          icon: Icons.favorite,
                          title: ApplicationLocalizations.of(context)
                              .translate('favorite'),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FavoritePage(),
                              ),
                            );
                          },
                        ),
                        // DrawerProTile(
                        //   assetImagePath: "assets/proicon.png",
                        //   tittle: "Pro Wallpaper",
                        //   function: () {
                        //     Navigator.push(
                        //       context,
                        //       MaterialPageRoute(
                        //         builder: (context) => ProImagesPage(),
                        //       ),
                        //     );
                        //   },
                        // ),
                        AdsNoWidget(
                          lottiePath: "assets/gif.json",
                          tittle: "Premium Glory",
                          function: () {
                            premiumGloryGet();
                          },
                        ),
                        Divider(
                          height: 10,
                          thickness: 0.5,
                          color: Colors.grey,
                          indent: 12,
                          endIndent: 12,
                        ),
                        MenuItem(
                          color: Colors.pink[400],
                          icon: Icons.settings,
                          title: ApplicationLocalizations.of(context)
                              .translate('setting'),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Setting(),
                              ),
                            );
                          },
                        ),
                        MenuItem(
                          color: Color(0xffafb4b2),
                          icon: Icons.feedback,
                          title: ApplicationLocalizations.of(context)
                              .translate('feedback'),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FeedbackPage(),
                              ),
                            );
                          },
                        ),
                        MenuItem(
                          color: Provider.of<Settings>(context).isDarkMode
                              ? Colors.teal
                              : Colors.black,
                          icon: Icons.share,
                          title: ApplicationLocalizations.of(context)
                              .translate('share'),
                          onTap: () async {
                            await shareText(appShareUrl);
                          },
                        ),
                        Divider(
                          height: 10,
                          thickness: 0.5,
                          color: Colors.grey,
                          indent: 12,
                          endIndent: 12,
                        ),
                        MenuItem(
                          color: Colors.indigo.shade400,
                          icon: Icons.my_library_books_sharp,
                          title: ApplicationLocalizations.of(context)
                              .translate('about_app'),
                          onTap: () {
                            getDialogOkayButtonSave(context);
                          },
                        ),
                        Divider(
                          height: 10,
                          thickness: 0.5,
                          color: Colors.grey,
                          indent: 12,
                          endIndent: 12,
                        ),
                        MenuItem(
                          color: Colors.amber.shade600,
                          icon: Icons.exit_to_app,
                          title: ApplicationLocalizations.of(context)
                              .translate('exit'),
                          onTap: () {
                            SystemNavigator.pop();
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void customRelaseAppDetailDialog(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => CustomRelaseDialog(
        title: "Terms of use",
        image: Image.asset('assets/darwlogo.png'),
        description:
            "I accept the terms and conditions of use of Glory Wallpaper and I agree not to use it for anything bad.",
        buttonText: "Okay",
        childWidget: AboutPage(),
      ),
    );
  }

  // ignore: missing_return
  Future<bool> getDialogOkayButtonSave(BuildContext context) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var btnResult = preferences.getBool("okayButtonSave");
    if (btnResult == true) {
      return Navigator.push(
        context,
        new MaterialPageRoute(
          builder: (BuildContext context) => AboutPage(),
        ),
      );
    } else {
      customRelaseAppDetailDialog(context);
    }
  }
}
