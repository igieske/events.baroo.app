// константы

import 'package:baroo/models/post_type.dart';
import 'package:baroo/models/case_type.dart';
import 'package:baroo/models/case_genre.dart';


final List<PostType> postTypes = [
  PostType(
    type: PostTypes.cs,
    slug: 'case',
    label: 'Событие',
  ),
  PostType(
    type: PostTypes.bar,
    slug: 'bar',
    label: 'Место',
  ),
  PostType(
    type: PostTypes.band,
    slug: 'band',
    label: 'Бэнд',
  ),
  PostType(
    type: PostTypes.fella,
    slug: 'fella',
    label: 'Фэлла',
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
