import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Models/FriendsModels.dart';
import '../const.dart';

class ApiServiceGetAllStudents {
  static Future<StudentList> getAllStudents() async {
    const String URL = "${baseUrl}getAllStudents"; // Replace 'baseUrl' with your actual base URL.

    final response = await http.get(Uri.parse(URL));
    if (response.statusCode == 200) {
      final String res = response.body;
      if (res.isNotEmpty) {
        Map<String, dynamic> jsonData = json.decode(res) as Map<String, dynamic>;
        final studentList = StudentList.fromJson(jsonData);
        return studentList;
      } else {
        return StudentList(students: []);
      }
    } else {
      // Throw an exception with the response body if the API call fails.
      throw Exception("Failed to fetch students: ${response.body}");
    }
  }
}