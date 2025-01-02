import 'dart:convert';
import 'package:http/http.dart' as http;


class Http {

  static Future post(String method, [Map<String, dynamic>? body]) async {
    print('----> $method');
    body ??= {};

    try {

      // запрос
      final response = await http.post(
        Uri.https('baroo.ru', 'wp-content/themes/baroo-child/app/$method.php'),
        body: json.encode(body),
      );

      // print(response.body);

      // todo: проверять response.statusCode
      // print(response.statusCode);

      // парсим json
      Map<String, dynamic> decodedJson;
      try {
        decodedJson = json.decode(response.body) as Map<String, dynamic>;
      } on FormatException catch (e) {
        throw('! Ответ не JSON: ${e.message}');
      }

      return decodedJson['data'] ?? {};

    } catch (e) {
      // todo
      print('! ошибка при отправке запроса: $e');
    }
    return null;
  }

}