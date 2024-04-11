// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

Widget ButtonWidget(String text, Function? callback,
    {bool isDanger = false, bool addPadding = true}) {
  return Container(
    height: 56,
    margin: addPadding ? const EdgeInsets.only(top: 32) : null,
    width: double.maxFinite,
    child: ElevatedButton(
      child: Text(
        text,
      ),
      onPressed: () {
        if (callback != null) callback();
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: !isDanger
            ? const Color.fromARGB(255, 0, 9, 38)
            : const Color.fromARGB(255, 231, 90, 91),
      ),
    ),
  );
}
