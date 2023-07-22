import 'package:brainboosters/ChooseCourseStudy/ChooseCourse.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../LoginWithEmail/LoginPage.dart';
import '../LoginWithEmail/SignUpPage.dart';

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
                    Get.to(()  =>const ChooseCoursePage());


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
                  onPressed: () async {
                    final User? user = await _signInWithGoogle();
                    // Do something with the signed-in user, such as storing it in the app's state
                    if (user != null) {
                      // User signed in successfully
                    } else {
                      // Sign in failed
                    }
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
                    Get.to(()  =>const ChooseCoursePage());

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
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  Future<User?> _signInWithGoogle() async {
    try {
      // Trigger the Google sign-in flow
      print("This here");
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      print("this is google: $googleUser");
      // Obtain the authentication details from the Google user
      final GoogleSignInAuthentication googleAuth =
      await googleUser!.authentication;
      print("This Was");

      // Create a new credential using the Google ID token and access token
      final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken,
      );

      print(credential.providerId);
      // Sign in to Firebase with the credential
      final UserCredential userCredential =
      await firebaseAuth.signInWithCredential(credential);

      // Access the signed-in user's information
      final User? user = userCredential.user;
      return user;
    } catch (error) {
      print('Error signing in with Google: $error');
      return null;
    }
  }

}
