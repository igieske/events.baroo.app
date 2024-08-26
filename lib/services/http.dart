import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiParams {
  String action;
  Object? body;

  ApiParams(this.action, [this.body]);
}

class Http {

  static Future post(ApiParams params) async {
    print('----> ${params.action}');

    final request = http.Request('POST',
        Uri.parse('https://baroo.ru/wp-content/themes/baroo-child/app-handler.php')
    );
    request.body = json.encode(params.body);
    request.headers.addAll({
      'Content-Type': 'application/json',
      'Action': params.action,
    });

    try {
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        final responseString = await response.stream.bytesToString();
        // парсим json
        Map<String, dynamic> decodedJSON;
        try {
          decodedJSON = json.decode(responseString) as Map<String, dynamic>;
        } on FormatException catch (e) {
          // ! ошибка при парсинге JSON
          print('! Ответ не JSON: ${e.message}');
          decodedJSON = jsonDecode('{"Error": 3, "Message": "Ошибка запроса, попробуйте позже"}');
        }
        // ответ
        print(decodedJSON);
        return decodedJSON;
      } else {
        // ! ошибка при ожидании потока респонса
        print('! ошибка при ожидании потока респонса');
        return jsonDecode('{"Error": 3, "Message": "Ошибка запроса, попробуйте позже."}');
      }

    } catch (e) {
      // ! ошибка при отправке запроса
      print('! ошибка при отправке запроса');
      print(e);
      return jsonDecode('{"Error": 3, "Message": "Ошибка. Проверьте подключение к интернету."}');
    }

  }

}