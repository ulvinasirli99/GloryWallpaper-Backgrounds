import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_cmoon_icons/flutter_cmoon_icons.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper_app_flutter/pages/navPage/dialog/msg_send_dialog.dart';
import 'package:wallpaper_app_flutter/service/firestore/feedback_service.dart';
import 'package:wallpaper_app_flutter/service/provider/theme_provider.dart';
import 'package:wallpaper_app_flutter/utils/global/constants.dart';
import 'package:wallpaper_app_flutter/widget/global/toasts.dart';

class FeedbackPage extends StatefulWidget {
  @override
  _FeedbackPageState createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  final scaffolKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final msgController = TextEditingController();
  // AdmobInterstitial interstitialAd;
  FeedbackService feedbackService = FeedbackService();
  String email = '';
  String message = '';

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   interstitialAd = AdmobInterstitial(
  //     adUnitId: INTERSITITAL_ID,
  //     listener: (AdmobAdEvent event, Map<String, dynamic> args) {
  //       if (event == AdmobAdEvent.closed) interstitialAd.load();
  //       handleEvent(event, args, 'Interstitial');
  //     },
  //   );
  //
  //   interstitialAd.load();
  // }

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
      body: Form(
        key: formKey,
        child: Container(
          color: Provider.of<Settings>(context).isDarkMode
              ? Colors.grey
              : Colors.blue,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Align(
            alignment: Alignment.center,
            child: ListView(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Provider.of<Settings>(context).isDarkMode
                          ? Colors.grey[300]
                          : Colors.blue[300],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height - 100,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Feedback',
                          style: TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.w900,
                              color: Colors.yellow),
                        ),
                        TextFormField(
                          onSaved: (mail) {
                            email = mail;
                          },
                          keyboardType: TextInputType.emailAddress,
                          validator: (email) {
                            if (!email.contains('@')) {
                              return 'Enter the email form correctly';
                            }
                            if (email.isEmpty) {
                              return 'Email is empty';
                            }
                          },
                          controller: emailController,
                          decoration: InputDecoration(
                            hintText:
                                'Email (Please enter the email correctly)',
                            suffixIcon: Icon(IconMoon.icon_email1),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          onSaved: (msg) {
                            message = msg;
                          },
                          validator: (msg) {
                            if (msg.isEmpty) {
                              return 'Message is empty';
                            }
                          },
                          controller: msgController,
                          decoration: InputDecoration(
                            hintText: 'Message',
                            suffixIcon: Icon(Icons.message),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            GestureDetector(
                              onTap: () async {
                                if (formKey.currentState.validate()) {
                                  // if (await interstitialAd.isLoaded) {
                                  //   interstitialAd.show();
                                  // } else {
                                  //   print("Loaded");
                                  // }
                                  formKey.currentState.save();
                                  feedbackService.addMeessageService(
                                      email, message);
                                  messageSendResultDialog(context);
                                  msgController.clear();
                                  emailController.clear();
                                }
                              },
                              child: Container(
                                margin: EdgeInsets.only(bottom: 14),
                                width: MediaQuery.of(context).size.width / 2,
                                height: 48,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(9),
                                  color: Colors.blue[500],
                                ),
                                child: Center(
                                    child: Text(
                                  'Send Feedback',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  messageSendResultDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => MsgResultDialog(
        title: 'Thank you Feedback',
        description:
            'Thank you for this notification. You will be answered soon.',
        buttonText: 'Close',
      ),
    );
  }
}
