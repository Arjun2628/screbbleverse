import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scribbleverse/config/theams/colors.dart';
import 'package:scribbleverse/config/theams/fonts.dart';
import 'package:scribbleverse/domain/provider/poems/poems_provider.dart';
import 'package:scribbleverse/presentation/widgets/skeleton_widgets/profile/posts_skeleton.dart';

class ViewSavedPosts extends StatelessWidget {
  const ViewSavedPosts({
    super.key,
    required this.uid,
  });

  final String uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: black,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back,
            color: white,
          ),
        ),
        title: Text(
          'Saved Posts',
          style: buttonText,
        ),
      ),
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
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('users')
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .collection('savedPosts')
                        .orderBy('time')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const PoestsSkeleton(); // Loading indicator
                      }

                      // Process data from collection1

                      return GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10),
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          final document = snapshot.data!.docs[index];
                          final data = document.data() as Map<String, dynamic>;
                          return data['type'] == 'poem'
                              ? GestureDetector(
                                  onLongPress: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Text(
                                            "Do you realy want to remove this post from library??",
                                            style: normalBlack,
                                          ),
                                          actions: [
                                            ElevatedButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: const Text('cancel')),
                                            ElevatedButton(
                                                onPressed: () async {
                                                  Provider.of<AddPoemProvider>(
                                                          context,
                                                          listen: false)
                                                      .deletePoem(
                                                          data['saved_id']);
                                                  Navigator.pop(context);
                                                },
                                                child: const Text('delete')),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  child: Stack(
                                    fit: StackFit.expand,
                                    children: [
                                      Consumer<AddPoemProvider>(
                                        builder: (context, value, child) =>
                                            ColorFiltered(
                                          colorFilter: backgroundFilter,
                                          child: Image.asset(
                                            value.templateList[
                                                data['template_index']],
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Consumer<AddPoemProvider>(
                                        builder: (context, value, child) =>
                                            // ignore: sized_box_for_whitespace
                                            Container(
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
                                  ),
                                )
                              : GestureDetector(
                                  onLongPress: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Text(
                                            "Do you realy want to remove this post from library??",
                                            style: normalBlack,
                                          ),
                                          actions: [
                                            ElevatedButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: const Text('cancel')),
                                            ElevatedButton(
                                                onPressed: () async {
                                                  Provider.of<AddPoemProvider>(
                                                          context,
                                                          listen: false)
                                                      .deletePoem(
                                                          data['saved_id']);
                                                  Navigator.pop(context);
                                                },
                                                child: const Text('delete')),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  child: Container(
                                    height: 90,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                                data['cover_photo']))),
                                  ),
                                );
                        },
                      );
                    }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
