import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scribbleverse/config/theams/colors.dart';
import 'package:scribbleverse/config/theams/fonts.dart';
import 'package:scribbleverse/domain/provider/public/public_provider.dart';
import 'package:scribbleverse/presentation/views/books/screens/view_books.dart';

class HomeBar extends StatelessWidget {
  const HomeBar({
    super.key,
    required this.index,
  });

  final int index;

  @override
  Widget build(BuildContext context) {
    return Consumer<PublicProvider>(
      builder: (context, public, child) => Container(
        height: 40,
        width: double.infinity,
        color: black,
        //  Colors.grey.shade200,
        child: Row(
          children: [
            Flexible(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: GestureDetector(
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color:
                          public.currentIndex < 4 ? Colors.black : Colors.brown,
                    ),
                    child: Center(
                      child: Text(
                        'Trending',
                        style: normal,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Flexible(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: GestureDetector(
                  onTap: () {
                    public.postAdding('view_poems');
                    public.pageSelection(4);
                  },
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: public.currentIndex == 4
                          ? Colors.black
                          : Colors.brown,
                    ),
                    child: Center(
                      child: Text(
                        'Poems',
                        style: normal,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Flexible(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: GestureDetector(
                  onTap: () {
                    public.postAdding('short_stories');
                    public.pageSelection(5);
                  },
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: public.currentIndex == 5
                          ? Colors.black
                          : Colors.brown,
                    ),
                    child: Center(
                      child: Text(
                        'Short Stories',
                        style: normal,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Flexible(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ViewBooks(),
                        ));
                  },
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.brown,
                    ),
                    child: Center(
                      child: Text(
                        'Books',
                        style: normal,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
