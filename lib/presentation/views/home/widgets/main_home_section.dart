import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scribbleverse/domain/provider/poems/poems_provider.dart';
import 'package:scribbleverse/presentation/views/home/widgets/home_widget.dart';
import 'package:scribbleverse/presentation/views/home/widgets/poem_card.dart';
import 'package:scribbleverse/presentation/views/home/widgets/short_story_card.dart';
import 'package:scribbleverse/presentation/widgets/skeleton_widgets/home/home_page.skeleton.dart';

class MainHomeSection extends StatelessWidget {
  const MainHomeSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('poems').snapshots(),
          builder: (context, snapshot1) {
            if (snapshot1.hasError) {
              return Text('Error: ${snapshot1.error}');
            }
            if (snapshot1.connectionState == ConnectionState.waiting) {
              return const HomPageSkeleton(); // Loading indicator
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
                if (snapshot2.connectionState == ConnectionState.waiting) {
                  return const HomPageSkeleton(); // Loading indicator
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
                    final data = document.data() as Map<String, dynamic>;
                    // Build UI based on the document
                    final time = document['time'].toDate();
                    DateTime itemTime = data['time'].toDate();
                    DateTime currentDateTime = DateTime.now();
                    Duration difference = currentDateTime.difference(itemTime);
                    String timeDifference =
                        Provider.of<AddPoemProvider>(context, listen: false)
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
    );
  }
}
