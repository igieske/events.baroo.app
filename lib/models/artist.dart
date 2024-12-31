class Artist {
  final int id;
  final String name;
  final String? avatarUrl;

  Artist({
    required this.id,
    required this.name,
    this.avatarUrl,
  });
}

class Fella extends Artist {
  Fella({
    required super.id,
    required super.name,
    super.avatarUrl,
  });

  factory Fella.fromJson(Map<String, dynamic> json, [String? avatarUrl]) {
    return Fella(
      id: int.parse(json['id']),
      name: json['name'] as String,
      avatarUrl: avatarUrl,
    );
  }
}

class Band extends Artist {
  Band({
    required super.id,
    required super.name,
    super.avatarUrl,
  });

  factory Band.fromJson(Map<String, dynamic> json, [String? avatarUrl]) {
    return Band(
      id: int.parse(json['id']),
      name: json['name'] as String,
      avatarUrl: avatarUrl,
    );
  }
}