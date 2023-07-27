import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:scribbleverse/config/router/routes.dart';
import 'package:scribbleverse/domain/provider/authentication/sign_up_with_google.dart';
import 'package:scribbleverse/presentation/views/authentication/screens/login_screen.dart';
import 'package:provider/provider.dart';
import 'package:scribbleverse/presentation/views/home/home.dart';

import 'domain/provider/authentication/sign_up_with_email.dart';
import 'domain/provider/authentication/sign_up_with_facebook.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SignUpWithGoogleProvider()),
        ChangeNotifierProvider(
            create: (context) => SignUpWithFacebookProvider()),
        ChangeNotifierProvider(create: (context) => SignUpWithEmailProvider())
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        onGenerateRoute: (settings) => generateRoute(settings),
        home: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.data == null) {
                return const LoginScreen();
              } else {
                return const HomeScreen();
              }
            }
            return const LoginScreen();
          },
        ),
      ),
    );
  }
}
