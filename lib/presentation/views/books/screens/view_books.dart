import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scribbleverse/config/theams/fonts.dart';
import 'package:scribbleverse/domain/provider/books/screens/add_book_provider.dart';
import 'package:scribbleverse/domain/provider/books/screens/view_books.dart';

import '../../../../config/theams/colors.dart';

class ViewBooks extends StatelessWidget {
  const ViewBooks({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            child: ListView(
              children: [
                SizedBox(
                  height: 130,
                  width: double.infinity,
                  child: Row(
                    children: [
                      Flexible(
                        flex: 1,
                        child: SizedBox(
                          height: double.infinity,
                          width: double.infinity,
                          child: Center(
                            child: Text(
                              'Library',
                              style: buttonTextHeading,
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: SizedBox(
                          height: double.infinity,
                          width: double.infinity,
                          // color: Colors.red,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 20, 20, 20),
                            child: Container(
                              height: double.infinity,
                              width: double.infinity,
                              // color: Colors.amber,
                              decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'lib/data/datasources/local/images/[removal.ai]_9f970741-cd23-4c84-bc36-927ff50c9b24-images.png'))),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                BooksCategory(heading: 'Trending'),
                BooksCategory(heading: 'Trending'),
                BooksCategory(heading: 'Trending'),
                BooksCategory(heading: 'Trending'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class BooksCategory extends StatelessWidget {
  BooksCategory({
    super.key,
    required this.heading,
  });
  String heading;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15),
          child: SizedBox(
            height: 30,
            width: double.infinity,
            child: Text(
              heading,
              style: buttonText,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15),
          child: SizedBox(
            height: 130,
            width: double.infinity,
            // color: Colors.lightBlue,
            child: Expanded(
              child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('books')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }

                    if (!snapshot.hasData) {
                      return const Center(child: Text('No data available.'));
                    }
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        final document = snapshot.data!.docs[index];
                        final data = document.data() as Map<String, dynamic>;
                        return Row(
                          children: [
                            Stack(
                              children: [
                                GestureDetector(
                                  onTap: () async {
                                    await Provider.of<AddBooksProvider>(context,
                                            listen: false)
                                        .getEpubFileFromFirebaseAsUnit8List(
                                            data['book']);
                                    // ignore: use_build_context_synchronously
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              MyApp1(eUrl: ''),
                                        ));
                                  },
                                  child: Container(
                                    height: double.infinity,
                                    width: 100,
                                    decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Image.network(
                                      Provider.of<AddBooksProvider>(context,
                                              listen: false)
                                          .coverUri[index],
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 5,
                            )
                          ],
                        );
                      },
                    );
                  }),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
