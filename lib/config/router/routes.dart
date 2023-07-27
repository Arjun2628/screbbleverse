import 'package:flutter/material.dart';
import 'package:scribbleverse/presentation/views/authentication/screens/login_screen.dart';
import 'package:scribbleverse/presentation/views/authentication/screens/signup_screen.dart';
import 'package:scribbleverse/presentation/views/home/home.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    // signup
    case SignupScreen.routName:
      return MaterialPageRoute(
        builder: (context) => SignupScreen(),
      );
    //login
    case LoginScreen.routName:
      return MaterialPageRoute(builder: (context) => const LoginScreen());
    //home
    case HomeScreen.routName:
      return MaterialPageRoute(builder: (context) => const HomeScreen());
    default:
      return MaterialPageRoute(
          builder: (context) => const Scaffold(
                body: Center(
                  child: Text('no data'),
                ),
              ));
  }
}
