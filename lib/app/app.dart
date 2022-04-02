import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper_app_flutter/localizations/app_localizations.dart';
import 'package:wallpaper_app_flutter/splash/splash_screen.dart';
import 'package:wallpaper_app_flutter/state/provider/theme_provider.dart';
import 'package:wallpaper_app_flutter/utils/theme/theme.dart';


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
          if (supportedLocaleLanguage.languageCode == locale!.languageCode &&
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