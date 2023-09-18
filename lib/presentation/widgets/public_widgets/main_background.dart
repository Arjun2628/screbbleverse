import 'package:flutter/material.dart';
import 'package:scribbleverse/config/theams/colors.dart';

class MainBackground extends StatelessWidget {
  const MainBackground({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ColorFiltered(
      colorFilter: backgroundFilter,
      child:
          //  Image.network(
          //   'https://static.vecteezy.com/system/resources/thumbnails/000/600/537/small/BG58-01.jpg',
          //   fit: BoxFit.cover,
          // )
          Image.asset(
        'lib/data/datasources/local/images/BG58-01.jpg',
        fit: BoxFit.cover,
      ),
    );
  }
}
