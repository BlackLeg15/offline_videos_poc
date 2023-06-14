import '../models/video_model.dart';

class VideosToDownloadRepository {
  //final hive = Hive.init(path)
  //Procurar meu projeto sobre Hive no GitHub
  final videos = ['https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'];

  Future<void> saveVideo(VideoModel model) async {
    //Com o filePath, salva o registro do vídeo com o Hive
    //Resgata posteriormente
    //gg
  }
}
