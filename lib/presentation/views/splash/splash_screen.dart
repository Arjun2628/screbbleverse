import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:scribbleverse/domain/provider/public/public_provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key, required this.screen});
  final String screen;

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
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
      const Duration(seconds: 3),
      () {
        goToHome();
      },
    );
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(
                    'lib/data/datasources/local/images/BG58-01.jpg'))),
      ),
    );
  }
}
