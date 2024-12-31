import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:events_baroo_app/services/functions.dart';
import 'package:events_baroo_app/pages/login/login_http.dart';


class AppScaffoldDrawer extends StatefulWidget {
  const AppScaffoldDrawer({super.key});

  @override
  State<AppScaffoldDrawer> createState() => _AppScaffoldDrawerState();
}

class _AppScaffoldDrawerState extends State<AppScaffoldDrawer> {
  bool userIsLoggedIn = false;
  String userName = '';

  void getUser() async {
    if (await AuthService.userIsLoggedIn()) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      setState(() {
        userIsLoggedIn = true;
        userName = jsonDecode(prefs.getString('loginDetails')!)['displayName'];
        return;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          DrawerHeader(
            child: Container(
                alignment: AlignmentDirectional.center,
                child: Text(userName)
            ),
          ),
          const SizedBox(height: 30),
          Expanded(
            child: Column(
              children: [
                userIsLoggedIn
                  ? FilledButton(
                    onPressed: () async {
                      await AuthService.logout();
                      setState(() {
                        userIsLoggedIn = false;
                        userName = '';
                      });
                    },
                    child: const Text('logout')
                  )
                  : FilledButton(
                    onPressed: () async {
                      final String? gotUserName = await context.push<String>('/login');
                      if (gotUserName != null) {
                        setState(() {
                          userIsLoggedIn = true;
                          userName = gotUserName;
                        });
                      }
                    },
                    child: const Text('login')
                ),

                if (userIsLoggedIn) FilledButton(
                    onPressed: () async {
                      context.pushNamed('add_case');
                    },
                    child: const Text('add case'),
                ),

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
    );
  }
}
