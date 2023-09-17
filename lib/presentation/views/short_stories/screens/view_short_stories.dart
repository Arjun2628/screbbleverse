import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scribbleverse/config/theams/fonts.dart';
import 'package:scribbleverse/presentation/views/home/widgets/home_widget.dart';
import 'package:scribbleverse/presentation/views/short_stories/screens/read_short_stories.dart';
import 'package:scribbleverse/presentation/views/short_stories/screens/write_short_stories.dart';

import '../../../../config/theams/colors.dart';
import '../../../../domain/provider/short_stories/read_short_story_provider.dart';

class ViewShortStories extends StatelessWidget {
  const ViewShortStories({super.key});

  static const String routName = '/view_short_stories';

  @override
  Widget build(BuildContext context) {
    bool a = true;

    return
        //  Scaffold(
        //   body:
        Stack(
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
          child: Column(
            children: [
              const HomeBar(
                index: 2,
              ),
              Row(
                children: [
                  Expanded(
                      child: Container(
                    color: black,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Row(
                        children: [
                          Consumer<ReadShortStoriesProvider>(
                            builder: (context, read, child) => Container(
                              decoration: const BoxDecoration(
                                  boxShadow: [], color: black),
                              child: Theme(
                                data: Theme.of(context).copyWith(
                                  canvasColor: Colors.black,
                                ),
                                child: DropdownButton<String>(
                                  icon: const Icon(
                                    Icons.sort,
                                    color: white,
                                    size: 15,
                                  ),
                                  value: read.sorting_content,
                                  style: normal,
                                  items: <String>[
                                    'All',
                                    'Option 2',
                                    'Option 3',
                                  ].map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        value,
                                        style: normal,
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (newValue) {
                                    read.sortContent(newValue!);
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )),
                  Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const WriteShortStories(),
                            ));
                      },
                      child: Container(
                        height: 25,
                        width: 160,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: const Offset(0, 3),
                              ),
                            ]),
                        child: const Padding(
                          padding: EdgeInsets.only(left: 7),
                          child: Row(
                            children: [
                              Icon(Icons.add),
                              Text('Add short stories')
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const AllShortStories()
            ],
          ),
        ),
      ],
    );
  }
}

class AllShortStories extends StatelessWidget {
  const AllShortStories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // String content =
    //     Provider.of<ReadShortStoriesProvider>(context, listen: false)
    //         .sorting_content!;
    return Consumer<ReadShortStoriesProvider>(
      builder: (context, value, child) => Expanded(
        child: StreamBuilder<QuerySnapshot>(
          stream: value.sorting_content == 'All'
              ? FirebaseFirestore.instance
                  .collection('short_stories')
                  .orderBy('time', descending: true)
                  .snapshots()
              : value.sorting_content == 'Option 2'
                  ? FirebaseFirestore.instance
                      .collection('short_stories')
                      .where('content_type', isEqualTo: 'Option 2')
                      .snapshots()
                  : FirebaseFirestore.instance
                      .collection('short_stories')
                      .where('content_type', isEqualTo: 'Option 3')
                      .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (!snapshot.hasData) {
              return const Text('error');
            }
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final document = snapshot.data!.docs[index];
                final data = document.data() as Map<String, dynamic>;
                return Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
                  child: GestureDetector(
                    onTap: () {
                      Provider.of<ReadShortStoriesProvider>(context,
                              listen: false)
                          .textChange(data['writting']);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ReadShortStories(),
                          ));
                    },
                    child: Container(
                      height: 160,
                      width: double.infinity,
                      // color: Colors.amber,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            opacity: 0.8,
                            image: AssetImage(
                                'lib/data/datasources/local/images/Screenshot (81).png')),
                      ),
                      child: Row(
                        children: [
                          Flexible(
                            flex: 1,
                            child: SizedBox(
                              height: double.infinity,
                              width: double.infinity,
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 20, 10, 20),
                                child: Container(
                                  height: double.infinity,
                                  width: double.infinity,
                                  // color: Colors.amber,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                              data['cover_photo']))),
                                ),
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 2,
                            child: SizedBox(
                              height: double.infinity,
                              width: double.infinity,
                              child: Column(
                                children: [
                                  Flexible(
                                    flex: 1,
                                    child: SizedBox(
                                      height: double.infinity,
                                      width: double.infinity,
                                      child: Row(
                                        children: [
                                          Expanded(child: Container()),
                                          const Padding(
                                            padding: EdgeInsets.only(right: 15),
                                            child: Icon(Icons.favorite),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    flex: 3,
                                    child: SizedBox(
                                      height: double.infinity,
                                      width: double.infinity,
                                      child: Column(
                                        children: [
                                          Align(
                                              alignment: Alignment.topLeft,
                                              child: Text(
                                                data['short_story_name'],
                                                style: buttonTextBlack,
                                              )),
                                          Align(
                                              alignment: Alignment.topLeft,
                                              child: Text(
                                                data['discription'],
                                                style: normalBlack,
                                                maxLines: 3,
                                                overflow: TextOverflow.ellipsis,
                                              )),
                                          Align(
                                              alignment: Alignment.bottomLeft,
                                              child: Row(
                                                children: [
                                                  Text(
                                                    'Sahil Saleem',
                                                    style: normalBlackItalic,
                                                  ),
                                                  const Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 5),
                                                    child: CircleAvatar(
                                                      radius: 8,
                                                    ),
                                                  )
                                                ],
                                              )),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
