import 'package:flutter/material.dart';
import 'package:scribbleverse/config/theams/colors.dart';

class DailyQuotesSkeleton extends StatelessWidget {
  const DailyQuotesSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: 8,
      itemBuilder: (context, index) {
        return Row(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 25, 2, 20),
              child: SizedBox(
                height: double.infinity,
                width: 80,

                // color: Colors.amber,
                child: Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(width: 2, color: Colors.grey)),
                  child: const CircleAvatar(
                    backgroundColor: black,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
