import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:scribbleverse/config/theams/fonts.dart';
import 'package:scribbleverse/presentation/views/books/screens/add_books.dart';

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
              'lib/data/datasources/local/images/istockphoto-1353780638-612x612.jpg',
              fit: BoxFit.cover,
            ),
          ),
          SafeArea(
            child: ListView(
              children: [
                // Row(
                //   children: [
                //     Expanded(child: Container()),
                //     Padding(
                //       padding: const EdgeInsets.only(right: 15, top: 15),
                //       child: GestureDetector(
                //         onTap: () async {
                //           Navigator.push(
                //               context,
                //               MaterialPageRoute(
                //                 builder: (context) => AddBooks(),
                //               ));
                //         },
                //         child: Container(
                //           height: 35,
                //           width: 90,
                //           decoration: BoxDecoration(
                //               borderRadius: BorderRadius.circular(20),
                //               color: white,
                //               boxShadow: [
                //                 BoxShadow(
                //                   color: Colors.grey
                //                       .withOpacity(0.2), // Shadow color
                //                   spreadRadius: 5, // How far the shadow spreads
                //                   blurRadius: 7, // Soften the shadow
                //                   offset: const Offset(
                //                       0, 3), // Offset in x and y directions
                //                 ),
                //               ]),
                //           child: const Padding(
                //             padding: EdgeInsets.only(left: 7),
                //             child: Center(
                //                 child: Text(
                //               'Done',
                //               style: TextStyle(fontSize: 17),
                //             )),
                //           ),
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
                Container(
                  height: 130,
                  width: double.infinity,
                  child: Row(
                    children: [
                      Flexible(
                        flex: 1,
                        child: Container(
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
                        child: Container(
                          height: double.infinity,
                          width: double.infinity,
                          // color: Colors.red,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 20, 20, 20),
                            child: Container(
                              height: double.infinity,
                              width: double.infinity,
                              // color: Colors.amber,
                              decoration: BoxDecoration(
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
                BooksCategory(),
                BooksCategory(),
                BooksCategory(),
                BooksCategory(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class BooksCategory extends StatelessWidget {
  const BooksCategory({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Container(
            height: 30,
            width: double.infinity,
            child: Text(
              'Trending',
              style: buttonText,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Container(
            height: 130,
            width: double.infinity,
            // color: Colors.lightBlue,
            child: Expanded(
              child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('epub_files')
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
                        return Row(
                          children: [
                            Container(
                              height: double.infinity,
                              width: 100,
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(5)),
                            ),
                            SizedBox(
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
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
