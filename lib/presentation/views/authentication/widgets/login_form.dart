import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scribbleverse/domain/provider/authentication/login.dart';
import 'package:scribbleverse/domain/provider/public/public_provider.dart';

import '../../../../config/theams/colors.dart';
import '../../../../config/theams/fonts.dart';
import '../../../../domain/provider/authentication/sign_up_with_google.dart';
import '../../../widgets/public_widgets/text_form_field.dart';

class LoginFormArea extends StatelessWidget {
  LoginFormArea({
    super.key,
    required this.regExp,
    required bool isPressed,
  }) : _isPressed = isPressed;

  final RegExp regExp;
  final bool _isPressed;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 35, 15, 0),
            child: Text(
              'Login',
              style: mainFont,
              // TextStyle(fontSize: 28, color: Colors.white),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 40, 15, 0),
            child: Consumer<LoginProvider>(
              builder: (context, value, child) => Container(
                width: double.infinity,
                // height: 55,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(20)),
                child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: TextFIeldWidget(
                      type: false,
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
            padding: const EdgeInsets.fromLTRB(15, 23, 15, 0),
            child: Consumer<LoginProvider>(
              builder: (context, value, child) => Container(
                width: double.infinity,
                // height: 55,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: TextFIeldWidget(
                    type: true,
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
                          child: Consumer<LoginProvider>(
                        builder: (context, value, child) => RichText(
                          text: TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () async {
                                value.resetpassword(context);
                              },
                            text: 'Forgot Password?',
                            style: forgotPassword,
                            children: <TextSpan>[
                              TextSpan(
                                  text: 'Sign up',
                                  style: buttonText,
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.pushNamed(context, '/signUp');
                                    }),
                            ],
                          ),
                        ),
                      )),
                      Consumer<LoginProvider>(
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
                                    .signInWithEmailAndPassword(
                                        email: value.emailController.text,
                                        password: value.passwordController.text)
                                    // .createUserWithEmailAndPassword(
                                    //     email: value.emailController.text,
                                    //     password: value.passwordController.text)
                                    .then((value) async {
                                  await Provider.of<PublicProvider>(context,
                                          listen: false)
                                      .getUserData();
                                  // ignore: use_build_context_synchronously
                                  Navigator.pushNamed(context, '/home');
                                });
                              }
                            },
                            child: Text(
                              'Login',
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
            padding: const EdgeInsets.only(top: 30),
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
                      Navigator.pushNamed(context, '/add_profile');
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
