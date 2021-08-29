import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper_app_flutter/service/provider/theme_provider.dart';
import 'package:wallpaper_app_flutter/splash/splash_screen.dart';
import 'package:wallpaper_app_flutter/utils/theme/theme.dart';
import 'localizations/app_localizations.dart';
import 'splash/glory_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Initialize without device test ids.
  // Admob.initialize(testDeviceIds: [DEVICE_ID]);
  // Or add a list of test ids.
  // Admob.initialize(testDeviceIds: ['YOUR DEVICE ID']);

  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  runApp(GloryWall());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Glory Wallpaper',
      theme: Provider.of<Settings>(context).isDarkMode
          ? setDarkTheme
          : setLightTheme,
      supportedLocales: [
        Locale('en', 'US'),
        Locale('az', 'AZ'),
        Locale('de', 'DE'),
        Locale('ru', 'RU'),
        Locale('tr', 'TR'),
      ],
      localizationsDelegates: [
        ApplicationLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        for (var supportedLocaleLanguage in supportedLocales) {
          if (supportedLocaleLanguage.languageCode == locale.languageCode &&
              supportedLocaleLanguage.countryCode == locale.countryCode) {
            return supportedLocaleLanguage;
          }
        }

        return supportedLocales.first;
      },
      home: SplashScreen(),
    );
  }
}
