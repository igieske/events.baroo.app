import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:baroo/layout/scaffold/scaffold.dart';
import 'package:baroo/pages/login.dart';
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

  ],
);