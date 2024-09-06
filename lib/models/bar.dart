class Bar {
  final int id;
  final String name;

  Bar({
    required this.id,
    required this.name,
  });

  factory Bar.fromJson(Map<String, dynamic> json) {
    return Bar(
      id: int.parse(json['id']),
      name: json['name'] as String,
    );
  }
}