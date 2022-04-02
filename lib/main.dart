import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:wallpaper_app_flutter/manager/download_manager.dart';
import 'package:wallpaper_app_flutter/repository/premium_ringtone_repository.dart';
import 'package:wallpaper_app_flutter/repository/ringtone_repository.dart';
import 'package:wallpaper_app_flutter/state/cubit/premium_ringtone/premium_ringtone_zedge_cubit.dart';
import 'package:wallpaper_app_flutter/state/cubit/premium_ringtone_search_bloc/premium_ringtone_search_bloc.dart';
import 'package:wallpaper_app_flutter/state/cubit/ringtone_cubit/ringtone_cubit_cubit.dart';
import 'package:wallpaper_app_flutter/state/provider/authentication_provider.dart';

import 'splash/glory_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // todo One Signal Test Devicem >>> Menim Id im >>> : ef67a904-61ba-11ec-9877-9a09d9d25ebf <<<

  RingtoneRepository ringtoneRepository = RingtoneRepository();
  PremiumRingtoneRepository premiumRingtoneRepository =
      PremiumRingtoneRepository();

  // Initialize without device test ids.
  // Admob.initialize(testDeviceIds: [DEVICE_ID]);
  // Or add a list of test ids.
  // Admob.initialize(testDeviceIds: ['YOUR DEVICE ID']);

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ),
  );
  List<SingleChildWidget> providers = [
    ChangeNotifierProvider<AuthenticationProvider>(
      create: (_) => AuthenticationProvider(),
    ),
    ChangeNotifierProvider<FileDownloaderProvider>(
      create: (_) => FileDownloaderProvider(),
    ),
  ];
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => RingtoneCubitCubit(
            ringtoneRepository,
          ),
        ),
        BlocProvider(
          create: (context) => PremiumRingtoneSearchBloc(
            premiumRingtoneRepository,
          ),
        ),
        BlocProvider(
          create: (context) => PremiumRingtoneZedgeCubit(
            premiumRingtoneRepository,
          ),
        ),
      ],
      child: MultiProvider(
        providers: providers,
        child: GloryWall(),
      ),
    ),
  );
}
