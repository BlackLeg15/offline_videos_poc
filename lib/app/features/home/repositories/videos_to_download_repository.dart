import 'package:offline_videos_poc/app/features/home/services/storage/hive_storage_imp.dart';

import '../models/video_model.dart';

class VideosToDownloadRepository {
  final videos = [
    'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
    'https://storage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
    'https://storage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4',
    'https://storage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4',
    "https://vod.dev.fanherocdn.com/61ba2606c1805142c289377f/61ba2e33d066385027bccd20/63dd499d47935de359e5a4f3/cmaf/63dd499d47935de359e5a4f3_1675446685057.m3u8",
    // TODO(adbysantos): Fazer download e parse
    'http://playertest.longtailvideo.com/adaptive/wowzaid3/playlist.m3u8',
    'https://demo.unified-streaming.com/k8s/features/stable/video/tears-of-steel/tears-of-steel.mp4/.m3u8',
    'http://1253131631.vod2.myqcloud.com/26f327f9vodgzp1253131631/f4bdff799031868222924043041/playlist.m3u8',
    'http://1252463788.vod2.myqcloud.com/95576ef5vodtransgzp1252463788/68e3febf4564972819220421305/v.f220.m3u8',
    'https://vod.dev.fanherocdn.com/61ba2606c1805142c289377f/61ba2e33d066385027bccd20/63dd499d47935de359e5a4f3/cmaf/63dd499d47935de359e5a4f3_1675446685057_Cmaf_720p.m3u8'
  ];

  Future<void> saveVideo(VideoModel model) async {
    final value = model.toJson();
    final key = model.id;
    final hive = await HiveStorageService.getInstance(boxName: 'videos');
    await hive.write(key, value);
  }
}
