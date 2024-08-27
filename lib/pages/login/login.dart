import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login_http.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final _loginFormKey = GlobalKey<FormState>();
  bool formIsLoading = false;
  final TextEditingController _usernameCtrl = TextEditingController(text: 'igoza99@gmail.com');
  final TextEditingController _passwordCtrl = TextEditingController(text: 'JS5sU*cgbg6vYl0h1GqOoBHk');

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text('login page'),
      ),

      body: Container(
        padding: const EdgeInsets.all(20),
        child: Form(
            key: _loginFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  autofocus: true,
                  controller: _usernameCtrl,
                  decoration: const InputDecoration(
                    label: Text('username or email'),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter username or email';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _passwordCtrl,
                  decoration: const InputDecoration(
                    label: Text('password'),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter password';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 50),
                FilledButton(
                  onPressed: formIsLoading ? null : () async {
                    if (_loginFormKey.currentState!.validate()) {
                      setState(() => formIsLoading = true);
                      Map<String, dynamic> authResponse = await AuthService.login(
                          _usernameCtrl.text,
                          _passwordCtrl.text
                      );
                      if (authResponse['statusCode'] != 200) {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              showCloseIcon: true,
                              closeIconColor: Colors.white,
                              content: Text(authResponse['message']),
                            ),
                          );
                        }
                      } else if (authResponse['success']) {
                        SharedPreferences prefs = await SharedPreferences.getInstance();
                        await prefs.setString(
                            'loginDetails',
                            jsonEncode(authResponse['data'])
                        );
                        if (context.mounted) {
                          context.pop(authResponse['data']['displayName']);
                        }
                        return;
                      }
                      setState(() => formIsLoading = false);
                    }
                  },
                  child: formIsLoading
                    ? const SizedBox(
                      height: 16,
                      width: 16,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 1,
                      ),
                  )
                  : const Text('login'),
                )
              ],
            )
        ),
      ),

    );
  }
}
