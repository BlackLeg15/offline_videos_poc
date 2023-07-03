import 'dart:developer';

import 'package:background_downloader/background_downloader.dart';
import 'package:flutter/material.dart';
import 'package:offline_videos_poc/app/features/home/models/offline_video_model.dart';
import 'package:offline_videos_poc/app/features/home/pages/offline_videos_page.dart';
import 'package:offline_videos_poc/app/features/home/repositories/videos_to_download_repository.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final repository = VideosToDownloadRepository();
  var error = '';
  var isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vídeos para baixar'),
        actions: [
          ElevatedButton(
            child: const Text('Vídeos'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const OfflineVideosPage(),
                ),
              );
            },
          )
        ],
      ),
      body: ListView.separated(
          separatorBuilder: (context, index) => const Divider(),
          itemCount: repository.videos.length,
          itemBuilder: (context, index) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(repository.videos[index].title),
                ElevatedButton(
                  onPressed: isLoading
                      ? null
                      : () async {
                          setState(() {
                            isLoading = true;
                          });
                          OfflineVideoModel? offlineVideoModel;
                          try {
                            offlineVideoModel = await downloadVideoByIndex(index);
                          } catch (e) {
                            log(e.toString(), name: 'Download Task\'s exception');
                          }
                          if (offlineVideoModel == null) {
                            setState(() {
                              isLoading = false;
                            });
                            return;
                          }
                          try {
                            await repository.saveVideo(offlineVideoModel);
                          } catch (e) {
                            log(e.toString(), name: 'Save Task\'s exception');
                          }
                          setState(() {
                            isLoading = false;
                          });
                        },
                  child: const Text('Baixar vídeo'),
                ),
              ],
            );
          }),
    );
  }

  Future<OfflineVideoModel?> downloadVideoByIndex(int index) async {
    OfflineVideoModel? offlineVideoModel;
    try {
      final task = await DownloadTask(
        url: repository.videos[index].url,
      ).withSuggestedFilename(unique: true);

      final result = await FileDownloader().download(
        task,
        onProgress: (progress) {
          log(progress.toString(), name: 'Download Progress');
        },
      );

      final resultException = result.exception;
      if (resultException != null) {
        log(resultException.description, name: 'Download Task\'s Result Exception');
      } else {
        final filePath = await result.task.filePath();
        log(filePath, name: 'File Path');
        offlineVideoModel = OfflineVideoModel(
          path: filePath,
          id: repository.videos[index].id,
          title: repository.videos[index].title,
          url: repository.videos[index].url,
        );
      }
    } catch (e) {
      log(e.toString(), name: 'Download Task\'s Exception');
    }
    return offlineVideoModel;
  }
}
