import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper_app_flutter/service/provider/authentication_provider.dart';
import 'splash/glory_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // todo One SIgnal Test Devicem >>> Menim Id im >>> : ef67a904-61ba-11ec-9877-9a09d9d25ebf <<<

  // Initialize without device test ids.
  // Admob.initialize(testDeviceIds: [DEVICE_ID]);
  // Or add a list of test ids.
  // Admob.initialize(testDeviceIds: ['YOUR DEVICE ID']);

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ),
  );
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  runApp(
    ChangeNotifierProvider<AuthenticationProvider>(
      create: (_) => AuthenticationProvider(),
      child: GloryWall(),
    ),
  );
}
