import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scribbleverse/config/theams/colors.dart';
import 'package:scribbleverse/config/theams/fonts.dart';
import 'package:scribbleverse/domain/provider/profile/add_profile_provider.dart';
import 'package:scribbleverse/domain/provider/public/public_provider.dart';

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
            // color: Colors.amber,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(
                        'lib/data/datasources/local/images/istockphoto-1353780638-612x612.jpg'))),
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
                                      child: CircleAvatar(
                                        radius: 45,
                                        backgroundImage: NetworkImage(
                                            value.user!.profileImage!),
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
                                                    Text(
                                                      user.numberOfPosts
                                                          .toString(),
                                                      style: buttonText,
                                                    ),
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
                                              child: Column(
                                                children: [
                                                  Text(
                                                    '0',
                                                    style: buttonText,
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
                                        Flexible(
                                          flex: 1,
                                          child: SizedBox(
                                            height: double.infinity,
                                            width: double.infinity,
                                            child: Center(
                                              child: Column(
                                                children: [
                                                  Text(
                                                    '0',
                                                    style: buttonText,
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
                                child: SizedBox(
                                  height: double.infinity,
                                  width: double.infinity,
                                  child: Image.asset(
                                      'lib/data/datasources/local/images/miscellaneous-rectangle-pin.png'),
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
        )
      ],
    );
  }
}
