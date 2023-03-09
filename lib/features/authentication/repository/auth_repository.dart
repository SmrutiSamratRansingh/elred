import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:developer' as devtools show log;

class AuthRepository {
  // signinWithGoogle() async {
  //   GoogleSignIn _googleSignIn = GoogleSignIn(
  //     scopes: <String>[
  //       'email',
  //       'https://www.googleapis.com/auth/contacts.readonly',
  //     ],
  //   );
  //   try {
  //     await _googleSignIn.signIn();
  //   } catch (error) {
  //     devtools.log(error.toString());
  //   }
  // }

  Future<UserCredential> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      devtools.log(e.toString());
      rethrow;
    }
  }
}
