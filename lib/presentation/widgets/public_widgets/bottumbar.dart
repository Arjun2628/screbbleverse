import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scribbleverse/config/theams/colors.dart';
import 'package:scribbleverse/domain/provider/public/public_provider.dart';

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
            value.pageSelection(index);
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
