import 'package:baroo/models/post_type.dart';
import 'package:flutter/material.dart';

import 'package:baroo/services/local_storage/local_storage.dart';
import 'package:baroo/pages/search/search_case_form.dart';


class SearchPage extends StatefulWidget {
  const SearchPage({super.key, required this.args, required this.localStorage});

  final Map<String, dynamic> args;
  final LocalStorage localStorage;

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
          localStorage: widget.localStorage,
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
      final searchCaseTypeDefault =
        searchFormKey.currentState!.formCaseTypes.map((e) => e.id).toList();
      widget.localStorage.write({
        'searchCaseTypeDefault': searchCaseTypeDefault,
      });
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
              child: searchForm
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
