import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';


class LocalStorage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/local_storage.txt');
  }

  Future<Map<String, String>?> read() async {
    try {
      final file = await _localFile;
      final contents = await file.readAsString();
      return json.decode(contents);
    } catch (e) {
      print('LocalStorage read error: $e');
      return null;
    }
  }

  Future<File> write(Map<String, dynamic> data) async {
    final file = await _localFile;
    return file.writeAsString(json.encode(data));
  }
}