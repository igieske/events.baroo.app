import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:baroo/services/functions.dart';


class DrawerMenu extends StatelessWidget {
  const DrawerMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 30),
            Expanded(
              child: Column(
                children: [
                  FilledButton(
                      onPressed: () => context.push('/login'),
                      child: const Text('login'),
                  )
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Divider(),
                GestureDetector(
                  child: const ListTile(
                    title: Text(
                      'Сайт Baroo.ru',
                      style: TextStyle(
                        color: Colors.grey,
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.normal,
                      )
                    ),
                  ),
                  onTap: () => goUrl('https://baroo.ru/'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
