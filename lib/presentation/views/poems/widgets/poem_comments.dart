import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scribbleverse/config/theams/fonts.dart';
import 'package:scribbleverse/domain/provider/poems/comments_provider.dart';
import 'package:scribbleverse/domain/provider/public/public_provider.dart';
import 'package:uuid/uuid.dart';

import '../../../../config/theams/colors.dart';

class PoemComments extends StatelessWidget {
  const PoemComments({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('comments'),
      ),
    );
  }
}

class PostScreen extends StatelessWidget {
  final DocumentSnapshot post;

  const PostScreen({super.key, required this.post, required this.data});

  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Comments')),
      body: Stack(
        fit: StackFit.expand,
        children: [
          ColorFiltered(
            colorFilter: backgroundFilter,
            child: Image.asset(
              'lib/data/datasources/local/images/BG58-01.jpg',
              fit: BoxFit.cover,
            ),
          ),
          ListView(
            children: [
              // Display the post content here
              // Text(post['content']),
              // Add a comment input field and button
              Consumer<CommentsProvider>(
                builder: (context, value, child) => Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TextField(
                          style: normal,
                          controller: value.commentController,
                          decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(width: 1, color: white),
                                  borderRadius: BorderRadius.circular(20)),
                              border: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(width: 1, color: white),
                                  borderRadius: BorderRadius.circular(20)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: const BorderSide(color: white)),
                              labelText: 'Add your comment',
                              labelStyle: buttonText),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: Consumer<PublicProvider>(
                        builder: (context, publicProvider, child) => IconButton(
                            onPressed: () async {
                              String uid = const Uuid().v1();
                              Map<String, dynamic> cmt = {
                                'text': value.commentController.text,
                                'timestamp': FieldValue.serverTimestamp(),
                                'uid': uid,
                                'user_profile':
                                    publicProvider.user!.profileImage
                              };
                              await FirebaseFirestore.instance
                                  .collection('poems/${post.id}/comments')
                                  .doc(uid)
                                  .set(cmt);
                              // await FirebaseFirestore.instance
                              //     .collection('users')
                              //     .doc(data['user_id'])
                              //     .collection('notifications')
                              //     .add({
                              //   'text': value.commentController.text,
                              //   'timestamp': FieldValue.serverTimestamp(),
                              //   'type': 'comment',
                              //   'userName': Provider.of<PublicProvider>(context,
                              //           listen: false)
                              //       .user!
                              //       .userName,
                              //   'user_profile':
                              //       publicProvider.user!.profileImage
                              // });
                            },
                            icon: const Icon(
                              Icons.send,
                              color: white,
                            )),
                      ),
                    )
                  ],
                ),
              ),
              // ElevatedButton(
              //   onPressed: () {
              //     // Add the comment to the Firebase Firestore
              //     FirebaseFirestore.instance
              //         .collection('posts/${post.id}/comments')
              //         .add({
              //       'text': 'User\'s comment',
              //       'timestamp': FieldValue.serverTimestamp(),
              //     });
              //   },
              //   child: Text('Add Comment'),
              // ),
              // Display the comments
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('poems/${post.id}/comments')
                    .orderBy('timestamp', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const CircularProgressIndicator();
                  }
                  return Column(
                    children: snapshot.data!.docs.map((commentDoc) {
                      DateTime commentTime = commentDoc['timestamp'].toDate();
                      DateTime currentDateTime = DateTime.now();
                      Duration difference =
                          currentDateTime.difference(commentTime);
                      String timeDifference =
                          Provider.of<CommentsProvider>(context, listen: false)
                              .commentDifference(difference);
                      return Column(
                        children: [
                          ListTile(
                            leading: CircleAvatar(
                              backgroundImage:
                                  NetworkImage(commentDoc['user_profile']),
                            ),
                            title: Text(
                              commentDoc['text'],
                              style: normal,
                            ),
                            subtitle: Text(
                              timeDifference,
                              style: normal,
                            ),
                            trailing: TextButton(
                              onPressed: () {
                                _showReplyDialog(context, commentDoc['uid']);
                              },
                              child: Text(
                                'Reply',
                                style: buttonText,
                              ),
                            ),
                          ),
                          // Display replies
                          StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('poems/${post.id}/replies')
                                .where("replay_id",
                                    isEqualTo: commentDoc['uid'])
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return const CircularProgressIndicator();
                              }
                              return Column(
                                children: snapshot.data!.docs.map((replyDoc) {
                                  return Padding(
                                    padding: const EdgeInsets.only(left: 50),
                                    child: ListTile(
                                      leading: CircleAvatar(
                                        backgroundImage: NetworkImage(
                                            replyDoc['user_profile']),
                                      ),
                                      title: Text(
                                        replyDoc['text'],
                                        style: normal,
                                      ),
                                    ),
                                  );
                                }).toList(),
                              );
                            },
                          ),
                        ],
                      );
                    }).toList(),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showReplyDialog(BuildContext context, String commentId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String replyText = '';

        return AlertDialog(
          title: const Text('Reply to Comment'),
          content: TextField(
            onChanged: (value) {
              replyText = value;
            },
            decoration: const InputDecoration(labelText: 'Enter your reply'),
          ),
          actions: [
            Consumer<PublicProvider>(
              builder: (context, value, child) => TextButton(
                onPressed: () async {
                  if (replyText.isNotEmpty) {
                    // Add the reply to Firestore
                    await FirebaseFirestore.instance
                        .collection('poems/${post.id}/replies')
                        .add({
                      'text': replyText,
                      'timestamp': FieldValue.serverTimestamp(),
                      'user_profile': value.user!.profileImage,
                      'replay_id': commentId
                    });
                    // ignore: use_build_context_synchronously
                    Navigator.pop(context);
                  }
                },
                child: const Text('Send'),
              ),
            ),
          ],
        );
      },
    );
  }
}
