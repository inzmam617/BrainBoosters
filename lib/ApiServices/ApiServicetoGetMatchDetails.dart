import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../const.dart';

class ApiServicestogetMatch {
  static Future<Map<String, dynamic>> addMatch() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String id =  prefs.get("id").toString();
    String URL = "${baseUrl}addMatch/$id";
    print(URL);

    final response = await http.post(Uri.parse(URL));
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      return responseData;
    } else {
      throw Exception('Failed to add match.');
    }
  }
  static Future<Map<String, dynamic>> giveResulOftMatch(String result) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String id =  prefs.get("id").toString();
    String URL = "${baseUrl}addMatch/$id";
        Map<String ,dynamic> body = {
          "result" : result
        };
      final response = await http.post(Uri.parse(URL),
      body: json.encode(body),
      headers: {"Content-Type": "application/json"},
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      return responseData;
    } else {
      throw Exception('Failed to add match.');
    }
  }
}
