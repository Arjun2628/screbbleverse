import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scribbleverse/config/theams/colors.dart';
import 'package:scribbleverse/domain/models/user_moder.dart';
import 'package:scribbleverse/domain/provider/public/public_provider.dart';

class PostWidget extends StatefulWidget {
  final DocumentSnapshot post;
  final User? currentUser;

  PostWidget({required this.post, required this.currentUser});

  @override
  _PostWidgetState createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  bool _isLiked = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // ListTile(
        //   title: Text(widget.post['title']),

        //   subtitle: Text(widget.post['content']),
        //   trailing: Row(
        //     mainAxisSize: MainAxisSize.min,
        //     children: [

        //       Text(widget.post['likes'].toString()), // Display like count
        //     ],
        //   ),
        // ),
        Consumer<PublicProvider>(
          builder: (context, value, child) => IconButton(
            icon: _isLiked
                ? Icon(Icons.favorite, color: Colors.red)
                : Icon(
                    Icons.favorite_border,
                    color: white,
                  ),
            onPressed: () {
              // Handle the like button click
              _handleLikeButton(value.user);
            },
          ),
        ),
      ],
    );
  }

  Future<void> _handleLikeButton(UserModel? user) async {
    if (widget.currentUser != null) {
      setState(() {
        _isLiked = !_isLiked; // Toggle the like status locally

        // Update the like status in Firestore
        FirebaseFirestore.instance
            .collection('poems')
            .doc(widget.post.id)
            .update({
          'likes':
              _isLiked ? FieldValue.increment(1) : FieldValue.increment(-1),
          'likedBy.${widget.currentUser!.uid}': _isLiked,
        });
      });
      Map<String, dynamic> data = {
        'userName': user!.userName,
        'profile': user.profileImage,
        'timestamp': FieldValue.serverTimestamp(),
        'user_id': FirebaseAuth.instance.currentUser!.uid
      };
      await FirebaseFirestore.instance
          .collection('poems/${widget.post.id}/likes')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set(data);
      await FirebaseFirestore.instance
          .collection('users')
          .doc(data['user_id'])
          .collection('notifications')
          .add({
        'timestamp': FieldValue.serverTimestamp(),
        'type': 'like',
        'userName':
            Provider.of<PublicProvider>(context, listen: false).user!.userName,
        'user_profile': Provider.of<PublicProvider>(context, listen: false)
            .user!
            .profileImage
      });
    } else {
      // Handle user authentication (e.g., show a login dialog)
    }
  }
}

// class PostWidget extends StatefulWidget {
//   final DocumentSnapshot post;
//   final User? currentUser;

//   PostWidget({required this.post, required this.currentUser});

//   @override
//   _PostWidgetState createState() => _PostWidgetState();
// }

// class _PostWidgetState extends State<PostWidget> {
//   bool _isLiked = false;
//   int _likeCount = 0;

//   @override
//   void initState() {
//     super.initState();
//     _likeCount = widget.post['likes'] ?? 0;
//     _isLiked =
//         widget.post['likedBy']?.containsKey(widget.currentUser?.uid) ?? false;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         IconButton(
//           icon: _isLiked
//               ? Icon(Icons.favorite, color: Colors.red)
//               : Icon(Icons.favorite_border),
//           onPressed: () {
//             // Handle the like button click
//             _handleLikeButton();
//           },
//         ),
//       ],
//     );
//   }

//   void _handleLikeButton() {
//     if (widget.currentUser != null) {
//       setState(() {
//         _isLiked = !_isLiked; // Toggle the like status locally

//         // Update the like status and count in Firestore
//         FirebaseFirestore.instance
//             .collection('posts')
//             .doc(widget.post.id)
//             .update({
//           'likes':
//               _isLiked ? FieldValue.increment(1) : FieldValue.increment(-1),
//           'likedBy.${widget.currentUser!.uid}': _isLiked,
//         });

//         // Update the like count locally
//         _likeCount += _isLiked ? 1 : -1;
//       });
//     } else {
//       // Handle user authentication (e.g., show a login dialog)
//     }
//   }
// }

// class PostWidget extends StatefulWidget {
//   final DocumentSnapshot post;
//   final User? currentUser;

//   PostWidget({required this.post, required this.currentUser});

//   @override
//   _PostWidgetState createState() => _PostWidgetState();
// }

// class _PostWidgetState extends State<PostWidget> {
//   bool _isLiked = false;
//   int _likeCount = 0;

//   @override
//   void initState() {
//     super.initState();
//     // Initialize _isLiked and _likeCount based on post data
//     _likeCount = widget.post['likes'] ?? 0;
//     _isLiked =
//         widget.post['likedBy']?.contains(widget.currentUser?.uid) ?? false;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         // ... (other post content)
//         Row(
//           children: [
//             GestureDetector(
//               onTap: () {
//                 // Handle the like button click
//                 _handleLikeButton();
//               },
//               child: Icon(
//                 _isLiked ? Icons.favorite : Icons.favorite_border,
//                 color: _isLiked ? Colors.red : Colors.grey,
//               ),
//             ),
//             Text(_likeCount.toString()), // Display like count
//           ],
//         ),
//         // ... (other post content)
//       ],
//     );
//   }

//   void _handleLikeButton() {
//     if (widget.currentUser != null) {
//       setState(() {
//         _isLiked = !_isLiked; // Toggle the like status locally

//         // Update the like status and count in Firestore
//         FirebaseFirestore.instance
//             .collection('poems')
//             .doc(widget.post.id)
//             .update({
//           'likes':
//               _isLiked ? FieldValue.increment(1) : FieldValue.increment(-1),
//         });

//         // Update the list of users who liked the post
//         if (_isLiked) {
//           FirebaseFirestore.instance
//               .collection('poems')
//               .doc(widget.post.id)
//               .update({
//             'likedBy': FieldValue.arrayUnion([widget.currentUser!.uid]),
//           });
//         } else {
//           FirebaseFirestore.instance
//               .collection('poems')
//               .doc(widget.post.id)
//               .update({
//             'likedBy': FieldValue.arrayRemove([widget.currentUser!.uid]),
//           });
//         }

//         // Update the like count locally
//         _likeCount = _isLiked ? _likeCount + 1 : _likeCount - 1;
//       });
//     } else {
//       // Handle user authentication (e.g., show a login dialog)
//     }
//   }
// }
