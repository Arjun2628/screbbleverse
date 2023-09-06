import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scribbleverse/config/theams/colors.dart';
import 'package:scribbleverse/config/theams/fonts.dart';
import 'package:scribbleverse/domain/provider/poems/poems_provider.dart';
import 'package:scribbleverse/domain/provider/public/public_provider.dart';
import 'package:scribbleverse/presentation/views/poems/widgets/poem_template.dart';

class AddPoems extends StatelessWidget {
  static const String routName = '/add_poems';

  const AddPoems({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                opacity: 0.9,
                fit: BoxFit.cover,
                image: AssetImage(
                    'lib/data/datasources/local/images/istockphoto-1353780638-612x612.jpg'))),
        child: SafeArea(
          child: ListView(
            children: [
              Row(
                children: [
                  Expanded(child: Container()),
                  Padding(
                    padding: const EdgeInsets.only(right: 15, top: 15),
                    child: GestureDetector(
                      onTap: () async {
                        Provider.of<AddPoemProvider>(context, listen: false)
                            .finalOutText();
                        Navigator.pushNamed(context, '/render_poem');
                        // await Provider.of<AddPoemProvider>(context,
                        //         listen: false)
                        //     .addPoem(Provider.of<PublicProvider>(context,
                        //             listen: false)
                        //         .user);
                      },
                      child: Container(
                        height: 35,
                        width: 90,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey
                                    .withOpacity(0.2), // Shadow color
                                spreadRadius: 5, // How far the shadow spreads
                                blurRadius: 7, // Soften the shadow
                                offset: const Offset(
                                    0, 3), // Offset in x and y directions
                              ),
                            ]),
                        child: const Padding(
                          padding: EdgeInsets.only(left: 7),
                          child: Center(
                              child: Text(
                            'Done',
                            style: TextStyle(fontSize: 17),
                          )),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Consumer<AddPoemProvider>(
                builder: (context, addPoem, child) => Padding(
                  padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                  child: Container(
                    height: 470,
                    width: double.infinity,
                    // color: Colors.white,
                    decoration: BoxDecoration(
                        image: addPoem.templateIndex == 4
                            ? addPoem.photo != null
                                ? DecorationImage(
                                    // opacity: 0.9,
                                    opacity: addPoem.backgroundOpacity,
                                    fit: BoxFit.cover,
                                    image: FileImage(addPoem.photo!),
                                  )
                                : DecorationImage(
                                    fit: BoxFit.cover,
                                    opacity: addPoem.backgroundOpacity,
                                    image: AssetImage(addPoem.templateList[0]))
                            : DecorationImage(
                                fit: BoxFit.cover,
                                opacity: addPoem.backgroundOpacity,
                                image: AssetImage(addPoem.template))),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: ListView(
                        children: [
                          TextField(
                            controller: addPoem.addPoemHeadController,
                            focusNode: addPoem.headingFocusNode,
                            // style: TextStyle(
                            //     fontSize: 20, color: addPoem.headingColor),
                            style: addPoem.selectedFontTextStyleHeading,
                            onTap: () {
                              FocusScope.of(context)
                                  .requestFocus(addPoem.headingFocusNode);
                              addPoem.focus('heading');
                            },
                            textAlign: addPoem.textAlignHead,
                            decoration: InputDecoration(
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      addPoem.colorArea(context);
                                    },
                                    icon: const Icon(
                                      Icons.color_lens,
                                      color: Colors.black,
                                    ))),
                          ),
                          TextSelectionTheme(
                            data: TextSelectionThemeData(
                              selectionColor: Colors
                                  .green, // Set your desired selection color
                              selectionHandleColor: Colors.green,
                            ),
                            child: TextField(
                              focusNode: addPoem.contentFocusNode,
                              style: addPoem.selectedFontTextStyle,
                              textAlign: addPoem.textAlign,
                              controller: addPoem.addPoemController,
                              onTap: () {
                                FocusScope.of(context)
                                    .requestFocus(addPoem.contentFocusNode);
                                addPoem.focus('content');
                              },
                              onChanged: (value) {
                                TextSelection selection =
                                    addPoem.addPoemController.selection;

                                addPoem.selectionHandling(
                                  selection.start,
                                  selection.end,
                                );
                              },
                              maxLines: 15,
                              maxLength: 1000,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Consumer<AddPoemProvider>(
                builder: (context, value, child) => Padding(
                  padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                  child: Container(
                    height: 100,
                    width: double.infinity,
                    color: Colors.brown,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: value.templateList.length,
                      itemBuilder: (context, index) {
                        return PoemTemplates(
                          index: index,
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Consumer<AddPoemProvider>(
        builder: (context, value, child) => BottomNavigationBar(
            onTap: (index) async {
              if (index == 1) {
                value.fonttItalic(
                    value.focusHead == true ? 'heading' : 'content');
              } else if (index == 0) {
                // value.textAlignment('center');
                value.boldText(value.focusHead == true ? 'heading' : 'content');
              } else if (index == 2) {
                // value.textAlignment('center');
                value.underlineText(
                    value.focusHead == true ? 'heading' : 'content');
              } else if (index == 3) {
                value.textAlignment(
                    'left', value.focusHead == true ? 'heading' : 'content');

                // value.pickFont(context);
              } else if (index == 4) {
                value.textAlignment(
                    'center', value.focusHead == true ? 'heading' : 'content');

                // value.boldText();
              } else if (index == 5) {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Container(
                        height: 300,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30)),
                          color: black,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(25, 40, 25, 0),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 45,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      child: Row(
                                        children: [
                                          Consumer<AddPoemProvider>(
                                              builder: (context, poem, child) =>
                                                  Text(poem.focusContent == true
                                                      ? poem.currentFont
                                                      : poem
                                                          .currentFontHeading)),
                                          Expanded(child: Container()),
                                          IconButton(
                                              onPressed: () async {
                                                if (value.focusHead == true) {
                                                  await value.pickFont(
                                                      context, 'heading');
                                                } else if (value.focusContent ==
                                                    true) {
                                                  await value.pickFont(
                                                      context, 'content');
                                                } else {
                                                  print(
                                                      'cursor not in a textField');
                                                }
                                                // value.pickFont(context,);
                                              },
                                              icon: Icon(Icons.arrow_drop_down))
                                        ],
                                      )
                                      //  ListTile(
                                      //   leading: Text('font family'),
                                      //   trailing: IconButton(
                                      //       onPressed: () {},
                                      //       icon: Icon(Icons.arrow_drop_down)),
                                      // ),
                                      ),
                                ),
                              ),
                              Row(
                                children: [
                                  Flexible(
                                    flex: 2,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(0, 8, 8, 8),
                                      child: Container(
                                        height: 45,
                                        width: double.infinity,
                                        color: Colors.black,
                                        child: const Row(
                                          children: [
                                            BottomSheetIconTemplate(
                                              icon: Icon(
                                                Icons.format_bold,
                                                color: white,
                                              ),
                                              selected: 'bold',
                                            ),
                                            BottomSheetIconTemplate(
                                              icon: Icon(
                                                Icons.format_italic,
                                                color: white,
                                              ),
                                              selected: 'italic',
                                            ),
                                            BottomSheetIconTemplate(
                                              icon: Icon(
                                                Icons.format_underline,
                                                color: white,
                                              ),
                                              selected: 'underline',
                                            ),
                                            BottomSheetIconTemplate(
                                              icon: Icon(
                                                Icons.format_color_fill_rounded,
                                                color: white,
                                              ),
                                              selected: 'color',
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  // BottomSheetIconTemplate(),
                                  Flexible(
                                      child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Container(
                                        height: 35,
                                        width: double.infinity,

                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(2),
                                          border: Border.all(
                                              width: 1, color: white),
                                          color: Colors.amber,
                                        ),
                                        // child: DropdownButton(
                                        //   items: ,
                                        //    onChanged: onChanged),
                                        child: Row(
                                          children: [
                                            Consumer<AddPoemProvider>(
                                              builder: (context, poem1,
                                                      child) =>
                                                  Flexible(
                                                      flex: 2,
                                                      child: Container(
                                                        height: double.infinity,
                                                        width: double.infinity,
                                                        color: Colors.black,
                                                        child: Center(
                                                          child: Text(
                                                            poem1.focusHead ==
                                                                    false
                                                                ? poem1.fontSize
                                                                : poem1
                                                                    .fontSizeHead,
                                                            style: buttonText,
                                                          ),
                                                        ),
                                                      )),
                                            ),
                                            Flexible(
                                                flex: 1,
                                                child: Container(
                                                  height: double.infinity,
                                                  width: double.infinity,
                                                  color: Colors.lightBlue,
                                                  child:
                                                      Consumer<AddPoemProvider>(
                                                    builder: (context, poem2,
                                                            child) =>
                                                        Column(
                                                      children: [
                                                        Flexible(
                                                            flex: 1,
                                                            child:
                                                                GestureDetector(
                                                              onTap: () {
                                                                if (poem2
                                                                        .focusHead ==
                                                                    true) {
                                                                  poem2.selectFontSize(
                                                                      'add',
                                                                      'heading');
                                                                } else {
                                                                  poem2.selectFontSize(
                                                                      'add',
                                                                      'content');
                                                                }
                                                              },
                                                              child: Container(
                                                                height: double
                                                                    .infinity,
                                                                width: double
                                                                    .infinity,
                                                                color: white,
                                                                child:
                                                                    const Icon(
                                                                  Icons
                                                                      .arrow_drop_up,
                                                                  color: black,
                                                                ),
                                                              ),
                                                            )),
                                                        Flexible(
                                                            flex: 1,
                                                            child:
                                                                GestureDetector(
                                                              onTap: () {
                                                                if (poem2
                                                                        .focusHead ==
                                                                    true) {
                                                                  poem2.selectFontSize(
                                                                      'substract',
                                                                      'heading');
                                                                } else {
                                                                  poem2.selectFontSize(
                                                                      'substract',
                                                                      'content');
                                                                }
                                                              },
                                                              child: Container(
                                                                height: double
                                                                    .infinity,
                                                                width: double
                                                                    .infinity,
                                                                color: white,
                                                                child: Icon(Icons
                                                                    .arrow_drop_down),
                                                              ),
                                                            )),
                                                      ],
                                                    ),
                                                  ),
                                                ))
                                          ],
                                        ),
                                      ),
                                    ),
                                  ))
                                ],
                              ),
                              const Row(
                                children: [
                                  BottomSheetIconTemplate2(
                                    icon: Icon(
                                      Icons.format_align_center,
                                      color: white,
                                    ),
                                    selected: 'center',
                                  ),
                                  BottomSheetIconTemplate2(
                                    icon: Icon(
                                      Icons.format_align_justify_outlined,
                                      color: white,
                                    ),
                                    selected: 'center',
                                  ),
                                  BottomSheetIconTemplate2(
                                    icon: Icon(
                                      Icons.format_align_left_outlined,
                                      color: white,
                                    ),
                                    selected: 'left',
                                  ),
                                  BottomSheetIconTemplate2(
                                    icon: Icon(
                                      Icons.format_align_right,
                                      color: white,
                                    ),
                                    selected: 'right',
                                  ),

                                  // BottomSheetIconTemplate(
                                  //   icon: Icon(
                                  //     Icons.format_bold,
                                  //     color: white,
                                  //   ),
                                  // ),
                                  // BottomSheetIconTemplate(
                                  //   icon: Icon(
                                  //     Icons.format_bold,
                                  //     color: white,
                                  //   ),
                                  // ),
                                ],
                              ),
                              Consumer<AddPoemProvider>(
                                builder: (context, slider, child) => Slider(
                                  value: slider.sliderValue,
                                  min: 0,
                                  max: 100,
                                  divisions: 100,
                                  thumbColor: white,
                                  onChanged: (value) {
                                    slider.selectSlider(value);
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
            },
            showSelectedLabels: false,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.format_bold_rounded),
                  label: 'templates',
                  backgroundColor: black),
              BottomNavigationBarItem(
                  icon: Icon(Icons.format_italic), label: 'templates'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.format_underline), label: 'templates'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.format_align_left), label: 'templates'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.format_align_center), label: 'templates'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.arrow_drop_down), label: 'templates')
            ]),
      ),
    );
  }
}

class BottomSheetIconTemplate2 extends StatelessWidget {
  const BottomSheetIconTemplate2({
    super.key,
    this.icon,
    required this.selected,
  });

  final Widget? icon;
  final String selected;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Consumer<AddPoemProvider>(
          builder: (context, value, child) => GestureDetector(
            onTap: () {
              value.bottomSheetIconSelection(
                  selected, value.focusHead == true ? 'heading' : 'content');
            },
            child: SizedBox(
                height: 45,
                width: double.infinity,
                // color: Colors.amber,
                child: icon),
          ),
        ),
      ),
    );
  }
}

class BottomSheetIconTemplate extends StatelessWidget {
  const BottomSheetIconTemplate({
    super.key,
    this.icon,
    required this.selected,
  });
  final Widget? icon;
  final String selected;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      child: Consumer<AddPoemProvider>(
        builder: (context, value, child) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              value.bottomSheetIconSelectionStyling(
                  selected, value.focusHead == true ? 'heading' : 'content');
            },
            child: SizedBox(
              height: 45,
              width: double.infinity,
              // color: Colors.amber,
              child: icon,
            ),
          ),
        ),
      ),
    );
  }
}

class DropdownButtonExample extends StatefulWidget {
  const DropdownButtonExample({super.key});

  @override
  State<DropdownButtonExample> createState() => _DropdownButtonExampleState();
}

class _DropdownButtonExampleState extends State<DropdownButtonExample> {
  @override
  Widget build(BuildContext context) {
    List<String> fontList = <String>['One', 'Two', 'Three', 'Four'];
    String dropdownValue = fontList.first;
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_drop_down),
      isExpanded: true,
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
        });
      },
      items: fontList.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}

class ProgressBarDemo extends StatefulWidget {
  @override
  _ProgressBarDemoState createState() => _ProgressBarDemoState();
}

class _ProgressBarDemoState extends State<ProgressBarDemo> {
  double _progressValue = 0.5; // Initial progress value

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Movable Linear Progress Bar')),
      body: Center(
        child: GestureDetector(
          onPanUpdate: (details) {
            setState(() {
              // Calculate the new progress value based on the pan distance
              _progressValue += details.delta.dx / context.size!.width;
              // Ensure the progress value stays within the valid range
              _progressValue = _progressValue.clamp(0.0, 1.0);
            });
          },
          child: LinearProgressIndicator(
            value: _progressValue,
            minHeight: 20.0,
          ),
        ),
      ),
    );
  }
}
