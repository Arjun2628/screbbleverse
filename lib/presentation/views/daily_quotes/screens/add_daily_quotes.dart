import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scribbleverse/config/theams/colors.dart';
import 'package:scribbleverse/config/theams/fonts.dart';
import 'package:scribbleverse/domain/provider/daily_quotes/daily_quotes_provider.dart';
import 'package:scribbleverse/domain/provider/poems/poems_provider.dart';
import 'package:scribbleverse/domain/provider/public/public_provider.dart';
import 'package:scribbleverse/presentation/views/poems/screens/add_poems.dart';
import 'package:scribbleverse/presentation/views/poems/widgets/poem_template.dart';

class AddDailyQuotes extends StatelessWidget {
  static const String routName = '/add_poems';

  const AddDailyQuotes({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                opacity: 0.9,
                fit: BoxFit.cover,
                image: AssetImage(
                    'lib/data/datasources/local/images/BG58-01.jpg'))),
        child: SafeArea(
          child: ListView(
            children: [
              Row(
                children: [
                  Expanded(
                      child: Container(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20, top: 10),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: [
                            Text(
                              'Daily quotes',
                              style: headdingText,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(
                              Icons.draw_sharp,
                              color: white,
                            )
                          ],
                        ),
                      ),
                    ),
                  )),
                  Padding(
                    padding: const EdgeInsets.only(right: 15, top: 15),
                    child: GestureDetector(
                      onTap: () async {
                        await Provider.of<AddDailyQuotesProvider>(context,
                                listen: false)
                            .addDailyQuotes(Provider.of<PublicProvider>(context,
                                    listen: false)
                                .user);
                        Navigator.pop(context);
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
              Consumer<AddDailyQuotesProvider>(
                builder: (context, addPoem, child) => Padding(
                  padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                  child: Container(
                    height: 470,
                    width: double.infinity,
                    // color: Colors.white,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      fit: BoxFit.cover,
                      opacity: addPoem.backgroundOpacity,
                      image: AssetImage(
                          "lib/data/datasources/local/images/[removal.ai]_255b6677-8f24-488b-b257-fb567e6e9474-617fa35f9105137354ee05460ae611b7.png"),
                      //  addPoem.templateIndex == 4
                      //     ? addPoem.photo != null
                      //         ? DecorationImage(
                      //             // opacity: 0.9,
                      //             opacity: addPoem.backgroundOpacity,
                      //             fit: BoxFit.cover,
                      //             image: FileImage(addPoem.photo!),
                      //           )
                      //         : DecorationImage(
                      //             fit: BoxFit.cover,
                      //             opacity: addPoem.backgroundOpacity,
                      //             image: AssetImage(addPoem.templateList[0]))
                      //     : DecorationImage(
                      //         fit: BoxFit.cover,
                      //         opacity: addPoem.backgroundOpacity,
                      //         image: AssetImage(addPoem.template))
                    )),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(75, 85, 65, 65),
                      child: ListView(
                        children: [
                          // TextField(
                          //   controller: addPoem.addPoemHeadController,
                          //   focusNode: addPoem.headingFocusNode,
                          //   // style: TextStyle(
                          //   //     fontSize: 20, color: addPoem.headingColor),
                          //   style: addPoem.selectedFontTextStyleHeading,
                          //   onTap: () {
                          //     FocusScope.of(context)
                          //         .requestFocus(addPoem.headingFocusNode);
                          //     addPoem.focus('heading');
                          //   },
                          //   textAlign: addPoem.textAlignHead,
                          //   decoration: InputDecoration(
                          //       suffixIcon: IconButton(
                          //           onPressed: () {
                          //             addPoem.colorArea(context);
                          //           },
                          //           icon: const Icon(
                          //             Icons.color_lens,
                          //             color: Colors.black,
                          //           ))),
                          // ),
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
                              maxLines: 9,
                              maxLength: 200,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Consumer<AddDailyQuotesProvider>(
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
      bottomNavigationBar: Consumer<AddDailyQuotesProvider>(
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
                                          Consumer<AddDailyQuotesProvider>(
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
                                            Consumer<AddDailyQuotesProvider>(
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
                              Consumer<AddDailyQuotesProvider>(
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
