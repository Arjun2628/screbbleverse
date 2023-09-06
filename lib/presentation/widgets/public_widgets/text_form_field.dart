import 'package:flutter/material.dart';

import '../../../config/theams/colors.dart';

class TextFIeldWidget extends StatelessWidget {
  final String hintText;
  final bool type;
  String? Function(String?)? validate;
  final TextEditingController controller;

  TextFIeldWidget(
      {super.key,
      required this.hintText,
      required this.controller,
      this.validate,
      required this.type});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validate,
      obscureText: type,
      enableSuggestions: false,
      autocorrect: false,
      decoration: InputDecoration(
          errorStyle: const TextStyle(
            color: Colors.yellow,
          ),
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
              borderSide: const BorderSide(color: Colors.grey, width: 1)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(color: Colors.red, width: 1)),
          fillColor: Colors.white,
          filled: true,
          // enabledBorder: OutlineInputBorder(
          //     borderRadius: BorderRadius.circular(20),
          //     borderSide: BorderSide.none),
          hintText: hintText),
    );
  }
}
