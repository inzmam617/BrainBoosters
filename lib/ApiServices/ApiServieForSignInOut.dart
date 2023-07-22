import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../Models/AlertMessagModel.dart';
import '../const.dart';

class ApiServicesforSignIn_Out {

  static Future<AlertModel> signIn(String email, String password) async {
    const String URL = "${baseUrl}signIn"; // Replace 'baseUrl' with your actual base URL.
    Map<String,dynamic> body={
      'email': email,
      'password': password,

    };
    print(json.encode(body));
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

  static Future<AlertModel> logOut() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String id =  prefs.get("id").toString();
     String URL = "${baseUrl}logOut/${id}"; // Replace 'baseUrl' with your actual base URL.


    final response = await http.post(
      Uri.parse(URL),

      // headers: {"Content-Type": "application/json"},
    );
    prefs.remove("id");

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

