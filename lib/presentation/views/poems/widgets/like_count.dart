import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scribbleverse/presentation/widgets/skeleton_widgets/profile/connections_count.dart';

class PoemLikeCount extends StatelessWidget {
  const PoemLikeCount({
    super.key,
    required this.poemId,
    required this.style,
  });

  final String poemId;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('poems')
            .doc(poemId)
            .collection('likes')
            .snapshots(),
        builder: (context, follow) {
          if (!follow.hasData) {
            return Center(
                child: connectionCountSkelton()); // Show a loading indicator.
          }
          if (follow.hasError) {
            return Text('Error: ${follow.error}');
          }
          if (follow.connectionState == ConnectionState.waiting) {
            return connectionCountSkelton();
          }
          final length = follow.data!.docs.length;
          return Text(
            length.toString(),
            style: style,
          );
        });
  }
}
