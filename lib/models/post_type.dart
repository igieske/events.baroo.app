enum PostTypes {
  cs,
  bar,
  fella,
  band,
}

class PostType {
  final PostTypes type;
  final String slug;
  final String label;

  PostType({
    required this.type,
    required this.slug,
    required this.label,
  });
}
