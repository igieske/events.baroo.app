import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import 'package:baroo/layout/bric.dart';
import 'package:baroo/layout/chiper.dart';
import 'package:baroo/models/case_type.dart';
import 'package:baroo/models/bar.dart';
import 'package:baroo/services/dict/dict_cubit.dart';
import 'package:baroo/services/time_formatter.dart';
import 'package:baroo/services/date_formatter.dart';


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
  final TextEditingController _caseTypeCtrl = TextEditingController();

  DateTime? _date;
  List<CaseType> caseTypes = [];

  final TextEditingController _titleCtrl = TextEditingController();
  final TextEditingController _shortDescriptionCtrl = TextEditingController();
  final TextEditingController _sourcesCtrl = TextEditingController();

  XFile? poster;
  final ImagePicker picker = ImagePicker();


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

                  Container(
                    padding: const EdgeInsets.only(top: 20),
                    width: double.infinity,
                    child: Text(
                      'Место и время',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),

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
                        prefixIcon: MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: Icon(Icons.calendar_month),
                        ),
                        label: Text('Дата'),
                      ),
                      validator: (value) => dateTextValidator(value),
                      mouseCursor: SystemMouseCursors.click,
                      canRequestFocus: false,
                      onTap: () async {
                        final DateTime today = DateTime.now().copyWith(
                          hour: 0,
                          minute: 0,
                          second: 0,
                          millisecond: 0,
                          microsecond: 0,
                        );
                        DateTime? datePickerResult = await showDatePicker(
                          context: context,
                          initialDate: _date,
                          locale: const Locale('ru'),
                          firstDate: today,
                          lastDate: today.add(const Duration(days: 365)),
                        );
                        if (datePickerResult != null) {
                          _date = datePickerResult;
                          _dateCtrl.text = DateFormat('dd.MM.yyyy').format(datePickerResult);
                        }
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
                        prefixIcon: Icon(Icons.access_time),
                        label: Text('Время (двери)'),
                        counterText: '',
                      ),
                      maxLength: 5,
                      keyboardType: TextInputType.number,
                      inputFormatters: [TimeTextFormatter()],
                      validator: (value) => timeTextValidator(value),
                    ),
                  ),

                  Bric(
                    size: const {
                      BrickWidth.sm: 6,
                    },
                    child: TextFormField(
                      controller: _timeStartCtrl,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.access_time),
                        label: Text('Время (начало)'),
                        counterText: '',
                      ),
                      maxLength: 5,
                      keyboardType: TextInputType.number,
                      inputFormatters: [TimeTextFormatter()],
                      validator: (value) => timeTextValidator(value),
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

                  const Bric(
                    size: {
                      BrickWidth.sm: 6,
                    },
                    child: Chiper(
                        children: ['Живая музыка'],
                    ),
                  ),

                  Bric(
                    size: const {
                      BrickWidth.sm: 6,
                    },
                    child: TextFormField(
                      controller: _caseTypeCtrl,
                      decoration: const InputDecoration(
                        label: Text('Тип события'),
                        suffixIcon: MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: Icon(Icons.list)
                        ),
                      ),
                      mouseCursor: SystemMouseCursors.click,
                      canRequestFocus: false,
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext  context) {
                            return StatefulBuilder(
                              builder: (BuildContext context, StateSetter setState) {
                                return AlertDialog(
                                  title: const Text('Тип события'),
                                  content: SingleChildScrollView(
                                    child: ListBody(
                                      children: dict.caseTypes.map((caseType) {
                                        return FilterChip(
                                          label: Text(caseType.name),
                                          selected: caseTypes.contains(caseType),
                                          onSelected: (bool selected) {
                                            setState(() {
                                              if (selected) {
                                                caseTypes.add(caseType);
                                              } else {
                                                caseTypes.remove(caseType);
                                              }
                                            });
                                            _caseTypeCtrl.text = caseTypes.map((caseType) => caseType.name).join(', ');
                                          },
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                  actions: [
                                    FilledButton(
                                      child: const Text('ОК'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        );
                      },
                    ),
                  ),

                  Container(
                    padding: const EdgeInsets.only(top: 20),
                    width: double.infinity,
                    child: Text(
                      'Основная информация',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),

                  Bric(
                    size: const {
                      BrickWidth.sm: 6,
                    },
                    child: TextFormField(
                      controller: _titleCtrl,
                      decoration: const InputDecoration(
                        label: Text('Название события'),
                      ),
                      maxLength: 150,
                    ),
                  ),

                  Bric(
                    size: const {
                      BrickWidth.sm: 6,
                    },
                    child: TextFormField(
                      controller: _shortDescriptionCtrl,
                      decoration: const InputDecoration(
                        label: Text('Краткое описание'),
                      ),
                      maxLength: 150,
                    ),
                  ),

                  Bric(
                    size: const {
                      BrickWidth.sm: 6,
                    },
                    child: TextFormField(
                      controller: _sourcesCtrl,
                      decoration: const InputDecoration(
                        label: Text('Источники'),
                        hintText: 'По одной ссылке в строке',
                      ),
                      minLines: 1,
                      maxLines: 5,
                      clipBehavior: Clip.hardEdge,
                      keyboardType: TextInputType.url,
                    ),
                  ),

                  Bric(
                    size: const {
                      BrickWidth.sm: 6,
                    },
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: () async {
                          poster = await picker.pickImage(source: ImageSource.gallery);
                          setState(() { });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          clipBehavior: Clip.hardEdge,
                          child: Center(
                            child: poster == null
                              ? const Text('Выбрать')
                              : kIsWeb
                                ? Image.network(poster!.path)
                                : Image.file(File(poster!.path)),
                          ),
                        ),
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
