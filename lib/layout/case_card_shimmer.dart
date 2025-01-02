import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';


class CaseCardShimmer extends StatelessWidget {
  const CaseCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 12,
          children: [

            Shimmer.fromColors(
              baseColor: const Color(0xFFC6CFD8),
              highlightColor: const Color(0xFFA2B1C1),
              child: Container(
                height: 24,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey,
                ),
              ),
            ),

            Shimmer.fromColors(
              baseColor: const Color(0xFFC6CFD8),
              highlightColor: const Color(0xFFA2B1C1),
              child: Container(
                height: 16,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey,
                ),
              ),
            ),

            Shimmer.fromColors(
              baseColor: const Color(0xFFC6CFD8),
              highlightColor: const Color(0xFFA2B1C1),
              child: Container(
                height: 16,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey,
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
