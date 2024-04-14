// константы

import 'package:baroo/models/case_type.dart';

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
