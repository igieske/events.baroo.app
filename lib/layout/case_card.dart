import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:extended_image/extended_image.dart';

import 'package:events_baroo_app/models/case.dart';


class CaseCard extends StatelessWidget {
  final Case cs;

  const CaseCard({super.key, required this.cs});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [

          if (cs.poster != null)
            AspectRatio(
              aspectRatio: cs.poster!.aspectRatio,
              child: ExtendedImage.network(
                cs.poster!.url,
                fit: BoxFit.cover,
                width: double.infinity,
                cache: false,
                loadStateChanged: (ExtendedImageState state) {
                  switch (state.extendedImageLoadState) {
                    case LoadState.loading:
                      return Shimmer.fromColors(
                        baseColor: const Color(0xFFC6CFD8),
                        highlightColor: const Color(0xFFA2B1C1),
                        child: Container(color: Colors.grey),
                      );
                    case LoadState.completed:
                      return null;
                    case LoadState.failed:
                      return Center(
                        child: Icon(Icons.broken_image_outlined),
                      );
                  }
                  return null;
                },
              ),
            ),

          Container(
            color: Theme.of(context).colorScheme.secondary,
            child: Column(
              children: [

                Text(
                  cs.title,
                  style: Theme.of(context).textTheme.titleMedium,
                ),

                Text(
                  DateFormat(
                    cs.timeStart != null ? 'd MMMM, HH:mm' : 'd MMMM'
                  ).format(cs.date)
                ),

                if (cs.shortDescription != null) Text(
                    cs.shortDescription!
                ),

              ],
            ),
          ),

        ],
      ),
    );
  }
}
