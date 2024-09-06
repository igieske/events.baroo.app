import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:baroo/models/bar.dart';
import 'package:baroo/models/case_type.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'dict_state.dart';


class DictCubit extends Cubit<DictState> {
  DictCubit() : super(DictInitial());

  // загрузка словарей
  Future<void> loadDictionaries(List<String> dicts) async {
    emit(DictLoading());
    const dictsUrl = 'https://baroo.ru/wp-content/themes/baroo-child/app/get-dicts.php';
    try {

      final request = http.Request('POST', Uri.parse(dictsUrl));
      request.body = json.encode({ 'dicts': dicts });
      request.headers.addAll({ 'Content-Type': 'application/json' });
      http.StreamedResponse response = await request.send()
          .timeout(const Duration(seconds: 10));
      final responseString = await response.stream.bytesToString();
      final data = json.decode(responseString);

      List<Bar> bars = [];
      List<CaseType> caseTypes = [];

      for (final dict in data.entries) {
        switch (dict.key) {
          case 'bars':
            bars = (dict.value as List)
                .map((bar) => Bar.fromJson(bar))
                .toList();
            break;
          case 'caseTypes':
            caseTypes = (dict.value as List)
                .map((type) => CaseType.fromJson(type))
                .toList();
            break;
          default:
            print('Unknown dictionary type: ${dict.key}');
        }
      }

      emit(Dict(
          bars: bars,
          caseTypes: caseTypes,
      ));
    } catch (e) {
      print(e);
      emit(DictError(message: e.toString()));
    }
  }

}
