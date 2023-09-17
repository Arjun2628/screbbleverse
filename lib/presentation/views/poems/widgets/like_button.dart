import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scribbleverse/config/theams/colors.dart';

// class LikesButton extends StatelessWidget {
//   const LikesButton({
//     super.key,
//     required this.uid,
//   });

//   final String uid;

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<QuerySnapshot>(
//         stream: FirebaseFirestore.instance
//             .collection('poems')
//             .doc(uid)
//             .collection('likes')
//             .where('user_id', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
//             .snapshots(),
//         builder: (context, follow) {
//           if (!follow.hasData) {
//             return Center(
//                 child:
//                     CircularProgressIndicator()); // Show a loading indicator.
//           }
//           if (follow.hasError) {
//             return Text('Error: ${follow.error}');
//           }
//           final length = follow.data!.docs.length;
//           if (length == 0) {
//             return Icon(
//               Icons.favorite_border,
//               color: white,
//             );
//           } else {
//             return Icon(
//               Icons.favorite,
//               color: Colors.red,
//             );
//           }
//         });
//   }
// }