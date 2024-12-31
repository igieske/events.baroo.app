import 'package:events_baroo_app/pages/home/home_feed_buttons.dart';
import 'package:events_baroo_app/pages/home/home_feed_cases.dart';
import 'package:flutter/material.dart';


class HomeFeed extends StatelessWidget {
  final VoidCallback onOpenPastCases;

  const HomeFeed({super.key, required this.onOpenPastCases});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
      
          HomeFeedButtons(
            onOpenPastCases: onOpenPastCases,
          ),
          
          HomeFeedCases(),
      
        ],
      ),
    );
  }
}
