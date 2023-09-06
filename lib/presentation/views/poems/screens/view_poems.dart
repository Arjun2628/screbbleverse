import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scribbleverse/config/theams/colors.dart';
import 'package:scribbleverse/config/theams/fonts.dart';
import 'package:scribbleverse/domain/provider/poems/poems_provider.dart';
import 'package:scribbleverse/presentation/views/poems/screens/writting_screen.dart';
import 'package:scribbleverse/presentation/views/poems/widgets/poem_comments.dart';
import 'package:scribbleverse/presentation/views/poems/widgets/poem_likes.dart';

import '../../home/widgets/home_widget.dart';

class ViewPoems extends StatelessWidget {
  const ViewPoems({super.key});

  static const String routName = '/view_poems';

  @override
  Widget build(BuildContext context) {
    return

        // appBar: AppBar(),
        // body:
        Stack(
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
          child: Column(
            children: [
              const HomeBar(
                index: 1,
              ),
              Container(
                height: 30,
                color: black,
                child: Row(
                  children: [
                    Expanded(child: Container()),
                    Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/add_poems');
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //       builder: (context) => Writter(),
                          //     ));
                        },
                        child: Container(
                          height: 25,
                          width: 110,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey
                                      .withOpacity(0.2), // Shadow color
                                  spreadRadius: 5, // How far the shadow spreads
                                  blurRadius: 7, // Soften the shadow
                                  offset: const Offset(
                                      0, 3), // Offset in x and y directions
                                ),
                              ]),
                          child: const Padding(
                            padding: EdgeInsets.only(left: 7),
                            child: Row(
                              children: [Icon(Icons.add), Text('Add poems')],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('poems')
                    .orderBy('date_and_time', descending: true)
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

                  return Expanded(
                    child: Container(
                      // color: Colors.brown.withOpacity(0.7),
                      color: black,
                      // Colors.grey.shade300,
                      child: ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          final document = snapshot.data!.docs[index];
                          final data = document.data() as Map<String, dynamic>;
                          final headingSize = data['heading_fontSize'];
                          // double doubleValue = headingSize.toDouble();
                          // Color color = Color(int.parse(data['content_color']));

                          String headingColorString =
                              data['heading_color'].toString();
                          String headingColor = headingColorString.substring(
                              6, headingColorString.length - 1);
                          String contentColorString =
                              data['content_color'].toString();
                          String contentColor = contentColorString.substring(
                              6, contentColorString.length - 1);
                          String headingfontSizeString =
                              data['content_fontsize'].toString();
                          double headingFontSize =
                              double.parse(headingfontSizeString);
                          String contentfontSizeString =
                              data['content_fontsize'].toString();
                          double contentFontSize =
                              double.parse(contentfontSizeString);
                          DateTime poemTime = data['date_and_time'].toDate();
                          DateTime currentDateTime = DateTime.now();
                          Duration difference =
                              currentDateTime.difference(poemTime);
                          String timeDifference = Provider.of<AddPoemProvider>(
                                  context,
                                  listen: false)
                              .poemTimeDifference(difference);
                          // int likes = Provider.of<AddPoemProvider>(context,
                          //         listen: false)
                          //     .getLike(docId);
                          return Padding(
                            padding: const EdgeInsets.only(
                                top: 2, left: 2, right: 2),
                            child: Consumer<AddPoemProvider>(
                              builder: (context, value, child) => Column(
                                children: [
                                  Container(
                                    height: 60,
                                    color: black,
                                    child: ListTile(
                                      leading: Padding(
                                        padding: const EdgeInsets.only(
                                          bottom: 10,
                                        ),
                                        child: CircleAvatar(
                                          radius: 25,
                                          backgroundColor: Colors.amber,
                                          backgroundImage: NetworkImage(
                                              data['user_profile_image']),
                                        ),
                                      ),
                                      title: Text(
                                        data['caption'],
                                        style: buttonText,
                                      ),
                                      subtitle: Row(
                                        children: [
                                          Text(
                                            data['user_name'],
                                            style: buttonText,
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          const CircleAvatar(
                                            radius: 8,
                                          )
                                        ],
                                      ),
                                      trailing: Padding(
                                        padding: const EdgeInsets.only(
                                          bottom: 15,
                                        ),
                                        child: Icon(
                                          Icons.more_vert,
                                          color: white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        image: data['background_image'] == '' ||
                                                data['template_index'] < 4
                                            ? DecorationImage(
                                                fit: BoxFit.cover,
                                                image: AssetImage(value
                                                        .templateList[
                                                    data['template_index']]))
                                            : DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(
                                                    data['background_image']))),
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 450,
                                          width: double.infinity,
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                15, 15, 15, 0),
                                            child: ListView(
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              children: [
                                                SizedBox(
                                                  width: double.infinity,
                                                  // color: Colors.amber,
                                                  child: Align(
                                                    alignment:
                                                        data['heading_alignment'] ==
                                                                'TextAlign.center'
                                                            ? Alignment.center
                                                            : Alignment
                                                                .centerLeft,
                                                    child: Text(
                                                      data['heading'],
                                                      textAlign: data[
                                                                  'heading_alignment'] ==
                                                              'textalign_center'
                                                          ? TextAlign.center
                                                          : TextAlign.left,
                                                      style: TextStyle(
                                                          color: Color(int.parse(
                                                              headingColor)),
                                                          fontSize:
                                                              contentFontSize,
                                                          fontFamily: data[
                                                              'heading_fontfamily'],
                                                          fontWeight:
                                                              data['heading_bold'] ==
                                                                      false
                                                                  ? FontWeight
                                                                      .normal
                                                                  : FontWeight
                                                                      .bold),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ),
                                                const Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: Divider(height: 2),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Expanded(
                                                    child: SizedBox(
                                                      width: double.infinity,
                                                      // color: Colors.lightBlue,
                                                      child: Text(
                                                        data['content'],
                                                        textAlign: data[
                                                                    'content_alignment'] ==
                                                                'TextAlign.center'
                                                            ? TextAlign.center
                                                            : TextAlign.left,
                                                        style: TextStyle(
                                                          color: Color(int.parse(
                                                              contentColor)),
                                                          // decoration: inputde,
                                                          // color: data['content_color'] as Color,
                                                          fontSize:
                                                              headingFontSize,
                                                          fontFamily: data[
                                                              'content_fontfamily'],
                                                          fontWeight:
                                                              data['content_bold'] ==
                                                                      false
                                                                  ? FontWeight
                                                                      .normal
                                                                  : FontWeight
                                                                      .bold,
                                                          fontStyle:
                                                              data['content_italic'] ==
                                                                      false
                                                                  ? FontStyle
                                                                      .normal
                                                                  : FontStyle
                                                                      .italic,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 20,
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Container(),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 10),
                                                child: Text(
                                                  'Read more...',
                                                  style: buttonTextBlack,
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: 65,
                                    color: Colors.black,
                                    child: Row(
                                      children: [
                                        Flexible(
                                          flex: 1,
                                          child: SizedBox(
                                            // color: Colors.lightBlue,
                                            height: double.infinity,
                                            width: double.infinity,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.only(top: 8),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      GestureDetector(
                                                          onTap: () async {
                                                            FirebaseAuth auth =
                                                                FirebaseAuth
                                                                    .instance;
                                                            Map<String, dynamic>
                                                                count = {
                                                              'user_id': auth
                                                                  .currentUser!
                                                                  .uid
                                                            };

                                                            await FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    'poems')
                                                                .doc(data[
                                                                    'poem_id'])
                                                                .collection(
                                                                    'likes')
                                                                .doc(auth
                                                                    .currentUser!
                                                                    .uid)
                                                                .set(count);
                                                          },
                                                          child:
                                                              // const Icon(
                                                              //   Icons.favorite,
                                                              //   color: white,
                                                              // ),
                                                              PostWidget(
                                                                  post:
                                                                      document,
                                                                  currentUser:
                                                                      FirebaseAuth
                                                                          .instance
                                                                          .currentUser)),
                                                      Text(
                                                        'Likes',
                                                        style: buttonText,
                                                      ),
                                                    ],
                                                  ),
                                                  // Text('86752')
                                                  // FutureBuilder<>(
                                                  //   future: FirebaseFirestore.instance.collection('poems').doc(),
                                                  //   builder: )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Flexible(
                                          flex: 1,
                                          child: GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        PostScreen(
                                                      post: document,
                                                      data: data,
                                                    ),
                                                  ));
                                            },
                                            child: SizedBox(
                                              // color: Colors.green,
                                              height: double.infinity,
                                              width: double.infinity,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  const Icon(
                                                    Icons.comment,
                                                    color: white,
                                                  ),
                                                  Text(
                                                    'Comments',
                                                    style: buttonText,
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Flexible(
                                          flex: 1,
                                          child: SizedBox(
                                            // color: Colors.red,
                                            height: double.infinity,
                                            width: double.infinity,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                const Icon(
                                                  Icons.save_rounded,
                                                  color: white,
                                                ),
                                                Text(
                                                  'Save',
                                                  style: buttonText,
                                                )
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Text(
                                          timeDifference,
                                          style: const TextStyle(color: white),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ],
    );
  }
}
