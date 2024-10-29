import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:baroo/models/bar.dart';
import 'package:baroo/models/genre.dart';
import 'package:baroo/models/artist.dart';
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
      List<Band> bands = [];
      List<Fella> fellas = [];
      List<Genre> genres = [];
      List<CaseType> caseTypes = [];

      for (final dict in data.entries) {
        switch (dict.key) {
          case 'bars':
            bars = (dict.value as List)
                .map((bar) => Bar.fromJson(bar))
                .toList();
            break;
          case 'bands':
            bands = (dict.value as List)
                .map((band) => Band.fromJson(band))
                .toList();
            break;
          case 'fellas':
            fellas = (dict.value as List)
                .map((fella) => Fella.fromJson(fella))
                .toList();
            break;
          case 'genres':
            genres = (dict.value as List)
                .map((type) => Genre.fromJson(type))
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
        bands: bands,
        fellas: fellas,
        genres: genres,
        caseTypes: caseTypes,
      ));
    } catch (e) {
      print(e);
      emit(DictError(message: e.toString()));
    }
  }

}
