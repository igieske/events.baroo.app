import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:baroo/layout/bric.dart';
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

  final TextEditingController _dateCtrl = TextEditingController();
  final TextEditingController _timeEntryCtrl = TextEditingController();
  final TextEditingController _timeStartCtrl = TextEditingController();
  final TextEditingController _placeDetailsCtrl = TextEditingController();

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

            return Form(
              key: addCaseFormKey,
              child: Brics(
                gap: 16,
                crossGap: 16,
                maxWidth: 840 - 16 * 2,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [

                  Bric(
                    size: const {
                      BrickWidth.sm: 6,
                    },
                    builder: (context, bricWidth) {
                      return Autocomplete<Bar>(
                        displayStringForOption: (Bar bar) => bar.name,
                        optionsBuilder: (TextEditingValue textEditingValue) {
                          if (textEditingValue.text.length < 2) {
                            return const Iterable<Bar>.empty();
                          }
                          return dict.bars.where((bar) => bar.name.toLowerCase()
                              .contains(textEditingValue.text.toLowerCase()));
                        },
                        optionsViewBuilder: (BuildContext context,
                            AutocompleteOnSelected<Bar> onSelected,
                            Iterable<Bar> options) {
                          return Align(
                            alignment: Alignment.topLeft,
                            child: Material(
                              elevation: 4.0,
                              child: ConstrainedBox(
                                constraints: BoxConstraints(maxWidth: bricWidth),
                                child: ListView.builder(
                                  padding: EdgeInsets.zero,
                                  shrinkWrap: true,
                                  itemCount: options.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    final Bar bar = options.elementAt(index);
                                    return InkWell(
                                      onTap: () {
                                        onSelected(bar);
                                      },
                                      child: Builder(
                                        builder: (BuildContext context) {
                                          final bool highlight = AutocompleteHighlightedOption.of(context) == index;
                                          if (highlight) {
                                            SchedulerBinding.instance.addPostFrameCallback((Duration timeStamp) {
                                              Scrollable.ensureVisible(context, alignment: 0.5);
                                            });
                                          }
                                          return Container(
                                            color: highlight ? Theme.of(context).focusColor : null,
                                            padding: const EdgeInsets.all(16.0),
                                            child: Text(
                                              RawAutocomplete.defaultStringForOption(bar.name),
                                            ),
                                          );
                                        }
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          );
                        },
                        fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
                          return TextField(
                            controller: controller,
                            focusNode: focusNode,
                            decoration: const InputDecoration(
                              hintText: 'Место',
                            ),
                            onSubmitted: (value) {
                              onFieldSubmitted();
                            },
                          );
                        },
                        onSelected: (Bar selection) {
                          print('Выбрано: ${selection.name}, ID: ${selection.id}');
                        },

                      );
                    },
                  ),

                  Bric(
                    size: const {
                      BrickWidth.sm: 6,
                    },
                    child: TextFormField(
                      controller: _dateCtrl,
                      decoration: const InputDecoration(
                        label: Text('Дата'),
                      ),
                      validator: (value) {
                        if ((value?.trim().isEmpty ?? '') == '') {
                          return 'Укажите дату';
                        }
                        return null;
                      },
                    ),
                  ),

                  Bric(
                    size: const {
                      BrickWidth.sm: 6,
                    },
                    child: TextFormField(
                      controller: _timeEntryCtrl,
                      decoration: const InputDecoration(
                        label: Text('Время (двери)'),
                      ),
                    ),
                  ),

                  Bric(
                    size: const {
                      BrickWidth.sm: 6,
                    },
                    child: TextFormField(
                      controller: _timeStartCtrl,
                      decoration: const InputDecoration(
                        label: Text('Время (начало)'),
                      ),
                      validator: (value) {
                        if ((value?.trim().isEmpty ?? '') == '') {
                          return 'Укажите время начала';
                        }
                        return null;
                      },
                    ),
                  ),

                  Bric(
                    size: const {
                      BrickWidth.sm: 6,
                    },
                    child: TextFormField(
                      controller: _placeDetailsCtrl,
                      decoration: const InputDecoration(
                        label: Text('Уточнение о месте проведения'),
                      ),
                    ),
                  ),

                ],
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
