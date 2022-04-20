import 'dart:math';
import 'package:animated_search_bar/animated_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper_app_flutter/model/ringtone/pro_ringtone_model.dart';
import 'package:wallpaper_app_flutter/state/getx/premium_ringtone_getx.dart';
import 'package:wallpaper_app_flutter/state/provider/theme_provider.dart';
import 'package:wallpaper_app_flutter/views/ringtone/ringtone_gridview.dart';
import 'package:wallpaper_app_flutter/widget/button/custom_back_button.dart';

class PremiumRingtoneScreen extends StatefulWidget {
  const PremiumRingtoneScreen({Key? key}) : super(key: key);

  @override
  _PremiumRingtoneScreenState createState() => _PremiumRingtoneScreenState();
}

class _PremiumRingtoneScreenState extends State<PremiumRingtoneScreen> {
  AudioPlayer player = AudioPlayer();
  int currentIndex = -1;
  bool animtionColumnVisibilty = false;

  int initialPageNumber = Random().nextInt(30);
  int searchByPremiumSearchPageIndex = 1;
  String searchFieldByProRingtone = '';
  PremimumRingtoneController premimumRingtoneController =
      Get.put(PremimumRingtoneController());
  ScrollController ringtoneScrollCtr = ScrollController();
  ScrollController searchPproRingtoneScrollCtr = ScrollController();

  @override
  void initState() {
    super.initState();
    premimumRingtoneController.initalizePrRingListData(initialPageNumber);
    ringtoneScrollCtr.addListener(() {
      if (ringtoneScrollCtr.offset >=
              ringtoneScrollCtr.position.maxScrollExtent &&
          !ringtoneScrollCtr.position.outOfRange) {
        setState(() {
          initialPageNumber++;
          premimumRingtoneController.nextPrRingListData(initialPageNumber);
          print(initialPageNumber);
        });
      }
    });
    // Todo By Search Premimum Ringtone.....
    searchPproRingtoneScrollCtr.addListener(() {
      if (searchPproRingtoneScrollCtr.offset >=
              searchPproRingtoneScrollCtr.position.maxScrollExtent &&
          !searchPproRingtoneScrollCtr.position.outOfRange) {
        setState(() {
          searchByPremiumSearchPageIndex++;
          premimumRingtoneController.bySearchProRingonteNexPageMethod(
              searchFieldByProRingtone, searchByPremiumSearchPageIndex);
          print(searchByPremiumSearchPageIndex);
        });
      }
    });
  }

  @override
  void dispose() {
    player.dispose();
    premimumRingtoneController.dispose();
    ringtoneScrollCtr.dispose();
    searchPproRingtoneScrollCtr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          backGenerateColor(),
          Container(
            margin: EdgeInsets.only(top: (10 * size.height) / 100),
            child: firstInitalizedScreen(),
          ),
          searchInputFormAndBackComponent(context),
          animtionColumnVisibilty == true
              ? Container(
                  margin: EdgeInsets.only(top: (10 * size.height) / 100),
                  child: responseOfPremiumSearchWidget(),
                )
              : const SizedBox(),
        ],
      ),
    );
  }

  Widget responseOfPremiumSearchWidget() {
    return AnimatedOpacity(
      opacity: animtionColumnVisibilty == true ? 1 : 0,
      duration: const Duration(milliseconds: 300),
      child: GetX<PremimumRingtoneController>(
        builder: (isLoadValue) {
          List<PremimumRingtoneModel?> searchPremiumModelList =
              premimumRingtoneController.prRingList;
          return isLoadValue.isLoadingValue.value
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Padding(
                  padding: const EdgeInsets.only(top: 20, left: 8, right: 8),
                  child: GridView.builder(
                    controller: searchPproRingtoneScrollCtr,
                    physics: const BouncingScrollPhysics(),
                    itemCount: searchPremiumModelList.length + 1,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 10,
                      childAspectRatio: 0.6,
                    ),
                    itemBuilder: (ctx, index) {
                      if (index == searchPremiumModelList.length) {
                        return SizedBox(
                          width: 70,
                          height: 70,
                          child: Center(
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(
                                Color.fromARGB(255, 68, 0, 135),
                              ),
                            ),
                          ),
                        );
                      }
                      return CustomRingtoneGridview(
                        child: IconButton(
                          onPressed: () async {
                            await player.setUrl(
                              searchPremiumModelList[index]!.meta!.previewUrl!,
                            );
                            setState(() {
                              if (currentIndex < index) {
                                playRingtone();
                                currentIndex = index;
                              } else if (currentIndex == index) {
                                pauseRingtone();
                                currentIndex = -1;
                              }
                            });
                          },
                          icon: Icon(
                            currentIndex != index
                                ? Icons.play_arrow_rounded
                                : Icons.pause,
                          ),
                          iconSize: 100,
                          color: currentIndex != index
                              ? Colors.yellow
                              : Colors.white,
                        ),
                        url: searchPremiumModelList[index]!.meta!.previewUrl!,
                        backImgUrl: searchPremiumModelList[index]!.imageUrl,
                      );
                    },
                  ),
                );
        },
      ),
    );
  }

  Padding searchInputFormAndBackComponent(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 8,
        right: 12,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15, top: 8),
            child: CustomBackButton(),
          ),
          SizedBox(
            width: 30,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: AnimatedSearchBar(
                searchStyle: TextStyle(
                  color: Provider.of<Settings>(context).isDarkMode
                      ? Colors.white
                      : Colors.black,
                  fontSize: 18,
                ),
                searchIcon: Icon(
                  Icons.search,
                  size: 35,
                  color: Colors.white,
                ),
                closeIcon: Icon(
                  Icons.clear,
                  color: Provider.of<Settings>(context).isDarkMode
                      ? Colors.white
                      : Colors.black,
                ),
                cursorColor: Colors.white,
                searchDecoration: InputDecoration(
                  hintText: "Search Ringtone",
                  alignLabelWithHint: true,
                  fillColor: Colors.white,
                  focusColor: Colors.white,
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                ),
                onChanged: (value) {
                  print(value);
                  PremimumRingtoneController searchDynamicCTR =
                      Get.put(PremimumRingtoneController());
                  searchDynamicCTR.bySearchProRingonteMethodFirst(
                    value,
                    searchByPremiumSearchPageIndex,
                  );
                  setState(() {
                    searchFieldByProRingtone = value;
                    print("searchFieldByProRingtone : " +
                        searchFieldByProRingtone);
                    if (value.length > 0) {
                      animtionColumnVisibilty = true;
                    } else {
                      animtionColumnVisibilty = false;
                    }
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget firstInitalizedScreen() {
    return AnimatedOpacity(
      opacity: animtionColumnVisibilty == false ? 1 : 0,
      duration: const Duration(milliseconds: 300),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: RefreshIndicator(
              color: Provider.of<Settings>(context).isDarkMode
                  ? Colors.white
                  : Colors.black,
              backgroundColor: Provider.of<Settings>(context).isDarkMode
                  ? Colors.black
                  : Colors.white,
              onRefresh: () async {
                int randomPageNum = Random().nextInt(35);
                premimumRingtoneController
                    .initalizePrRingListData(randomPageNum);
              },
              child: GetX<PremimumRingtoneController>(
                builder: (isLoading) {
                  List<PremimumRingtoneModel?> premiumModelList =
                      premimumRingtoneController.prRingList;
                  return isLoading.isLoadingValue.value
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : Padding(
                          padding:
                              const EdgeInsets.only(top: 20, left: 8, right: 8),
                          child: GridView.builder(
                            controller: ringtoneScrollCtr,
                            physics: const BouncingScrollPhysics(),
                            itemCount: premiumModelList.length + 1,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 8,
                              crossAxisSpacing: 10,
                              childAspectRatio: 0.6,
                            ),
                            itemBuilder: (ctx, index) {
                              if (index == premiumModelList.length) {
                                return SizedBox(
                                  width: 70,
                                  height: 70,
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation(
                                        Color.fromARGB(255, 68, 0, 135),
                                      ),
                                    ),
                                  ),
                                );
                              }
                              return CustomRingtoneGridview(
                                child: IconButton(
                                  onPressed: () async {
                                    await player.setUrl(
                                      premiumModelList[index]!
                                          .meta!
                                          .previewUrl!,
                                    );
                                    setState(() {
                                      if (currentIndex < index) {
                                        playRingtone();
                                        currentIndex = index;
                                      } else if (currentIndex == index) {
                                        pauseRingtone();
                                        currentIndex = -1;
                                      }
                                    });
                                  },
                                  icon: Icon(
                                    currentIndex != index
                                        ? Icons.play_arrow_rounded
                                        : Icons.pause,
                                  ),
                                  iconSize: 100,
                                  color: currentIndex != index
                                      ? Colors.yellow
                                      : Colors.white,
                                ),
                                url: premiumModelList[index]!.meta!.previewUrl!,
                                backImgUrl: premiumModelList[index]!.imageUrl,
                              );
                            },
                          ),
                        );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container backGenerateColor() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: Provider.of<Settings>(context).isDarkMode
              ? [Colors.black, Colors.black, Colors.black]
              : [
                  Colors.purple.shade200,
                  Colors.purple.shade300,
                  Colors.purple.shade400,
                  Colors.purple.shade500,
                ],
        ),
      ),
    );
  }

  playRingtone() async {
    await player.play();
  }

  pauseRingtone() async {
    await player.pause();
  }
}
