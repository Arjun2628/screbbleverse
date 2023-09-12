import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:scribbleverse/config/theams/colors.dart';

import 'package:scribbleverse/domain/provider/public/public_provider.dart';
import 'package:scribbleverse/presentation/views/books/screens/add_books.dart';
import 'package:scribbleverse/presentation/views/search/screens/search.dart';

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
          children: [value.pages[value.currentIndex]],
        ),
      ),
      bottomNavigationBar: const BottomBar(),
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
            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //       builder: (context) => const AddBooks(),
            //     ));

            value.pageSelection(index);

            // Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //         builder: (context) => SearchUsers(),
            //       ));
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
