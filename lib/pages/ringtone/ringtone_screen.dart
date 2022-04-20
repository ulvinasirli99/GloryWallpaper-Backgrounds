import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper_app_flutter/pages/ringtone/premium_ringtone_screen.dart';
import 'package:wallpaper_app_flutter/state/cubit/ringtone_cubit/ringtone_cubit_cubit.dart';
import 'package:wallpaper_app_flutter/state/provider/theme_provider.dart';
import 'package:wallpaper_app_flutter/views/ringtone/ringtone_gridview.dart';
import 'package:wallpaper_app_flutter/widget/button/custom_back_button.dart';
import 'package:wallpaper_app_flutter/widget/text/custom_text.dart';

class RingtoneScreen extends StatefulWidget {
  const RingtoneScreen({Key? key}) : super(key: key);

  @override
  _RingtoneScreenState createState() => _RingtoneScreenState();
}

class _RingtoneScreenState extends State<RingtoneScreen> {
  AudioPlayer player = AudioPlayer();

  int currentIndex = -1;

  @override
  void initState() {
    context.read<RingtoneCubitCubit>().getAllRingtoneListCallback();
    super.initState();
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Provider.of<Settings>(context).isDarkMode
          ? Colors.black
          : Colors.indigo.shade400,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15, top: 15),
                child: CustomBackButton(),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 12, top: 8),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (ctx) => PremiumRingtoneScreen(),
                      ),
                    );
                  },
                  child: Lottie.asset(
                    'assets/premimumlottie.json',
                    width: 55,
                    height: 55,
                  ),
                ),
              ),
            ],
          ),
          BlocBuilder<RingtoneCubitCubit, RingtoneCubitState>(
            builder: (context, state) {
              if (state is RingtoneCubitLoading) {
                return Expanded(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              if (state is RingtoneCubitError) {
                return Center(
                  child: CustomText(
                    text: "Error : " + state.errorMessage,
                    textSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                );
              }
              if (state is RingtoneCubitLoaded) {
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20, left: 8, right: 8),
                    child: GridView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: state.ringtoneList.length,
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
                                state.ringtoneList[index].musicName!,
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
                          url: state.ringtoneList[index].musicName,
                        );
                      },
                    ),
                  ),
                );
              }
              return Center(
                child: CustomText(
                  text: "Ringtone don't loaded...\nPlease try again...",
                  textSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  textAlign: TextAlign.center,
                ),
              );
            },
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
