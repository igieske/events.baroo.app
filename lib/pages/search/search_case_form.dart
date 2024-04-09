import 'package:flutter/material.dart';

import 'package:intl/intl.dart';


class SearchCaseForm extends StatefulWidget {
  const SearchCaseForm({super.key});

  @override
  State<SearchCaseForm> createState() => _SearchCaseFormState();
}

class _SearchCaseFormState extends State<SearchCaseForm> {

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

  @override
  void initState() {
    dateStart = today;
    dateEnd = today;
    tomorrow = today.add(const Duration(days: 1));
    super.initState();
  }

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
            FilledButton.tonal(
              onPressed: () {
                setState(() {
                  dateStart = today;
                  dateEnd = today;
                });
              },
              style: dateStart == today && dateEnd == today
                  ? _selectedButtonStyle : null,
              child: const Text('Сегодня'),
            ),
            const SizedBox(width: 8),
            FilledButton.tonal(
              onPressed: () {
                setState(() {
                  dateStart = tomorrow;
                  dateEnd = tomorrow;
                });
              },
              style: dateStart == tomorrow && dateEnd == tomorrow
                  ? _selectedButtonStyle : null,
              child: const Text('Завтра'),
            ),
            const SizedBox(width: 8),
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
      ],
    );
  }
}
