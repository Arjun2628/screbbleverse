import 'package:dictionaryx/dictionary_msa.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_flip/page_flip.dart';
import 'package:provider/provider.dart';
import 'package:quick_dictionary/quick_dictionary.dart';
import 'package:scribbleverse/config/theams/colors.dart';
import 'package:scribbleverse/config/theams/fonts.dart';
import 'package:scribbleverse/domain/provider/public/public_provider.dart';
import 'package:scribbleverse/domain/provider/short_stories/read_short_story_provider.dart';
import 'package:dictionaryx/dictentry.dart';

import '../../../../data/repositories/word_repository.dart';

class ReadShortStories extends StatefulWidget {
  const ReadShortStories({super.key});

  @override
  State<ReadShortStories> createState() => _ReadShortStoriesState();
}

class _ReadShortStoriesState extends State<ReadShortStories> {
  double _scale = 1.0;
  double _previousScale = 1.0;

  @override
  Widget build(BuildContext context) {
    Provider.of<ReadShortStoriesProvider>(context, listen: false)
        .getPageNumbers();
    String selectedText = 'ghghh';
    TextEditingController firstController = TextEditingController();
    TextEditingController secondController = TextEditingController();
    firstController.text =
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum";
    int idx = 1;
    dynamic _controller;

    return Scaffold(
      backgroundColor: black,
      body: SafeArea(
        child: idx == 1
            ? Stack(
                // children: List.generate(
                //     Provider.of<ReadShortStoriesProvider>(context,
                //             listen: false)
                //         .pageCount!,
                //     (index) => buildPage(context, _controller, index)),
                children: [
                  buildPageMain(
                    context,
                  )
                ],
              )
            : Container(
                height: double.infinity,
                width: double.infinity,
                color: Colors.black,
                child: Builder(
                  builder: (context) => GestureDetector(
                    onLongPress: () {
                      // Handle long-press here
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Selected Text"),
                            content: Text("Your selected text here..."),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text("Close"),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: SelectableText.rich(
                      const TextSpan(
                          text:
                              "simply dIpsum is si Lorem Ipsum simply dIpsum is sisimply dIpsum is sisimply dIpsum is sisimply dIpsum is siis simply dIpsum is simply dummy text of the printiIpsum is simply dummy text of the printiIpsum is simply dummy text of the printiIpsum is simply dummy text of the printiIpsum is simply dummy text of the printiummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum",
                          style: TextStyle(
                            color: Colors.white,
                          )),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 25),
                      onTap: () {},
                      toolbarOptions:
                          const ToolbarOptions(copy: true, selectAll: false),
                      showCursor: true,
                      cursorWidth: 2,
                      onSelectionChanged: (selection, cause) {
                        if (cause == SelectionChangedCause.longPress) {
                          final selectedText = selection.textInside;
                          _controller.handleSelection(selectedText);

                          print('Selected Text: $selectedText');
                          print(selection.textInside as String);
                        }
                      },
                      selectionControls: _controller,
                      cursorColor: Colors.black,
                      cursorRadius: const Radius.circular(5),
                    ),
                  ),
                ),
              ),
      ),
    );
  }

  Widget buildPageMain(
    BuildContext context,
  ) {
    var _controller;
    Provider.of<ReadShortStoriesProvider>(context, listen: false)
        .setBackSubstring();
    return PageFlipWidget(
      key: _controller,
      children: List.generate(
          Provider.of<ReadShortStoriesProvider>(context, listen: false)
              .pageCount!, (index) {
        String subString =
            Provider.of<ReadShortStoriesProvider>(context, listen: false)
                .text
                .substring(580 * index, 580 * (index + 1));
        return buildPage(context, _controller, index, subString);
      }),
      initialIndex: 0,
    );
  }

  Widget buildPage(
      BuildContext context, dynamic controller, int index, String substring) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: const BoxDecoration(
          color: black,
          image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(
                  'lib/data/datasources/local/images/Screenshot (87).png'))),
      child: GestureDetector(
        onScaleStart: (details) {
          _previousScale = _scale;
        },
        onScaleUpdate: (details) {},
        child: Consumer<ReadShortStoriesProvider>(
          builder: (context, value, child) => SelectableText.rich(
            TextSpan(
                text: substring,
                style: const TextStyle(
                    color: Colors.black, fontFamily: 'Lato-Regular')),
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
            onTap: () {
              print('Tapped');
            },
            // contextMenuBuilder: (context, editableTextState) {
            //   return buildCustomContextMenu(
            //       context, editableTextState as TextSelection);
            // },
            toolbarOptions:
                const ToolbarOptions(copy: true, selectAll: true, cut: true),
            showCursor: true,
            cursorWidth: 2,
            onSelectionChanged: (selection, cause) async {
              Provider.of<PublicProvider>(context, listen: false)
                  .getMeaning(null);
              final selectedTextStart = selection.baseOffset;
              final selectedTextEnd = selection.extentOffset;
              String word =
                  substring.substring(selectedTextStart, selectedTextEnd);
              // Future.delayed(Duration(seconds: 5));
              if (cause == SelectionChangedCause.longPress) {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      backgroundColor: black,
                      title: Consumer<PublicProvider>(
                          builder: (context, value, child) =>
                              value.meaning != null
                                  ? Text(
                                      value.meaning!,
                                      style: buttonText,
                                    )
                                  : Center(
                                      child: CircularProgressIndicator(
                                      color: white,
                                    ))),
                    );
                  },
                );
              }

              String meaning = await lookupWord(word);
              Provider.of<PublicProvider>(context, listen: false)
                  .getMeaning(meaning);
              // ignore: use_build_context_synchronously
            },
            selectionControls: controller,
            cursorColor: Colors.black,
            cursorRadius: const Radius.circular(5),
          ),
        ),
      ),
    );
  }

  Future<String> lookupWord(String word) async {
    WordRepository wordRepository = WordRepository();
    try {
      final wordDefinitions = await wordRepository.getWordFromDictionary(word);
      return wordDefinitions;
    } catch (error) {
      return 'I appologise the meaning not found';
    }
  }

  void showToolbox(Offset position, String selectedWord) {
    final overlayState = Overlay.of(context)!;

    OverlayEntry? entry;
    entry = OverlayEntry(
      builder: (context) => Positioned(
        left: position.dx,
        top: position.dy - 50, // Adjust this value as needed.
        child: Card(
          elevation: 4.0,
          child: Column(
            children: [
              ListTile(
                title: Text('Copy'),
                onTap: () {
                  // Implement your copy logic here.
                  entry!.remove(); // Close the toolbox.
                },
              ),
              ListTile(
                title: Text('Show Meaning'),
                onTap: () async {
                  // Implement your meaning retrieval logic here.
                  String meaning = await lookupWord(selectedWord);

                  // Show the meaning in a dialog.
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text(meaning),
                      );
                    },
                  );

                  entry!.remove(); // Close the toolbox.
                },
              ),
              // Add more toolbox options here.
            ],
          ),
        ),
      ),
    );

    overlayState.insert(entry);
  }

  void showCustomPopUp(BuildContext context, Offset position) {
    final RenderBox overlay =
        Overlay.of(context)!.context.findRenderObject() as RenderBox;
    final Offset positionGlobal = overlay.localToGlobal(position);

    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        positionGlobal.dx,
        positionGlobal.dy,
        positionGlobal.dx + 48.0, // Adjust this value for the X position
        positionGlobal.dy + 48.0, // Adjust this value for the Y position
      ),
      items: [
        PopupMenuItem(
          child: Text('Copy Text'),
          onTap: () {
            // Perform your copy text functionality here
            Navigator.of(context).pop();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Text copied!')),
            );
          },
        ),
        PopupMenuItem(
          child: Text('Custom Action'),
          onTap: () {
            // Perform your custom action here
            Navigator.of(context).pop();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Custom action performed!')),
            );
          },
        ),
      ],
    );
  }
}

Widget buildCustomContextMenu(BuildContext context, TextSelection selection) {
  return Card(
    elevation: 4.0,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ListTile(
          title: Text('Selected Text:'),
        ),
        ListTile(
          title: Text(
            selection.textInside as String,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        ListTile(
          leading: Icon(Icons.copy),
          title: Text('Copy'),
          onTap: () {
            Clipboard.setData(
                ClipboardData(text: selection.textInside as String));
            Navigator.pop(context); // Close the context menu
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Copied to clipboard')),
            );
          },
        ),
        // Add more custom context menu items as needed.
      ],
    ),
  );
}

void _showWord(Word? word) {
  if (word == null) return;

  print(word);

  for (var d in word.definitions) {
    print('-- $d');
  }

  print('');
}
