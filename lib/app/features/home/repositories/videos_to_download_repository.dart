import 'package:offline_videos_poc/app/features/home/services/storage/hive_storage_imp.dart';

import '../models/video_model.dart';

class VideosToDownloadRepository {
  final videos = [
    'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
    'https://storage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
    'https://storage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4',
    'https://storage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4',
  ];

  Future<void> saveVideo(VideoModel model) async {
    final value = model.toJson();
    final key = model.id;
    final hive = await HiveStorageService.getInstance(boxName: 'videos');
    await hive.write(key, value);
  }
}
