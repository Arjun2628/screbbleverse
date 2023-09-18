import 'package:flutter/material.dart';
import 'package:scribbleverse/config/theams/colors.dart';

class HomPageSkeleton extends StatelessWidget {
  const HomPageSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) {
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
                    border: Border.all(width: 0.5, color: Colors.grey.shade100),
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        topLeft: Radius.circular(15))),
                child: ListTile(
                  leading: const Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: CircleAvatar(
                      backgroundColor: Colors.grey,
                    ),
                  ),
                  title: Container(
                    color: Colors.grey,
                    child: const Text(
                      'Arjun Added a poem',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Container(
                      color: Colors.grey,
                      width: 50,
                      child: const Text(
                        '@Arjun',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Container(
                  decoration: const BoxDecoration(
                    color: black,

                    // border: Border.all(width: 0.5, color: Colors.grey.shade300),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        topLeft: Radius.circular(15)),
                  ),
                  child: Container(
                    // color: Colors.green,

                    decoration: const BoxDecoration(color: black
                        // border: Border.all(width: 1),
                        // borderRadius:
                        //     BorderRadius.only(bottomLeft: Radius.circular(15))
                        ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Container(
                                height: 55,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: black,
                    // image: DecorationImage(
                    //     fit: BoxFit.cover,
                    //     opacity: 0.8,
                    //     image: AssetImage(
                    //         'lib/data/datasources/local/images/Screenshot (81).png')),
                    border: Border.all(width: 0.5, color: Colors.grey.shade100),
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        topLeft: Radius.circular(15))),
                child: ListTile(
                  leading: const Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: CircleAvatar(
                      backgroundColor: Colors.grey,
                    ),
                  ),
                  title: Container(
                    color: Colors.grey,
                    child: const Text(
                      'Arjun Added a poem',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Container(
                      color: Colors.grey,
                      width: 50,
                      child: const Text(
                        '@Arjun',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                // color: Colors.green,
                decoration: const BoxDecoration(color: black
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
                      Container(
                        height: 170,
                        width: double.infinity,
                        // color: Colors.amber,
                        color: black,

                        child: Row(
                          children: [
                            Flexible(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: double.infinity,
                                  width: double.infinity,
                                  // color: Colors.green,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            Flexible(
                              flex: 1,
                              child: Container(
                                height: double.infinity,
                                width: double.infinity,
                                // color: Colors.grey,
                                child: Center(
                                    child: Container(
                                  color: Colors.grey,
                                  child: const Text(
                                    'short_story_name',
                                    style: TextStyle(color: Colors.grey),
                                  ),
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
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  color: Colors.grey,
                                  child: const Text(
                                    'kjnlknlknljnljnklklkjkkjnlknlklklk',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  color: Colors.grey,
                                  child: const Text(
                                    'kjnlknlknljnljnklklkjkkjnlknlklklk',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Container(
                            // color: Colors.amber,

                            ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
