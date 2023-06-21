import 'dart:developer';
import 'dart:io';

import 'package:background_downloader/background_downloader.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hls_parser/flutter_hls_parser.dart';
import 'package:flutter_tencentplayer/controller/download_controller.dart';
import 'package:m3u/m3u.dart';
import 'package:offline_videos_poc/app/features/home/pages/offline_videos_page.dart';
import 'package:offline_videos_poc/app/features/home/repositories/videos_to_download_repository.dart';

import '../models/offline_video_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final repository = VideosToDownloadRepository();
  var error = '';
  var isLoading = false;

  late DownloadController _downloadController;
  String currentDownloadUrl = '';

  @override
  void initState() {
    // getApplicationDocumentsDirectory().then((value) {
    //   _downloadController = DownloadController(value.path);
    //   _downloadController.addListener(() {
    //     if (!mounted) {
    //       return;
    //     }
    //     final value = _downloadController.value[currentDownloadUrl];
    //     final downloadStatus = value?.downloadStatus;
    //     if (downloadStatus == 'complete') {
    //       log('PLAY PATH ${value!.playPath!}');
    //       final offlineVideo = OfflineVideoModel(path: value.playPath!, id: DateTime.now().toString(), title: DateTime.now().toString(), url: '');
    //       repository.saveVideo(offlineVideo).whenComplete(() {
    //         setState(() {
    //           isLoading = false;
    //         });
    //       });
    //     }
    //     if (downloadStatus == 'error') {
    //       isLoading = false;
    //     }
    //     setState(() {});
    //   });
    // });
    super.initState();
  }

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
                          // currentDownloadUrl = repository.videos[index];
                          // setState(() {
                          //   isLoading = true;
                          // });
                          // _downloadController.dowload(repository.videos[index]);
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
                              final offlineVideo =
                                  OfflineVideoModel(path: filePath, id: DateTime.now().toString(), title: task.filename, url: '');
                              await repository.saveVideo(offlineVideo);
                              //if (filePath.endsWith('m3u8')) {
                              late HlsPlaylist playlist;
                              try {
                                playlist = await HlsPlaylistParser.create()
                                    .parseString(Uri.parse(repository.videos[index]), File(filePath).readAsStringSync());
                              } on ParserException catch (e) {
                                print(e);
                              }

                              if (playlist is HlsMasterPlaylist) {
                                // master m3u8 file
                              } else if (playlist is HlsMediaPlaylist) {
                                // media m3u8 file
                              }

                              final fileContent = await File(filePath).readAsString();
                              final listOfTracks = await parseFile(fileContent);
                              if (kDebugMode) {
                                print(listOfTracks);
                              }

                              // Organized categories
                              final categories = sortedCategories(entries: listOfTracks, attributeName: 'group-title');
                              if (kDebugMode) {
                                print(categories);
                              }
                            }
                            // }
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
