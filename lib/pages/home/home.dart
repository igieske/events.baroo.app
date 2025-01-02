import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:events_baroo_app/services/feed_cubit/feed_cubit.dart';
import 'package:events_baroo_app/layout/page_rounded_wrapper.dart';
import 'package:events_baroo_app/layout/case_card_shimmer.dart';
import 'package:events_baroo_app/pages/home/home_feed.dart';
import 'package:events_baroo_app/pages/home/home_past_feed.dart';


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
    context.read<FeedCubit>().getCases();
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

      child: BlocBuilder<FeedCubit, FeedState>(
        builder: (context, state) {
          if (state.isLoading) {
            return Padding(
              padding: const EdgeInsets.all(13),
              child: Column(
                spacing: 10,
                children: [
                  CaseCardShimmer(),
                  CaseCardShimmer(),
                ],
              ),
            );
          }

          if (state.errorMessage != null) {
            return Center(child: Text('Ошибка: ${state.errorMessage}'));
          }

          if (state.cases.isEmpty && state.pastCases.isEmpty) {
            return Center(child: Text('Нет событий'));
          }

          return PageView(
            controller: _pageViewController,
            physics: NeverScrollableScrollPhysics(),
            children: [

              HomePastFeed(
                goBackToFeed: () {
                  _pageViewController.animateToPage(
                    1,
                    duration: Duration(milliseconds: 200),
                    curve: Curves.easeInOut,
                  );
                },
              ),

              HomeFeed(
                pastCasesCount: state.pastCases.length,
                onOpenPastCases: () {
                  _pageViewController.animateToPage(
                    0,
                    duration: Duration(milliseconds: 200),
                    curve: Curves.easeInOut,
                  );
                },
              ),

            ],
          );
        },
      ),
    );
  }
}
