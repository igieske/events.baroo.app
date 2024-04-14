enum CaseTypes {
  liveMusic,
  poetry,
  standup,
  theatre,
}

class CaseType {
  final int id;
  final CaseTypes type;
  final String slug;
  final String label;

  CaseType({
    required this.id,
    required this.type,
    required this.slug,
    required this.label,
  });
}