import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignUpWithGoogleProvider extends ChangeNotifier {
  Future<void> googleSignUp() async {
    GoogleSignInAccount? googleUsers = await GoogleSignIn().signIn();

    GoogleSignInAuthentication? googleAuth = await googleUsers?.authentication;

    AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleAuth?.idToken, accessToken: googleAuth?.accessToken);

    await FirebaseAuth.instance.signInWithCredential(credential);
    notifyListeners();
  }
}
