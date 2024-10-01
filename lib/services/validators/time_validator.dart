String? timeTextValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Укажите время';
  }
  else if (value.length != 5
      || !timeRegExp.hasMatch(value)
      || int.parse(value.split(':')[0]) > 23
      || int.parse(value.split(':')[1]) > 59
  ) {
    return 'Неверный формат времени';
  }
  return null;
}

final RegExp timeRegExp = RegExp(r'^([0-1]?[0-9]|2[0-3]):[0-5][0-9]$');