class Artist {
  final int id;
  final String name;

  Artist({
    required this.id,
    required this.name,
  });
}

class Fella extends Artist {
  Fella({
    required super.id,
    required super.name,
  });

  factory Fella.fromJson(Map<String, dynamic> json) {
    return Fella(
      id: int.parse(json['id']),
      name: json['name'] as String,
    );
  }
}

class Band extends Artist {
  Band({
    required super.id,
    required super.name,
  });

  factory Band.fromJson(Map<String, dynamic> json) {
    return Band(
      id: int.parse(json['id']),
      name: json['name'] as String,
    );
  }
}