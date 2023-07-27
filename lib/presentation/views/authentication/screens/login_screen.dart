import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:scribbleverse/presentation/views/authentication/screens/signup_screen.dart';
import 'package:scribbleverse/util/constants/constants.dart';

import '../widgets/login_form.dart';
import '../widgets/sign_up_form.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  static const String routName = '/login';
  final bool _isPressed = false;

  // Map<String, dynamic>? _userData;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              opacity: 0.9,
              fit: BoxFit.cover,
              image: AssetImage(
                  'lib/data/datasources/local/images/istockphoto-1353780638-612x612.jpg')),
        ),
        child: SafeArea(
            child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 60, 20, 0),
              child: Container(
                height: 110,
                width: 110,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('lib/assets/images/logo2.png'))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: LoginFormArea(
                regExp: Constants.regExp,
                isPressed: _isPressed,
              ),
            )
          ],
        )),
      ),
    );
  }
}
