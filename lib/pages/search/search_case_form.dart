import 'package:flutter/material.dart';

class SearchCaseForm extends StatefulWidget {
  const SearchCaseForm({super.key});

  @override
  State<SearchCaseForm> createState() => _SearchCaseFormState();
}

class _SearchCaseFormState extends State<SearchCaseForm> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Дата'),
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
              onPressed: () {},
              child: const Text('Даты...'),
            ),
          ],
        )
      ],
    );
  }
}
