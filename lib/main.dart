import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'package:baroo/layout/scaffold/scaffold_bloc.dart';
import 'package:baroo/services/dict/dict_cubit.dart';
import 'package:baroo/services/local_storage/local_storage_bloc.dart';

import 'router.dart';


void main() async {

  // final localStorage = await LocalStorage.read();
  final localStorageBloc = LocalStorageBloc();
  localStorageBloc.add(LocalStorageLoadEvent(localStorageBloc.state.data));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    final scaffoldBloc = ScaffoldBloc();
    final localStorageBloc = LocalStorageBloc();

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => scaffoldBloc),
        BlocProvider(create: (context) => localStorageBloc),
        BlocProvider(create: (context) => DictCubit()..loadDictionaries(['all'])),
      ],
      child: MaterialApp.router(
        title: 'Baroo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        routerConfig: appRouter,
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('ru', 'RU'),
          Locale('en', 'US'),
        ],
        builder: (context, child) => ResponsiveBreakpoints.builder(
          child: child!,
          breakpoints: [
            const Breakpoint(start: 0, end: 450, name: MOBILE),
            const Breakpoint(start: 451, end: 840, name: TABLET),
            const Breakpoint(start: 841, end: 1920, name: DESKTOP),
            const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
          ],
        ),
      ),
    );
  }
}
