import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';


class LocalStorage {
  static Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  static Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/local_storage.json');
  }

  static Future<Map<String, dynamic>> read() async {
    try {
      final file = await _localFile;
      if (await file.exists()) {
        final contents = await file.readAsString();
        return json.decode(contents);
      }
      print('! файла нет');
      file.writeAsString(json.encode({}));
      return {};
    } catch (e) {
      print('LocalStorage read error: $e');
      return {};
    }
  }

  static Future<File> write(Map<String, dynamic> data) async {
    final file = await _localFile;
    return file.writeAsString(json.encode(data));
  }
}