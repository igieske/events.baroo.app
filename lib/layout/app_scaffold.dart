import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:events_baroo_app/layout/app_scaffold_drawer.dart';


// лист табов, маршруты согласно branches в роутинге
const List<NavigationDestination> navigationDestinations = [
  NavigationDestination(
    selectedIcon: Icon(Icons.home),
    icon: Icon(Icons.home_outlined),
    label: 'Главная',
    tooltip: '',
  ),
  NavigationDestination(
    selectedIcon: Icon(Icons.table_rows),
    icon: Icon(Icons.table_rows_outlined),
    label: 'События',
    tooltip: '',
  ),
  NavigationDestination(
    selectedIcon: Icon(Icons.local_bar),
    icon: Icon(Icons.local_bar_outlined),
    label: 'Места',
    tooltip: '',
  ),
];


class AppScaffold extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const AppScaffold({
    Key? key,
    required this.navigationShell,
  }) : super(key: key ?? const ValueKey<String>('ScaffoldWithNavBar'));

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text(navigationDestinations[navigationShell.currentIndex].label),
        elevation: navigationShell.currentIndex == 0 ? 0 : null,
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),

      body: navigationShell,

      bottomNavigationBar: NavigationBar(
        destinations: navigationDestinations,

        indicatorColor: Colors.amber,

        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: (int index) => navigationShell.goBranch(
          index,
          initialLocation: index == navigationShell.currentIndex,
        ),

      ),

      drawer: const AppScaffoldDrawer(),

    );
  }
}
