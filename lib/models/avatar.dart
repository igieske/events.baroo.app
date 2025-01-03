import 'dart:ui';

class Avatar {
  final String thumbnailUrl;
  final String url;
  final int width;
  final int height;
  final Color averageColor;

  Avatar({
    required this.thumbnailUrl,
    required this.url,
    required this.width,
    required this.height,
    required this.averageColor,
  });

  double get aspectRatio => width / height;

  factory Avatar.fromJson(Map<String, dynamic> json) {
    return Avatar(
      thumbnailUrl: json['thumbnailUrl'] as String,
      url: json['url'] as String,
      width: json['width'] as int,
      height: json['height'] as int,
      averageColor: Color(int.parse(json['averageColor'].replaceFirst('#', '0xff'))),
    );
  }
}
