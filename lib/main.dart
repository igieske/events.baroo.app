import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:baroo/layout/bric.dart';
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
      ),
    );
  }
}
