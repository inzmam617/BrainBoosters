import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Models/AlertMessagModel.dart';
import '../const.dart';

class ApiServicesforSignUp {
  static Future<AlertModel> signup(String email, String password,String name) async {
    const String URL = "${baseUrl}signUp"; // Replace 'baseUrl' with your actual base URL.
    Map<String,dynamic> body={
      'email': email,
      'password': password,
      'name': name,
    };
    print(body);
    final response = await http.post(
      Uri.parse(URL),
      body: json.encode(body),
      headers: {"Content-Type": "application/json"},
    );
    print(response.body);
    final String res = response.body;
    if (res != 'null') {
      print(res);
      try {
        final jsonData = json.decode(res) as Map<String, dynamic>;
        return AlertModel.fromJson(jsonData);
      } catch (e) {}
    }
    return AlertModel(message: 'An error occurred',);
  }
}

