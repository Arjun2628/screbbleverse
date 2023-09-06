import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:scribbleverse/config/theams/fonts.dart';
import 'package:scribbleverse/domain/provider/short_stories/read_short_story_provider.dart';
import 'package:scribbleverse/presentation/views/short_stories/widgets/add_cover.dart';
import 'package:uuid/uuid.dart';

import '../../../../config/theams/colors.dart';

class AddCaptionShortStory extends StatelessWidget {
  const AddCaptionShortStory({super.key});
  // final Map<String, dynamic> data;

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
          ListView(
            children: [
              AddCover(tittle: 'Add cover'),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Content type :',
                            style: buttonText,
                          ),
                          Expanded(child: Container())
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Container(
                          height: 45,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: white,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Consumer<ReadShortStoriesProvider>(
                                builder: (context, read, child) =>
                                    DropdownButton<String>(
                                  isExpanded: true,
                                  value: read.contentType,
                                  style: buttonTextBlack, // Default value
                                  items: <String>[
                                    'Content type',
                                    'Option 2',
                                    'Option 3',
                                  ].map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Text(value),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (newValue) {
                                    // Handle the selection
                                    read.changeContentType(newValue!);
                                  },
                                ),
                              )),
                        ),
                      ),
                    ],
                  )),
              Padding(
                padding: const EdgeInsets.fromLTRB(25, 25, 25, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Short story name :',
                          style: buttonText,
                        ),
                        Expanded(child: Container())
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Container(
                        height: 75,
                        decoration: BoxDecoration(
                          color: white,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Consumer<ReadShortStoriesProvider>(
                          builder: (context, value, child) => Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Expanded(
                                child: TextField(
                              controller: value.shortStoryNameController,
                              decoration: InputDecoration(
                                  hintText: 'Short story name',
                                  border: InputBorder.none),
                            )),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(25, 25, 25, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Discription :',
                          style: buttonText,
                        ),
                        Expanded(child: Container())
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          color: white,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Consumer<ReadShortStoriesProvider>(
                          builder: (context, value, child) => Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Expanded(
                                child: TextField(
                              controller: value.shortStoryDiscriptionController,
                              maxLines: 5,
                              decoration: InputDecoration(
                                  hintText: 'Add discription',
                                  border: InputBorder.none),
                            )),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(25, 25, 25, 0),
                child: Container(
                  height: 40,
                  width: double.infinity,
                  child: Row(
                    children: [
                      Flexible(
                        flex: 2,
                        child: Container(
                          height: double.infinity,
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 25),
                            child: Container(
                              height: double.infinity,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.white,
                              ),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.arrow_circle_left_outlined),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 5),
                                      child: Text(
                                        'Back',
                                        style: buttonTextBlack,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: Container(
                          height: double.infinity,
                          width: double.infinity,
                        ),
                      ),
                      Flexible(
                        flex: 2,
                        child: Container(
                          height: double.infinity,
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 25),
                            child: Consumer<ReadShortStoriesProvider>(
                              builder: (context, value, child) =>
                                  GestureDetector(
                                onTap: () async {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: Lottie.asset(
                                          'lib/data/datasources/local/lottie/animation_lm0crmem.json',
                                          width: 50,
                                          height: 100,
                                        ),
                                      );
                                    },
                                  );
                                  await value.cloudAdd(value.photo!);
                                  String uuid = Uuid().v4();
                                  DateTime date = DateTime.now();
                                  Map<String, dynamic> data = {
                                    'writting': value.controller.text,
                                    'short_story_id': uuid,
                                    'short_story_name':
                                        value.shortStoryNameController.text,
                                    'discription': value
                                        .shortStoryDiscriptionController.text,
                                    'content_type': value.contentType,
                                    'cover_photo': value.imageUri,
                                    'time': date,
                                    'all': 'all'
                                  };

                                  await FirebaseFirestore.instance
                                      .collection('short_stories')
                                      .doc(uuid)
                                      .set(data);
                                  // ignore: use_build_context_synchronously
                                  Navigator.pop(context);
                                  // ignore: use_build_context_synchronously
                                  Navigator.pop(context);
                                  // ignore: use_build_context_synchronously
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  height: double.infinity,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.white,
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Submit',
                                      style: buttonTextBlack,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
