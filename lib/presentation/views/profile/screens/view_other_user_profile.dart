import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scribbleverse/config/theams/colors.dart';
import 'package:scribbleverse/config/theams/fonts.dart';
import 'package:scribbleverse/domain/models/user_moder.dart';

import 'package:scribbleverse/domain/provider/public/public_provider.dart';
import 'package:scribbleverse/domain/provider/search/user_search_provider.dart';

import 'package:scribbleverse/presentation/views/profile/screens/view_connections.dart';

import 'package:scribbleverse/presentation/views/profile/widgets/view_posts.dart';

import 'package:scribbleverse/presentation/views/search/widgets/follow_button.dart';

class ViewOtherProfile extends StatelessWidget {
  const ViewOtherProfile({super.key, required this.user});
  final UserModel user;
  // static const String routName = '/view_profile';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ColorFiltered(
            colorFilter: backgroundFilter,
            child: Container(
              height: 310,
              width: double.infinity,
              // color: Colors.amber,
              decoration: const BoxDecoration(
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
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: CircleAvatar(
                                        radius: 45,
                                        backgroundImage:
                                            NetworkImage(user.profileImage!),
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
                                    child: Row(
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
                                                        uid: user.uid!,
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
                                                                uid: user.uid!,
                                                                colloctionName:
                                                                    "following"),
                                                      ));
                                                },
                                                child: Column(
                                                  children: [
                                                    FollowersFollowingCount(
                                                      uid: user.uid!,
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
                                                                uid: user.uid!,
                                                                colloctionName:
                                                                    "followers"),
                                                      ));
                                                },
                                                child: Column(
                                                  children: [
                                                    FollowersFollowingCount(
                                                      uid: user.uid!,
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
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 15),
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
                                    Padding(
                                      padding: user.userName!.length <= 5
                                          ? const EdgeInsets.only(left: 25)
                                          : user.userName!.length > 5 &&
                                                  user.userName!.length <= 7
                                              ? const EdgeInsets.only(left: 20)
                                              : const EdgeInsets.only(left: 8),
                                      child: Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          user.userName!,
                                          style: buttontextProfile,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            user.about!,
                                            style: normal,
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
                                                                  UserSearchProvider>(
                                                              context,
                                                              listen: false)
                                                          .addFollowes(
                                                              user.uid!, user);
                                                    },
                                                    child: Container(
                                                      width: double.infinity,
                                                      height: 30,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          color: Colors.blue),
                                                      child: Align(
                                                        alignment:
                                                            Alignment.center,
                                                        child: FollowButton(
                                                            uid: user.uid!,
                                                            style: normal),
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
                                    onTap: () async {},
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
          ViewPosts(uid: user.uid!)
        ],
      ),
    );
  }
}
