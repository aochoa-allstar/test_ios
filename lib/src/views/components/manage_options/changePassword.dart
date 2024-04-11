// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:onax_app/src/controllers/manageSettingController.dart';

import '../textFields/inputDesing.dart';

class ManageChangePassword extends StatelessWidget {
  final ManageSettingsController controllers;
  ManageChangePassword({Key? key, required this.controllers}) : super(key: key);
  late double h, w;
  @override
  Widget build(BuildContext context) {
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.indigo,
      body: SafeArea(
        child: Center(
          child: _content(),
        ),
      ),
    );
  }

  _content() {
    return Container(
      child: Column(
        children: [
          Spacer(),
          _inputPassword(),
          SizedBox(
            height: h * 0.02,
          ),
          _confirmPassword(),
          SizedBox(
            height: h * 0.06,
          ),
          _btnChange(),
          Spacer(),
        ],
      ),
    );
  }

  _inputPassword() {
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
          obscureText: true,
          //keyboardType: TextInputType.visiblePassword,
          cursorColor: Colors.white,
          controller: controllers.password,
          textAlign: TextAlign.center,
          autofocus: false,
          style: const TextStyle(fontSize: 14.0, color: Colors.white),
          decoration: InputDesingOwn().userInputDecoration('Password'),
        ),
      ),
    );
  }

  _confirmPassword() {
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
          obscureText: true,
          //keyboardType: TextInputType.visiblePassword,
          cursorColor: Colors.white,
          controller: controllers.confirmPassword,
          textAlign: TextAlign.center,
          autofocus: false,
          style: const TextStyle(fontSize: 14.0, color: Colors.white),
          decoration: InputDesingOwn().userInputDecoration('Confirm password'),
        ),
      ),
    );
  }

  _btnChange() {
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
            await controllers.changePassword();
          },
          child: const Text('Accept')),
    );
  }
}
