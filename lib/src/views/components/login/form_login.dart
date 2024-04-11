// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:onax_app/core/services/network_service.dart';
import 'package:onax_app/src/controllers/loginController.dart';
import 'package:onax_app/src/utils/styles/themWhite.dart';
import 'package:onax_app/src/utils/theme.dart';
import 'package:onax_app/src/views/components/login/forgotPasswordScreen.dart';
import 'package:onax_app/src/views/components/textFields/inputDesing.dart';

class FormLogin extends StatelessWidget {
  NetworkService networkService = Get.find();
  final LoginController controller;
  FormLogin({
    Key? key,
    required this.controller,
  }) : super(key: key);
  late double h, w;
  @override
  Widget build(BuildContext context) {
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;
    return Container(
      height: h,
      margin: EdgeInsets.symmetric(horizontal: w * 0.15),
      decoration: const BoxDecoration(
          //color: Colors.blue,
          ),
      child: Form(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(() => Text('${networkService.downloadSpeed.toString()}MB/s')),
            Obx(() => Text(networkService.connectionType.toString())),
            //
            Spacer(),
            _logo(),
            _emailField(),
            SizedBox(
              height: h * 0.03,
            ),
            _passwordField(),
            SizedBox(
              height: h * 0.01,
            ),
            _acceptTermsCheck(),
            SizedBox(
              height: h * 0.02,
            ),
            _btnLogin(),
            SizedBox(
              height: h * 0.1,
            ),
            _recoveryPassWord(),
            Spacer(),
          ],
        ),
      ),
    );
  }

  _logo() {
    return Center(
      child: Container(
        width: w * 0.7,
        height: h * 0.22,
        decoration: const BoxDecoration(
            //color: Colors.red,
            ),
        child: Center(
          child:
              // SvgPicture.asset(
              //   'assets/img/logologin.svg',
              //   semanticsLabel: 'Onax llc',
              //   height: 100,
              //   width: 70,
              // ),
              Image.asset(
            'assets/img/splashLogo.png',
            fit: BoxFit.fill,
            scale: 1,
          ),
        ),
      ),
    );
  }

  _emailField() {
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
          keyboardType: TextInputType.emailAddress,
          cursorColor: Colors.white,
          controller: controller.email,
          textAlign: TextAlign.center,
          autofocus: false,
          style: const TextStyle(fontSize: 14.0, color: Colors.white),
          decoration: InputDesingOwn().userInputDecoration('Email'),
        ),
      ),
    );
  }

  _passwordField() {
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
          controller: controller.password,
          textAlign: TextAlign.center,
          autofocus: false,
          style: const TextStyle(fontSize: 14.0, color: Colors.white),
          decoration: InputDesingOwn().userInputDecoration('Password'),
        ),
      ),
    );
  }

  _acceptTermsCheck() {
    return Container(
        width: w * 0.47,
        height: h * 0.05,
        decoration: BoxDecoration(
            //color: Colors.orange,
            ),
        child: Row(
          children: [
            Checkbox(
              tristate: false,
              value: controller.isCheckSelected,
              onChanged: (value) {
                //
                controller.uploadCheckTerm(value);
              },
              checkColor: Colors.white,
              activeColor: Colors.transparent,
              //materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            const Text(
              'Accept Terms & conditions',
              style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  letterSpacing: -0.5,
                  fontFamily: 'Poppins'),
            ),
          ],
        ));
  }

  _btnLogin() {
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
            await controller.login();
          },
          child: const Text('Login')),
    );
  }

  _recoveryPassWord() {
    return Container(
      decoration: BoxDecoration(
          //color: Colors.white,
          ),
      child: TextButton(
        onPressed: () async {
          //
          return Get.to(
            () => ForgotPasswordScreen(controller: controller),
            transition: Transition.rightToLeft,
            duration: Duration(milliseconds: 250),
          );
        },
        child: Text(
          'Forgot Password?',
          style: ThemeWhite().underLineTextAction(Colors.white),
        ),
      ),
    );
  }
}
