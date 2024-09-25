import 'package:flutter/services.dart';

// formatter
class TimeTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    // accept only numbers
    String filteredText = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');
    // fix backspace bug
    if (oldValue.text.length >= newValue.text.length) {
      return newValue;
    }
    final dateText = _addSeparators(filteredText, ':');
    return newValue.copyWith(text: dateText, selection: updateCursorPosition(dateText));
  }
  String _addSeparators(String value, String separator) {
    value = value.replaceAll(':', '');
    var newString = '';
    for (int i = 0; i < value.length; i++) {
      newString += value[i];
      if (i == 1) {
        newString += separator;
      }
    }
    return newString;
  }
  TextSelection updateCursorPosition(String text) {
    return TextSelection.fromPosition(TextPosition(offset: text.length));
  }
}

// validator
String? timeTextValidator(value) {
  if (value == null || value.isEmpty) {
    return 'Укажите время';
  }
  else if (value.length != 5 || !timeRegExp.hasMatch(value) || int.parse(value.split(':')[0]) > 23 || int.parse(value.split(':')[1]) > 59 ) {
    return 'Неверный формат времени';
  }
  return null;
}

final RegExp timeRegExp = RegExp(r'^([0-1]?[0-9]|2[0-3]):[0-5][0-9]$');