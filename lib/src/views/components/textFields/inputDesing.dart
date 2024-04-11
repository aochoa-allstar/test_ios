import 'package:flutter/material.dart';

class InputDesingOwn {
  InputDecoration userInputDecoration(String hint) {
    return InputDecoration(
      border: InputBorder.none,
      filled: true,
      fillColor: Colors.transparent,
      hintText: hint,
      hintStyle: const TextStyle(
        fontSize: 14.0,
        color: Colors.white,
      ),
      contentPadding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.white),
        borderRadius: BorderRadius.circular(25.7),
      ),
      enabledBorder: UnderlineInputBorder(
        borderSide: const BorderSide(color: Colors.white),
        borderRadius: BorderRadius.circular(25.7),
      ),
    );
  }

  InputDecoration textArea(String hint) {
    return InputDecoration(
      border: InputBorder.none,
      filled: true,
      fillColor: Colors.transparent,
      hintText: hint,
      hintStyle: const TextStyle(
        fontSize: 14.0,
        color: Colors.black,
      ),
      contentPadding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.white),
        borderRadius: BorderRadius.circular(25.7),
      ),
      enabledBorder: UnderlineInputBorder(
        borderSide: const BorderSide(color: Colors.white),
        borderRadius: BorderRadius.circular(25.7),
      ),
    );
  }
}
