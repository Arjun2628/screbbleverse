import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scribbleverse/config/theams/colors.dart';
import 'package:scribbleverse/config/theams/fonts.dart';
import 'package:scribbleverse/domain/provider/poems/poems_provider.dart';
import 'package:scribbleverse/domain/provider/public/public_provider.dart';
import 'package:scribbleverse/presentation/views/poems/widgets/caption.dart';
import 'package:scribbleverse/presentation/views/profile/widgets/about.dart';

class PoemRendering extends StatelessWidget {
  const PoemRendering({super.key});

  static const String routName = '/render_poem';

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
        child: ListView(
          children: [
            // Padding(
            //   padding: const EdgeInsets.only(top: 20),
            //   child: Caption(tittle: 'bjhbjhb'),
            // ),
            Padding(
              padding: const EdgeInsets.only(right: 25, top: 20),
              child: Container(
                height: 40,
                width: double.infinity,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        'Caption :',
                        style: buttonText,
                      ),
                    ),
                    Expanded(child: Container()),
                    ElevatedButton(
                        onPressed: () async {
                          await Provider.of<AddPoemProvider>(context,
                                  listen: false)
                              .addPoem(Provider.of<PublicProvider>(context,
                                      listen: false)
                                  .user);
                          Navigator.pop(context);
                          Navigator.pop(context);
                          // Navigator.popUntil(
                          //     context, (route) => routName == '/view_poems');
                        },
                        child: Text(
                          'Add Poem',
                          style: buttonTextBlack,
                        ))
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(5, 5, 15, 15),
              child: Consumer<AddPoemProvider>(
                builder: (context, value, child) => Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(5)),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextField(
                      controller: value.captionController,
                      decoration:
                          const InputDecoration(filled: true, fillColor: white),
                      maxLines: 2,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                'Final output :',
                style: buttonText,
              ),
            ),
            Consumer<AddPoemProvider>(
                builder: (context, addPoem, child) => Padding(
                      padding:
                          const EdgeInsets.only(top: 15, left: 15, right: 15),
                      child: Consumer<PublicProvider>(
                        builder: (context, value, child) => Column(
                          children: [
                            // Container(
                            //   height: 60,
                            //   color: white,
                            //   child: ListTile(
                            //     trailing: ElevatedButton(
                            //         onPressed: () {}, child: Text('Add')),
                            //     // leading: Padding(
                            //     //   padding: const EdgeInsets.only(
                            //     //     bottom: 10,
                            //     //   ),
                            //     //   child: CircleAvatar(
                            //     //     radius: 25,
                            //     //     backgroundColor: Colors.amber,
                            //     //     backgroundImage:
                            //     //         NetworkImage(value.user!.profileImage!),
                            //     //   ),
                            //     // ),
                            //     // title: Text(
                            //     //   'kjnlkbiubjkbohjnouhlklih',
                            //     //   style: buttonTextBlack,
                            //     // ),
                            //     // subtitle: Row(
                            //     //   children: [
                            //     //     Text(
                            //     //       value.user!.userName!,
                            //     //       style: buttonTextBlack,
                            //     //     ),
                            //     //     const SizedBox(
                            //     //       width: 5,
                            //     //     ),
                            //     //     const CircleAvatar(
                            //     //       radius: 8,
                            //     //     )
                            //     //   ],
                            //     // ),
                            //     // trailing: Icon(Icons.more_vert_rounded),
                            //   ),
                            // ),
                            Container(
                              decoration: BoxDecoration(
                                  image: addPoem.image == '' ||
                                          addPoem.templateIndex < 4
                                      ? DecorationImage(
                                          fit: BoxFit.cover,
                                          image: AssetImage(
                                              addPoem.templateList[
                                                  addPoem.templateIndex]))
                                      : DecorationImage(
                                          fit: BoxFit.cover,
                                          image: FileImage(
                                              File(addPoem.photo!.path)))),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 450,
                                    width: double.infinity,
                                    // color: Colors.amber,
                                    // decoration: BoxDecoration(
                                    //     image: DecorationImage(
                                    //         fit: BoxFit.cover,
                                    //         image: AssetImage(value.templateList[
                                    //             data['template_index']]))),
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          15, 15, 15, 0),
                                      child: ListView(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        children: [
                                          TextField(
                                            controller: addPoem
                                                .addPoemHeadFinalController,
                                            focusNode: addPoem.headingFocusNode,
                                            // style: TextStyle(
                                            //     fontSize: 20, color: addPoem.headingColor),
                                            style: addPoem
                                                .selectedFontTextStyleHeading,
                                            onTap: () {
                                              FocusScope.of(context)
                                                  .requestFocus(
                                                      addPoem.headingFocusNode);
                                              addPoem.focus('heading');
                                            },
                                            textAlign: addPoem.textAlignHead,
                                            decoration: InputDecoration(
                                                suffixIcon: IconButton(
                                                    onPressed: () {
                                                      addPoem
                                                          .colorArea(context);
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
                                              selectionHandleColor:
                                                  Colors.green,
                                            ),
                                            child: TextField(
                                              focusNode:
                                                  addPoem.contentFocusNode,
                                              style:
                                                  addPoem.selectedFontTextStyle,
                                              textAlign: addPoem.textAlign,
                                              controller: addPoem
                                                  .addPoemFinalController,
                                              onTap: () {
                                                FocusScope.of(context)
                                                    .requestFocus(addPoem
                                                        .contentFocusNode);
                                                addPoem.focus('content');
                                              },
                                              onChanged: (value) {
                                                TextSelection selection =
                                                    addPoem.addPoemController
                                                        .selection;

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
                                  SizedBox(
                                    height: 20,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Container(),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 10),
                                          child: Container(
                                            // color: Colors.amber,
                                            child: Text(
                                              'Read more...',
                                              style: buttonTextBlack,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              height: 45,
                              color: Colors.brown,
                            ),
                          ],
                        ),
                      ),
                    )),
          ],
        ),
      ),
    );
  }
}
