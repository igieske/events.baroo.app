class Case {
  Case({
    required this.id,
    required this.title,
    required this.date,
    required this.caseTypes,
    this.playlistsVk,
    this.poster,
    this.timeStart,
    this.timeEntry,
    this.tags,
    this.genres,
    this.entryFee,
    this.entryFeePrice,
    this.entryFeeFrom,
    this.entryFeeDecrease,
    this.entryFeeIncrease,
    this.shortDescription,

    this.placeDetails,
    this.posterAverageColor,
  });

  final int id;
  final String title;
  final String date;
  final List<String> caseTypes;
  final bool? playlistsVk;
  final String? poster;
  final String? timeStart;
  final String? timeEntry;
  final List<String>? tags;
  final List<String>? genres;
  final String? entryFee;
  final int? entryFeePrice;
  final bool? entryFeeFrom;
  final String? entryFeeDecrease;
  final String? entryFeeIncrease;
  final String? shortDescription;
  final String? placeDetails;
  final String? posterAverageColor;

  // конвертим json в объект Case
  factory Case.fromJson(Map<String, dynamic> json) {
    final id = json['id'] as int;
    final title = json['title'] as String;
    final date = json['date'] as String;
    final caseTypesData = json['caseTypes'] as List<dynamic>?;
    final caseTypes = caseTypesData != null ? caseTypesData.map((type) => type.toString()).toList() : <String>[];
    final playlistsVk = json['playlistsVk'] as bool? ?? false;
    final poster = json['poster'] as String?;
    final timeStart = json['timeStart'] as String?;
    final timeEntry = json['timeEntry'] as String?;
    final tagsData = json['tags'] as List<dynamic>?;
    final tags = tagsData != null ? tagsData.map((tag) => tag.toString()).toList() : <String>[];
    final genresData = json['genres'] as List<dynamic>?;
    final genres = genresData != null ? genresData.map((genre) => genre.toString()).toList() : <String>[];
    final entryFee = json['entryFee'] as String?;
    final entryFeePrice = json['entryFeePrice'] != null ? int.parse(json['entryFeePrice']) : null;
    final entryFeeFrom = json['entryFeeFrom'] != null ? json['entryFeeFrom'] == 'true' : null;
    final entryFeeDecrease = json['entryFeeDecrease'] as String?;
    final entryFeeIncrease = json['entryFeeIncrease'] as String?;
    final shortDescription = json['shortDescription'] as String?;
    final placeDetails = json['placeDetails'] as String?;
    final posterAverageColor = json['posterAverageColor'] as String?;
    return Case(
      id: id,
      title: title,
      date: date,
      caseTypes: caseTypes,
      playlistsVk: playlistsVk,
      poster: poster,
      timeStart: timeStart,
      timeEntry: timeEntry,
      tags: tags,
      genres: genres,
      entryFee: entryFee,
      entryFeePrice: entryFeePrice,
      entryFeeFrom: entryFeeFrom,
      entryFeeDecrease: entryFeeDecrease,
      entryFeeIncrease: entryFeeIncrease,
      shortDescription: shortDescription,
      placeDetails: placeDetails,
      posterAverageColor: posterAverageColor,
    );
  }

}