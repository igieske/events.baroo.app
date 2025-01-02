import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:events_baroo_app/models/case.dart';


class CaseCard extends StatelessWidget {
  final Case cs;

  const CaseCard({super.key, required this.cs});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [

              Text(
                cs.title,
                style: Theme.of(context).textTheme.titleMedium,
              ),

              Text(
                DateFormat('d MMMM').format(cs.date) +
                (cs.timeStart != null ? ', ${cs.timeStart!}' : '')
              ),

              if (cs.shortDescription != null) Text(
                cs.shortDescription!
              ),

            ],
          ),
        ),
      ),
    );
  }
}
