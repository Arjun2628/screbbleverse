import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:scribbleverse/config/router/routes.dart';
import 'package:scribbleverse/domain/provider/authentication/login.dart';
import 'package:scribbleverse/domain/provider/authentication/sign_up_with_google.dart';
import 'package:scribbleverse/domain/provider/books/add_book_provider.dart';
import 'package:scribbleverse/domain/provider/poems/comments_provider.dart';
import 'package:scribbleverse/domain/provider/poems/poems_provider.dart';
import 'package:scribbleverse/domain/provider/poems/writting_provider.dart';
import 'package:scribbleverse/domain/provider/public/public_provider.dart';
import 'package:scribbleverse/domain/provider/short_stories/read_short_story_provider.dart';
import 'package:scribbleverse/presentation/views/authentication/screens/login_screen.dart';
import 'package:provider/provider.dart';
import 'package:scribbleverse/presentation/views/home/screens/home.dart';
import 'package:scribbleverse/presentation/views/splash/splash_screen.dart';

import 'domain/provider/authentication/sign_up_with_email.dart';
import 'domain/provider/authentication/sign_up_with_facebook.dart';
import 'domain/provider/profile/add_profile_provider.dart';

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
        ChangeNotifierProvider(create: (context) => SignUpWithEmailProvider()),
        ChangeNotifierProvider(create: (context) => AddProfileProvider()),
        ChangeNotifierProvider(create: (context) => PublicProvider()),
        ChangeNotifierProvider(create: (context) => LoginProvider()),
        ChangeNotifierProvider(create: (context) => AddPoemProvider()),
        ChangeNotifierProvider(create: (context) => DrawingProvider()),
        ChangeNotifierProvider(create: (context) => CommentsProvider()),
        ChangeNotifierProvider(create: (context) => ReadShortStoriesProvider()),
        ChangeNotifierProvider(create: (context) => AddBooksProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
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
                return const SplashScreen(screen: 'login');
              } else {
                return const SplashScreen(screen: 'home');
              }
            }
            return const SplashScreen(screen: 'login');
          },
        ),
      ),
    );
  }
}
