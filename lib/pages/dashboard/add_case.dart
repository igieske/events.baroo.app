import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'package:baroo/models/bar.dart';
import 'package:baroo/services/dict/dict_cubit.dart';


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
      body: BlocBuilder<DictCubit, DictState>(
        builder: (context, dict) {

          if (dict is DictLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (dict is Dict) {

            return Align(
              alignment: Alignment.topCenter,
              child: Container(
                color: Colors.white,
                constraints: const BoxConstraints(maxWidth: 840),
                padding: ResponsiveBreakpoints.of(context).smallerOrEqualTo(TABLET)
                    ? const EdgeInsets.symmetric(horizontal: 16) : null,
                child: Form(
                  key: addCaseFormKey,
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return Wrap(
                        spacing: 16,
                        runSpacing: 16,
                        children: [

                          ResponsiveRowColumnItem(
                            child: SizedBox(
                              width: ResponsiveValue(
                                context,
                                defaultValue: constraints.maxHeight,
                                conditionalValues: [
                                  Condition.equals(
                                    name: MOBILE,
                                    value: constraints.maxHeight,
                                  ),
                                  Condition.equals(
                                    name: TABLET,
                                    value: constraints.maxHeight / 2,
                                  ),
                                  Condition.largerThan(
                                    name: TABLET,
                                    value: constraints.maxHeight / 3,
                                  ),
                                ],
                              ).value,
                              child: Autocomplete<Bar>(
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
                            ),
                          ),

                          ResponsiveRowColumnItem(
                            child: SizedBox(
                              width: ResponsiveValue(
                                context,
                                defaultValue: constraints.maxHeight,
                                conditionalValues: [
                                  Condition.equals(
                                    name: MOBILE,
                                    value: constraints.maxHeight,
                                  ),
                                  Condition.equals(
                                    name: TABLET,
                                    value: constraints.maxHeight / 2,
                                  ),
                                  Condition.largerThan(
                                    name: TABLET,
                                    value: constraints.maxHeight / 3,
                                  ),
                                ],
                              ).value,
                              child: TextFormField(
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
                            ),
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
    );
  }
}
