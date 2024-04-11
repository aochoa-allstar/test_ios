// ignore_for_file: avoid_unnecessary_containers, must_be_immutable

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:onax_app/src/controllers/authController.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({Key? key}) : super(key: key);
  late double h, w;

  @override
  Widget build(BuildContext context) {
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;
    final AuthController authController = AuthController();

    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<AuthController>(
        init: authController,
        builder: (_) {
          return Center(
            child: SizedBox(
              width: w * 0.6,
              height: h * 0.4,
              //color: Colors.red,
              child: Center(
                  child: Image.asset(
                'assets/img/splashLogo.png',
                fit: BoxFit.contain,
                width: w * 0.5,
              )),
            ),
          );
        },
      ),
    );
  }
}
