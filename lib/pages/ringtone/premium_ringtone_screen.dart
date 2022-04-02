import 'package:animated_search_bar/animated_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper_app_flutter/state/cubit/premium_ringtone/premium_ringtone_zedge_cubit.dart';
import 'package:wallpaper_app_flutter/state/cubit/premium_ringtone_search_bloc/premium_ringtone_search_bloc.dart';
import 'package:wallpaper_app_flutter/state/provider/theme_provider.dart';
import 'package:wallpaper_app_flutter/views/ringtone/ringtone_gridview.dart';
import 'package:wallpaper_app_flutter/widget/button/custom_back_button.dart';
import 'package:wallpaper_app_flutter/widget/text/custom_text.dart';

class PremiumRingtoneScreen extends StatefulWidget {
  const PremiumRingtoneScreen({Key ?key}) : super(key: key);

  @override
  _PremiumRingtoneScreenState createState() => _PremiumRingtoneScreenState();
}

class _PremiumRingtoneScreenState extends State<PremiumRingtoneScreen> {
  AudioPlayer player = AudioPlayer();
  int currentIndex = -1;
  bool animtionColumnVisibilty = false;
  int premiumSearchPageIndex = 1;
  String searchField = "";

  @override
  void initState() {
    super.initState();
    context.read<PremiumRingtoneZedgeCubit>().premiumRingtoneTrending(1);
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.purple.shade200,
                  Colors.purple.shade300,
                  Colors.purple.shade400,
                  Colors.purple.shade500,
                ],
              ),
            ),
          ),
          AnimatedOpacity(
            opacity: animtionColumnVisibilty == false ? 1 : 0,
            duration: const Duration(milliseconds: 700),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15, top: 15),
                  child: CustomBackButton(),
                ),
                BlocBuilder<PremiumRingtoneZedgeCubit,
                    PremiumRingtoneZedgeState>(
                  builder: (context, state) {
                    if (state is PremiumRingtoneZedgeLoading) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (state is PremiumRingtoneZedgeError) {
                      return Center(
                        child: CustomText(
                          text: "Error Message : ${state.errMessgae} : " +
                              state.errCode,
                        ),
                      );
                    }
                    if (state is PremiumRingtoneZedgeLoaded) {
                      return Expanded(
                        child: Padding(
                          padding:
                              const EdgeInsets.only(top: 20, left: 8, right: 8),
                          child: GridView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: state.premiumModelList!.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 8,
                              crossAxisSpacing: 10,
                              childAspectRatio: 0.6,
                            ),
                            itemBuilder: (ctx, index) {
                              return CustomRingtoneGridview(
                                child: IconButton(
                                  onPressed: () async {
                                    await player.setUrl(
                                      state.premiumModelList![index]!.meta!
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
                                url: state
                                    .premiumModelList![index]!.meta!.previewUrl!,
                                backImgUrl:
                                    state.premiumModelList![index]!.imageUrl,
                              );
                            },
                          ),
                        ),
                      );
                    }
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width / 2.7,
              top: 8,
              right: 12,
            ),
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
                BlocProvider.of<PremiumRingtoneSearchBloc>(context).add(
                  PremiumSearhEvent(
                    premiumSearchPageIndex,
                    value,
                  ),
                );
                setState(() {
                  if (value.length > 0) {
                    animtionColumnVisibilty = true;
                  } else {
                    animtionColumnVisibilty = false;
                  }
                });
              },
            ),
          ),
          AnimatedOpacity(
            opacity: animtionColumnVisibilty == true ? 1 : 0,
            duration: const Duration(milliseconds: 700),
            child: BlocBuilder<PremiumRingtoneSearchBloc,
                PremiumRingtoneSearchState>(
              builder: (ctx, state) {
                if (state is PremiumRingtoneSearchLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is PremiumRingtoneSearchLoaded) {
                  return Padding(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height / 8,
                      left: 8,
                      right: 8,
                    ),
                    child: GridView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: state.premiumModelList!.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 10,
                        childAspectRatio: 0.6,
                      ),
                      itemBuilder: (ctx, index) {
                        return CustomRingtoneGridview(
                          child: IconButton(
                            onPressed: () async {
                              await player.setUrl(
                                state.premiumModelList![index]!.meta!.previewUrl!,
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
                          url: state.premiumModelList![index]!.meta?.previewUrl,
                          backImgUrl: state.premiumModelList![index]!.imageUrl,
                        );
                      },
                    ),
                  );
                }
                if (state is PremiumRingtoneSearchError) {
                  return Center(
                    child: CustomText(text: state.errMsg),
                  );
                }
                return Center(
                    child: CustomText(
                        text: "Data not loaded...Please try again later."));
              },
            ),
          ),
        ],
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
