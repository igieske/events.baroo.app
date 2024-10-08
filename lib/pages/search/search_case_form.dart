import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:baroo/services/local_storage/local_storage_bloc.dart' as local_storage_bloc;
import 'package:baroo/models/case_type.dart';
import 'package:baroo/models/case_genre.dart';
import 'package:baroo/services/constants.dart';


class SearchCaseForm extends StatefulWidget {
  final Function(Map<String, dynamic> args) submitFilters;

  const SearchCaseForm({super.key, required this.submitFilters});

  @override
  State<SearchCaseForm> createState() => SearchCaseFormState();
}

class SearchCaseFormState extends State<SearchCaseForm> {

  final _selectedButtonStyle = TextButton.styleFrom(
    backgroundColor: Colors.accents.first,
    foregroundColor: Colors.white
  );

  final DateTime today = DateTime.now().copyWith(
      hour: 0,
      minute: 0,
      second: 0,
      millisecond: 0,
      microsecond: 0
  );
  late final DateTime tomorrow;

  DateTime? dateStart;
  DateTime? dateEnd;

  late List<CaseType> formCaseTypes;
  late List<CaseGenre> formCaseGenres;

  Map<String, dynamic> encodeSearchForm() {
    Map<String, dynamic> args = {};
    // даты в формате: 20240131 / 20240130_20240131
    if (dateStart != null && dateEnd != null) {
      final String dateStartFormat = DateFormat('yyyyMMdd').format(dateStart!);
      final String dateEndFormat = DateFormat('yyyyMMdd').format(dateEnd!);
      args['dates'] = dateStartFormat +
          (dateStartFormat != dateEndFormat ? '_$dateEndFormat' : '');
    }
    // типы кейсов
    if (caseTypes.length != formCaseTypes.length) {
      args['case_types'] = formCaseTypes.map((item) => item.slug);
    }
    // todo: жанры
    return args;
  }

  @override
  void initState() {
    dateStart = today;
    dateEnd = today;
    tomorrow = today.add(const Duration(days: 1));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    // final localStorageBloc = LocalStorageBloc();
    final localStorageBloc = BlocProvider.of<local_storage_bloc.LocalStorageBloc>(context);

    print(localStorageBloc.state.data);

    return BlocBuilder<local_storage_bloc.LocalStorageBloc, local_storage_bloc.LocalStorageState>(
      bloc: localStorageBloc,
      builder: (context, state) {

        // final localStorageBloc = LocalStorageBloc();
        // print(localStorageBloc);

        print('----');
        print(state.data);

        formCaseTypes = List.from(caseTypes);
        formCaseGenres = List.from(caseGenres);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text([
                    'Дата',
                    [
                      if (dateStart != null)
                        DateFormat('dd.MM.yyyy').format(dateStart!),
                      if (dateEnd != null && dateEnd != dateStart)
                        DateFormat('dd.MM.yyyy').format(dateEnd!),
                    ].join(' – '),
                  ].join(': ')),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 6,
                    children: [
                      FilledButton.tonal(
                        onPressed: () => setState(() {
                          dateStart = today;
                          dateEnd = today;
                        }),
                        style: dateStart == today && dateEnd == today
                            ? _selectedButtonStyle : null,
                        child: const Text('Сегодня'),
                      ),
                      FilledButton.tonal(
                        onPressed: () => setState(() {
                          dateStart = tomorrow;
                          dateEnd = tomorrow;
                        }),
                        style: dateStart == tomorrow && dateEnd == tomorrow
                            ? _selectedButtonStyle : null,
                        child: const Text('Завтра'),
                      ),
                      FilledButton.tonal(
                        style: dateStart != dateEnd || (dateStart != null && dateStart != today && dateStart != tomorrow)
                            ? _selectedButtonStyle : null,
                        onPressed: () async {
                          DateTimeRange? datePickerResult = await showDateRangePicker(
                            context: context,
                            locale: const Locale('ru'),
                            initialDateRange: (dateStart != null && dateEnd != null)
                                ? DateTimeRange(start: dateStart!, end:  dateEnd!) : null,
                            firstDate: today,
                            lastDate: today.add(const Duration(days: 90)),
                            currentDate: today,
                            initialEntryMode: DatePickerEntryMode.calendarOnly,
                            saveText: 'Выбрать',
                          );
                          if (datePickerResult != null) {
                            setState(() {
                              dateStart = datePickerResult.start;
                              dateEnd = datePickerResult.end;
                            });
                          }
                        },
                        child: const Text('Выбрать...'),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  const Text('Тип события'),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 6,
                    children: caseTypes.map((CaseType caseType) {
                      final bool isOn = formCaseTypes.contains(caseType);
                      return FilledButton.tonal(
                        onPressed: () => setState(() {
                          if (isOn) {
                            formCaseTypes.removeWhere((item) => item == caseType);
                          } else {
                            formCaseTypes.add(caseType);
                          }
                        }),
                        style: isOn ? _selectedButtonStyle : null,
                        child: Text(caseType.label),
                      );
                    }).toList(),
                  ),

                  const SizedBox(height: 20),

                  const Text('Жанры'),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 6,
                    children: caseGenres.map((CaseGenre caseGenre) {
                      final bool isOn = formCaseGenres.contains(caseGenre);
                      return FilledButton.tonal(
                        onPressed: () => setState(() {
                          if (isOn) {
                            formCaseGenres.removeWhere((item) => item == caseGenre);
                          } else {
                            formCaseGenres.add(caseGenre);
                          }
                        }),
                        style: isOn ? _selectedButtonStyle : null,
                        child: Text(caseGenre.label),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ],
        );
      }
    );
  }
}
