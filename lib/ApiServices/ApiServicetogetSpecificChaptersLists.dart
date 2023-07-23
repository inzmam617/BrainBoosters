
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../Models/CoursesModels.dart';
import '../Models/SampleSubCourseForChaptersNew.dart';
import '../const.dart';

class ApiServicetogetSpecificChaptersLists{
  static Future<ChaptersResponse> getChaptersLists(String id) async {
    String URL = "${baseUrl}getChapters/$id";
    print(URL);

    final response = await http.get(Uri.parse(URL));
    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      print(responseData);

      if (responseData is Map<String, dynamic> && responseData.containsKey('chapters')) {
        return ChaptersResponse.fromJson(responseData);
      } else {
        throw Exception('Invalid response format.');
      }
    } else {
      throw Exception('Failed to fetch chapters.');
    }
  }



}