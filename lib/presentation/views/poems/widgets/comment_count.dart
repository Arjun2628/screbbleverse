import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CommentCount extends StatelessWidget {
  const CommentCount({
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
            .collection('poems')
            .doc(uid)
            .collection('comments')
            .snapshots(),
        builder: (context, comments) {
          if (!comments.hasData) {
            return Center(
                child:
                    CircularProgressIndicator()); // Show a loading indicator.
          }
          if (comments.hasError) {
            return Text('Error: ${comments.error}');
          }
          final commentLength = comments.data!.docs.length;
          return StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('poems')
                  .doc(uid)
                  .collection('replies')
                  .snapshots(),
              builder: (context, replies) {
                if (!replies.hasData) {
                  return Center(
                      child:
                          CircularProgressIndicator()); // Show a loading indicator.
                }
                if (replies.hasError) {
                  return Text('Error: ${replies.error}');
                }

                int replayLength = replies.data!.docs.length;
                int totalComments = commentLength + replayLength;

                return Text(
                  totalComments.toString(),
                  style: style,
                );
              });
        });
  }
}
