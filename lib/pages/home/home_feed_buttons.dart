import 'package:flutter/material.dart';


class HomeFeedButtons extends StatelessWidget {
  final VoidCallback onOpenPastCases;

  const HomeFeedButtons({super.key, required this.onOpenPastCases});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        Row(
          spacing: 6,
          children: [

            Expanded(
              child: FilledButton.icon(
                onPressed: onOpenPastCases,
                icon: Icon(Icons.chevron_left),
                label: Text('Прошли'),
              ),
            ),

            Expanded(
              child: FilledButton.tonal(
                onPressed: null,
                child: Text('Всего: 5')
              ),
            ),

            Expanded(
              child: FilledButton.icon(
                onPressed: () {},
                icon: Icon(Icons.chevron_right),
                iconAlignment: IconAlignment.end,
                label: Text('Скрыто', maxLines: 1),
              ),
            ),

          ],
        ),

      ],
    );
  }
}
