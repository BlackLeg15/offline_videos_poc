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
        title: const Text('Videos to download'),
        actions: [
          ElevatedButton(
            child: const Text('Videos'),
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
                ElevatedButton(
                  onPressed: isLoading
                      ? null
                      : () async {
                          setState(() {
                            isLoading = true;
                          });
                          try {
                            final task = await DownloadTask(
                              url: repository.videos[index],
                            ).withSuggestedFilename(unique: true);
                            final result = await FileDownloader().download(
                              task,
                              onProgress: (progress) {
                                log(progress.toString(), name: 'Download Progress');
                              },
                            );
                            final resultException = result.exception;
                            if (resultException != null) {
                              setState(() {
                                error = resultException.description;
                              });
                            } else {
                              final filePath = await result.task.filePath();
                              log(filePath, name: 'File Path');
                              final offlineVideo = OfflineVideoModel(path: filePath, id: DateTime.now().toString(), title: task.filename, url: '');
                              await repository.saveVideo(offlineVideo);
                            }
                          } catch (e) {
                            error = e.toString();
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
}
