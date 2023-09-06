import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scribbleverse/config/theams/colors.dart';
import 'package:scribbleverse/config/theams/fonts.dart';
import 'package:scribbleverse/domain/provider/profile/add_profile_provider.dart';
import 'package:scribbleverse/util/constants/constants.dart';

class About extends StatelessWidget {
  const About({
    super.key,
    required this.tittle,
  });
  final String tittle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 25),
          child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'About :',
                style: buttonText,
              )),
        ),
        Padding(
          padding: const EdgeInsets.all(23),
          child: Consumer<AddProfileProvider>(
            builder: (context, addprofile, child) => Form(
              key: tittle == 'Add'
                  ? addprofile.aboutKey
                  : addprofile.aboutEditKey,
              child: TextFormField(
                validator: (value) {
                  if (value == '' || value == null || value.isEmpty) {
                    return 'enter username';
                  } else if (value.length < 5) {
                    return 'enter minimun 5';
                  }
                  return null;
                },
                onChanged: (value) {
                  addprofile.aboutKey.currentState!.validate();
                },
                controller: addprofile.aboutController,
                style: buttonTextDark,
                maxLines: 4,
                decoration: InputDecoration(
                    fillColor: white,
                    filled: true,
                    helperStyle: const TextStyle(color: Colors.amber),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(color: white)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(color: white)),
                    // disabledBorder: OutlineInputBorder(
                    //     borderSide: BorderSide(color: white, width: 1)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide:
                            const BorderSide(color: Colors.grey, width: 1)),
                    errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(
                            color: Color.fromARGB(255, 228, 24, 24), width: 1)),
                    errorStyle: Constants.error),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
