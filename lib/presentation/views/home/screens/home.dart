import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:scribbleverse/config/theams/colors.dart';
import 'package:scribbleverse/config/theams/fonts.dart';

import 'package:scribbleverse/domain/provider/public/public_provider.dart';
import 'package:scribbleverse/presentation/views/authentication/screens/login_screen.dart';
import 'package:scribbleverse/presentation/views/books/screens/add_books.dart';
import 'package:scribbleverse/presentation/views/profile/screens/saved_posts.dart';
import 'package:scribbleverse/presentation/views/search/screens/search.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const String routName = '/home';

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<PublicProvider>(
        builder: (context, value, child) => Stack(
          children: [value.pages[value.currentIndex]],
        ),
      ),
      drawer: Consumer<PublicProvider>(
        builder: (context, value, child) => Drawer(
          child: ListView(
            padding: const EdgeInsets.all(0),
            children: [
              DrawerHeader(
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(
                              'lib/data/datasources/local/images/BG58-01.jpg'))), //BoxDecoration
                  child: Row(
                    children: [
                      Flexible(
                        flex: 1,
                        child: SizedBox(
                          height: double.infinity,
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              backgroundImage:
                                  NetworkImage(value.user!.profileImage!),
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 2,
                        child: SizedBox(
                          height: double.infinity,
                          width: double.infinity,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    value.user!.userName!,
                                    style: normal,
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'sahil@gmail.com',
                                    style: normal,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  )),
              ListTile(
                leading: const Icon(Icons.person),
                title: const Text(' My Profile '),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.video_label),
                title: const Text(' Saved Posts'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ViewSavedPosts(
                            uid: FirebaseAuth.instance.currentUser!.uid),
                      ));
                },
              ),
              ListTile(
                leading: const Icon(Icons.edit),
                title: const Text(' Edit Profile '),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('LogOut'),
                onTap: () async {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        backgroundColor: black,
                        title: Text(
                          "Do you realy want to logout???",
                          style: normal,
                        ),
                        actions: [
                          ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                'Cancel',
                                style: normalBlack,
                              )),
                          ElevatedButton(
                              onPressed: () async {
                                await FirebaseAuth.instance.signOut();
                                // ignore: use_build_context_synchronously
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const LoginScreen(),
                                    ),
                                    (route) => false);
                              },
                              child: Text(
                                'Logout',
                                style: normalBlack,
                              ))
                        ],
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomBar(),
    );
  }
}

class BottomBar extends StatelessWidget {
  const BottomBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<PublicProvider>(
      builder: (context, value, child) => BottomNavigationBar(
          showSelectedLabels: false,
          onTap: (index) async {
            value.pageSelection(index);
          },
          items: const [
            BottomNavigationBarItem(
              backgroundColor: bottomNavigationColor,
              icon: Icon(Icons.home),
              label: 'Page 0',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Page 1',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications),
              label: 'Page 3',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Page 4',
            ),
          ]),
    );
  }
}
