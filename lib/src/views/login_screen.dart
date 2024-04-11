import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:onax_app/src/controllers/loginController.dart';

import 'components/login/form_login.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  late double h, w;
  @override
  Widget build(BuildContext context) {
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;
    final LoginController _loginController = LoginController();
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.indigo,
        body: GetBuilder<LoginController>(
          init: _loginController,
          builder: (_) {
            return SafeArea(
              child: Container(
                width: w,
                height: h,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                    image: AssetImage(
                      'assets/img/backgroundOnax.png',
                    ),
                    fit: BoxFit.fitHeight,
                  ),
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: FormLogin(controller: _),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
