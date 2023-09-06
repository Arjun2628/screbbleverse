import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scribbleverse/config/theams/colors.dart';
import 'package:scribbleverse/domain/provider/poems/poems_provider.dart';

class PoemTemplates extends StatelessWidget {
  const PoemTemplates({
    super.key,
    required this.index,
  });
  final int index;

  @override
  Widget build(BuildContext context) {
    // print(index);
    return Padding(
      padding: const EdgeInsets.only(left: 10, top: 5, bottom: 5),
      child: Consumer<AddPoemProvider>(
        builder: (context, value, child) => GestureDetector(
          onTap: () {
            value.templateSelection(index);
          },
          child: Container(
            height: 80,
            width: 70,
            decoration: BoxDecoration(
                border: Border.all(
                    width: 2,
                    color:
                        value.templateIndex == index ? Colors.yellow : white),
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(value.templateList[index]))),
          ),
        ),
      ),
    );
  }
}
