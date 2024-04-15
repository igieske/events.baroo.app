import 'package:baroo/services/local_storage/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:baroo/layout/scaffold/scaffold.dart';
import 'package:baroo/pages/login/login.dart';
import 'package:baroo/pages/search/search.dart';

import 'package:baroo/pages/home/home.dart';
import 'package:baroo/pages/cases.dart';
import 'package:baroo/pages/bars.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _shellNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'shell');

final GoRouter appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/cases',
  routes: <RouteBase>[

    // shell with bottom menu
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (BuildContext context, GoRouterState state, Widget child) {
        return const AppScaffold();
      },
      routes: [
        // home
        GoRoute(
          path: '/home',
          builder: (context, state) => const HomePage(),
        ),
        // cases
        GoRoute(
          path: '/cases',
          builder: (context, state) => const CasesPage(),
        ),
        // bars
        GoRoute(
          path: '/bars',
          builder: (context, state) => const BarsPage(),
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

  ],
);