import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../Models/QuizHistoryModel.dart';
import '../const.dart';

class QuizAPIFOr {

  static Future<List<QuizHistoryResponse>> getQuizResponses() async {

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String id =  prefs.get("id").toString();
     String URL = "${baseUrl}getMatch/${id}";
     // print("THis is the URL: $URL");

    try {
      final response = await http.get(Uri.parse(URL));
      // print(response.body);
      if (response.statusCode == 200) {
        List<dynamic> jsonList = jsonDecode(response.body);
        // print("Json List: " + jsonList.toString());

        return jsonList.map((json) => QuizHistoryResponse.fromJson(json)).toList();

      } else {
        throw Exception('Failed to load quiz responses');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
