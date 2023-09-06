import 'package:flutter/material.dart';
import 'package:scribbleverse/presentation/views/authentication/screens/login_screen.dart';
import 'package:scribbleverse/presentation/views/authentication/screens/signup_screen.dart';
import 'package:scribbleverse/presentation/views/home/screens/home.dart';
import 'package:scribbleverse/presentation/views/poems/screens/add_poems.dart';
import 'package:scribbleverse/presentation/views/poems/screens/final_rendering.dart';
import 'package:scribbleverse/presentation/views/poems/screens/view_poems.dart';
import 'package:scribbleverse/presentation/views/short_stories/screens/view_short_stories.dart';
import 'package:scribbleverse/presentation/views/profile/screens/add_profile.dart';
import 'package:scribbleverse/presentation/views/profile/screens/edit_profile.dart';

import '../../presentation/views/profile/screens/view_profile.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    // signup
    case SignupScreen.routName:
      return MaterialPageRoute(
        builder: (context) => const SignupScreen(),
      );
    //login
    case LoginScreen.routName:
      return MaterialPageRoute(builder: (context) => const LoginScreen());
    // add_profile
    case AddProfile.routName:
      return MaterialPageRoute(builder: (context) => const AddProfile());
    // edit_profile
    case EditProfile.routName:
      return MaterialPageRoute(builder: (context) => const EditProfile());
    // view_profile
    case ViewProfile.routName:
      return MaterialPageRoute(builder: (context) => const ViewProfile());
    // view_poems
    case ViewPoems.routName:
      return MaterialPageRoute(builder: (context) => const ViewPoems());
    // add_poems
    case AddPoems.routName:
      return MaterialPageRoute(builder: (context) => const AddPoems());
    // render_poems
    case PoemRendering.routName:
      return MaterialPageRoute(builder: (context) => const PoemRendering());
    // view_short_stories
    case ViewShortStories.routName:
      return MaterialPageRoute(builder: (context) => const ViewShortStories());
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
