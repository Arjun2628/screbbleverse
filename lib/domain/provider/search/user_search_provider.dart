import 'dart:isolate';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scribbleverse/domain/models/user_moder.dart';

class UserSearchProvider extends ChangeNotifier {
  List<Map<String, dynamic>> userList = [];
  Future<void> getSuggestions(String query) async {
    final CollectionReference suggestionsRef =
        FirebaseFirestore.instance.collection('users');

    final QuerySnapshot result = await suggestionsRef
        .where('userName', isGreaterThanOrEqualTo: query)
        .get();

    for (int i = 0; i < result.docs.length; i++) {
      final document = result.docs[i];
      final data = document.data() as Map<String, dynamic>;
      userList.add(data);
    }
    notifyListeners();
  }

  addFollowes(String uid, UserModel user) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    Map<String, dynamic> data = {
      "profile_image": user.profileImage,
      "userName": user.userName,
      "uid": auth.currentUser!.uid
    };
    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('followers')
        .where("uid", isEqualTo: auth.currentUser!.uid)
        .get();
    if (snapshot.docs.isEmpty) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('followers')
          .doc(auth.currentUser!.uid)
          .set(data);
      await FirebaseFirestore.instance
          .collection('users')
          .doc(auth.currentUser!.uid)
          .collection('following')
          .doc(uid)
          .set(data);
    } else {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('followers')
          .doc(auth.currentUser!.uid)
          .delete();
      await FirebaseFirestore.instance
          .collection('users')
          .doc(auth.currentUser!.uid)
          .collection('following')
          .doc(uid)
          .delete();
    }
  }

  Future<void> isolateFunction(SendPort sendPort) async {
    final ReceivePort receivePort = ReceivePort();
    sendPort.send(receivePort.sendPort);

    receivePort.listen((dynamic message) async {
      if (message is Map<String, dynamic> &&
          message['action'] == 'deleteFollowing') {
        final String uid = message['uid'];
        await deleteFollowing(uid);
      }
    });
  }

  Future<void> deleteFollowing(String uid) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('following')
        .doc(uid)
        .delete();
  }

  Future<void> mutualConnection(String uid) async {
    List<DocumentSnapshot> friends = [];
    final connection = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('following')
        .get();
    final myConnection = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('following')
        .get();

    friends.addAll(connection.docs);
    friends.addAll(myConnection.docs);
  }

// Future<List<String>> getCommonUsers() async {
//   // Get the documents from the first collection.
//   final collection1 = FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).collection('following');
//   final docs1 = await collection1.get();

//   // Get the documents from the second collection.
//   final collection2 = FirebaseFirestore.instance.collection('users');
//   final docs2 = await collection2.get();

//   // Create a set to store the users from the first collection.
//   final set = Set<String>();

//   // Iterate through the documents from the second collection.
//   for (final doc in docs2) {
//     // If the user is in the set, add it to a list of common users.
//     if (set.contains(doc.id)) {
//       commonUsers.add(doc.id);
//     }
//   }

//   // Return the list of common users.
//   return commonUsers;
// }
}
