import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import "package:http/http.dart" as http;
import '../LoginWithEmail/LoginPage.dart';

import '../const.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
            children: [

              SizedBox(
                height: 35,
                width: MediaQuery.of(context).size.width / 1.7,
                  child: SvgPicture.asset("assets/logo.svg",fit: BoxFit.cover,)),

              SizedBox(height: MediaQuery.of(context).size.height / 11,),
              const Text(
                "Login",
                style: TextStyle(color: Colors.black, fontSize: 28),
              ),
              const SizedBox(
                height: 40,
              ),
              SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width * 0.8,
                child: ElevatedButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all(const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)))),
                      backgroundColor:
                          MaterialStateProperty.all(const Color(0xff494FC7))),
                  onPressed: () {
                    // Get.to(()  =>const ChooseCoursePage());
                    _showMyDialog();


                  },
                  child: Row(
                    children: [
                      SvgPicture.asset("assets/facebook-round-icon.svg"),
                      const SizedBox(width: 20,),
                      const Text("Login with Facebook" ,style: TextStyle(color: Colors.white,fontSize: 16),),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width * 0.8,
                child: ElevatedButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all(const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)))),
                      backgroundColor:
                          MaterialStateProperty.all(Colors.white)),
                  onPressed: ()  {
                    _showMyDialog();
                    // _handleSignIn();
                  },
                  child: Row(
                    children: [
                      SvgPicture.asset("assets/google.svg"),
                      const SizedBox(width: 20,),
                      const Text("Login with Google" ,style: TextStyle(color: Colors.black,fontSize: 16),),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width * 0.8,
                child: ElevatedButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all(const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)))),
                      backgroundColor:
                          MaterialStateProperty.all(Colors.black)),
                  onPressed: () {
                    // Get.to(()  =>const ChooseCoursePage());

                    _showMyDialog();
                  },
                  child: Row(
                    children: [
                      SvgPicture.asset("assets/apple.svg"),
                      const SizedBox(width: 20,),
                      const Text("Login with Apple" ,style: TextStyle(color: Colors.white,fontSize: 16),),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width * 0.8,
                child: ElevatedButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all(const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)))),
                      backgroundColor:
                          MaterialStateProperty.all(Colors.orange)),
                  onPressed: () {
                    Get.to(()  =>const LoginEmailPassword());

                  },
                  child: const Text("Login with Email/Password" ,style: TextStyle(color: Colors.white,fontSize: 16),),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
  // final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  // final GoogleSignIn googleSignIn = GoogleSignIn();
  // Future<User?> _signInWithGoogle() async {
  //   try {
  //     // Trigger the Google sign-in flow
  //     print("This here");
  //     final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  //     print("this is google: $googleUser");
  //     // Obtain the authentication details from the Google user
  //     final GoogleSignInAuthentication googleAuth =
  //     await googleUser!.authentication;
  //     print("This Was");
  //
  //     // Create a new credential using the Google ID token and access token
  //     final AuthCredential credential = GoogleAuthProvider.credential(
  //       idToken: googleAuth.idToken,
  //       accessToken: googleAuth.accessToken,
  //     );
  //
  //     print(credential.providerId);
  //     // Sign in to Firebase with the credential
  //     final UserCredential userCredential =
  //     await firebaseAuth.signInWithCredential(credential);
  //
  //     // Access the signed-in user's information
  //     final User? user = userCredential.user;
  //     return user;
  //   } catch (error) {
  //     print('Error signing in with Google: $error');
  //     return null;
  //   }
  // }
  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Feature'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Feature Coming Soon..'),
                SizedBox(height: 20,),
                Text('Please Try With Email and Password'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Okay'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['profile', 'email']);
   Future<void> _handleSignIn() async {
    try {
      // Perform Google sign-in to obtain the access token or ID token
      GoogleSignInAccount? account = await _googleSignIn.signIn();
      if (account != null) {
        GoogleSignInAuthentication auth = await account.authentication;
        String? token = auth.accessToken ?? auth.idToken;

        // Make an HTTP GET request to your Node.js backend with the token
        const String URL = "http://$baseUrl:3000/auth/google"; // Replace 'YOUR_NODEJS_SERVER_ADDRESS' with your actual backend URL.
        final response = await http.get(
          Uri.parse('$URL?token=$token'),
        );

        print("this is the response:${response.body}");
        if (response.statusCode == 200) {
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
