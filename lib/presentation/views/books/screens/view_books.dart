import 'package:flutter/material.dart';
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
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(child: Container()),
                    Padding(
                      padding: const EdgeInsets.only(right: 15, top: 15),
                      child: GestureDetector(
                        onTap: () async {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddBooks(),
                              ));
                        },
                        child: Container(
                          height: 35,
                          width: 90,
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
                            child: Center(
                                child: Text(
                              'Done',
                              style: TextStyle(fontSize: 17),
                            )),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
