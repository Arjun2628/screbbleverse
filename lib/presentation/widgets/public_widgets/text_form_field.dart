import 'package:flutter/material.dart';

class TextFIeldWidget extends StatelessWidget {
  final String hintText;
  String? Function(String?)? validate;
  final TextEditingController controller;

  TextFIeldWidget(
      {super.key,
      required this.hintText,
      required this.controller,
      this.validate});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validate,
      //  (value) {
      //   if (value == '') {
      //     return 'Enter password';
      //   } else if (value!.length < 6) {
      //     return 'password in 6 characters';
      //   }
      //   return null;
      // },
      obscureText: true,
      enableSuggestions: false,
      autocorrect: false,
      // controller: _passwordController,
      decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide.none),
          border: InputBorder.none,
          fillColor: Colors.white,
          filled: true,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide.none),
          hintText: hintText),
    );
  }
}
