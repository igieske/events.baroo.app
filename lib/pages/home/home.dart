import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:events_baroo_app/layout/page_rounded_wrapper.dart';
import 'package:events_baroo_app/pages/home/home_feed.dart';
import 'package:events_baroo_app/pages/home/home_past.dart';
import 'package:events_baroo_app/models/post_type.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late PageController _pageViewController;

  @override
  void initState() {
    super.initState();
    _pageViewController = PageController(initialPage: 1);
  }

  @override
  void dispose() {
    super.dispose();
    _pageViewController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageRoundedWrapper(

      // child: Column(
      //   children: [
      //     FilledButton(
      //       onPressed: () => context.pushNamed(
      //           'search',
      //           extra: { 'postType': PostTypes.cs }
      //       ),
      //       child: const Text('Поиск событий'),
      //     ),
      //     FilledButton(
      //       onPressed: () => context.pushNamed(
      //           'search',
      //           extra: { 'postType': PostTypes.bar }
      //       ),
      //       child: const Text('Поиск мест'),
      //     ),
      //   ],
      // ),

      child: PageView(
        controller: _pageViewController,
        physics: NeverScrollableScrollPhysics(),
        children: [

          HomePast(
            goBackToFeed: () {
              _pageViewController.animateToPage(
                1,
                duration: Duration(milliseconds: 200),
                curve: Curves.easeInOut,
              );
            },
          ),

          HomeFeed(
            onOpenPastCases: () {
              _pageViewController.animateToPage(
                0,
                duration: Duration(milliseconds: 200),
                curve: Curves.easeInOut,
              );
            },
          ),

        ],
      ),

    );
  }
}
