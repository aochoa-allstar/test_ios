import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onax_app/src/views/components/textFields/inputDesing.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../controllers/recover_password_controller.dart';

class RecoverPasswordFormWidget extends StatelessWidget {
  final RecoverPasswordController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.maxFinite,
      margin: EdgeInsets.symmetric(horizontal: 75),
      child: Form(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            _logo(),
            SizedBox(height: 24),
            _emailField(),
            SizedBox(height: 16),
            _submitButton(),
            Spacer(),
          ],
        ),
      ),
    );
  }

  _logo() {
    return Center(
      child: Image.asset(
        'assets/img/logotype.png',
        fit: BoxFit.fill,
        scale: 1,
        width: 128,
        height: 128,
      ),
    );
  }

  _emailField() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.white,
          width: 1,
          style: BorderStyle.solid,
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      child: TextField(
        keyboardType: TextInputType.emailAddress,
        cursorColor: Colors.white,
        controller: controller.email,
        textAlign: TextAlign.center,
        autofocus: false,
        style: const TextStyle(fontSize: 14, color: Colors.white),
        decoration:
            InputDesingOwn().userInputDecoration('auth_fields_email'.tr),
      ),
    );
  }

  _submitButton() {
    return RoundedLoadingButton(
      color: Colors.white,
      onPressed: (() => controller.recoverPassword()),
      controller: controller.submitButton,
      child: Text(
        'auth_recover_password_submit'.tr,
        style: TextStyle(color: Colors.black),
      ),
    );
  }
}
