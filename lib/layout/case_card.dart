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

          // постер
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
                },
              ),
            ),

          Stack(
            alignment: Alignment.topCenter,
            children: [

              // градиент
              if (cs.poster != null) SizedBox(
                width: double.infinity,
                height: 100,
                child: ShaderMask(
                  shaderCallback: (bounds) => LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withValues(alpha: 1),
                      Colors.black.withValues(alpha: 0),
                    ],
                    stops: [0.35, 1],
                  ).createShader(bounds),
                  blendMode: BlendMode.dstIn,
                  child: Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()..rotateX(3.14159),
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(cs.poster!.url),
                          fit: BoxFit.cover,
                          alignment: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              // текст
              Container(
                decoration: BoxDecoration(
                  color: cs.poster != null && cs.poster?.averageColor != null
                    ? cs.poster!.averageColor
                    : Theme.of(context).colorScheme.secondary,
                  border: Border.all(
                    color: Colors.white12,
                    width: 3,
                  ),
                ),
                padding: EdgeInsets.all(15),
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: DefaultTextStyle(
                  style: TextStyle(color: Colors.white),
                  child: Column(
                    spacing: 6,
                    children: [

                      Text(
                        cs.title,
                        style: TextStyle(fontSize: 18),
                      ),

                      Text(
                        DateFormat(
                          cs.timeStart != null ? 'd MMMM, HH:mm' : 'd MMMM'
                        ).format(cs.date),
                        style: TextStyle(color: Colors.white54),
                      ),

                      if (cs.shortDescription != null) Text(
                          cs.shortDescription!
                      ),

                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
