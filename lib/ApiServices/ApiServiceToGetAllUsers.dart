import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../Models/FriendsListsModel.dart';
import '../const.dart';

class ApiServices {
  static Future<FriendsListsModel> getUsersData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String id = prefs.getString("id").toString();
    String url = "${baseUrl}getFriendAndNonFriendLists/$id"; // Replace 'getUsersData' with your API endpoint.
    final response = await http.get(Uri.parse(url));

    final String res = response.body;
    if (response.statusCode == 200) {
      if (res.isNotEmpty) {
        Map<String, dynamic> jsonData = json.decode(res) as Map<String, dynamic>;
        FriendsListsModel studentResponse = FriendsListsModel.fromJson(jsonData);
        return studentResponse;
      } else {
        throw Exception('No data found.');
      }
    } else {
      throw Exception('Failed to fetch users.');
    }
  }
}

