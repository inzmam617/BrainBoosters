import 'package:google_sign_in/google_sign_in.dart';

GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: [
    'email',
  ],
  clientId: 'http://523758394101-8rm1el0l6vi0231bljlg43h6nt7mqsuh.apps.googleusercontent.com/',
);

Future<void> signInWithGoogle() async {
  try {
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;
    // Use googleAuth.idToken and googleAuth.accessToken for further operations
  } catch (error) {
    // Handle sign-in error
    print('Google Sign-In error: $error');
  }
}
