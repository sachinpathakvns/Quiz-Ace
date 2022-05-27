import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../../main.dart';

class Downloader {
  static Future<dynamic> getData(String base, String part) async {
    Uri url = Uri.http(base, part, {});
    try {
      final response = await http.get(url);
      print(response.body);
      final jsonResponse = convert.jsonDecode(response.body);
      return jsonResponse;
    } catch (e) {
      print(e);
      return false;
    }
  }
}

