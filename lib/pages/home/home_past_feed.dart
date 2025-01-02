import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:events_baroo_app/services/feed_cubit/feed_cubit.dart';
import 'package:events_baroo_app/layout/case_card.dart';
import 'package:events_baroo_app/models/case.dart';


class HomePastFeed extends StatelessWidget {
  final VoidCallback goBackToFeed;

  const HomePastFeed({super.key, required this.goBackToFeed});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<FeedCubit, FeedState, List<Case>>(
      selector: (state) => state.pastCases,
      builder: (context, pastCases) {
        return SingleChildScrollView(
          padding: EdgeInsets.all(13),
          child: Column(
            children: [

              FilledButton.icon(
                onPressed: goBackToFeed,
                icon: Icon(Icons.chevron_right),
                iconAlignment: IconAlignment.end,
                label: Text('Назад'),
              ),

              const SizedBox(height: 10),

              Column(
                spacing: 10,
                children: pastCases.map((cs) => CaseCard(cs: cs)).toList(),
              ),

            ],
          ),
        );
      },
    );
  }
}
