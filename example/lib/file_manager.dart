import 'dart:convert';

import 'package:flutter/services.dart';

class FileManager {
  FileManager._privateConstructor();
  static FileManager share = FileManager._privateConstructor();

  Future<dynamic> readJson({required String fileName}) async {
    final String response =
        await rootBundle.loadString('assets/dummy/$fileName');
    final data = await json.decode(response);
    return data;
  }
}
