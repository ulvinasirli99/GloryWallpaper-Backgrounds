import 'package:colorlizer/colorlizer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper_app_flutter/manager/download_manager.dart';
import 'package:wallpaper_app_flutter/utils/notification/notification_service.dart';
import 'package:wallpaper_app_flutter/widget/global/toasts.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class CustomRingtoneGridview extends StatelessWidget {
  final Widget? child;
  final String? url;
  final String? backImgUrl;
  CustomRingtoneGridview({
    Key? key,
    this.child,
    this.url,
    this.backImgUrl,
  }) : super(key: key);
  ColorLizer colorlizer = ColorLizer();
  @override
  Widget build(BuildContext context) {
    intalizedNotification();
    var fileDownloaderProvider =
        Provider.of<FileDownloaderProvider>(context, listen: false);
    return Container(
      width: 120,
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            colorlizer.getRandomColors()!.withOpacity(0.2),
            colorlizer.getRandomColors()!.withOpacity(0.4),
          ],
        ),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(8),
              bottomRight: Radius.circular(8),
            ),
            child: Image.asset(
              'assets/vector_image.png',
              fit: BoxFit.cover,
            ),
          ),
          backImgUrl == null
              ? SizedBox()
              : Align(
                  alignment: Alignment.center,
                  child: Image.network(backImgUrl!),
                ),
          // Align(
          //   alignment: Alignment.topRight,
          //   child: Padding(
          //     padding: const EdgeInsets.only(top: 5),
          //     child: IconButton(
          //       onPressed: () async {
          //         var newFilePath =
          //             url.substring((url.length - 10).clamp(0, url.length));
          //         String path =
          //             "/storage/emulated/0/Download/GRingtone $newFilePath";
          //         bool directoryExists = await Directory(path).exists();
          //         bool fileExists = await File(path).exists();
          //         print('Senin Pathin : ' + path);
          //         if (directoryExists || fileExists) {
          //           // Todoo Bura isleyir ve yoxlayir var ya yoxdur....
          //         } else {
          //           // Todo Eks halda yoxdursa o zaman yuklesin ve yeniden recreate edib set elesin....
          //         }
          //       },
          //       icon: Icon(
          //         Icons.phonelink_ring_outlined,
          //         size: 25,
          //         color: Colors.white,
          //       ),
          //     ),
          //   ),
          // ),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(top: 5),
              child: IconButton(
                onPressed: () {
                  var newFilePath =
                      url!.substring((url!.length - 10).clamp(0, url!.length));
                  fileDownloaderProvider
                      .downloadFile(url!, "GRingtone $newFilePath")
                      .then((onValue) {
                    print(onValue.toString());
                    showNotification("Download success");
                  });
                  print('Menim Pathim : ' +
                      fileDownloaderProvider.downloadedFile);
                },
                icon: Icon(
                  Icons.downloading_rounded,
                  size: 30,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: child,
          ),
        ],
      ),
    );
  }

  intalizedNotification() {
    var initializationSettingsAndroid =
        AndroidInitializationSettings('mipmap/ic_launcher');
    var initializationSettingsIOs = IOSInitializationSettings();
    var initSetttings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOs);
    flutterLocalNotificationsPlugin.initialize(initSetttings,
        onSelectNotification: onSelectNotification);
  }

  showNotification(String imageName) async {
    var android = new AndroidNotificationDetails('id', 'channel ',
        channelDescription: 'description',
        priority: Priority.high,
        importance: Importance.max,
        playSound: true,
        sound: RawResourceAndroidNotificationSound('notif'));
    var iOS = new IOSNotificationDetails();
    var platform = new NotificationDetails(android: android, iOS: iOS);
    await flutterLocalNotificationsPlugin.show(
        0, imageName, 'Download Ringtone Successfully', platform,
        payload: 'Dowloaded');
  }

  Future? onSelectNotification(String? payload) {
    return notificationMessage(payload!);
  }
}
