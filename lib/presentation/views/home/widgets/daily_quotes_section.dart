import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scribbleverse/config/theams/colors.dart';
import 'package:scribbleverse/domain/provider/daily_quotes/daily_quotes_provider.dart';
import 'package:scribbleverse/presentation/views/daily_quotes/screens/view_daily_quotes.dart';
import 'package:scribbleverse/presentation/widgets/skeleton_widgets/home/daily_quotes_skeleton.dart';

class DailyQuotesSection extends StatelessWidget {
  const DailyQuotesSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
          height: 120,
          color: black,
          width: double.infinity,
          child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('daily_quotes')
                  .orderBy("time", descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const DailyQuotesSkeleton(); // Loading indicator
                }
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final document = snapshot.data!.docs[index];
                    final data = document.data() as Map<String, dynamic>;
                    return Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 25, 2, 20),
                          child: SizedBox(
                            height: double.infinity,
                            width: 80,
                            // color: Colors.amber,
                            child: StreamBuilder<QuerySnapshot>(
                                stream: FirebaseFirestore.instance
                                    .collection('daily_quotes')
                                    .doc(data['user_id'])
                                    .collection('views')
                                    .where('user_id',
                                        isEqualTo: FirebaseAuth
                                            .instance.currentUser!.uid)
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData) {
                                    return Expanded(
                                        child: Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: white, // Set the border color
                                          width: 2, // Set the border width
                                        ),
                                      ),
                                      child: GestureDetector(
                                        onTap: () async {
                                          await Provider.of<
                                                      AddDailyQuotesProvider>(
                                                  context,
                                                  listen: false)
                                              .checkView(data['user_id']);
                                          // ignore: use_build_context_synchronously
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    ViewDailyQuotes(data: data),
                                              ));
                                        },
                                        child: CircleAvatar(
                                          backgroundColor: black,
                                          backgroundImage: NetworkImage(
                                              data['user_profile_image']),
                                        ),
                                      ),
                                    ));
                                  }
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Expanded(
                                        child: Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: white, // Set the border color
                                          width: 2, // Set the border width
                                        ),
                                      ),
                                      child: GestureDetector(
                                        onTap: () async {
                                          await Provider.of<
                                                      AddDailyQuotesProvider>(
                                                  context,
                                                  listen: false)
                                              .checkView(data['user_id']);
                                          // ignore: use_build_context_synchronously
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    ViewDailyQuotes(data: data),
                                              ));
                                        },
                                        child: CircleAvatar(
                                          backgroundColor: black,
                                          backgroundImage: NetworkImage(
                                              data['user_profile_image']),
                                        ),
                                      ),
                                    ));
                                  }

                                  final length = snapshot.data!.docs.length;
                                  Color? color;
                                  if (length == 0) {
                                    color = const Color.fromARGB(
                                        255, 230, 229, 229);
                                  } else {
                                    color = Colors.grey;
                                  }
                                  return Expanded(
                                      child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: color, // Set the border color
                                        width: 2, // Set the border width
                                      ),
                                    ),
                                    child: GestureDetector(
                                      onTap: () async {
                                        await Provider.of<
                                                    AddDailyQuotesProvider>(
                                                context,
                                                listen: false)
                                            .checkView(data['user_id']);
                                        // ignore: use_build_context_synchronously
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  ViewDailyQuotes(data: data),
                                            ));
                                      },
                                      child: CircleAvatar(
                                        backgroundColor: black,
                                        backgroundImage: NetworkImage(
                                            data['user_profile_image']),
                                      ),
                                    ),
                                  ));
                                }),
                          ),
                        ),
                      ],
                    );
                  },
                );
              })),
    );
  }
}
