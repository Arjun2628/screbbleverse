import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scribbleverse/presentation/widgets/public_widgets/text_form_field.dart';

import '../../../../config/theams/colors.dart';
import '../../../../config/theams/fonts.dart';
import '../../../../domain/provider/authentication/sign_up_with_email.dart';
import '../../../../domain/provider/authentication/sign_up_with_google.dart';

class FormArea extends StatelessWidget {
  FormArea({
    super.key,
    required this.regExp,
    required bool isPressed,
  }) : _isPressed = isPressed;

  final RegExp regExp;
  final bool _isPressed;
  // final GlobalKey<FormState> _formKey;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(15, 35, 15, 0),
            child: Text(
              'Sign up',
              style: mainFont,
              // TextStyle(fontSize: 28, color: Colors.white),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 40, 15, 0),
            child: Consumer<SignUpWithEmailProvider>(
              builder: (context, value, child) => Container(
                width: double.infinity,
                height: 55,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(20)),
                child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: TextFIeldWidget(
                      hintText: 'Email',
                      controller: value.emailController,
                      validate: (p0) {
                        if (p0 == '') {
                          return 'Enter Email';
                        } else if (p0!.length < 6) {
                          return 'password in 6 characters';
                        }
                        return null;
                      },
                    )),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
            child: Consumer<SignUpWithEmailProvider>(
              builder: (context, value, child) => Container(
                width: double.infinity,
                height: 55,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: TextFIeldWidget(
                    hintText: 'Password',
                    controller: value.passwordController,
                    validate: (p0) {
                      if (p0 == '') {
                        return 'Enter password';
                      } else if (p0!.length < 6) {
                        return 'password in 6 characters';
                      }
                      return null;
                    },
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
            child: Consumer<SignUpWithEmailProvider>(
              builder: (context, value, child) => Container(
                width: double.infinity,
                height: 55,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: TextFIeldWidget(
                    hintText: 'Confirm password',
                    controller: value.confirmPasswordController,
                    validate: (p0) {
                      if (p0 == '') {
                        return 'Confirm password';
                      } else if (p0!.length < 6) {
                        return 'password in 6 characters';
                      }
                      return null;
                    },
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
            child: SizedBox(
              width: double.infinity,
              child: GestureDetector(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  curve: Curves.easeInOut,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: _isPressed
                        ? [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              offset: const Offset(0, 4),
                              blurRadius: 8,
                            ),
                          ]
                        : [],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                          child: Text(
                        'Already have an account?',
                        style: forgotPassword,
                      )),
                      Consumer<SignUpWithEmailProvider>(
                        builder: (context, value, child) => ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: signElivated,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                showDialog(
                                    context: context,
                                    builder: ((context) {
                                      return const Center(
                                          child: CircularProgressIndicator());
                                    }));
                                await FirebaseAuth.instance
                                    .createUserWithEmailAndPassword(
                                        email: value.emailController.text,
                                        password: value.passwordController.text)
                                    .then((value) {
                                  Navigator.pushNamed(context, '/home');
                                });
                                onError:
                                ((error, stackTrace) {});
                              }
                            },
                            child: Text(
                              'Sign up',
                              style: buttonText,
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  flex: 1,
                  child: GestureDetector(
                    onTap: () async {
                      await Provider.of<SignUpWithGoogleProvider>(context,
                              listen: false)
                          .googleSignUp();
                      // ignore: use_build_context_synchronously
                      Navigator.pushNamed(context, '/home');
                    },
                    child: const CircleAvatar(
                      radius: 25,
                      backgroundColor: white,
                      child: Image(
                          image: AssetImage(
                              'lib/data/datasources/local/images/[removal.ai]_f42b415b-cb8f-4c0e-ae5a-e703aafb692d_google-logo-isolated-editorial-icon-free-vector.png')),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                const Flexible(
                  flex: 1,
                  child: CircleAvatar(
                    radius: 25,
                    backgroundColor: Color.fromRGBO(25, 60, 136, 0.612),
                    child: Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Image(
                          image: AssetImage(
                              'lib/data/datasources/local/images/[removal.ai]_c95c93fb-b2e6-431c-8ecf-caa51f3f06d6-images.png')),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
