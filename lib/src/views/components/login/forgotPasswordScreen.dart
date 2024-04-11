import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../controllers/loginController.dart';
import '../textFields/inputDesing.dart';

class ForgotPasswordScreen extends StatelessWidget {
  final LoginController controller;
  ForgotPasswordScreen({Key? key, required this.controller}) : super(key: key);
  late double h, w;
  @override
  Widget build(BuildContext context) {
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.indigo,
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: _content(),
        ),
      ),
    );
  }

  _content() {
    return Container(
      height: h,
      margin: EdgeInsets.symmetric(horizontal: w * 0.15),
      child: Column(
        children: [
          Spacer(),
          _inputEmial(),
          SizedBox(
            height: h * 0.1,
          ),
          _btnResetPassword(),
          Spacer(),
        ],
      ),
    );
  }

  _inputEmial() {
    return Center(
      child: Container(
        width: w * 0.4,
        height: h * 0.055,
        decoration: BoxDecoration(
          // color: Colors.red,
          border: Border.all(
            color: Colors.white,
            width: 1,
            style: BorderStyle.solid,
          ),
          borderRadius: BorderRadius.circular(25.7),
        ),
        child: TextField(
          cursorColor: Colors.white,
          controller: controller.recoveryEmail,
          textAlign: TextAlign.center,
          keyboardType: TextInputType.emailAddress,
          autofocus: false,
          style: const TextStyle(fontSize: 14.0, color: Colors.white),
          decoration: InputDesingOwn().userInputDecoration('Email'),
        ),
      ),
    );
  }

  _btnResetPassword() {
    return Container(
      width: w * 0.4,
      height: h * 0.055,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.white,
          width: 1,
          style: BorderStyle.solid,
        ),
        borderRadius: BorderRadius.circular(25.7),
      ),
      child: TextButton(
          onPressed: () async {
            await controller.recoveryPass();
          },
          child: const Text('Reset Password')),
    );
  }
}
