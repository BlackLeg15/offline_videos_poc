import 'package:offline_videos_poc/app/features/home/models/offline_video_model.dart';

import '../services/storage/hive_storage_imp.dart';

class DownloadedVideosRepository {
  Future<List<OfflineVideoModel>> getOfflineVideos() async {
    final hive = await HiveStorageService.getInstance(boxName: 'videos');
    final box = await hive.boxCompleter.future;
    final values = box.values.toList().cast<String>();
    return List.generate(values.length, (index) => OfflineVideoModel.fromJson(values[index]));
  }
}
