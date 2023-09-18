import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scribbleverse/config/theams/colors.dart';
import 'package:scribbleverse/config/theams/fonts.dart';
import 'package:scribbleverse/domain/provider/daily_quotes/daily_quotes_provider.dart';

import 'package:scribbleverse/presentation/views/daily_quotes/widgets/like_button.dart';
import 'package:scribbleverse/presentation/views/daily_quotes/widgets/likes_count.dart';
import 'package:scribbleverse/presentation/views/daily_quotes/widgets/viewers_count.dart';

class ViewDailyQuotes extends StatelessWidget {
  const ViewDailyQuotes({super.key, required this.data});
  final Map<String, dynamic> data;

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
                          const SizedBox(
                            width: 5,
                          ),
                          const Icon(
                            Icons.draw_sharp,
                            color: white,
                          )
                        ],
                      ),
                    ),
                  )),
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
                      image: const AssetImage(
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
                              data: const TextSelectionThemeData(
                                selectionColor: Colors
                                    .green, // Set your desired selection color
                                selectionHandleColor: Colors.green,
                              ),
                              child: Align(
                                alignment: data['content_alignment'] ==
                                        'TextAlign.center'
                                    ? Alignment.center
                                    : Alignment.topLeft,
                                child: Text(
                                  data['content'],
                                  style: addPoem.selectedFontTextStyle,
                                  maxLines: 9,
                                ),
                              )
                              //  TextField(
                              //   focusNode: addPoem.contentFocusNode,
                              //   style: addPoem.selectedFontTextStyle,
                              //   textAlign: addPoem.textAlign,
                              //   controller: addPoem.addPoemController,
                              //   onTap: () {
                              //     FocusScope.of(context)
                              //         .requestFocus(addPoem.contentFocusNode);
                              //     addPoem.focus('content');
                              //   },
                              //   onChanged: (value) {
                              //     TextSelection selection =
                              //         addPoem.addPoemController.selection;

                              //     addPoem.selectionHandling(
                              //       selection.start,
                              //       selection.end,
                              //     );
                              //   },
                              //   maxLines: 9,
                              //   maxLength: 200,
                              // ),
                              ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: Row(
                  children: [
                    Flexible(
                        flex: 1,
                        child: SizedBox(
                          height: double.infinity,
                          width: double.infinity,
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.remove_red_eye_outlined,
                                  color: white,
                                ),
                                Padding(
                                    padding: const EdgeInsets.only(left: 5),
                                    child: ViewersCount(
                                        uid: data['user_id'], style: buttonText)

                                    //  Text(
                                    //   '0',
                                    //   style: buttonText,
                                    // ),
                                    )
                              ],
                            ),
                          ),
                        )),
                    Flexible(
                        flex: 1,
                        child: SizedBox(
                          height: double.infinity,
                          width: double.infinity,
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                    onPressed: () async {
                                      await Provider.of<AddDailyQuotesProvider>(
                                              context,
                                              listen: false)
                                          .checkLikes(data['user_id']);
                                    },
                                    icon: LikesButton(
                                      uid: data['user_id'],
                                      baseCollection: "daily_quotes",
                                      icon: const Icon(
                                        Icons.favorite_border,
                                        color: white,
                                      ),
                                    )),
                                Padding(
                                    padding: const EdgeInsets.only(left: 5),
                                    child: LikesCount(
                                        uid: data['user_id'], style: buttonText)

                                    //  Text(
                                    //   '0',
                                    //   style: buttonText,
                                    // ),
                                    )
                              ],
                            ),
                          ),
                        )),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
