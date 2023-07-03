import '../models/video_model.dart';
import '../services/storage/hive_storage_imp.dart';

class VideosToDownloadRepository {
  static const List<String> _links = [
    'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
    'https://storage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
    'https://storage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4',
    'https://storage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4',
  ];

  final videos = List.generate(
    _links.length,
    (index) => VideoModel(
      id: index.toString(),
      title: Uri.parse(_links[index].toString()).pathSegments.last,
      url: _links[index],
    ),
  );

  Future<void> saveVideo(VideoModel model) async {
    final value = model.toJson();
    final key = model.id;
    final hive = await HiveStorageService.getInstance(boxName: 'videos');
    await hive.write(key, value);
  }
}
