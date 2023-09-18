import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scribbleverse/config/theams/colors.dart';
import 'package:scribbleverse/config/theams/fonts.dart';
import 'package:scribbleverse/domain/provider/poems/poems_provider.dart';
import 'package:scribbleverse/presentation/widgets/skeleton_widgets/profile/posts_skeleton.dart';

class ViewPosts extends StatelessWidget {
  const ViewPosts({
    super.key,
    required this.uid,
  });

  final String uid;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('poems')
              .where("user_id", isEqualTo: uid)
              .snapshots(),
          builder: (context, snapshot1) {
            if (snapshot1.hasError) {
              return Text('Error: ${snapshot1.error}');
            }
            if (snapshot1.connectionState == ConnectionState.waiting) {
              return const PoestsSkeleton(); // Loading indicator
            }

            // Process data from collection1
            final data1 = snapshot1.data!.docs;

            return StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('short_stories')
                  .where("user_id", isEqualTo: uid)
                  .snapshots(),
              builder: (context, snapshot2) {
                if (snapshot2.hasError) {
                  return Text('Error: ${snapshot2.error}');
                }
                if (snapshot2.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator(); // Loading indicator
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
                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10),
                  itemCount: combinedData.length,
                  itemBuilder: (context, index) {
                    final document = combinedData[index];
                    final data = document.data() as Map<String, dynamic>;
                    return data['type'] == 'poem'
                        ? Stack(
                            fit: StackFit.expand,
                            children: [
                              Consumer<AddPoemProvider>(
                                builder: (context, value, child) =>
                                    ColorFiltered(
                                  colorFilter: backgroundFilter,
                                  child: data['template_index'] != 4
                                      ? Image.asset(
                                          value.templateList[
                                              data['template_index']],
                                          fit: BoxFit.cover,
                                        )
                                      : Image.network(
                                          data['background_image'],
                                          fit: BoxFit.cover,
                                        ),
                                ),
                              ),
                              Consumer<AddPoemProvider>(
                                // ignore: sized_box_for_whitespace
                                builder: (context, value, child) => Container(
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
                                color: Colors.grey,
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(data['cover_photo']))),
                          );
                  },
                );
              },
            );
          }),
    ));
  }
}
