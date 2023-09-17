import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scribbleverse/config/theams/colors.dart';
import 'package:scribbleverse/config/theams/fonts.dart';
import 'package:scribbleverse/domain/provider/poems/poems_provider.dart';
import 'package:scribbleverse/domain/provider/profile/add_profile_provider.dart';
import 'package:scribbleverse/domain/provider/public/public_provider.dart';
import 'package:scribbleverse/presentation/views/authentication/screens/login_screen.dart';
import 'package:scribbleverse/presentation/views/daily_quotes/screens/add_daily_quotes.dart';
import 'package:scribbleverse/presentation/views/profile/screens/view_connections.dart';
import 'package:scribbleverse/presentation/views/search/widgets/follow_button.dart';
import 'package:scribbleverse/presentation/widgets/skeleton_widgets/profile/posts_skeleton.dart';

class ViewProfile extends StatelessWidget {
  const ViewProfile({super.key});

  static const String routName = '/view_profile';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ColorFiltered(
          colorFilter: backgroundFilter,
          child: Container(
            height: 310,
            width: double.infinity,
            decoration: const BoxDecoration(
                // color: Colors.amber,
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(
                        'lib/data/datasources/local/images/BG58-01.jpg'))),
            child: SafeArea(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                      child: SizedBox(
                        height: 100,
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Column(
                                children: [
                                  Consumer<PublicProvider>(
                                    builder: (context, value, child) => Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: GestureDetector(
                                        onTap: () {
                                          Scaffold.of(context).openDrawer();
                                        },
                                        child: CircleAvatar(
                                          radius: 45,
                                          backgroundImage: NetworkImage(
                                              value.user!.profileImage!),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              child: SizedBox(
                                height: 100,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 40),
                                  child: Consumer<PublicProvider>(
                                    builder: (context, user, child) => Row(
                                      children: [
                                        Flexible(
                                            flex: 1,
                                            child: SizedBox(
                                              height: double.infinity,
                                              width: double.infinity,
                                              child: Center(
                                                child: Column(
                                                  children: [
                                                    PoemCount(
                                                        uid: user.user!.uid!,
                                                        style: normal),
                                                    Text(
                                                      'Post',
                                                      style: normal,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )),
                                        Flexible(
                                          flex: 1,
                                          child: SizedBox(
                                            height: double.infinity,
                                            width: double.infinity,
                                            child: Center(
                                              child: GestureDetector(
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            ViewFollowers(
                                                                uid: FirebaseAuth
                                                                    .instance
                                                                    .currentUser!
                                                                    .uid,
                                                                colloctionName:
                                                                    "following"),
                                                      ));
                                                },
                                                child: Column(
                                                  children: [
                                                    FollowersFollowingCount(
                                                      uid: user.user!.uid!,
                                                      style: normal,
                                                      type: "following",
                                                    ),
                                                    Text(
                                                      'Following',
                                                      style: normal,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Flexible(
                                          flex: 1,
                                          child: SizedBox(
                                            height: double.infinity,
                                            width: double.infinity,
                                            child: Center(
                                              child: GestureDetector(
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            ViewFollowers(
                                                                uid: FirebaseAuth
                                                                    .instance
                                                                    .currentUser!
                                                                    .uid,
                                                                colloctionName:
                                                                    "followers"),
                                                      ));
                                                },
                                                child: Column(
                                                  children: [
                                                    FollowersFollowingCount(
                                                      uid: user.user!.uid!,
                                                      style: normal,
                                                      type: "followers",
                                                    ),
                                                    Text(
                                                      'Followers',
                                                      style: normal,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                    child: SizedBox(
                      height: 140,
                      width: double.infinity,
                      child: Row(
                        children: [
                          Flexible(
                            flex: 4,
                            child: SizedBox(
                              height: double.infinity,
                              width: double.infinity,
                              child: Column(
                                children: [
                                  Consumer<PublicProvider>(
                                    builder: (context, value, child) => Padding(
                                      padding: value.user!.userName!.length <= 5
                                          ? const EdgeInsets.only(left: 25)
                                          : value.user!.userName!.length > 5 &&
                                                  value.user!.userName!
                                                          .length <=
                                                      7
                                              ? const EdgeInsets.only(left: 20)
                                              : const EdgeInsets.only(left: 8),
                                      child: Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          value.user!.userName!,
                                          style: buttontextProfile,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Consumer<PublicProvider>(
                                    builder: (context, value, child) => Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            value.user!.about!,
                                            style: normal,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Row(
                                      children: [
                                        Flexible(
                                            flex: 1,
                                            child: Consumer<PublicProvider>(
                                              builder:
                                                  (context, value, child) =>
                                                      Padding(
                                                padding:
                                                    const EdgeInsets.all(3.0),
                                                child: GestureDetector(
                                                  onTap: () async {
                                                    await Provider.of<
                                                                AddProfileProvider>(
                                                            context,
                                                            listen: false)
                                                        .setEditUser(
                                                            value.user!);
                                                    // ignore: use_build_context_synchronously
                                                    Navigator.pushNamed(context,
                                                        '/edit_profile');
                                                  },
                                                  child: Container(
                                                    width: double.infinity,
                                                    height: 30,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        color: Colors.blue),
                                                    child: Center(
                                                      child: Text(
                                                        'Edit Profile',
                                                        style: normal,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )),
                                        Flexible(
                                            flex: 1,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(3.0),
                                              child: Container(
                                                width: double.infinity,
                                                height: 30,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color: Colors.blue),
                                                child: Center(
                                                  child: Text(
                                                    'Activities',
                                                    style: normal,
                                                  ),
                                                ),
                                              ),
                                            )),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Flexible(
                              flex: 3,
                              child: Padding(
                                padding: const EdgeInsets.all(30.0),
                                child: GestureDetector(
                                  onTap: () async {
                                    // await FirebaseAuth.instance.signOut();
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              AddDailyQuotes(),
                                        ),
                                        (route) => false);
                                  },
                                  child: SizedBox(
                                    height: double.infinity,
                                    width: double.infinity,
                                    child: Image.asset(
                                        'lib/data/datasources/local/images/miscellaneous-rectangle-pin.png'),
                                  ),
                                ),
                              ))
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Container(
          height: 40,
          width: double.infinity,
          color: Colors.grey.shade200,
          child: Row(
            children: [
              Flexible(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.black,
                    ),
                    child: Center(
                      child: Text(
                        'All',
                        style: normal,
                      ),
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.brown,
                    ),
                    child: Center(
                      child: Text(
                        'Poems',
                        style: normal,
                      ),
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.brown,
                    ),
                    child: Center(
                      child: Text(
                        'Short Stories',
                        style: normal,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        ViewPosts(
          uid: FirebaseAuth.instance.currentUser!.uid,
        )
      ],
    );
  }
}

class ViewPosts extends StatelessWidget {
  const ViewPosts({
    super.key,
    required this.uid,
  });

  final String uid;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('poems')
                .where("user_id", isEqualTo: uid)
                .snapshots(),
            builder: (context, snapshot1) {
              if (snapshot1.hasError) {
                return Text('Error: ${snapshot1.error}');
              }
              if (snapshot1.connectionState == ConnectionState.waiting) {
                return PoestsSkeleton(); // Loading indicator
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
                    return CircularProgressIndicator(); // Loading indicator
                  }

                  // Process data from collection2
                  final data2 = snapshot2.data!.docs;

                  // Combine and sort the data based on the timestamp field
                  final combinedData = [...data1, ...data2];
                  combinedData.sort((a, b) {
                    final timestampA = a['time'] as Timestamp;
                    final timestampB = b['time'] as Timestamp;
                    return timestampA.compareTo(timestampB);
                  });

                  //  final  combinedData.reversed;

                  // Now, you have sorted data in `combinedData`
                  // You can build your UI using this data
                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10),
                    itemCount: combinedData.length,
                    itemBuilder: (context, index) {
                      final document = combinedData[index];
                      final data = document.data() as Map<String, dynamic>;
                      return data['type'] == 'poem'
                          ? Stack(
                              fit: StackFit.expand,
                              children: [
                                Consumer<AddPoemProvider>(
                                  builder: (context, value, child) =>
                                      ColorFiltered(
                                    colorFilter: backgroundFilter,
                                    child: Image.asset(
                                      value
                                          .templateList[data['template_index']],
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Consumer<AddPoemProvider>(
                                  builder: (context, value, child) => Container(
                                    height: 90,
                                    width: double.infinity,
                                  ),
                                ),
                                Center(
                                    child: Text(
                                  data['heading'],
                                  style: buttonTextBlack,
                                ))
                              ],
                            )
                          : Container(
                              height: 90,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image:
                                          NetworkImage(data['cover_photo']))),
                            );
                    },
                  );
                },
              );
            }),
      ),
    ));
  }
}
