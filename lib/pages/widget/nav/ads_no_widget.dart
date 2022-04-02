import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper_app_flutter/state/provider/theme_provider.dart';

class AdsNoWidget extends StatelessWidget {
  final String? lottiePath;
  final String ?tittle;
  final VoidCallback? function;

  const AdsNoWidget({Key? key, this.lottiePath, this.tittle, this.function})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: <Widget>[
            Lottie.asset(
              lottiePath!,
              width: 45,
              height: 45,
            ),
            SizedBox(
              width: 8,
            ),
            Text(
              tittle!,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17,
                color: Provider.of<Settings>(context).isDarkMode
                    ? Colors.white
                    : Colors.purple,
                letterSpacing: 1.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
