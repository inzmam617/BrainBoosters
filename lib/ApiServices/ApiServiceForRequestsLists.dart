import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../Models/FriendReqModel.dart';
import '../Models/FriendsModels.dart'; // Replace with the correct path to your FriendsModels.dart file.
import '../const.dart'; // Replace with the correct path to your const.dart file.

class ApiServicesforReq {
  static Future<List<FriendRequest>> getAllFriendRequests() async {

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String id =  prefs.get("id").toString();
    final String URL = "${baseUrl}getFriendRequestList/$id"; // Replace 'baseUrl' with your actual base URL.

    final response = await http.get(Uri.parse(URL));
    print("this is the body: ${response.body}");

    if (response.statusCode == 200) {
      final String res = response.body;

      if (res.isNotEmpty) {
        try {
          Map<String, dynamic> jsonData = json.decode(res) as Map<String, dynamic>;
          final friendRequestResponse = FriendRequestResponse.fromJson(jsonData);
          return friendRequestResponse.friendRequests;
        } catch (e) {
          throw Exception('Failed to parse response');
        }
      } else {
        throw Exception('No friend requests found');
      }
    } else {
      throw Exception('Failed to fetch friend requests');
    }
  }
}
