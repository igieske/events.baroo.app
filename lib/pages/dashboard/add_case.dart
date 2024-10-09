import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:collection/collection.dart';

import 'package:baroo/layout/bric.dart';
import 'package:baroo/layout/chiper.dart';
import 'package:baroo/models/case_type.dart';
import 'package:baroo/models/bar.dart';
import 'package:baroo/services/dict/dict_cubit.dart';
import 'package:baroo/services/validators/time_validator.dart';
import 'package:baroo/services/validators/date_validator.dart';
import 'package:baroo/services/validators/url_validator.dart';


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

  DateTime? _date;
  List<CaseType> caseTypes = [];
  List<String> genresValue = [];

  final TextEditingController _titleCtrl = TextEditingController();
  final TextEditingController _shortDescriptionCtrl = TextEditingController();
  final TextEditingController _descriptionCtrl = TextEditingController();
  final TextEditingController _sourcesCtrl = TextEditingController();

  XFile? poster;
  final ImagePicker picker = ImagePicker();

  String? _entryFee;
  int _entryFeeFrom = 0;
  final TextEditingController _entryFeePriceCtrl = TextEditingController();
  final TextEditingController _entryFeeCommentCtrl = TextEditingController();

  final TextEditingController _ticketsLinkCtrl = TextEditingController();


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

            return SingleChildScrollView(
              child: Form(
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
                        validator: dateTextValidator,
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
                        inputFormatters: [
                          MaskedInputFormatter('##:##',
                              allowedCharMatcher: RegExp(r'[0-9]')
                          ),
                        ],
                        validator: timeTextValidator,
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
                        inputFormatters: [
                          MaskedInputFormatter('##:##',
                              allowedCharMatcher: RegExp(r'[0-9]')
                          ),
                        ],
                        validator: timeTextValidator,
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
              
                    Bric(
                      size: const {
                        BrickWidth.sm: 6,
                      },
                      child: Chiper(
                        labelText: 'Тип события',
                        options: dict.caseTypes.map((caseType) => ChiperOption(
                            value: caseType.slug,
                            label: caseType.name,
                        )).toList(),
                        values: caseTypes.map((value) => value.slug).toList(),
                        onChanged: (values) {
                          setState(() {
                            caseTypes = values.fold([], (list, value) {
                              final matchedType = dict.caseTypes.firstWhereOrNull((item) => item.slug == value);
                              if (matchedType != null) list.add(matchedType);
                              return list;
                            });
                          });
                        },
                      ),
                    ),

                    Bric(
                      size: const {
                        BrickWidth.sm: 6,
                      },
                      child: Chiper(
                        labelText: 'Жанры',
                        options: dict.genres.map((genre) {
                          return ChiperOption(
                            value: genre.slug,
                            label: genre.label,
                            subOptions: genre.subgenres?.map((subgenre) {
                              return ChiperOption(
                                value: subgenre.slug,
                                label: subgenre.label,
                              );
                            }).toList()
                          );
                        }).toList(),
                        values: genresValue,
                        onChanged: (values) {
                          setState(() => genresValue = values);
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
                        BrickWidth.sm: 8,
                      },
                      child: Column(
                        children: [

                          TextFormField(
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

                          const SizedBox(height: 16),

                          TextFormField(
                            controller: _descriptionCtrl,
                            decoration: const InputDecoration(
                              label: Text('Подробное описание'),
                            ),
                            maxLength: 1200,
                            minLines: 3,
                            maxLines: 20,
                          )

                        ],
                      ),
                    ),

                    Bric(
                      size: const {
                        BrickWidth.sm: 4,
                      },
                      child: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: () async {
                            if (poster == null) {
                              final XFile? newPoster = await picker.pickImage(source: ImageSource.gallery);
                              if (newPoster != null) {
                                poster = newPoster;
                                setState(() { });
                              }
                              return;
                            }
                            await showDialog(
                              context: context,
                              builder: (context) => SimpleDialog(
                                title: const Text('Постер'),
                                children: [
                                  SimpleDialogOption(
                                    onPressed: () async {
                                      final XFile? newPoster = await picker.pickImage(source: ImageSource.gallery);
                                      if (newPoster != null) {
                                        poster = newPoster;
                                        setState(() { });
                                        if (context.mounted) {
                                          Navigator.pop(context);
                                        }
                                      }
                                    },
                                    child: const Text('Изменить'),
                                  ),
                                  SimpleDialogOption(
                                    onPressed: () {
                                      poster = null;
                                      setState(() { });
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Удалить'),
                                  ),
                                ],
                              ),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            constraints: const BoxConstraints(minHeight: 180),
                            clipBehavior: Clip.hardEdge,
                            child: Center(
                              child: poster == null
                                ? const Text('Нет постера')
                                : kIsWeb
                                  ? Image.network(poster!.path)
                                  : Image.file(File(poster!.path)),
                            ),
                          ),
                        ),
                      ),
                    ),

                    Bric(
                      size: const {
                        BrickWidth.sm: 3,
                      },
                      child: DropdownButtonFormField(
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.attach_money),
                          labelText: 'Стоимость',
                          labelStyle: TextStyle(color: Colors.grey),
                          counterText: '',
                        ),
                        onChanged: (value) => setState(() => _entryFee = value!),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Укажите стоимость';
                          }
                          return null;
                        },
                        items: const [
                          DropdownMenuItem(
                            value: 'free',
                            child: Text('FREE'),
                          ),
                          DropdownMenuItem(
                            value: 'charge',
                            child: Text('Платный'),
                          ),
                          DropdownMenuItem(
                            value: 'deposit',
                            child: Text('Депозит'),
                          ),
                          DropdownMenuItem(
                            value: 'donation',
                            child: Text('Донейшн'),
                          ),
                          DropdownMenuItem(
                            value: 'sold-out',
                            child: Text('Солд-аут'),
                          ),
                        ],
                      ),
                    ),

                    Bric(
                      size: const {
                        BrickWidth.sm: 9,
                      },
                      child: TextFormField(
                        controller: _ticketsLinkCtrl,
                        decoration: const InputDecoration(
                          label: Text('Ссылка на страницу покупки билетов / бронь / регистрацию'),
                          prefixIcon: Icon(Icons.link),
                        ),
                        clipBehavior: Clip.hardEdge,
                        keyboardType: TextInputType.url,
                        validator: urlValidator,
                      ),
                    ),

                    if (_entryFee == 'charge') Bric(
                      size: const {
                        BrickWidth.sm: 5,
                      },
                      child: TextFormField(
                        controller: _entryFeePriceCtrl,
                        decoration: InputDecoration(
                          label: const Text('Стоимость'),
                          prefix: Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: SegmentedButton<int>(
                              segments: const <ButtonSegment<int>>[
                                ButtonSegment<int>(
                                  value: 0,
                                  label: Text('ровно'),
                                ),
                                ButtonSegment<int>(
                                  value: 1,
                                  label: Text('от'),
                                ),
                              ],
                              selected: {_entryFeeFrom},
                              onSelectionChanged: (Set<int> newSelection) {
                                setState(() => _entryFeeFrom = newSelection.first);
                              },
                              showSelectedIcon: false,
                            ),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          CurrencyInputFormatter(
                            trailingSymbol: CurrencySymbols.RUBLE_SIGN,
                            thousandSeparator: ThousandSeparator.Space,
                            useSymbolPadding: true,
                            mantissaLength: 0,
                          ),
                        ],
                      ),
                    ),

                    Bric(
                      size: const {
                        BrickWidth.sm: 12,
                      },
                      child: TextFormField(
                        controller: _entryFeeCommentCtrl,
                        decoration: const InputDecoration(
                          label: Text('Комментарий о входе'),
                          prefixIcon: Icon(Icons.comment_outlined),
                          helperText: 'Например, "вход любая бумажная купюра" / "рекомендованный донейшн 200 руб." / "обязательная регистрация"',
                        ),
                        maxLength: 70,
                      ),
                    ),

                  ],
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
