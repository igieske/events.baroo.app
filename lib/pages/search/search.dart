import 'package:flutter/material.dart';

import 'package:events_baroo_app/services/local_storage/local_storage_bloc.dart';
import 'package:events_baroo_app/models/post_type.dart';
import 'package:events_baroo_app/pages/search/search_case_form.dart';


class SearchPage extends StatefulWidget {
  const SearchPage({super.key, required this.args});

  final Map<String, dynamic> args;

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

  GlobalKey<SearchCaseFormState> searchFormKey =
    GlobalKey<SearchCaseFormState>();

  @override
  Widget build(BuildContext context) {
    String title = '';
    Widget? searchForm;
    bool isDefaultFiltersActive = false;

    submitFilters(Map<String, dynamic> args) {
      print(args);
    }

    switch (widget.args['postType']) {
      case PostTypes.cs:
        title = 'Поиск событий';
        searchForm = SearchCaseForm(
          key: searchFormKey,
          submitFilters: submitFilters,
        );
        break;
      case PostTypes.bar:
        title = 'Поиск мест';
        break;
      case PostTypes.band:
        title = 'Поиск бэндов';
        break;
      case PostTypes.fella:
        title = 'Поиск людей';
        break;
      case null:
      default:
        return const Center(child: Text('postType is not defined'));
    }

    saveDefaultFilters() async {
      final localStorageBloc = LocalStorageBloc();
      print(localStorageBloc.state.data);
      // return;
      final searchCaseState = searchFormKey.currentState;
      final caseTypes = searchCaseState!.formCaseTypes.map((e) => e.slug).toList();
      final caseGenres = searchCaseState.formCaseGenres.map((e) => e.slug).toList();
      final defaults = {
        'caseTypes': caseTypes,
        'caseGenres': caseGenres,
      };
      // final localStorageBloc = LocalStorageBloc();
      localStorageBloc.add(LocalStorageUpdateEvent(defaults));
    }

    return Scaffold(

      appBar: AppBar(
        title: Text(title),
        actions: [
          if (isDefaultFiltersActive) const IconButton(
              onPressed: null,
              icon: Icon(Icons.how_to_reg_outlined),
              disabledColor: Colors.black26,
          ),
          PopupMenuButton(
              itemBuilder: (BuildContext context) => [
                PopupMenuItem(
                  onTap: saveDefaultFilters,
                  child: const Text('Сохранить фильтры по умолчанию'),
                ),
              ],
            position: PopupMenuPosition.under,
          ),
        ],
      ),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (searchForm != null) Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: searchForm,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 12,
              horizontal: 20,
            ),
            child: FilledButton(
              onPressed: () {
                submitFilters(searchFormKey.currentState!.encodeSearchForm());
              },
              child: const Text('Показать'),
            ),
          )
        ],
      ),

    );

  }
}
