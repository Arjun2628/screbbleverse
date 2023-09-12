import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:scribbleverse/config/theams/colors.dart';
import 'package:scribbleverse/domain/provider/poems/poems_provider.dart';
import 'package:scribbleverse/domain/provider/public/public_provider.dart';
import 'package:scribbleverse/presentation/views/books/screens/view_books.dart';

import '../../../../config/theams/fonts.dart';

class Page1 extends StatelessWidget {
  const Page1({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        ColorFiltered(
          colorFilter: backgroundFilter,
          child: Image.asset(
            'lib/data/datasources/local/images/istockphoto-1353780638-612x612.jpg',
            fit: BoxFit.cover,
          ),
        ),
        Column(
          children: [
            Container(
              height: 120,
              width: double.infinity,
              // decoration: const BoxDecoration(
              //     color: Colors.amber,
              //     image: DecorationImage(
              //         fit: BoxFit.cover,
              //         image: AssetImage(
              //             "lib/data/datasources/local/images/istockphoto-1353780638-612x612.jpg"))),
            ),
            const HomeBar(
              index: 0,
            ),
            // ElevatedButton(onPressed: () {}, child: Text('logout')),
            Expanded(
              child: Container(
                // decoration: BoxDecoration(
                //     image: DecorationImage(
                //         fit: BoxFit.cover,
                //         image: AssetImage(
                //             "lib/data/datasources/local/images/istockphoto-1353780638-612x612.jpg"))),
                child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('poems')
                        .snapshots(),
                    builder: (context, snapshot1) {
                      if (snapshot1.hasError) {
                        return Text('Error: ${snapshot1.error}');
                      }
                      if (snapshot1.connectionState ==
                          ConnectionState.waiting) {
                        return CircularProgressIndicator(); // Loading indicator
                      }

                      // Process data from collection1
                      final data1 = snapshot1.data!.docs;

                      return StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('short_stories')
                            .snapshots(),
                        builder: (context, snapshot2) {
                          if (snapshot2.hasError) {
                            return Text('Error: ${snapshot2.error}');
                          }
                          if (snapshot2.connectionState ==
                              ConnectionState.waiting) {
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
                          return ListView.builder(
                            itemCount: combinedData.length,
                            itemBuilder: (context, index) {
                              final document = combinedData[index];
                              final data =
                                  document.data() as Map<String, dynamic>;
                              // Build UI based on the document
                              final time = document['time'].toDate();
                              DateTime itemTime = data['time'].toDate();
                              DateTime currentDateTime = DateTime.now();
                              Duration difference =
                                  currentDateTime.difference(itemTime);
                              String timeDifference =
                                  Provider.of<AddPoemProvider>(context,
                                          listen: false)
                                      .poemTimeDifference(difference);
                              return data['type'] == 'poem'
                                  ? PoemCard(data: data)
                                  : ShortStoryCard(
                                      data: data,
                                      time: timeDifference,
                                    );
                            },
                          );
                        },
                      );
                    }),
              ),
            ),
            // ElevatedButton(
            //     onPressed: () async {
            //       await GoogleSignIn().signOut();
            //       FirebaseAuth.instance.signOut();
            //       Navigator.popAndPushNamed(context, '/login');
            //     },
            //     child: const Text('Logout')),
          ],
        ),
      ],
    );
  }
}

class PoemCard extends StatelessWidget {
  const PoemCard({
    super.key,
    required this.data,
  });

  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.amber,
      child: Padding(
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
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      topLeft: Radius.circular(15))),
              child: ListTile(
                leading: Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(data['user_profile_image']),
                  ),
                ),
                title: Text(
                  "${data['user_name']} added a new Poem",
                  style: buttonText,
                ),
                subtitle: Text(
                  "@${data['user_name']}",
                  style: normal,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Container(
                decoration: BoxDecoration(
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
                      padding: EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                          // color: Colors.amber,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Container(
                                  child: Text(
                                    data['heading'],
                                    style: buttonText,
                                  ),
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
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ShortStoryCard extends StatelessWidget {
  const ShortStoryCard({
    super.key,
    required this.data,
    required this.time,
  });

  final Map<String, dynamic> data;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.amber,
      child: Padding(
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
                  border: Border.all(width: 0.5, color: Colors.grey.shade300),
                  // border: BorderDirectional(
                  //     top: BorderSide(width: 0.5),
                  //     start: BorderSide(width: 0.5),
                  //     end: BorderSide(width: 0.5)),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      topLeft: Radius.circular(15))),
              child: ListTile(
                leading: Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(data['user_profile']),
                  ),
                ),
                title: Text(
                  "${data['user_name']} added a new Short Story",
                  style: buttonText,
                ),
                subtitle: Text(
                  "@${data['user_name']}",
                  style: normal,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Container(
                decoration: const BoxDecoration(
                    color: black,
                    // boxShadow: [
                    //   BoxShadow(offset: Offset(0, 0), color: Colors.grey)
                    // ],
                    // border: Border.all(width: 1),
                    borderRadius:
                        BorderRadius.only(bottomLeft: Radius.circular(15))),
                child: Card(
                  child: Container(
                    // color: Colors.green,
                    decoration: const BoxDecoration(
                      color: black,
                      // boxShadow: [
                      //   BoxShadow(offset: Offset(0, 0), color: Colors.grey)
                      // ],
                      // border: Border.all(width: 1),
                      // borderRadius:
                      //     BorderRadius.only(bottomLeft: Radius.circular(15))
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Container(
                            height: 170,
                            width: double.infinity,
                            // color: Colors.amber,

                            child: Row(
                              children: [
                                Flexible(
                                  flex: 1,
                                  child: Container(
                                    height: double.infinity,
                                    width: double.infinity,
                                    // color: Colors.green,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            // fit: BoxFit.cover,
                                            image: NetworkImage(
                                                data['cover_photo']))),
                                  ),
                                ),
                                Flexible(
                                  flex: 1,
                                  child: Container(
                                    height: double.infinity,
                                    width: double.infinity,
                                    child: Center(
                                        child: Text(
                                      data['short_story_name'],
                                      style: buttonText,
                                    )),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Container(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  data['discription'],
                                  style: normal,
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: Container(
                              // color: Colors.amber,
                              child: Text(
                                time.toString(),
                                style: normalBlack,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class HomeBar extends StatelessWidget {
  const HomeBar({
    super.key,
    required this.index,
  });

  final int index;

  @override
  Widget build(BuildContext context) {
    return Consumer<PublicProvider>(
      builder: (context, public, child) => Container(
        height: 40,
        width: double.infinity,
        color: black,
        //  Colors.grey.shade200,
        child: Row(
          children: [
            Flexible(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: GestureDetector(
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color:
                          public.currentIndex < 4 ? Colors.black : Colors.brown,
                    ),
                    child: Center(
                      child: Text(
                        'Trending',
                        style: normal,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Flexible(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: GestureDetector(
                  onTap: () {
                    public.postAdding('view_poems');
                    public.pageSelection(4);
                  },
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: public.currentIndex == 4
                          ? Colors.black
                          : Colors.brown,
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
            ),
            Flexible(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: GestureDetector(
                  onTap: () {
                    public.postAdding('short_stories');
                    public.pageSelection(5);
                  },
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: public.currentIndex == 5
                          ? Colors.black
                          : Colors.brown,
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
            ),
            Flexible(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ViewBooks(),
                        ));
                  },
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.brown,
                    ),
                    child: Center(
                      child: Text(
                        'Books',
                        style: normal,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Page2 extends StatelessWidget {
  const Page2({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Page 2'),
    );
  }
}
