import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:scribbleverse/config/theams/colors.dart';

import 'package:scribbleverse/domain/provider/public/public_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const String routName = '/home';

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<PublicProvider>(
        builder: (context, value, child) => Stack(
          children: [
            // _pages[_currentIndex],
            // value.currentIndex != 24
            value.pages[value.currentIndex]
            // : value.trending == true
            //     ? One()
            //     : value.poems == true
            //         ? Two()s
            //         : value.shortStories == true
            //             ? Three()
            //             : AddPoems()
          ],
        ),
      ),
      //  SafeArea(

      // )

      bottomNavigationBar: const BottomBar(),
      // floatingActionButton:
      //     Provider.of<PublicProvider>(context, listen: false).currentIndex ==
      //                 4 ||
      //             Provider.of<PublicProvider>(context, listen: false)
      //                     .currentIndex ==
      //                 5
      //         ? FloatingActionButton(
      //             onPressed: () {},
      //             child: Text('add'),
      //           )
      //         : null,
    );
  }
}

class BottomBar extends StatelessWidget {
  const BottomBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<PublicProvider>(
      builder: (context, value, child) => BottomNavigationBar(
          showSelectedLabels: false,
          onTap: (index) async {
            // if (value.currentIndex != 2) {
            // await value.getUserData();
            value.pageSelection(index);
            // }
            //  else {
            //   // Navigator.push(
            //   //     context,
            //   //     MaterialPageRoute(
            //   //       builder: (context) => AddPoems(),
            //   //     ));
            // }
          },
          items: const [
            BottomNavigationBarItem(
              backgroundColor: bottomNavigationColor,
              icon: Icon(Icons.home),
              label: 'Page 0',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Page 1',
            ),
            // BottomNavigationBarItem(
            //   icon: Icon(Icons.add),
            //   label: 'Page 2',
            // ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications),
              label: 'Page 3',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Page 4',
            ),
          ]),
    );
  }
}

class Page5 extends StatelessWidget {
  const Page5({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Page 3'),
    );
  }
}

class One extends StatelessWidget {
  const One({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('One'),
    );
  }
}

class Two extends StatelessWidget {
  const Two({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Two'),
    );
  }
}

class Three extends StatelessWidget {
  const Three({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Three'),
    );
  }
}
