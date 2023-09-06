import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginProvider extends ChangeNotifier {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  resetpassword(BuildContext context) async {
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      await auth.sendPasswordResetEmail(email: emailController.text);
      Navigator.pushNamed(context, '/login');
      // Get.snackbar("Send the link", 'Email');
      // loading.value = false;
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }
}
