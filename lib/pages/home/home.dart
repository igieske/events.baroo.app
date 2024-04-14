import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:baroo/models/post_type.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          FilledButton(
            onPressed: () => context.pushNamed(
                'search',
                extra: { 'postType': PostTypes.cs }
            ),
            child: const Text('Поиск событий'),
          ),
          FilledButton(
            onPressed: () => context.pushNamed(
                'search',
                extra: { 'postType': PostTypes.bar }
            ),
            child: const Text('Поиск мест'),
          ),
        ],
      ),
    );
  }
}
