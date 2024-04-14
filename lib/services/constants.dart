// константы

import 'package:baroo/models/case_type.dart';
import 'package:baroo/models/case_genre.dart';


final List<CaseType> caseTypes = [
  CaseType(
      id: 5,
      type: CaseTypes.liveMusic,
      slug: 'live-music',
      label: 'Живая музыка'
  ),
  CaseType(
      id: 6,
      type: CaseTypes.poetry,
      slug: 'poetry',
      label: 'Поэзия'
  ),
  CaseType(
      id: 7,
      type: CaseTypes.standup,
      slug: 'standup',
      label: 'Стендап'
  ),
  CaseType(
      id: 13,
      type: CaseTypes.theatre,
      slug: 'theatre',
      label: 'Театр'
  ),
];

final List<CaseGenre> caseGenres = [
  CaseGenre(
      type: CaseGenres.jazz,
      slug: 'jazz',
      label: 'Джаз',
      subgenres: [
        CaseSubGenres.blues,
        CaseSubGenres.soul,
        CaseSubGenres.funk,
      ],
  ),
  CaseGenre(
    type: CaseGenres.rock,
    slug: 'rock',
    label: 'Рок',
    subgenres: [
      CaseSubGenres.alternative,
      CaseSubGenres.rockNRoll,
      CaseSubGenres.punk,
      CaseSubGenres.ska,
      CaseSubGenres.postRock,
      CaseSubGenres.popRock,
      CaseSubGenres.indieRock,
      CaseSubGenres.metal,
      CaseSubGenres.country,
    ],
  ),
];
