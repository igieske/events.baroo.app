import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:events_baroo_app/services/feed_cubit/feed_cubit.dart';
import 'package:events_baroo_app/pages/home/home_feed_buttons.dart';
import 'package:events_baroo_app/layout/case_card.dart';
import 'package:events_baroo_app/models/case.dart';


class HomeFeed extends StatelessWidget {
  final int pastCasesCount;
  final VoidCallback onOpenPastCases;

  const HomeFeed({
    super.key,
    required this.pastCasesCount,
    required this.onOpenPastCases,
  });

  @override
  Widget build(BuildContext context) {
    return BlocSelector<FeedCubit, FeedState, List<Case>>(
      selector: (state) => state.cases,
      builder: (context, cases) {
        return SingleChildScrollView(
          child: Column(
            children: [

              HomeFeedButtons(
                casesCount: cases.length,
                pastCasesCount: pastCasesCount,
                onOpenPastCases: onOpenPastCases,
              ),

              const SizedBox(height: 10),

              Column(
                spacing: 25,
                children: cases.map((cs) => CaseCard(cs: cs)).toList(),
              ),

            ],
          ),
        );
      },
    );
  }
}
