import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginProvider extends ChangeNotifier {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  resetpassword(BuildContext context) async {
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      await auth.sendPasswordResetEmail(email: emailController.text);
      // ignore: use_build_context_synchronously
      Navigator.pushNamed(context, '/login');
      // Get.snackbar("Send the link", 'Email');
      // loading.value = false;
    } catch (e) {
      rethrow;
    }
    notifyListeners();
  }
}
