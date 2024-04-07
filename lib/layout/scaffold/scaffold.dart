import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:baroo/layout/scaffold/scaffold_bloc.dart' as scaffold_bloc;
import 'package:baroo/layout/drawer_menu.dart';

import 'package:baroo/pages/cases.dart';
import 'package:baroo/pages/bars.dart';


final List<Tab> _tabs = [
  Tab(
    'События',
    'cases',
    const CasesPage(),
    const Icon(Icons.table_rows_outlined),
  ),
  Tab(
    'Места',
    'bars',
    const BarsPage(),
    const Icon(Icons.local_bar),
  ),
];

class Tab {
  final String title;
  final String name;
  final Widget widget;
  final Widget icon;

  Tab(this.title, this.name, this.widget, this.icon);
}


class AppScaffold extends StatefulWidget {
  const AppScaffold({super.key});

  @override
  State<AppScaffold> createState() => _AppScaffoldState();
}

class _AppScaffoldState extends State<AppScaffold> {
  late int _selectedTabIndex;
  late Tab _selectedTab;

  @override
  void initState() {
    super.initState();
    _selectedTabIndex = 0;
    _selectedTab = _tabs.elementAt(_selectedTabIndex);
  }

  @override
  Widget build(BuildContext context) {

    final scaffoldBloc = BlocProvider.of<scaffold_bloc.ScaffoldBloc>(context);

    return BlocBuilder<scaffold_bloc.ScaffoldBloc, scaffold_bloc.ScaffoldState>(
      bloc: scaffoldBloc,
      builder: (context, state) {

        _selectedTabIndex = state.selectedTabIndex;
        _selectedTab = _tabs.elementAt(_selectedTabIndex);

        return Scaffold(

          appBar: AppBar(
            centerTitle: true,
            leading: const Center(child: Text('b')),
            title: Text(_selectedTab.title),
            elevation: _selectedTab.name != 'contacts' ? 4 : 0,
          ),

          body: PageView(
            controller: scaffoldBloc.state.pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: List.generate(
              _tabs.length,
              (index) => _tabs[index].widget,
            ),
          ),

          bottomNavigationBar: BottomNavigationBar(
            items: List.generate(
              _tabs.length, (index) =>
                BottomNavigationBarItem(
                  icon: _tabs[index].icon,
                  label: _tabs[index].title,
                ),
            ),
            currentIndex: _selectedTabIndex,
            selectedItemColor: Colors.red,
            showUnselectedLabels: true,
            onTap: (selectedPageIndex) {
              scaffoldBloc.add(scaffold_bloc.ScaffoldGoToTabEvent(selectedPageIndex));
            },
          ),

          endDrawer: const DrawerMenu(),

        );
      },
    );
  }

}