import 'package:baroo/models/bar.dart';
import 'package:baroo/services/dict/dict_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class AddCasePage extends StatefulWidget {
  const AddCasePage({super.key});

  @override
  State<AddCasePage> createState() => _AddCasePageState();
}

class _AddCasePageState extends State<AddCasePage> {

  late final DictCubit dict;

  GlobalKey addCaseFormKey = GlobalKey();

  final TextEditingController _barCtrl = TextEditingController();
  final TextEditingController _dateCtrl = TextEditingController();

  @override
  void initState() {
    dict = context.read<DictCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Добавить событие'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: BlocBuilder<DictCubit, DictState>(
          builder: (context, dict) {

            if (dict is DictLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (dict is Dict) {

              return Form(
                key: addCaseFormKey,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 840),
                    child: LayoutBuilder(
                      builder: (BuildContext context, BoxConstraints constraints) {

                        return Wrap(
                          spacing: 16,
                          runSpacing: 16,
                          children: [

                            Autocomplete<Bar>(
                              optionsBuilder: (TextEditingValue textEditingValue) {
                                if (textEditingValue.text.length < 2) {
                                  return const Iterable<Bar>.empty();
                                }
                                return dict.bars.where((bar) => bar.name.toLowerCase().contains(textEditingValue.text.toLowerCase()));
                              },
                              displayStringForOption: (Bar bar) => bar.name,
                              onSelected: (Bar selection) {
                                print('Выбрано: ${selection.name}, ID: ${selection.id}');
                              },
                              fieldViewBuilder: (BuildContext context, TextEditingController textEditingController, FocusNode focusNode, VoidCallback onFieldSubmitted) {
                                return TextField(
                                  controller: textEditingController,
                                  focusNode: focusNode,
                                  decoration: const InputDecoration(
                                    hintText: 'Введите имя бара',
                                  ),
                                );
                              },
                            ),

                            TextFormField(
                              controller: _barCtrl,
                              decoration: const InputDecoration(
                                label: Text('Уточнение о месте проведения'),
                              ),
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Please enter username or email';
                                }
                                return null;
                              },
                            ),

                            TextFormField(
                              controller: _dateCtrl,
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
                        );

                      },

                    ),
                  ),
                ),
              );

            } else {
              return const Center(child: Text('ошибка'));
            }

          },
        ),
      ),
    );
  }
}
