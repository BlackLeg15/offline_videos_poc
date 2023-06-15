import 'package:flutter/material.dart';
import 'package:offline_videos_poc/app/features/home/pages/watch_offline_video_page.dart';
import 'package:offline_videos_poc/app/features/home/repositories/downloaded_videos_repository.dart';

class OfflineVideosPage extends StatefulWidget {
  const OfflineVideosPage({super.key});

  @override
  State<OfflineVideosPage> createState() => _OfflineVideosPageState();
}

class _OfflineVideosPageState extends State<OfflineVideosPage> {
  final repository = DownloadedVideosRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Downloads'),
      ),
      body: FutureBuilder(
        future: repository.getOfflineVideos(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }
          final data = snapshot.data;
          if (data == null || data.isEmpty) {
            return const Center(child: Text('Vazio'));
          }
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => WatchOfflineVideoPage(path: data[index].path),
                  ),
                ),
                child: SizedBox(
                  height: 200,
                  child: ListTile(
                    leading: Text('ID: ${data[index].id}'),
                    title: Text('Title: ${data[index].title}'),
                    subtitle: Text('Path: ${data[index].path}'),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
