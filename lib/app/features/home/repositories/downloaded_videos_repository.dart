import 'dart:developer';

import 'package:background_downloader/background_downloader.dart';

class VideosToDownloadRepository {
  final videos = ['https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'];

  Future<void> downloadVideo(String url) async {
    final task = await DownloadTask(url: url).withSuggestedFilename(unique: true);
    final result = await FileDownloader().download(task);
    final filePath = await result.task.filePath();
    log(filePath, name: 'File path');
    //Com o filePath, salva o registro do vídeo com o Hive
    //Resgata posteriormente
    //gg
  }
}
