
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;
import '../const.dart';

class ApiServiceForHandlingRequests {



  static Future<int> acceptUser(String Userid) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  String id = prefs.getString("id").toString();
  String URL = "${baseUrl}acceptFriendRequest/${id}/${Userid}";
  final response = await http.get(Uri.parse(URL));
  return response.statusCode;
  }
  static Future<int> declineUser(String Userid) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  String id = prefs.getString("id").toString();
  String URL = "${baseUrl}rejectFriendRequest/${id}/${Userid}";
  final response = await http.get(Uri.parse(URL));
  return response.statusCode;
  }
  static Future<int> sendUserReq(String Userid) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  String id = prefs.getString("id").toString();
  String URL = "${baseUrl}sendFriendRequest/${id}/${Userid}";
  final response = await http.get(Uri.parse(URL));
  return response.statusCode;
  }


}
