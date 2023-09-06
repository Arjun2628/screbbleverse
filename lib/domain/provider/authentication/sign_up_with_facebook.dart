import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class SignUpWithFacebookProvider extends ChangeNotifier {
  Map<String, dynamic>? userData;

  Future<UserCredential> signInWithFacebook() async {
    final LoginResult loginResult =
        await FacebookAuth.instance.login(permissions: ['email']);
    // ignore: unrelated_type_equality_checks
    if (loginResult == LoginStatus.success) {
      final userDetails = await FacebookAuth.instance.getUserData();
      userData = userDetails;
    } else {
      print(loginResult.message);
    }

    final OAuthCredential oAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);

    return FirebaseAuth.instance.signInWithCredential(oAuthCredential);
  }
}
