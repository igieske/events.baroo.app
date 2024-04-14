import 'package:baroo/models/post_type.dart';
import 'package:flutter/material.dart';

import 'package:baroo/pages/search/search_case_form.dart';


class SearchPage extends StatefulWidget {
  const SearchPage({super.key, required this.args});

  final Map<String, dynamic> args;

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
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
        searchForm = SearchCaseForm(submitFilters: submitFilters);
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

      body: Container(
        padding: const EdgeInsets.all(20),
        child: searchForm,
      ),

    );

  }
}
