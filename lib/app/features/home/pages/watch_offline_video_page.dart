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
    //controller = VideoPlayerController.file(File(widget.path));
    //https://vod.dev.fanherocdn.com/61ba2606c1805142c289377f/61ba2e33d066385027bccd20/63dd499d47935de359e5a4f3/cmaf/63dd499d47935de359e5a4f3_1675446685057.m3u8
    controller = VideoPlayerController.network(
        'https://vod.dev.fanherocdn.com/61ba2606c1805142c289377f/61ba2e33d066385027bccd20/63dd499d47935de359e5a4f3/cmaf/63dd499d47935de359e5a4f3_1675446685057.m3u8');
    //controller = VideoPlayerController.asset('assets/playlist.m3u8');
    //controller = VideoPlayerController.asset('assets/bunny.mp4');
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
        title: const Text('Enjoy the video'),
      ),
      body: SizedBox(height: 200, child: VideoPlayer(controller)),
    );
  }
}
