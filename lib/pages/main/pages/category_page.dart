import 'package:flutter/material.dart';
import 'package:wallpaper_app_flutter/model/local/categorie_model.dart';
import 'package:wallpaper_app_flutter/pages/main/widget/ui/category_to_imagelist.dart';
import 'package:wallpaper_app_flutter/service/http/category_data.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:wallpaper_app_flutter/utils/global/constants.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  List<CategorieModel> categories = new List.empty(growable: true);
  // AdmobInterstitial interstitialAd;

  @override
  void initState() {
    super.initState();
    categories = getCategories();
    // interstitialAd = AdmobInterstitial(
    //   adUnitId: INTERSITITAL_ID,
    //   listener: (AdmobAdEvent event, Map<String, dynamic> args) {
    //     if (event == AdmobAdEvent.closed) interstitialAd.load();
    //     handleEvent(event, args, 'Interstitial');
    //   },
    // );
    //
    // interstitialAd.load();
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
  //
  // @override
  // void dispose() {
  //   interstitialAd.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimationLimiter(
        child: ListView.builder(
          itemCount: categories.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (BuildContext context, int index) {
            return AnimationConfiguration.staggeredList(
              delay: Duration(milliseconds: 500),
              duration: Duration(milliseconds: 2000),
              position: index,
              child: SlideAnimation(
                duration: Duration(milliseconds: 7000),
                verticalOffset: 50.0,
                child: FadeInAnimation(
                  delay: Duration(milliseconds: 500),
                  duration: Duration(milliseconds: 2000),
                  child: InkWell(
                    onTap: () async {
                      //Todo Thhis is loine intersitital ads service begin
                      // if (await interstitialAd.isLoaded) {
                      //   interstitialAd.show();
                      // } else {
                      //   print("Loaded");
                      // }
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CategoryToImageList(
                            imageUrl: categories[index].categorieName,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.only(
                        top: 7,
                        left: 12,
                        right: 10,
                      ),
                      width: MediaQuery.of(context).size.width,
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          12,
                        ),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            categories[index].imgUrl,
                          ),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          categories[index].categorieName,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
