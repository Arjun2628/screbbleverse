import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:scribbleverse/config/theams/colors.dart';
import 'package:scribbleverse/config/theams/fonts.dart';
import 'package:scribbleverse/domain/models/user_moder.dart';
import 'package:scribbleverse/presentation/views/profile/screens/view_other_user_profile.dart';

class PoemCard extends StatelessWidget {
  const PoemCard({
    super.key,
    required this.data,
  });

  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                color: black,
                // image: DecorationImage(
                //     fit: BoxFit.cover,
                //     opacity: 0.8,
                //     image: AssetImage(
                //         'lib/data/datasources/local/images/Screenshot (81).png')),
                border: Border.all(width: 0.5, color: Colors.grey.shade100),
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    topLeft: Radius.circular(15))),
            child: ListTile(
              leading: Padding(
                padding: const EdgeInsets.only(right: 10),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(data['user_profile_image']),
                ),
              ),
              title: Text(
                "${data['user_name']} added a new Poem",
                style: buttonText,
              ),
              subtitle: GestureDetector(
                onTap: () async {
                  final document = await FirebaseFirestore.instance
                      .collection('users')
                      .doc(data['t9089loY9fav9dnRXNuUgZgSC2Z2'])
                      .get();
                  final userData = document.data() as Map<String, dynamic>;
                  UserModel user = UserModel.fromJson(userData!);
                  // ignore: use_build_context_synchronously
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ViewOtherProfile(user: user),
                      ));
                },
                child: Text(
                  "@${data['user_name']}",
                  style: normal,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Container(
              decoration: const BoxDecoration(
                color: black,

                // border: Border.all(width: 0.5, color: Colors.grey.shade300),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    topLeft: Radius.circular(15)),
              ),
              child: Card(
                child: Container(
                  // color: Colors.green,
                  decoration: const BoxDecoration(color: black
                      // border: Border.all(width: 1),
                      // borderRadius:
                      //     BorderRadius.only(bottomLeft: Radius.circular(15))
                      ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text(
                              data['heading'],
                              style: buttonText,
                            ),
                            Text(
                              data['caption'],
                              style: normal,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
