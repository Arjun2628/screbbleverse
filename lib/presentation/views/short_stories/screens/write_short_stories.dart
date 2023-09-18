import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scribbleverse/config/theams/colors.dart';
import 'package:scribbleverse/domain/provider/short_stories/read_short_story_provider.dart';
import 'package:scribbleverse/presentation/views/short_stories/screens/add_caption_screen.dart';

class WriteShortStories extends StatelessWidget {
  const WriteShortStories({super.key});

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
            child: Container(
                height: double.infinity,
                width: double.infinity,
                color: Colors.black,
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Consumer<ReadShortStoriesProvider>(
                    builder: (context, value, child) => TextField(
                      controller: value.controller,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          color: white),
                      maxLines: null,
                      maxLength: 15000,
                      cursorColor: white,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Write here....',
                        hintStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            color: white),
                      ),
                    ),
                  ),
                )),
          ),
          Positioned(
            top: 25,
            right: 5,
            child: ElevatedButton(
                onPressed: () async {
                  // String uuid = Uuid().v4();
                  // Map<String, dynamic> data = {
                  //   'writting': controller.text,
                  //   'short_story_id': uuid
                  // };
                  // await FirebaseFirestore.instance
                  //     .collection('short_stories')
                  //     .doc(uuid)
                  //     .set(data);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AddCaptionShortStory(),
                      ));
                },
                child: const Text('Done')),
          )
        ],
      ),
    );
  }
}
