import 'dart:convert';

import '../Models/QuizModels.dart';
import "package:http/http.dart" as http;

import '../const.dart';

class QuizApiService {
  static Future<List<QuizQuestion>> getQuizQuestions(String CourseName ,String SubCoursename ,String ChapterName) async {
    String URL = "${baseUrl}getMcqs/${CourseName}/${SubCoursename}/${ChapterName}";
    final response = await http.get(Uri.parse(URL));

    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((questionJson) => QuizQuestion.fromJson(questionJson)).toList();
    } else {
      throw Exception('Failed to fetch quiz questions');
    }
  }
}
