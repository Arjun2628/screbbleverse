import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class LikesCount extends StatelessWidget {
  const LikesCount({
    super.key,
    required this.uid,
    required this.style,
  });

  final String uid;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('daily_quotes')
            .doc(uid)
            .collection('likes')
            .snapshots(),
        builder: (context, follow) {
          if (!follow.hasData) {
            return const Center(
                child:
                    CircularProgressIndicator()); // Show a loading indicator.
          }
          if (follow.hasError) {
            return Text('Error: ${follow.error}');
          }
          final length = follow.data!.docs.length;
          return Text(
            length.toString(),
            style: style,
          );
        });
  }
}
