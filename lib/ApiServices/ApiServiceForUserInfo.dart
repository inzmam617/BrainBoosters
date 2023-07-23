
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../Models/UserInfoModel.dart';
import '../const.dart';

class ApiServicetoGetUserInfo {
  static Future<UserModel> GetPersionalInfo( String id) async {

    String url = "${baseUrl}getInfo/$id"; // Replace 'getUsersData' with your API endpoint.
    final response = await http.get(Uri.parse(url));

    final String res = response.body;
    print(res);
    if (response.statusCode == 200) {
      if (res.isNotEmpty) {
        Map<String, dynamic> jsonData = json.decode(res) as Map<String, dynamic>;
        UserModel studentResponse = UserModel.fromJson(jsonData);
        return studentResponse;
      } else {
        throw Exception('No data found.');
      }
    } else {
      throw Exception('Failed to fetch users.');
    }
  }
}