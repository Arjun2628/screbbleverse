import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scribbleverse/config/theams/fonts.dart';
import 'package:scribbleverse/domain/provider/public/public_provider.dart';

import '../authentication/screens/login_screen.dart';
import '../home/screens/home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key, required this.screen});
  final String screen;

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<PublicProvider>(context, listen: false).getUserData();
  }

  Future<void> goToHome() async {
    if (widget.screen == 'home') {
      Navigator.pushNamed(context, '/home');
    } else {
      Navigator.pushNamed(context, '/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(
      Duration(seconds: 3),
      () {
        goToHome();
      },
    );
    return Scaffold(
      body: Center(
        child: Text(
          'Welcome',
          style: buttonTextBlack,
        ),
      ),
    );
  }
}
