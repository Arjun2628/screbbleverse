import 'package:flutter/material.dart';
import 'package:scribbleverse/presentation/views/profile/widgets/add_image.dart';

import '../../../../config/theams/colors.dart';
import '../widgets/about.dart';
import '../widgets/date_of_birth.dart';
import '../widgets/gender_selection.dart';
import '../widgets/phone_number.dart';
import '../widgets/submit_button.dart';
import '../widgets/username.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({super.key});

  static const String routName = '/edit_profile';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(fit: StackFit.expand, children: [
        ColorFiltered(
          colorFilter: backgroundFilter,
          child: Image.asset(
            'lib/data/datasources/local/images/BG58-01.jpg',
            fit: BoxFit.cover,
          ),
        ),
        SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: const [
              AddImage(tittle: 'Edit image'),
              UserName(tittle: 'Edit image'),
              DateOfBirthSelection(),
              Gender(),
              PhoneNumber(tittle: 'Edit image'),
              About(tittle: 'Edit image'),
              SubmitButton(tittle: 'Edit'),
            ],
          ),
        )),
      ]),
    );
  }
}
