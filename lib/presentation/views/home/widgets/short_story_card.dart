import 'package:flutter/material.dart';
import 'package:scribbleverse/config/theams/colors.dart';
import 'package:scribbleverse/config/theams/fonts.dart';

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
    return Padding(
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
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    topLeft: Radius.circular(15))),
            child: ListTile(
              leading: Padding(
                padding: const EdgeInsets.only(right: 10),
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
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        SizedBox(
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
                                // ignore: sized_box_for_whitespace
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
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              data['discription'],
                              style: normal,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: Text(
                            time.toString(),
                            style: normalBlack,
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
    );
  }
}
