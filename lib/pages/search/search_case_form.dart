import 'package:flutter/material.dart';

import 'package:intl/intl.dart';


class SearchCaseForm extends StatefulWidget {
  const SearchCaseForm({super.key});

  @override
  State<SearchCaseForm> createState() => _SearchCaseFormState();
}

class _SearchCaseFormState extends State<SearchCaseForm> {

  DateTime? dateStart;
  DateTime? dateEnd;

  @override
  Widget build(BuildContext context) {
    return Column(
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
        Row(
          children: [
            OutlinedButton(
              onPressed: () {},
              child: const Text('Сегодня'),
            ),
            const SizedBox(width: 8),
            OutlinedButton(
              onPressed: () {},
              child: const Text('Завтра'),
            ),
            const SizedBox(width: 8),
            OutlinedButton(
              onPressed: () async {
                DateTimeRange? datePickerResult = await showDateRangePicker(
                  context: context,
                  locale: const Locale('ru'),
                  initialDateRange: (dateStart != null && dateEnd != null)
                    ? DateTimeRange(start: dateStart!, end:  dateEnd!) : null,
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(const Duration(days: 90)),
                  currentDate: DateTime.now(),
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
              child: const Text('Выбрать'),
            ),
          ],
        )
      ],
    );
  }
}
