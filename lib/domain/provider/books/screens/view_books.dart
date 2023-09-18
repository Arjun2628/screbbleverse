import 'dart:io';

import 'package:epub_view/epub_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:scribbleverse/domain/provider/books/screens/add_book_provider.dart';

class MyApp1 extends StatefulWidget {
  MyApp1({Key? key, required this.eUrl})
      : super(
          key: key,
        );
  String eUrl;

  @override
  State<MyApp1> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp1> with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangePlatformBrightness() {
    _setSystemUIOverlayStyle();
  }

  Brightness get platformBrightness =>
      // ignore: deprecated_member_use
      MediaQueryData.fromView(WidgetsBinding.instance.window)
          .platformBrightness;

  void _setSystemUIOverlayStyle() {
    if (platformBrightness == Brightness.light) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.grey[50],
        systemNavigationBarIconBrightness: Brightness.dark,
      ));
    } else {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: Colors.grey[850],
        systemNavigationBarIconBrightness: Brightness.light,
      ));
    }
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Epub demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          brightness: Brightness.light,
        ),
        darkTheme: ThemeData(
          primarySwatch: Colors.blue,
          brightness: Brightness.dark,
        ),
        debugShowCheckedModeBanner: false,
        home: MyHomePage(eUrl: widget.eUrl),
      );
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, this.eUrl}) : super(key: key);
  String? eUrl;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late EpubController _epubReaderController;

  @override
  void initState() {
    if (widget.eUrl != null) {
      _epubReaderController = EpubController(
          document:
              //      EpubDocument.openData(
              //   Uri.parse(
              //           "https://firebasestorage.googleapis.com/v0/b/scribbleverse-b95d4.appspot.com/o/epub_files%2Fyour_file_name.epub?alt=media&token=e518b846-1404-4d91-b550-39f41c767455https://firebasestorage.googleapis.com/v0/b/scribbleverse-b95d4.appspot.com/o/epub_files%2Fyour_file_name.epub?alt=media&token=e518b846-1404-4d91-b550-39f41c767455")
              //       .data as Uint8List,
              // )
              // EpubDocument.openFile(
              // Provider.of<AddBooksProvider>(context, listen: false)
              //     .fileLocation!)
              // EpubDocument.openAsset(
              //     "lib/data/datasources/local/ebooks/Half_Girlfriend_-_Chetan_Bhagat (2).epub")
              EpubDocument.openData(
                  Provider.of<AddBooksProvider>(context, listen: false)
                      .eCoverted!)
          // EpubDocument.openData(
          //     Provider.of<AddBooksProvider>(context, listen: false)
          //         .fileLocation!)

          //     'epub/lib/assets/Half_Girlfriend_-_Chetan_Bhagat.epub'),
          // epubCfi: widget.eUrl
          // 'epubcfi(/6/26[id4]!/4/2/2[id4]/22)', // book.epub Chapter 3 paragraph 10
          // epubCfi:
          //     'epubcfi(/6/6[chapter-2]!/4/2/1612)', // book_2.epub Chapter 16 paragraph 3
          );
    }

    super.initState();
  }

  @override
  void dispose() {
    _epubReaderController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: EpubViewActualChapter(
            controller: _epubReaderController,
            builder: (chapterValue) => Text(
              chapterValue?.chapter?.Title?.replaceAll('\n', '').trim() ?? '',
              textAlign: TextAlign.start,
            ),
          ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.save_alt),
              color: Colors.white,
              onPressed: () => _showCurrentEpubCfi(context),
            ),
          ],
        ),
        drawer: Drawer(
          child: EpubViewTableOfContents(controller: _epubReaderController),
        ),
        body: EpubView(
          builders: EpubViewBuilders<DefaultBuilderOptions>(
            options: const DefaultBuilderOptions(),
            chapterDividerBuilder: (_) => const Divider(),
          ),
          controller: _epubReaderController,
        ),
      );

  void _showCurrentEpubCfi(context) {
    final cfi = _epubReaderController.generateEpubCfi();

    if (cfi != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(cfi),
          action: SnackBarAction(
            label: 'GO',
            onPressed: () {
              _epubReaderController.gotoEpubCfi(cfi);
            },
          ),
        ),
      );
    }
  }
}
