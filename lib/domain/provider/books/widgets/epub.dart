import 'package:epub_view/epub_view.dart';
import 'package:flutter/material.dart';

late EpubController _epubController;

@override
void initState() {
  initState();
  _epubController = EpubController(
    // Load document
    document: EpubDocument.openAsset('assets/book.epub'),
    // Set start point
    epubCfi: 'epubcfi(/6/6[chapter-2]!/4/2/1612)',
  );
}

@override
Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        // Show actual chapter name
        title: EpubViewActualChapter(
            controller: _epubController,
            builder: (chapterValue) => Text(
                  'Chapter: ' +
                      (chapterValue?.chapter?.Title
                              ?.replaceAll('\n', '')
                              .trim() ??
                          ''),
                  textAlign: TextAlign.start,
                )),
      ),
      // Show table of contents
      drawer: Drawer(
        child: EpubViewTableOfContents(
          controller: _epubController,
        ),
      ),
      // Show epub document
      body: EpubView(
        controller: _epubController,
      ),
    );
