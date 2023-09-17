import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scribbleverse/config/theams/colors.dart';

class LikesButton extends StatelessWidget {
  const LikesButton({
    super.key,
    required this.uid,
    required this.baseCollection,
    required this.icon,
  });

  final String uid;
  final String baseCollection;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection(baseCollection)
            .doc(uid)
            .collection('likes')
            .where('user_id', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
            .snapshots(),
        builder: (context, follow) {
          if (!follow.hasData) {
            return icon; // Show a loading indicator.
          }
          if (follow.hasError) {
            return Text('Error: ${follow.error}');
          }
          if (follow.connectionState == ConnectionState.waiting) {
            return icon;
          }
          final length = follow.data!.docs.length;
          if (length == 0) {
            return icon;
          } else {
            return Icon(
              Icons.favorite,
              color: Colors.red,
            );
          }
        });
  }
}
