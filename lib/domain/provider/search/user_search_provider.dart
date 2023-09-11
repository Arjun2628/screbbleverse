import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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
}
