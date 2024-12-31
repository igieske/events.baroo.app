import 'package:flutter/material.dart';


class HomePast extends StatelessWidget {
  final VoidCallback goBackToFeed;

  const HomePast({super.key, required this.goBackToFeed});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        Text('Past Feed'),

        FilledButton.icon(
          onPressed: goBackToFeed,
          icon: Icon(Icons.chevron_right),
          iconAlignment: IconAlignment.end,
          label: Text('Назад'),
        ),

      ],
    );
  }
}
