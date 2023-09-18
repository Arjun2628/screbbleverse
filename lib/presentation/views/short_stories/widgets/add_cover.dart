import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scribbleverse/config/theams/fonts.dart';
import 'package:scribbleverse/domain/provider/short_stories/read_short_story_provider.dart';
import 'package:scribbleverse/util/constants/constants.dart';

import '../../../../domain/provider/profile/add_profile_provider.dart';

class AddCover extends StatelessWidget {
  const AddCover({
    super.key,
    required this.tittle,
  });

  final String tittle;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: double.infinity,
      child: Row(
        children: [
          Flexible(
            flex: 1,
            child: Consumer<ReadShortStoriesProvider>(
              builder: (context, value, child) => SizedBox(
                height: 200,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: GestureDetector(
                      onTap: () async {
                        await value.selectPhoto(context);
                      },
                      child: tittle == 'Add cover'
                          ? value.photo == null
                              ? Container(
                                  height: double.infinity,
                                  width: double.infinity,
                                  decoration: const BoxDecoration(
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: AssetImage(
                                              'lib/data/datasources/local/images/addProfile.png'))),
                                )
                              : Consumer<ReadShortStoriesProvider>(
                                  builder: (context, value1, child) =>
                                      Container(
                                        height: double.infinity,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: FileImage(
                                                    File(value1.photo!.path)))),
                                      ))
                          : Consumer<ReadShortStoriesProvider>(
                              builder: (context, value, child) => Container(
                                    height: double.infinity,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image:
                                                NetworkImage(value.imageUri))),
                                  ))),
                ),
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: SizedBox(
                height: 200,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () async {
                            Provider.of<ReadShortStoriesProvider>(context,
                                    listen: false)
                                .selectPhoto(context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(top: 70),
                            child: Consumer<AddProfileProvider>(
                              builder: (context, value, child) => Column(
                                children: [
                                  Text(
                                    tittle,
                                    style: headdingText,
                                  ),
                                  Visibility(
                                    visible: value.errorImage,
                                    child: Text(
                                      '* Image required',
                                      style: Constants.error,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      )),
                )),
          )
        ],
      ),
    );
  }
}
