import 'package:flutter/material.dart';


class AddCasePage extends StatefulWidget {
  const AddCasePage({super.key});

  @override
  State<AddCasePage> createState() => _AddCasePageState();
}

class _AddCasePageState extends State<AddCasePage> {

  GlobalKey addCaseFormKey = GlobalKey();

  final TextEditingController _barCtrl = TextEditingController();
  final TextEditingController _usernameCtrl2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Добавить событие'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: addCaseFormKey,
          child: Align(
            alignment: Alignment.topCenter,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 840),
              child: GridView(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                ),
                children: [
                  TextFormField(
                    controller: _barCtrl,
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
                    controller: _usernameCtrl2,
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
