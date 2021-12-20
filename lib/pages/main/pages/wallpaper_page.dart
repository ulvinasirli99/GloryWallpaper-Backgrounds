import 'package:flutter/material.dart';
import 'package:flutter_cmoon_icons/flutter_cmoon_icons.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:wallpaper_app_flutter/components/extentions/bottom_list.dart';
import 'package:wallpaper_app_flutter/pages/main/pages/search_page.dart';
import 'package:wallpaper_app_flutter/pages/main/widget/dialog/di/ads_to_pro_dialog.dart';
import 'package:wallpaper_app_flutter/pages/widget/nav/drawerW.dart';
import 'package:wallpaper_app_flutter/service/provider/choose_color_provider.dart';
import 'package:wallpaper_app_flutter/service/provider/theme_provider.dart';
import 'category_page.dart';
import 'favorite.dart';
import 'home.dart';

class WallpaperPage extends StatefulWidget {
  @override
  _WallpaperPageState createState() => _WallpaperPageState();
}

class _WallpaperPageState extends State<WallpaperPage> {
  int _activeBottomNavigatorPositin = 0;
  final PageController _pageController = PageController();
  final _scaffoldState = GlobalKey<ScaffoldState>();
  Color color;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      int currentIndex = _pageController.page.round();
      if (currentIndex != _activeBottomNavigatorPositin) {
        _activeBottomNavigatorPositin = currentIndex;
        setState(
          () {},
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    ChooseColorProvider colorProvider = new ChooseColorProvider(color, context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: Text("Glory Wallpaper"),
        elevation: 0.0,
        actions: [
          GestureDetector(
            onTap: () {
              toProGloryCustomDialog(context);
            },
            child: Padding(
              padding: EdgeInsets.only(right: 10),
              child: Lottie.asset(
                "assets/gif.json",
                width: 50,
                height: 50,
              ),
            ),
          ),
        ],
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
      ),
      key: _scaffoldState,
      // Evvel burda buildPageView vard
      ///Todo Lakin bize her defe page render olmasin deye
      ///StackedView isletdik ve bunun syaesinde
      ///Evrey render life - qarsini almisiq olduq...........
      body: IndexedStack(
        index: _activeBottomNavigatorPositin,
        children: [
          Home(),
          SearchPage(),
          CategoryPage(),
          FavoritePage(),
        ],
      ),
      bottomNavigationBar: Container(
        color: Provider.of<Settings>(context).isDarkMode
            ? Colors.red[400]
            : Colors.white,
        child: SalomonBottomBar(
          curve: Curves.easeIn,
          currentIndex: _activeBottomNavigatorPositin,
          items: bottomItemList(colorProvider, color),
          onTap: (int index) {
            setState(() {
              _activeBottomNavigatorPositin = index;
            });
            _pageController.jumpToPage(index);
          },
        ),
      ),
      drawer: DrawerWidegts(),
    );
  }

  // PageView buildPageView() {
  //   return PageView(
  //     controller: _pageController,
  //     children: [
  //       Home(),
  //       SearchPage(),
  //       CategoryPage(),
  //       FavoritePage(),
  //     ],
  //   );
  // }

  void toProGloryCustomDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AdsToProDialog(),
    );
  }
}
