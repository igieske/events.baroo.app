import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:events_baroo_app/layout/app_scaffold.dart';

import 'package:events_baroo_app/pages/login/login.dart';
import 'package:events_baroo_app/pages/search/search.dart';

import 'package:events_baroo_app/pages/home/home.dart';
import 'package:events_baroo_app/pages/cases.dart';
import 'package:events_baroo_app/pages/bars.dart';
import 'package:events_baroo_app/pages/dashboard/add_case.dart';


final GlobalKey<NavigatorState> _rootNavigatorKey =
  GlobalKey<NavigatorState>(debugLabel: 'root');

final GlobalKey<NavigatorState> _homeNavigatorKey =
  GlobalKey<NavigatorState>(debugLabel: 'home');
final GlobalKey<NavigatorState> _casesNavigatorKey =
  GlobalKey<NavigatorState>(debugLabel: 'cases');
final GlobalKey<NavigatorState> _barsNavigatorKey =
  GlobalKey<NavigatorState>(debugLabel: 'bars');


final GoRouter appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/home',
  routes: [

    StatefulShellRoute.indexedStack(
      builder: (BuildContext context, GoRouterState state,
          StatefulNavigationShell navigationShell) {
        return AppScaffold(navigationShell: navigationShell);
      },
      branches: [

        // home
        StatefulShellBranch(
          navigatorKey: _homeNavigatorKey,
          routes: [
            GoRoute(
              path: '/home',
              name: 'home',
              builder: (context, state) => HomePage(),
            ),
          ],
        ),

        // cases
        StatefulShellBranch(
          navigatorKey: _casesNavigatorKey,
          routes: [
            GoRoute(
              path: '/cases',
              name: 'cases',
              builder: (context, state) => CasesPage(),
            ),
          ],
        ),

        // bars
        StatefulShellBranch(
          navigatorKey: _barsNavigatorKey,
          routes: [
            GoRoute(
              path: '/bars',
              name: 'bars',
              builder: (context, state) => BarsPage(),
            ),
          ],
        ),

      ],
    ),

    // login
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginPage(),
    ),

    // search
    GoRoute(
      path: '/search',
      name: 'search',
      builder: (context, state) => SearchPage(
        args: state.extra as Map<String, dynamic>,
      ),
    ),

    // login
    GoRoute(
      path: '/add_case',
      name: 'add_case',
      builder: (context, state) => const AddCasePage(),
    ),

  ],
);