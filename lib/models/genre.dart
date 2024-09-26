class Genre {
  final String slug;
  final String label;
  final List<Subgenre>? subgenres;

  Genre({
    required this.slug,
    required this.label,
    this.subgenres,
  });

  factory Genre.fromJson(Map<String, dynamic> json) {
    final subgenresData = json['subgenres'] as List<dynamic>?;
    final subgenres = subgenresData != null
        ? subgenresData.map((subgenre) => Subgenre.fromJson(subgenre)).toList()
        : <Subgenre>[];
    return Genre(
      slug: json['slug'] as String,
      label: json['label'] as String,
      subgenres: subgenres,
    );
  }
}

class Subgenre {
  final String slug;
  final String label;

  Subgenre({
    required this.slug,
    required this.label,
  });

  factory Subgenre.fromJson(Map<String, dynamic> json) {
    return Subgenre(
      slug: json['slug'] as String,
      label: json['label'] as String,
    );
  }
}