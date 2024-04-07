import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class SearchPage extends StatefulWidget {
  const SearchPage({super.key, this.postType});

  final String? postType;

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    String title = '';

    switch (widget.postType) {
      case 'case':
        title = 'Поиск событий';
        break;
      case 'bar':
        title = 'Поиск мест';
        break;
      case 'band':
        title = 'Поиск бэндов';
        break;
      case 'fella':
        title = 'Поиск людей';
        break;
      case null:
      default:
        return const Center(child: Text('postType is not defined'));
    }

    return Scaffold(

      appBar: AppBar(
        title: Text(title),
      ),

      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(title),
          ],
        ),
      ),

    );

  }
}
