import 'dart:convert';
import 'package:brainboosters/const.dart';
import "package:http/http.dart" as http;

import '../Models/CoursesModels.dart';

class ApiServices {

  static Future<List<Course>> getAllCourses() async {
    String URL = "${baseUrl}getAllCourses";
    print(baseUrl);

    print(URL);

    final response = await http.get(Uri.parse(URL));

    final String res = response.body;


    if (response.body != 'null') {
      try {
        if (response.statusCode == 200) {
          if (response.body.isNotEmpty) {
            Map<String, dynamic> jsonData = json.decode(res) as Map<String, dynamic>;
            final coursesList = jsonData['courses'] as List<dynamic>;
            return coursesList.map((json) => Course.fromJson(json)).toList();
          } else if (response.body.isEmpty) {
            throw Exception('Failed to fetch orders');
          }
        }
      } catch (e) {

      }
    }
    throw Exception("Failed to fetch courses");
  }

}