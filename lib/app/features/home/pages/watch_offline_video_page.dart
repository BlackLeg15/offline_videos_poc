import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class WatchOfflineVideoPage extends StatefulWidget {
  final String path;
  const WatchOfflineVideoPage({super.key, required this.path});

  @override
  State<WatchOfflineVideoPage> createState() => _WatchOfflineVideoPageState();
}

class _WatchOfflineVideoPageState extends State<WatchOfflineVideoPage> {
  late final VideoPlayerController controller;

  @override
  void initState() {
    controller = VideoPlayerController.file(File(widget.path));
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
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Aproveite o vídeo'),
      ),
      body: SizedBox(height: 200, child: VideoPlayer(controller)),
    );
  }
}
