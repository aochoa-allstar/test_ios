// ignore_for_file: prefer_const_constructors

import 'package:flutter/rendering.dart';

class ThemeWhite {
  TextStyle underLineTextAction(
    Color color,
  ) {
    return TextStyle(
      color: color,
      fontSize: 14,
      decoration: TextDecoration.underline,
      decorationColor: color,
      fontFamily: 'Poppins',
      letterSpacing: 0.50,
      fontWeight: FontWeight.w400,
    );
  }

  TextStyle labelNameCardsWorker(Color color) {
    return TextStyle(
      fontSize: 13,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w700,
      color: color,
    );
  }

  TextStyle labelBtnActions(Color color) {
    return TextStyle(
      fontSize: 14,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w500,
      color: color,
      letterSpacing: 0.75,
    );
  }

  TextStyle labelCompanyCardsWorker(Color color) {
    return TextStyle(
      fontSize: 12,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w500,
      color: color,
    );
  }

  TextStyle labelHomeTitles(Color color) {
    return TextStyle(
        fontSize: 12,
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w500,
        color: color,
        letterSpacing: 0.5);
  }

  TextStyle labelCheckbox(Color color) {
    return TextStyle(
        fontSize: 13,
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w500,
        color: color,
        letterSpacing: 0);
  }

  TextStyle labelStatusShift(Color color) {
    return TextStyle(
      fontSize: 11,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w500,
      color: color,
    );
  }

  TextStyle titleBar(Color color) {
    return TextStyle(
      fontSize: 24,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w600,
      color: color,
      letterSpacing: 0.5,
    );
  }

  TextStyle dateTicket(Color color) {
    return TextStyle(
      fontFamily: 'Poppins',
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: color,
    );
  }
}
