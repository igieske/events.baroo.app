class Avatar {
  final String thumbnailUrl;
  final String url;
  final int width;
  final int height;

  Avatar({
    required this.thumbnailUrl,
    required this.url,
    required this.width,
    required this.height,
  });

  double get aspectRatio => width / height;

  factory Avatar.fromJson(Map<String, dynamic> json) {
    return Avatar(
      thumbnailUrl: json['thumbnailUrl'] as String,
      url: json['url'] as String,
      width: json['width'] as int,
      height: json['height'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'thumbnailUrl': thumbnailUrl,
      'url': url,
      'width': width,
      'height': height,
    };
  }
}
