// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:offline_videos_poc/app/features/home/models/video_model.dart';

class OfflineVideoModel extends VideoModel {
  final String path;

  const OfflineVideoModel({required this.path, required super.id, required super.title, required super.url});

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'url': url,
      'path': path,
    };
  }

  factory OfflineVideoModel.fromMap(Map<String, dynamic> map) {
    return OfflineVideoModel(
      id: map['id'] as String,
      title: map['title'] as String,
      url: map['url'] as String,
      path: map['path'] as String,
    );
  }

  @override
  String toJson() => json.encode(toMap());

  factory OfflineVideoModel.fromJson(String source) => OfflineVideoModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

enum VideoType { network, file }
