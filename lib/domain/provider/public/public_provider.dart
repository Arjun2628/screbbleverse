import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scribbleverse/domain/models/user_moder.dart';
import 'package:scribbleverse/presentation/views/home/screens/home.dart';
import 'package:scribbleverse/presentation/views/home/widgets/home_widget.dart';
import 'package:scribbleverse/presentation/views/poems/screens/view_poems.dart';
import 'package:scribbleverse/presentation/views/search/screens/search.dart';
import 'package:scribbleverse/presentation/views/short_stories/screens/view_short_stories.dart';
import 'package:scribbleverse/presentation/views/profile/screens/view_profile.dart';
import 'package:uuid/uuid.dart';

import '../../../presentation/views/notifications/notifications.dart';

class PublicProvider extends ChangeNotifier {
  UserModel? user;
  bool trending = true;
  bool poems = false;
  bool shortStories = false;
  bool books = false;
  int numberOfPosts = 0;

  String? meaning;

  var current = const Page4();

  int currentIndex = 0;
  final List<Widget> pages = [
    const Page1(),
    const SearchUsers(),
    // AddPoems(),
    const Page4(),
    const ViewProfile(),
    const ViewPoems(),
    const ViewShortStories()
  ];

  pageSelection(int index) {
    currentIndex = index;
    notifyListeners();
  }

  getMeaning(String? value) {
    meaning = value;
    notifyListeners();
  }

  postAdding(String value) {
    if (value == 'trending') {
      trending = true;
      poems = false;
      shortStories = false;
      books = false;
    } else if (value == 'poems') {
      trending = false;
      poems = true;
      shortStories = false;
      books = false;
    } else if (value == 'short_stories') {
      trending = false;
      poems = false;
      shortStories = true;
      books = false;
    } else {
      trending = false;
      poems = false;
      shortStories = false;
      books = true;
    }
    notifyListeners();
  }

  Future getUserData() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection('users')
        .doc(auth.currentUser!.uid)
        .get();

    user = UserModel.fromJson(snapshot.data()!);
    //  DocumentSnapshot<Map<String, dynamic>> posts=  await FirebaseFirestore.instance
    //       .collection('users')
    //       .doc(auth.currentUser!.uid)
    //       .collection('posts')
    //       .doc('poems')
    //       .collection('poems').doc().get()
    final posts = await FirebaseFirestore.instance
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('posts')
        .doc('poems')
        .collection('poems')
        .get();
    numberOfPosts = posts.docs.length;

    notifyListeners();
  }

  editUser(UserModel data) {
    user = data;
    notifyListeners();
  }

  getPostCount(String uid) async {
    final poems = await FirebaseFirestore.instance
        .collection('poems')
        .where("user_id", isEqualTo: uid)
        .get();
    final shortStories = await FirebaseFirestore.instance
        .collection('poems')
        .where("user_id", isEqualTo: uid)
        .get();

    final poemCount = poems.docs.length;
    final shortStoryCount = shortStories.docs.length;
    int count = poemCount + shortStoryCount;
  }

  savePosts(Map<String, dynamic> data, BuildContext context) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    String uid = Uuid().v1();
    data.putIfAbsent("saved_id", () => uid);

    await FirebaseFirestore.instance
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('savedPosts')
        .doc(uid)
        .set(data);

    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Saved to your library')));
  }
}
