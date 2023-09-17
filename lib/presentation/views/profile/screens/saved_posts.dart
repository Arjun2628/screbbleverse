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
          child: Icon(
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
            child: Container(
              height: double.infinity,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
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
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return PoestsSkeleton(); // Loading indicator
                        }

                        // Process data from collection1

                        return GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10),
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            final document = snapshot.data!.docs[index];
                            final data =
                                document.data() as Map<String, dynamic>;
                            return data['type'] == 'poem'
                                ? Stack(
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
                                  )
                                : Container(
                                    height: 90,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                                data['cover_photo']))),
                                  );
                          },
                        );
                      }),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
