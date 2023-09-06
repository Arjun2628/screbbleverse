import 'package:flutter/material.dart';

import 'package:scribbleverse/config/theams/colors.dart';

import 'package:scribbleverse/presentation/views/profile/widgets/about.dart';
import 'package:scribbleverse/presentation/views/profile/widgets/add_image.dart';

import '../widgets/date_of_birth.dart';
import '../widgets/gender_selection.dart';
import '../widgets/phone_number.dart';
import '../widgets/submit_button.dart';
import '../widgets/username.dart';

class AddProfile extends StatelessWidget {
  const AddProfile({super.key});

  static const String routName = '/add_profile';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(fit: StackFit.expand, children: [
        ColorFiltered(
          colorFilter: backgroundFilter,
          child: Image.asset(
            'lib/data/datasources/local/images/istockphoto-1353780638-612x612.jpg',
            fit: BoxFit.cover,
          ),
        ),
        SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: const [
              AddImage(tittle: 'Add image'),
              UserName(
                tittle: 'Add',
              ),
              DateOfBirthSelection(),
              Gender(),
              PhoneNumber(
                tittle: 'Add',
              ),
              About(
                tittle: 'Add',
              ),
              SubmitButton(
                tittle: 'Add',
              ),
            ],
          ),
        )),
      ]),
    );
  }
}
