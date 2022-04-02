import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:wallpaper_app_flutter/utils/share/share.dart';

class AdsToProDialog extends StatelessWidget {
  final VoidCallback? voidCallback;

  const AdsToProDialog({
    Key? key,
    @required this.voidCallback,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0.0,
      insetAnimationCurve: Curves.bounceInOut,
      backgroundColor: Colors.transparent,
      child: dialocontent(context, voidCallback!),
    );
  }
}

Center dialocontent(BuildContext context, VoidCallback callback) {
  return Center(
    child: ClipRRect(
      borderRadius: BorderRadius.circular(14),
      child: Container(
        color: Colors.deepOrangeAccent,
        width: MediaQuery.of(context).size.width * 0.8,
        height: 400,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: callback,
                  child: Icon(
                    Icons.close,
                    size: 35,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset("assets/gif.json",
                        width: 80, height: 80, repeat: false),
                  ],
                ),
                ListTile(
                  title: Text(
                    "Rapid Support",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black54,
                      fontWeight: FontWeight.w900,
                      decoration: TextDecoration.none,
                    ),
                  ),
                  leading: Icon(
                    Icons.ads_click,
                    color: Colors.white,
                  ),
                ),
                ListTile(
                  title: Text(
                    "10 million wallpapers",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black54,
                      fontWeight: FontWeight.w900,
                      decoration: TextDecoration.none,
                    ),
                  ),
                  leading: Icon(
                    Icons.ac_unit_outlined,
                    color: Colors.white,
                  ),
                ),
                ListTile(
                  title: Text(
                    "Unlimited Pro Wallpapers",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black54,
                      fontWeight: FontWeight.w900,
                      decoration: TextDecoration.none,
                    ),
                  ),
                  leading: Icon(
                    Icons.all_inclusive,
                    color: Colors.white,
                  ),
                ),
                ListTile(
                  title: Text(
                    "More Performance Business",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black54,
                      fontWeight: FontWeight.w900,
                      decoration: TextDecoration.none,
                    ),
                  ),
                  leading: Icon(
                    Icons.navigation,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.arrow_forward_ios,
                        size: 40,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        premiumGloryGet();
                      },
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
