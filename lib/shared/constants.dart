import 'package:flutter/material.dart';

InputDecoration formInputDecoration(String text, BuildContext context) {
  return InputDecoration(
    hintText: text,
    fillColor: Colors.white,
    filled: true,
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.white,
        width: 2,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Theme.of(context).primaryColor,
        width: 2,
      ),
    ),
  );
}
