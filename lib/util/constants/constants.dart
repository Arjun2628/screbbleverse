import 'package:flutter/material.dart';

class Constants {
  //Email regExp
  static RegExp regExp =
      RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$');
  static TextStyle error = const TextStyle(
    color: Colors.yellow,
  );
}
