import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper_app_flutter/state/provider/theme_provider.dart';
import 'package:wallpaper_app_flutter/widget/text/custom_text.dart';
import 'package:wallpaper_app_flutter/widget/text/gradinet_text.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> with TickerProviderStateMixin {
  AnimationController ?animationController;
  @override
  void initState() {
    super.initState();
    animationController = new AnimationController(
        duration: const Duration(seconds: 3), vsync: this);
    animationController!.forward();
    animationController!.addListener(() {
      setState(() {
        if (animationController!.status == AnimationStatus.completed) {
          animationController!.repeat();
        }
      });
    });
  }

  @override
  void dispose() {
    animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(
          color: Provider.of<Settings>(context).isDarkMode
              ? Colors.white
              : Colors.black,
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GradientText(
                        text: 'G',
                        style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                        ),
                        gradient: LinearGradient(
                          colors: [
                            Colors.blue.shade300,
                            Colors.blue.shade400,
                            Colors.red.shade400,
                            Colors.red,
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      GradientText(
                        text: 'Wallpaper',
                        gradient: LinearGradient(
                          colors: [
                            Colors.blue.shade300,
                            Colors.blue.shade400,
                            Colors.red.shade400,
                            Colors.red,
                          ],
                        ),
                        style: TextStyle(
                          fontSize: 45,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 35, right: 10),
                    width: 100,
                    height: 100,
                    child: RotationTransition(
                      turns: Tween(begin: 0.0, end: 1.0)
                          .animate(animationController!),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(60),
                        child: Image.asset(
                          'assets/darwlogo.png',
                          width: 100,
                          height: 100,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: GradientText(
                      text: '5 million eye-catching Wallpapers',
                      textAlign: TextAlign.center,
                      gradient: LinearGradient(
                        colors: [
                          Colors.red.shade300,
                          Colors.green.shade400,
                          Colors.teal.shade400,
                          Colors.red,
                        ],
                      ),
                      style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  CustomText(
                    text: 'Download with QR Code...',
                    textSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Image.asset(
                    'assets/qr_code.png',
                    width: 150,
                    height: 150,
                  )
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(left: 25, right: 25, bottom: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.app_registration,
                    size: 30,
                    color: Colors.green,
                  ),
                  GradientText(
                    text: 'Created by Ulvi Nasirov',
                    textAlign: TextAlign.center,
                    gradient: LinearGradient(
                      colors: [
                        Colors.blue.shade300,
                        Colors.green.shade400,
                        Colors.indigo.shade400,
                        Colors.purple,
                      ],
                    ),
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
