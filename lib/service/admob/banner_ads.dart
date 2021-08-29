// import 'dart:io';
//
// import 'package:admob_flutter/admob_flutter.dart';
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// class MyMaterialApp extends StatefulWidget {
//   @override
//   _MyMaterialAppState createState() => _MyMaterialAppState();
// }
//
// class _MyMaterialAppState extends State<MyMaterialApp> {
//   AdmobBannerSize bannerSize;
//   AdmobInterstitial interstitialAd;
//
//   @override
//   void initState() {
//     super.initState();
//
//     // You should execute `Admob.requestTrackingAuthorization()` here before showing any ad.
//
//     bannerSize = AdmobBannerSize.BANNER;
//
//     interstitialAd = AdmobInterstitial(
//       adUnitId: getInterstitialAdUnitId(),
//       listener: (AdmobAdEvent event, Map<String, dynamic> args) {
//         if (event == AdmobAdEvent.closed) interstitialAd.load();
//         handleEvent(event, args, 'Interstitial');
//       },
//     );
//
//     interstitialAd.load();
//   }
//
//   void handleEvent(
//       AdmobAdEvent event, Map<String, dynamic> args, String adType) {
//     switch (event) {
//       case AdmobAdEvent.loaded:
//         print("Loaded");
//         break;
//       case AdmobAdEvent.opened:
//         print("Opend");
//         break;
//       case AdmobAdEvent.closed:
//         print("Closed");
//         break;
//       case AdmobAdEvent.failedToLoad:
//         print("Failed");
//         break;
//       default:
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primarySwatch: Colors.blueGrey,
//       ),
//       home: Builder(
//         builder: (BuildContext context) => Scaffold(
//           appBar: AppBar(
//             title: const Text('AdmobFlutter'),
//           ), // .withBottomAdmobBanner(context),
//           bottomNavigationBar: Builder(
//             builder: (BuildContext context) {
//               return Container(
//                 color: Colors.blueGrey,
//                 child: SafeArea(
//                   child: SizedBox(
//                     height: 60,
//                     child: Row(
//                       crossAxisAlignment: CrossAxisAlignment.stretch,
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: <Widget>[
//                         Expanded(
//                           child: FlatButton(
//                             child: Text(
//                               'Show Interstitial',
//                               style: TextStyle(color: Colors.white),
//                             ),
//                             onPressed: () async {
//                               if (await interstitialAd.isLoaded) {
//                                 interstitialAd.show();
//                               } else {
//                                 print("Loaded");
//                               }
//                             },
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.zero,
//                             ),
//                           ),
//                         ),
//                         Expanded(
//                           child: PopupMenuButton(
//                             initialValue: bannerSize,
//                             child: Center(
//                               child: Text(
//                                 'Banner size',
//                                 style: TextStyle(
//                                     fontWeight: FontWeight.w500,
//                                     color: Colors.white),
//                               ),
//                             ),
//                             offset: Offset(0, 20),
//                             onSelected: (AdmobBannerSize newSize) {
//                               setState(() {
//                                 bannerSize = newSize;
//                               });
//                             },
//                             itemBuilder: (BuildContext context) =>
//                                 <PopupMenuEntry<AdmobBannerSize>>[
//                               PopupMenuItem(
//                                 value: AdmobBannerSize.BANNER,
//                                 child: Text('BANNER'),
//                               ),
//                               PopupMenuItem(
//                                 value: AdmobBannerSize.LARGE_BANNER,
//                                 child: Text('LARGE_BANNER'),
//                               ),
//                               PopupMenuItem(
//                                 value: AdmobBannerSize.MEDIUM_RECTANGLE,
//                                 child: Text('MEDIUM_RECTANGLE'),
//                               ),
//                               PopupMenuItem(
//                                 value: AdmobBannerSize.FULL_BANNER,
//                                 child: Text('FULL_BANNER'),
//                               ),
//                               PopupMenuItem(
//                                 value: AdmobBannerSize.LEADERBOARD,
//                                 child: Text('LEADERBOARD'),
//                               ),
//                               PopupMenuItem(
//                                 value: AdmobBannerSize.SMART_BANNER(context),
//                                 child: Text('SMART_BANNER'),
//                               ),
//                               PopupMenuItem(
//                                 value: AdmobBannerSize.ADAPTIVE_BANNER(
//                                   width: MediaQuery.of(context)
//                                           .size
//                                           .width
//                                           .toInt() -
//                                       40, // considering EdgeInsets.all(20.0)
//                                 ),
//                                 child: Text('ADAPTIVE_BANNER'),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               );
//             },
//           ),
//           body: Column(
//             children: [
//               Expanded(
//                 child: Scrollbar(
//                   child: ListView.builder(
//                     padding: EdgeInsets.all(20.0),
//                     itemCount: 1000,
//                     itemBuilder: (BuildContext context, int index) {
//                       if (index != 0 && index % 6 == 0) {
//                         return Column(
//                           children: <Widget>[
//                             Container(
//                               margin: EdgeInsets.only(bottom: 20.0),
//                               child: AdmobBanner(
//                                 adUnitId: getBannerAdUnitId(),
//                                 adSize: bannerSize,
//                                 listener: (AdmobAdEvent event,
//                                     Map<String, dynamic> args) {
//                                   handleEvent(event, args, 'Banner');
//                                 },
//                                 onBannerCreated:
//                                     (AdmobBannerController controller) {
//                                   // Dispose is called automatically for you when Flutter removes the banner from the widget tree.
//                                   // Normally you don't need to worry about disposing this yourself, it's handled.
//                                   // If you need direct access to dispose, this is your guy!
//                                   // controller.dispose();
//                                 },
//                               ),
//                             ),
//                             Container(
//                               height: 100.0,
//                               margin: EdgeInsets.only(bottom: 20.0),
//                               color: Colors.cyan,
//                             ),
//                           ],
//                         );
//                       }
//                       return Container(
//                         height: 100.0,
//                         margin: EdgeInsets.only(bottom: 20.0),
//                         color: Colors.cyan,
//                       );
//                     },
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//     // .withBottomAdmobBanner(context);
//   }
//
//   @override
//   void dispose() {
//     interstitialAd.dispose();
//     super.dispose();
//   }
// }
//
// String getBannerAdUnitId() {
//   if (Platform.isIOS) {
//     return 'ca-app-pub-3940256099942544/2934735716';
//   } else if (Platform.isAndroid) {
//     return 'ca-app-pub-3940256099942544/6300978111';
//   }
//   return null;
// }
//
// String getInterstitialAdUnitId() {
//   if (Platform.isIOS) {
//     return 'ca-app-pub-3940256099942544/4411468910';
//   } else if (Platform.isAndroid) {
//     return 'ca-app-pub-3940256099942544/1033173712';
//   }
//   return null;
// }
