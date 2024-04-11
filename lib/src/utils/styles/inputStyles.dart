import 'package:flutter/material.dart';
import 'package:onax_app/src/utils/styles/themWhite.dart';

class StyleInput {
  inputTextSyle(String hint, Color color) {
    return InputDecoration(
      contentPadding: const EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 0.0),
      border: const OutlineInputBorder(
        borderSide: BorderSide(
          width: 0,
          style: BorderStyle.none,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      labelText: hint,
      labelStyle: ThemeWhite().labelBtnActions(Colors.grey.shade500),
      hintText: hint,
      hintStyle: ThemeWhite().labelBtnActions(Colors.grey.shade300),
      filled: true,
      fillColor: color,
    );
  }

  textAreaStyle(String hint, Color color) {
    return InputDecoration(
      contentPadding: const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
      border: const OutlineInputBorder(
        borderSide: BorderSide(
          width: 0,
          style: BorderStyle.none,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      //labelText: hint,
      //labelStyle: ThemeWhite().labelBtnActions(Colors.grey.shade500),
      hintText: hint,
      hintStyle: ThemeWhite().labelBtnActions(Colors.grey.shade300),
      filled: true,
      fillColor: color,
    );
  }
}
