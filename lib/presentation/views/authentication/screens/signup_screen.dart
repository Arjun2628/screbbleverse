// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import 'package:scribbleverse/presentation/views/authentication/widgets/sign_up_form.dart';
import 'package:scribbleverse/util/constants/constants.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  static const String routName = '/signUp';
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
              child: FormArea(
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
