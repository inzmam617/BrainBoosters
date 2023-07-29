import "dart:convert";
import "package:google_sign_in/google_sign_in.dart";
import "package:http/http.dart" as http;
import "../const.dart";

class ApiServiceForPassAuth{
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  Future<void> _handleSignIn() async {
    try {
      // Perform Google sign-in to obtain the access token or ID token
      GoogleSignInAccount? account = await _googleSignIn.signIn();
      if (account != null) {
        GoogleSignInAuthentication auth = await account.authentication;
        String? token = auth.accessToken ?? auth.idToken;

        // Make an HTTP GET request to your Node.js backend with the token
        const String URL = "${baseUrl}auth/google"; // Replace 'baseUrl' with your actual base URL.
        final response = await http.get(
          Uri.parse('$URL?token=$token'),
        );

        if (response.statusCode == 200) {
          // Successful response, extract user information
          final userJson = json.decode(response.body);
          print('User: $userJson');
          // Handle the user information as needed in your Flutter app
        } else {
          // Handle other response status codes
          print('HTTP Error ${response.statusCode}: ${response.body}');
        }
      }
    } catch (error) {
      // Handle any errors that occur during the Google sign-in or HTTP request
      print('Error: $error');
    }
  }

}
