import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scribbleverse/domain/models/user_moder.dart';
import 'package:scribbleverse/domain/provider/authentication/sign_up_with_email.dart';
import 'package:scribbleverse/domain/provider/public/public_provider.dart';

import '../../../../config/theams/fonts.dart';
import '../../../../domain/provider/profile/add_profile_provider.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({
    super.key,
    required this.tittle,
  });

  final String tittle;

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState>? userKey;
    GlobalKey<FormState>? phoneKey;
    GlobalKey<FormState>? aboutKey;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: Consumer<AddProfileProvider>(
            builder: (context, value, child) => Row(
              children: [
                Expanded(child: Container()),
                Consumer<SignUpWithEmailProvider>(
                  builder: (context, signUp, child) => ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      onPressed: () async {
                        if (tittle == 'Add') {
                          userKey = value.userKey;
                          phoneKey = value.phoneKey;
                          aboutKey = value.aboutKey;
                        } else {
                          userKey = value.userEditKey;
                          phoneKey = value.phoneEditKey;
                          aboutKey = value.aboutEditKey;
                        }

                        if (value.photo != null || tittle == 'Edit') {
                          await value.validationImage('false');
                          if (userKey!.currentState!.validate() &&
                              phoneKey!.currentState!.validate() &&
                              aboutKey!.currentState!.validate()) {
                            if (value.formateDate != 'Month / Day / Year') {
                              if (value.genderName != null) {
                                if (tittle == 'Add') {
                                  showDialog(
                                      context: context,
                                      builder: ((context) {
                                        return const Center(
                                            child: CircularProgressIndicator());
                                      }));
                                  // await FirebaseAuth.instance
                                  //     .createUserWithEmailAndPassword(
                                  //         email: signUp.emailController.text,
                                  //         password:
                                  //             signUp.passwordController.text);

                                  await value.cloudAdd(value.photo!);
                                }
                                Map<String, dynamic> data = {
                                  'userName': value.usernameController.text,
                                  'dateOfBirth': value.formateDate,
                                  'gender': value.genderName,
                                  'phone': value.phoneController.text,
                                  'about': value.aboutController.text,
                                  'profileImage': value.imageUri,
                                  'uid': FirebaseAuth.instance.currentUser!.uid
                                };
                                await value.addProfile(data);
                                UserModel user = UserModel.fromJson(data);
                                await Provider.of<PublicProvider>(context,
                                        listen: false)
                                    .editUser(user);
                                // ignore: use_build_context_synchronously
                                Navigator.pushNamed(context, '/home');
                              } else {}
                            } else {}
                          } else {
                            // value.validationImage('true');
                          }
                        } else {
                          value.validationImage('true');
                        }
                      },
                      child: Text(
                        'Submit',
                        style: buttonTextDark,
                      )),
                )
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        )
      ],
    );
  }
}
