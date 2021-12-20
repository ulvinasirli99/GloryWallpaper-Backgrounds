import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:lottie/lottie.dart';
import 'package:octo_image/octo_image.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:provider/provider.dart';
import 'package:random_color/random_color.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wallpaper_app_flutter/components/update/update_new_features.dart';
import 'package:wallpaper_app_flutter/mixins/upadteFetauresAlertConroller.dart';
import 'package:wallpaper_app_flutter/model/local/home_tabbar_strings.dart';
import 'package:wallpaper_app_flutter/model/pro/img_model_pro.dart';
import 'package:wallpaper_app_flutter/pages/main/widget/ui/category_to_imagelist.dart';
import 'package:wallpaper_app_flutter/pages/main/widget/ui/network_error.dart';
import 'package:wallpaper_app_flutter/service/http/home_tabbar_string_data.dart';
import 'package:wallpaper_app_flutter/service/http/pro_image_api_provider.dart';
import 'package:wallpaper_app_flutter/service/provider/theme_provider.dart';
import 'package:wallpaper_app_flutter/utils/global/constants.dart';
import 'full_image.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home>
    with UpdateFeaturesAlertController, SingleTickerProviderStateMixin {
  var _gridController = ScrollController();
  final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey =
      GlobalKey<LiquidPullToRefreshState>();
  var photos = List<Photo>.empty(growable: true);
  int _page = pageNumber;
  List<HomeTabbarStrings> strings = List.empty(growable: true);
  RandomColor randomColor = RandomColor();
  SharedPreferences preferences;
  bool isRead = false;
  bool isChristmasDaY = false;
  var currentTime = DateTime.now();
  var isChristmasDay = DateTime(2021, 12, 31);
  var isChristmasDay1 = DateTime(2022, 1, 1);
  var isChristmasDay2 = DateTime(2022, 1, 2);
  var isChristmasDay3 = DateTime(2022, 1, 3);
  var isChristmasDay4 = DateTime(2022, 1, 4);

  // todo >>>>> One Signal App Id Initazlized......<<<<<
  static final String oneSignalAppId = "3666bd4c-c230-4a35-88c1-3cf27d752405";

  // var imageLoadingSpinKit = SpinKitPulse(
  //   size: 60,
  //   color: Colors.redAccent,
  //   duration: Duration(milliseconds: 2000),
  // );

  isReadFetaures() async {
    preferences = await SharedPreferences.getInstance();
    var isAnswer = preferences.getBool("isRead") ?? false;
    setState(() {
      isRead = isAnswer;
    });
  }

  @override
  void initState() {
    resetSearch();
    super.initState();
    _gridController.addListener(_scrollListener);
    _loadSearchImages(rApiTexts);
    strings = getTabbarStrings();
    isReadFetaures();
    if (currentTime.compareTo(isChristmasDay) > 0) {
      isChristmasDaY = true;
    }
    if (currentTime.compareTo(isChristmasDay1) > 0) {
      isChristmasDaY = true;
    }
    if (currentTime.compareTo(isChristmasDay2) > 0) {
      isChristmasDaY = true;
    }
    if (currentTime.compareTo(isChristmasDay3) > 0) {
      isChristmasDaY = true;
    }
    if (currentTime.compareTo(isChristmasDay4) > 0) {
      isChristmasDaY = true;
    } else if (currentTime.compareTo(isChristmasDay) < 0) {
      isChristmasDaY = false;
    }
    initPlatformStateForOneSignal();
  }

  Future<void> initPlatformStateForOneSignal() async {
    OneSignal.shared.setAppId(oneSignalAppId);
    OneSignal.shared.setInAppMessageClickedHandler((action) {});
    await OneSignal.shared
        .promptUserForPushNotificationPermission(fallbackToSettings: true);
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          (isRead == false)
              ? Center(
                  child: UpdateNewFeature(
                    function: () async {
                      preferences = await SharedPreferences.getInstance();
                      preferences.setBool("isRead", true);
                      setState(() {
                        isRead = true;
                      });
                    },
                  ),
                )
              : Column(
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 65,
                      child: ListView.builder(
                        itemCount: strings.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding:
                                EdgeInsets.only(top: 10, bottom: 10, left: 5),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(25),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => CategoryToImageList(
                                        imageUrl: strings[index].imageNames,
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  width: 120,
                                  color:
                                      Provider.of<Settings>(context).isDarkMode
                                          ? RandomColor().randomColor(
                                              colorBrightness:
                                                  ColorBrightness.veryLight,
                                            )
                                          : RandomColor()
                                              .randomMaterialColor()
                                              .withOpacity(0.4),
                                  child: Center(
                                    child: Text(
                                      "${strings[index].imageNames}",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Expanded(
                      child: LiquidPullToRefresh(
                        color: Colors.red,
                        key: _refreshIndicatorKey,
                        onRefresh: _handleRefreshData,
                        showChildOpacityTransition: false,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          child: gridImageListView(),
                        ),
                      ),
                    ),
                    // Container(
                    //   width: MediaQuery.of(context).size.width,
                    //   height: 55,
                    //   child: AdmobBanner(
                    //     adUnitId: BannerTestId,
                    //     adSize: AdmobBannerSize.BANNER,
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
          isChristmasDaY == true
              ? Lottie.asset(
                  'assets/snow_json.json',
                )
              : const SizedBox(),
        ],
      ),
    );
  }

  Future<dynamic> _handleRefreshData() async {
    final Completer<void> completer = Completer<void>();
    Timer(const Duration(seconds: 3), () {
      completer.complete();
    });
    setState(() {
      _loadSearchImages(rApiTexts);
    });
  }

  gridImageListView() {
    return (photos.length > 0)
        ? GridView.builder(
            controller: _gridController,
            itemCount: photos.length + 1,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 5,
              crossAxisSpacing: 5,
              childAspectRatio: 0.6,
            ),
            itemBuilder: (context, index) {
              if (index == photos.length) {
                return Center(
                  child: SizedBox(
                    child: Lottie.asset(
                      'assets/circle_loading_lottie.json',
                      width: 70,
                      height: 70,
                    ),
                    width: 30,
                    height: 30,
                  ),
                );
              }
              return Hero(
                tag: photos[index].src.large2X,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (ctx) => FullImage(
                          imgUrl: photos[index].src.large2X,
                          imgIndex: index,
                          imgsList: photos,
                          //Bura onsa isdemir
                          imageName: photos[index].photographer,
                        ),
                      ),
                    );
                  },
                  child: Padding(
                    padding: EdgeInsets.only(top: 5, left: 2, right: 2),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: OctoImage(
                        fit: BoxFit.cover,
                        fadeInCurve: Curves.easeInCubic,
                        fadeOutCurve: Curves.easeOutSine,
                        image: NetworkImage(photos[index].src.portrait),
                        progressIndicatorBuilder: (context, progress) {
                          double value = 0;
                          var expectedBytes = progress?.expectedTotalBytes;
                          if (progress != null && expectedBytes != null) {
                            value =
                                progress.cumulativeBytesLoaded / expectedBytes;
                          }
                          return Center(
                            child: Lottie.asset(
                              'assets/circle_loading_lottie.json',
                              width: 70,
                              height: 70,
                            ),
                          );
                        },
                        errorBuilder: (context, error, stacktrace) => Center(
                          child: Icon(
                            Icons.error,
                            size: 40,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          )
        : Center(
            child: Lottie.asset(
              'assets/circle_loading_lottie.json',
              width: 70,
              height: 70,
            ),
          );
  }

  //Todo Sekillerin ele gec gelmesi try ve catch ile baglidir cunki search da ele deyil
  _loadSearchImages(String query) async {
    try {
      var model =
          await ProImageApiProvider().getSearchedProImages(query, ++_page);
      photos.addAll(model.photos);
      setState(() {});
    } catch (e) {}
  }

  _scrollListener() {
    if (_gridController.offset >= _gridController.position.maxScrollExtent &&
        !_gridController.position.outOfRange) {
      _loadSearchImages(rApiTexts);
    }
  }

  @override
  void dispose() {
    super.dispose();
    resetSearch();
  }

  resetSearch() {
    photos.clear();
    _page = 0;
  }
}
