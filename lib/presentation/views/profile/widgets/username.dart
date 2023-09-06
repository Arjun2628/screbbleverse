import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scribbleverse/config/theams/fonts.dart';

import '../../../../config/theams/colors.dart';
import '../../../../domain/provider/profile/add_profile_provider.dart';

class UserName extends StatelessWidget {
  const UserName({
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
                'Username :',
                style: normal,
              )),
        ),
        Padding(
          padding: const EdgeInsets.all(23),
          child: Consumer<AddProfileProvider>(
            builder: (context, addprofile, child) => SizedBox(
              width: double.infinity,
              // height: 65,
              child: Form(
                key: tittle == 'Add'
                    ? addprofile.userKey
                    : addprofile.userEditKey,
                child: TextFormField(
                  cursorColor: black,
                  validator: (value) {
                    if (value == '' || value == null || value.isEmpty) {
                      return 'enter username';
                    } else if (value.length < 5) {
                      return 'enter minimun 5';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    if (addprofile.userKey.currentState!.validate()) {
                      addprofile.validateSuffixIcon('userName');
                    }
                  },
                  style: buttonTextDark,
                  controller: addprofile.usernameController,
                  decoration: InputDecoration(
                    errorStyle: const TextStyle(
                      color: Colors.yellow,
                    ),
                    fillColor: white,
                    filled: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(color: white, width: 1)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(color: white)),
                    disabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: white, width: 1)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide:
                            const BorderSide(color: Colors.grey, width: 1)),
                    errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide:
                            const BorderSide(color: Colors.red, width: 1)),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
