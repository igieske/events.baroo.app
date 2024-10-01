String? urlValidator(String? value) {
  // Регулярное выражение для валидации URL
  const urlPattern = r'(https?:\/\/)?([\w\-])+\.{1}([a-zA-Z]{2,63})([\/\w\-\.\?\=\&\#]*)*\/?';
  final regExp = RegExp(urlPattern);

  if (value == null || value.isEmpty) {
    return 'Некорректная ссылка';
  } else if (!regExp.hasMatch(value)) {
    return 'Неверный формат ссылки';
  }
  return null;
}
