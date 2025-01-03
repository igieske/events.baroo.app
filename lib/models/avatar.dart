import 'dart:ui';

import 'package:flutter/painting.dart';

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

    // фиксим averageColor: делаем его не ярче уровня 0.5
    final Color averageColor = Color(int.parse(json['averageColor'].replaceFirst('#', '0xff')));
    final double maxLightness = 0.5;
    final averageHslColor = HSLColor.fromColor(averageColor);
    final adjustedLightness = averageHslColor.lightness > maxLightness
        ? maxLightness
        : averageHslColor.lightness;
    final Color adjustedAverageColor = averageHslColor.withLightness(adjustedLightness).toColor();

    return Avatar(
      thumbnailUrl: json['thumbnailUrl'] as String,
      url: json['url'] as String,
      width: json['width'] as int,
      height: json['height'] as int,
      averageColor: adjustedAverageColor,
    );
  }
}
