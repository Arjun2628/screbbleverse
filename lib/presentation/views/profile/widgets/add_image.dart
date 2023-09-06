import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scribbleverse/config/theams/fonts.dart';
import 'package:scribbleverse/util/constants/constants.dart';

import '../../../../domain/provider/profile/add_profile_provider.dart';

class AddImage extends StatelessWidget {
  const AddImage({
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
            child: Consumer<AddProfileProvider>(
              builder: (context, value, child) => SizedBox(
                height: 200,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: GestureDetector(
                      onTap: () async {
                        value.selectPhoto(context);
                      },
                      child: tittle == 'Add image'
                          ? value.photo == null
                              ? const CircleAvatar(
                                  radius: double.infinity,
                                  backgroundColor: Colors.black,
                                  backgroundImage: AssetImage(
                                      'lib/data/datasources/local/images/addProfile.png'),
                                )
                              : CircleAvatar(
                                  radius: double.infinity,
                                  backgroundColor: Colors.black,
                                  backgroundImage:
                                      FileImage(File(value.photo!.path)),
                                )
                          : Consumer<AddProfileProvider>(
                              builder: (context, value, child) => CircleAvatar(
                                radius: double.infinity,
                                backgroundColor: Colors.black,
                                backgroundImage: NetworkImage(value.imageUri),
                              ),
                            )
                      // : CircleAvatar(
                      //     radius: double.infinity,
                      //     backgroundColor: Colors.black,
                      //     backgroundImage: FileImage(File(value.photo!.path)),
                      //   ),
                      ),
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
                            Provider.of<AddProfileProvider>(context,
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
