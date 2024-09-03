class CaseType {
  final int id;
  final String slug;
  final String name;

  CaseType({
    required this.id,
    required this.slug,
    required this.name,
  });

  factory CaseType.fromJson(Map<String, dynamic> json) {
    return CaseType(
      id: int.parse(json['id']),
      slug: json['slug'] as String,
      name: json['name'] as String,
    );
  }
}