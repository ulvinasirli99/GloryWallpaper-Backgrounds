import 'dart:io';

import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper_app_flutter/database/db/database_provider.dart';
import 'package:wallpaper_app_flutter/database/db_model/favorite_model.dart';
import 'package:wallpaper_app_flutter/localizations/app_localizations.dart';
import 'package:wallpaper_app_flutter/service/provider/theme_provider.dart';
import 'package:wallpaper_app_flutter/utils/global/constants.dart';
import 'full_image.dart';

class FavoritePage extends StatefulWidget {
  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey =
      GlobalKey<LiquidPullToRefreshState>();
  // AdmobBannerSize bannerSize;
  List<Favorite> list = new List.empty(growable: true);
  //Todo Favorite Sayafasinda Image carousel Silder  Olacak
  Future<List<Favorite>> getData() async {
    var db = Helper();
    await db.getFavorites().then((value) {
      list = value;
    });
    return list;
  }

  @override
  void initState() {
    super.initState();
    // bannerSize = AdmobBannerSize.BANNER;
    getData();
    print(list);
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
      backgroundColor: Provider.of<Settings>(context).isDarkMode
          ? Colors.black
          : Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
          margin: EdgeInsets.only(top: 7),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: <Widget>[
              Expanded(
                child: FutureBuilder(
                  future: getData(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Favorite>> snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (snapshot.data.length == 0) {
                      return Center(
                        child: Text(
                          ApplicationLocalizations.of(context)
                              .translate('no_fav'),
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.teal,
                          ),
                        ),
                      );
                    }
                    if (snapshot.data.length > 0) {
                      return LiquidPullToRefresh(
                        color: Colors.red,
                        key: _refreshIndicatorKey,
                        onRefresh: () async {
                          try {
                            setState(() {
                              buildFavImagesAllGetApiRefresh(snapshot);
                            });
                          } catch (e) {}
                        },
                        child: buildFavImagesAllGetApiRefresh(snapshot),
                      );
                    }
                  },
                ),
              ),
              // Container(
              //   //Todo.BANNER BANNER_ID
              //   width: MediaQuery.of(context).size.width,
              //   height: 55,
              //   child: AdmobBanner(
              //     adUnitId: BANNER_ID,
              //     adSize: AdmobBannerSize.BANNER,
              //     listener: (AdmobAdEvent event, Map<String, dynamic> args) {
              //       handleEvent(event, args, 'Banner');
              //     },
              //     onBannerCreated: (AdmobBannerController controller) {
              //       //! Dispose is called automatically for you when Flutter removes the banner from the widget tree.
              //       //? Normally you don't need to worry about disposing this yourself, it's handled.
              //       //Todo If you need direct access to dispose, this is your guy!
              //       //! controller.dispose();
              //     },
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  GridView buildFavImagesAllGetApiRefresh(
      AsyncSnapshot<List<Favorite>> snapshot) {
    return GridView.builder(
      itemCount: snapshot.data.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
        childAspectRatio: 0.5,
      ),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FullImage(
                  imgUrl: snapshot.data[index].name,
                  imgIndex: index,
                  imgsList: null,
                  favListImgs: snapshot.data,
                ),
              ),
            );
          },
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(12),
              bottomLeft: Radius.circular(12),
            ),
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage("${snapshot.data[index].name}"),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
