import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scribbleverse/config/theams/fonts.dart';

import '../../../config/theams/colors.dart';

class Page4 extends StatelessWidget {
  const Page4({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        ColorFiltered(
          colorFilter: backgroundFilter,
          child: Image.asset(
            'lib/data/datasources/local/images/BG58-01.jpg',
            fit: BoxFit.cover,
          ),
        ),
        NotificationWidget(),
      ],
    );
  }

  // Stream<Map<String, dynamic>> getCombinedStream(){
  //   return  Rx.merge([getCommentsStream(), getLikesStream()])
  //       .map((notification) {
  //     final timestamp =
  //         notification['timestamp']; // Replace with your timestamp field
  //     return {'timestamp': timestamp, ...notification};
  //   });
  // }

  // Stream<Map<String, dynamic>> getSortedCombinedStream() {
  //   return getCombinedStream().orderBy((a, b) {
  //     final timestampA = a['timestamp'] ?? 0;
  //     final timestampB = b['timestamp'] ?? 0;
  //     return timestampB.compareTo(timestampA);
  //   });
  // }
}

// ignore: use_key_in_widget_constructors
class NotificationWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 80,
          width: double.infinity,
          color: Colors.black,
          child: SafeArea(
            child: Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 5),
                  child: Icon(
                    Icons.arrow_back,
                    color: white,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Text(
                    'Notifications',
                    style: buttontextProfile,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 5),
                  child: Icon(
                    Icons.notifications_active_rounded,
                    color: white,
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .collection('notifications')
                .orderBy('timestamp', descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final document = snapshot.data!.docs[index];
                    final data = document.data() as Map<String, dynamic>;
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                                color: black,
                                border: Border.all(width: 1, color: white),
                                borderRadius: BorderRadius.circular(15)),
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundImage:
                                    NetworkImage(data['user_profile']),
                              ),
                              title: data['type'] == 'comment'
                                  ? Column(
                                      children: [
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "${data['userName']} commented on your poem",
                                            style: normal,
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            '"${data['text']}"',
                                            style: normal,
                                            maxLines: 1,
                                          ),
                                        )
                                      ],
                                    )
                                  : Column(
                                      children: [
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "${data['userName']} liked on your poem",
                                            style: normal,
                                          ),
                                        ),
                                      ],
                                    ),
                            ),
                          ),
                        ),
                        // Divider()
                      ],
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ],
    );
  }
}
