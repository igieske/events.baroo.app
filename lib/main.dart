import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';

import 'package:events_baroo_app/services/dict/dict_cubit.dart';
import 'package:events_baroo_app/services/feed_cubit/feed_cubit.dart';
import 'package:events_baroo_app/services/local_storage/local_storage_bloc.dart';

import 'router.dart';
import 'themes/theme.dart';


void main() async {

  Intl.defaultLocale = 'ru';

  // final localStorage = await LocalStorage.read();
  final localStorageBloc = LocalStorageBloc();
  localStorageBloc.add(LocalStorageLoadEvent(localStorageBloc.state.data));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    final localStorageBloc = LocalStorageBloc();

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => localStorageBloc),
        BlocProvider(create: (_) => DictCubit()..loadDictionaries(['all'])),
        BlocProvider(create: (_) => FeedCubit()),
      ],
      child: MaterialApp.router(
        title: 'Baroo',
        debugShowCheckedModeBanner: false,
        theme: AppThemes.appThemeData[AppTheme.light],
        routerConfig: appRouter,
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        locale: Locale('ru', 'RU'),
        supportedLocales: const [
          Locale('ru', 'RU'),
          Locale('en', 'US'),
        ],
      ),
    );
  }
}
