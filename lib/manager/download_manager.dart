import 'dart:async';
import 'dart:typed_data';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

enum DownloadStatus { NotStarted, Started, Downloading, Completed }

class FileDownloaderProvider with ChangeNotifier {
  StreamSubscription? _downloadSubscription;
  DownloadStatus _downloadStatus = DownloadStatus.NotStarted;
  int _downloadPercentage = 0;
  String _downloadedFile = "";

  int get downloadPercentage => _downloadPercentage;
  DownloadStatus get downloadStatus => _downloadStatus;
  String get downloadedFile => _downloadedFile;

  Future downloadFile(String url, String filename) async {
    final Completer<void> completer = Completer<void>();

    if (await Permission.storage.request().isDenied) {
      // Either the permission was already granted before or the user just granted it.
      await Permission.storage.request().isGranted;
    } else {
      var httpClient = http.Client();
      var request = new http.Request('GET', Uri.parse(url));
      var response = httpClient.send(request);

      final dir = Platform.isAndroid
          ? '/storage/emulated/0/Download'
          : "${(await getApplicationDocumentsDirectory()).path}";

      List<List<int>> chunks = new List.empty(growable: true);
      int downloaded = 0;

      updateDownloadStatus(DownloadStatus.Started);

      _downloadSubscription =
          response.asStream().listen((http.StreamedResponse r) {
        updateDownloadStatus(DownloadStatus.Downloading);
        r.stream.listen((List<int> chunk) async {
          // Display percentage of completion
          print('downloadPercentage onListen : $_downloadPercentage');

          chunks.add(chunk);
          downloaded += chunk.length;
          _downloadPercentage = (downloaded / r.contentLength! * 100).round();
          notifyListeners();
        }, onDone: () async {
          // Display percentage of completion
          _downloadPercentage = (downloaded / r.contentLength! * 100).round();
          notifyListeners();
          print('downloadPercentage onDone: $_downloadPercentage');

          // Save the file
          File file = new File('$dir/$filename');

          _downloadedFile = '$dir/$filename';
          print(_downloadedFile);

          final Uint8List bytes = Uint8List(r.contentLength!);
          int offset = 0;
          for (List<int> chunk in chunks) {
            bytes.setRange(offset, offset + chunk.length, chunk);
            offset += chunk.length;
          }
          await file.writeAsBytes(bytes);

          updateDownloadStatus(DownloadStatus.Completed);
          _downloadSubscription?.cancel();
          _downloadPercentage = 0;

          notifyListeners();
          print('DownloadFile: Completed');
          completer.complete();

          return;
        });
      });
    }

    await completer.future;
  }

  void updateDownloadStatus(DownloadStatus status) {
    _downloadStatus = status;
    print('updateDownloadStatus: $status');
    notifyListeners();
  }
}
