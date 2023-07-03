import 'dart:convert';

class VideoModel {
  final String id;
  final String title;
  final String url;

  const VideoModel({
    required this.id,
    required this.title,
    required this.url,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'url': url,
    };
  }

  factory VideoModel.fromMap(Map<String, dynamic> map) {
    return VideoModel(
      id: map['id'] as String,
      title: map['title'] as String,
      url: map['url'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory VideoModel.fromJson(String source) => VideoModel.fromMap(json.decode(source) as Map<String, dynamic>);

  VideoModel copyWith({
    String? id,
    String? title,
    String? url,
  }) {
    return VideoModel(
      id: id ?? this.id,
      title: title ?? this.title,
      url: url ?? this.url,
    );
  }

  @override
  bool operator ==(covariant VideoModel other) {
    if (identical(this, other)) return true;

    return other.id == id && other.title == title && other.url == url;
  }

  @override
  int get hashCode {
    return id.hashCode ^ title.hashCode ^ url.hashCode;
  }
}
