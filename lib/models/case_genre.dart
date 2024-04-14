enum CaseGenres {
  classic,
  hipHop,
  pop,
  reggae,
  author,
  vocal,
  sacred,
  jazz,
  rock,
  electronic,
  folk,
  opera,
}

enum CaseSubGenres {
  hookahRap,
  indiePop,
  alternative,
  rockNRoll,
  punk,
  ska,
  postRock,
  popRock,
  indieRock,
  metal,
  country,
  blues,
  soul,
  funk,
  drumNBass,
  ambient,
  trance,
  techno,
  industrial,
  house,
  latino,
  irish,
}

class CaseGenre {
  final CaseGenres type;
  final String slug;
  final String label;
  final List<CaseSubGenres> subgenres;

  CaseGenre({
    required this.type,
    required this.slug,
    required this.label,
    required this.subgenres,
  });
}