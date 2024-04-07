import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


class AuthService {

  static const String wpJsonUrl = 'https://baroo.ru/wp-json/jwt-auth/v1/token';

  static Future<bool> userIsLoggedIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('loginDetails') != null;
  }

  static Future login(String username, String password) async {
    final request = http.Request('POST', Uri.parse(wpJsonUrl));
    request.body = json.encode({'username': username, 'password': password});
    request.headers.addAll({ 'Content-Type': 'application/json' });
    http.StreamedResponse response = await request.send()
        .timeout(const Duration(seconds: 10));
    final responseString = await response.stream.bytesToString();
    return json.decode(responseString);
  }

  static Future logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('loginDetails');
  }

}