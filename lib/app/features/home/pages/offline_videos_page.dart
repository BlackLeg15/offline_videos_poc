import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class OfflineVideosPage extends StatefulWidget {
  const OfflineVideosPage({super.key});

  @override
  State<OfflineVideosPage> createState() => _OfflineVideosPageState();
}

class _OfflineVideosPageState extends State<OfflineVideosPage> {
  final controller = VideoPlayerController.file(File('/data/user/0/com.example.offline_videos_poc/app_flutter/bee (2).mp4'));

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    controller.initialize().then((value) {
      setState(() {});
      controller.play();
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Title'),
      ),
      body: SizedBox(height: 200, child: VideoPlayer(controller)),
    );
  }
}
