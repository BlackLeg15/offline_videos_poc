import 'dart:convert';

import 'video_model.dart';

class OfflineVideoModel extends VideoModel {
  final String path;

  const OfflineVideoModel({required this.path, required super.id, required super.title, required super.url});

  @override
  Map<String, dynamic> toMap() {
    final superMap = super.toMap();
    final offlineMap = superMap..addAll({'path': path});
    return offlineMap;
  }

  factory OfflineVideoModel.fromMap(Map<String, dynamic> map) {
    return OfflineVideoModel(
      id: map['id'] as String,
      title: map['title'] as String,
      url: map['url'] as String,
      path: map['path'] as String,
    );
  }

  factory OfflineVideoModel.fromJson(String source) => OfflineVideoModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
