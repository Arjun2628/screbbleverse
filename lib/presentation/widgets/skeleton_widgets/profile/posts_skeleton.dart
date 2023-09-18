import 'package:flutter/material.dart';

class PoestsSkeleton extends StatelessWidget {
  const PoestsSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, crossAxisSpacing: 10, mainAxisSpacing: 10),
      itemCount: 12,
      itemBuilder: (context, index) {
        return Container(
          height: 90,
          width: double.infinity,
          color: Colors.grey,
        );
      },
    );
  }
}
