import 'package:animated_search_bar/animated_search_bar.dart';
import 'package:anitex/anitex.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wallpaper_app_flutter/localizations/app_localizations.dart';
import 'package:wallpaper_app_flutter/model/pro/img_model_pro.dart';
import 'package:wallpaper_app_flutter/pages/main/pages/full_image.dart';
import 'package:wallpaper_app_flutter/pages/main/widget/ui/network_error.dart';
import 'package:wallpaper_app_flutter/service/http/image/pro_image_api_provider.dart';
import 'package:wallpaper_app_flutter/state/provider/theme_provider.dart';
import 'package:wallpaper_app_flutter/utils/global/constants.dart';

class ProImagesPage extends StatefulWidget {
  @override
  _ProImagesPageState createState() => _ProImagesPageState();
}

class _ProImagesPageState extends State<ProImagesPage> {
  var _gridController = ScrollController();
  var photos = List<Photo>.empty(growable: true);
  String searchText = "";
  int page = pageNumber;
  int reward = 0;
  int getReward = 0;
  int nextReward = 0;
  // AdmobReward rewardAd;

  var imageLoadingSpinKit = SpinKitPulse(
    size: 60,
    color: Colors.redAccent,
    duration: Duration(milliseconds: 2000),
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _gridController.addListener(_scrollListener);
    if (searchText.isEmpty) {
      _loadSearchImages("4K");
    } else {
      _loadSearchImages(searchText);
    }

    //Todo rewardAd.load();
    // rewardAd = AdmobReward(
    //   adUnitId: REWARD_AD,
    //   listener: (AdmobAdEvent event, Map<String, dynamic> args) {
    //     if (event == AdmobAdEvent.closed) {
    //       rewardAd.load();
    //     }
    //     handleEvent(event, args, 'Reward');
    //   },
    // );
    // rewardAd.load();

    //Todo This is line getCoinDSF
    getCoinDSF();
  }

  //Todo Handle Event for Ads Service
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
  //     case AdmobAdEvent.rewarded:
  //       print("Rewarded geldi ${args["amount"]}");
  //       reward = args["amount"] as int;
  //       nextReward = args["amount"] as int;
  //       break;
  //     default:
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            size: 25,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: AnimatedSearchBar(
          label: "Search Wallpaper",
          labelStyle: TextStyle(fontSize: 16),
          searchStyle: TextStyle(
            color: Provider.of<Settings>(context).isDarkMode
                ? Colors.white
                : Colors.black,
          ),
          cursorColor: Colors.white,
          searchDecoration: InputDecoration(
            hintText: "Search",
            alignLabelWithHint: true,
            fillColor: Colors.white,
            focusColor: Colors.white,
            hintStyle: TextStyle(color: Colors.white70),
            border: InputBorder.none,
          ),
          onChanged: (value) {
            print(value);
            setState(() {
              searchText = value;
              resetSearch();
              value.isEmpty
                  ? _loadSearchImages("4K")
                  : _loadSearchImages(value);
            });
          },
        ),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 5),
                  child: Center(
                    child: Container(
                      width: 70,
                      height: 70,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.asset(
                          'assets/boy.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Premium Points",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.blueGrey,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    AnimatedText(
                      "${getReward.toString()} CP",
                      style: TextStyle(
                        fontSize: 18,
                        color: Provider.of<Settings>(context).isDarkMode
                            ? Colors.white
                            : Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                      duration: Duration(milliseconds: 800),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          // if (await rewardAd.isLoaded) {
                          //   // rewardAd.show();
                          //   setState(() {
                          //     getReward = getReward + 1000;
                          //     addCoinDSF(getReward);
                          //   });
                          // } else {
                          //   print('Reward ad is still loading...');
                          // }
                        },
                        child: Container(
                          width: 70,
                          height: 70,
                          child: Lottie.asset(
                            'assets/gif.json',
                            width: 40,
                            height: 40,
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: gridImageListView(),
          ),
        ],
      ),
    );
  }

  resetSearch() {
    photos.clear();
    page = 0;
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
                    child: CircularProgressIndicator(),
                    width: 30,
                    height: 30,
                  ),
                );
              }
              return Hero(
                tag: photos[index].src!.large2X!,
                child: GestureDetector(
                  onTap: () {
                    if (getReward == 0 && getReward < 200) {
                      nullCoinData();
                    } else if (getReward >= 200) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FullImage(
                            imgUrl: photos[index].src!.large2X!,
                            //Bura onsa isdemir
                            imageName: photos[index].photographer,
                          ),
                        ),
                      );
                      setState(() {
                        getReward = getReward - 200;
                        addCoinDSF(getReward);
                      });
                    }
                  },
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 5, left: 2, right: 2),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: FadeInImage(
                            fit: BoxFit.cover,
                            placeholder: AssetImage('assets/load.gif'),
                            image: NetworkImage(photos[index].src!.large!),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 12, right: 5),
                        child: Align(
                          alignment: Alignment.topRight,
                          child: Image.asset(
                            "assets/proicon.png",
                            width: 30,
                            height: 30,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          )
        : Center(
            child: WaitNetworkData(),
          );
  }

  @override
  void dispose() {
    // rewardAd.dispose();
    super.dispose();
  }

  _loadSearchImages(String query) async {
    try {
      var model =
          await ProImageApiProvider().getSearchedProImages(query, ++page);
      photos.addAll(model.photos!);
      setState(() {});
    } catch (e) {}
  }

  _scrollListener() {
    if (_gridController.offset >= _gridController.position.maxScrollExtent &&
        !_gridController.position.outOfRange) {
      _loadSearchImages("4K");
    }
  }

  void nullCoinData() {
    showAnimatedDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return ClassicGeneralDialogWidget(
          negativeText: "Cancel",
          positiveText: "Okay !",
          negativeTextStyle: TextStyle(fontSize: 16, color: Colors.red),
          positiveTextStyle: TextStyle(fontSize: 16, color: Colors.black),
          titleText: 'Alert',
          contentText:
              ApplicationLocalizations.of(context)!.translate("point_dialog"),
          onPositiveClick: () {
            Navigator.of(context).pop();
          },
          onNegativeClick: () {
            Navigator.of(context).pop();
          },
        );
      },
      animationType: DialogTransitionType.scale,
      curve: Curves.fastOutSlowIn,
      duration: Duration(milliseconds: 1000),
    );
  }

  addCoinDSF(int coinNum) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('coin', coinNum);
  }

  getCoinDSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    getReward = prefs.getInt('coin') ?? 0;
    return getReward;
  }
}
