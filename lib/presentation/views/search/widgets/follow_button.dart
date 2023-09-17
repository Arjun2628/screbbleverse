import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scribbleverse/presentation/widgets/skeleton_widgets/profile/connections_count.dart';

class FollowButton extends StatelessWidget {
  const FollowButton({
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
            .collection('users')
            .doc(uid)
            .collection('followers')
            .where("uid", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
            .snapshots(),
        builder: (context, follow) {
          if (!follow.hasData) {
            return Center(
                child:
                    CircularProgressIndicator()); // Show a loading indicator.
          }
          if (follow.hasError) {
            return Text('Error: ${follow.error}');
          }
          final length = follow.data!.docs.length;
          return length == 1
              ? Text(
                  'Following',
                  style: style,
                )
              : Text(
                  'Follow',
                  style: style,
                );
        });
  }
}

class FollowersFollowingCount extends StatelessWidget {
  const FollowersFollowingCount({
    super.key,
    required this.uid,
    required this.style,
    required this.type,
  });

  final String uid;
  final TextStyle style;
  final String type;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .collection(type)
            .where("uid", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
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

class PoemCount extends StatelessWidget {
  const PoemCount({
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
            .where("user_id", isEqualTo: uid)
            .snapshots(),
        builder: (context, snapshot1) {
          if (snapshot1.hasError) {
            return Text('Error: ${snapshot1.error}');
          }
          if (snapshot1.connectionState == ConnectionState.waiting) {
            return const connectionCountSkelton(); // Loading indicator
          }

          // Process data from collection1
          final data1 = snapshot1.data!.docs;

          return StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('short_stories')
                  .where("user_id", isEqualTo: uid)
                  .snapshots(),
              builder: (context, snapshot2) {
                if (snapshot2.hasError) {
                  return Text('Error: ${snapshot2.error}');
                }
                if (snapshot2.connectionState == ConnectionState.waiting) {
                  return connectionCountSkelton(); // Loading indicator
                }

                // Process data from collection2
                final data2 = snapshot2.data!.docs;

                // Combine and sort the data based on the timestamp field
                final combinedData = [...data1, ...data2];
                final length = combinedData.length;
                return Text(
                  length.toString(),
                  style: style,
                );
              });
        });
  }
}

// class MutualConnections extends StatelessWidget {
//   const MutualConnections({
//     super.key,
//     required this.uid,
//     required this.style,
//     required this.type,
//   });

//   final String uid;
//   final TextStyle style;
//   final String type;

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<QuerySnapshot>(
//         stream: FirebaseFirestore.instance.collection('poems').snapshots(),
//         builder: (context, snapshot1) {
//           if (snapshot1.hasError) {
//             return Text('Error: ${snapshot1.error}');
//           }
//           if (snapshot1.connectionState == ConnectionState.waiting) {
//             return CircularProgressIndicator(); // Loading indicator
//           }

//           // Process data from collection1
//           final data1 = snapshot1.data!.docs;

//           return StreamBuilder<QuerySnapshot>(
//             stream: FirebaseFirestore.instance
//                 .collection('short_stories')
//                 .snapshots(),
//             builder: (context, snapshot2) {
//               if (snapshot2.hasError) {
//                 return Text('Error: ${snapshot2.error}');
//               }
//               if (snapshot2.connectionState == ConnectionState.waiting) {
//                 return CircularProgressIndicator(); // Loading indicator
//               }

//               // Process data from collection2
//               final data2 = snapshot2.data!.docs;

//               // Combine and sort the data based on the timestamp field
//               final combinedData = [...data1, ...data2];
//               // combinedData.sort((a, b) {
//               //   final timestampA = a['time'] as Timestamp;
//               //   final timestampB = b['time'] as Timestamp;
//               //   return timestampA.compareTo(timestampB);
//               // });

//               //  final  combinedData.reversed;

//               // Now, you have sorted data in `combinedData`
//               // You can build your UI using this data
//               return 
             
//             },
//           );
//         });
//   }
// }
