import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scribbleverse/config/theams/colors.dart';
import 'package:scribbleverse/config/theams/fonts.dart';
import 'package:scribbleverse/domain/models/user_moder.dart';
import 'package:scribbleverse/domain/provider/public/public_provider.dart';
import 'package:scribbleverse/domain/provider/search/user_search_provider.dart';
import 'package:scribbleverse/presentation/views/profile/screens/view_other_user_profile.dart';

import 'package:scribbleverse/presentation/views/search/widgets/follow_button.dart';

class ViewFollowers extends StatelessWidget {
  const ViewFollowers(
      {super.key, required this.uid, required this.colloctionName});

  final String uid;
  final String colloctionName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
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
          SafeArea(
            child: SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .doc(uid)
                    .collection(colloctionName)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                        child:
                            CircularProgressIndicator()); // Show a loading indicator.
                  }
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }

                  // Process the data from the Firestore collection.
                  final data = snapshot.data!.docs;

                  return ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      final document = snapshot.data!.docs[index];
                      final data = document.data() as Map<String, dynamic>;
                      return Card(
                        color: Colors.grey.withOpacity(0.5),
                        child: ListTile(
                            leading: CircleAvatar(
                              backgroundImage:
                                  NetworkImage(data['profile_image']),
                            ),
                            title: Text(
                              data['userName'],
                              style: buttonText,
                            ),
                            trailing: Consumer<PublicProvider>(
                              builder: (context, user, child) => ElevatedButton(
                                onPressed: () async {
                                  await Provider.of<UserSearchProvider>(context,
                                          listen: false)
                                      .addFollowes(uid, user.user!);
                                },
                                child:
                                    FollowButton(uid: uid, style: normalBlack),

                                //   // Implement action when a search result is tapped.
                                // ),
                              ),
                            )),
                      );
                    },
                  );
                  //  ListTile(
                  //   title: Text(
                  //     'data',
                  //     style: buttonText,
                  //   ),
                  // );
                  // YourSearchWidget(
                  //     data); // Replace with your search widget.
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FollowerWidget extends StatefulWidget {
  final List<QueryDocumentSnapshot> data;

  const FollowerWidget(this.data, {super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ViewFollowerWidgetState createState() => _ViewFollowerWidgetState();
}

class _ViewFollowerWidgetState extends State<FollowerWidget> {
  String query = ''; // User input

  List<QueryDocumentSnapshot> get filteredData {
    // Filter the data based on the user input (query).
    return widget.data.where((doc) {
      final title =
          doc['userName'] as String; // Adjust this to your data structure.
      return title.toLowerCase().contains(query.toLowerCase());
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          onChanged: (value) {
            setState(() {
              query = value; // Update the query as the user types.
            });
          },
          decoration: InputDecoration(
            hintText: 'Search...',
            filled: true,
            fillColor: white,
            border: OutlineInputBorder(
                borderSide: const BorderSide(width: 1),
                borderRadius: BorderRadius.circular(20)),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: filteredData.length,
            itemBuilder: (context, index) {
              final userName = filteredData[index]['userName'] as String;
              final profileImage =
                  filteredData[index]['profileImage'] as String;
              final dateOfBirth = filteredData[index]['dateOfBirth'] as String;
              filteredData[index]['profileImage'] as String;
              final uid = filteredData[index]['uid'] as String;
              final document = filteredData[index];
              final data = document.data() as Map<String, dynamic>;

              return GestureDetector(
                onTap: () {
                  UserModel userModel = UserModel.fromJson(data);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ViewOtherProfile(user: userModel),
                      ));
                },
                child: Card(
                    color: Colors.grey.withOpacity(0.5),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(profileImage),
                      ),
                      title: Text(
                        userName,
                        style: buttonText,
                      ),
                      trailing: Consumer<PublicProvider>(
                        builder: (context, user, child) => ElevatedButton(
                          onPressed: () async {
                            Provider.of<UserSearchProvider>(context,
                                    listen: false)
                                .addFollowes(uid, user.user!);
                          },
                          child: FollowButton(uid: uid, style: normalBlack),

                          // Implement action when a search result is tapped.
                        ),
                      ),
                    )),
              );
            },
          ),
        ),
      ],
    );
  }
}
