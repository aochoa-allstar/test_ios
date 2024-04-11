import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onax_app/app/routes/app_pages.dart';
// import 'package:onax_app/core/services/network_service.dart';
import 'package:onax_app/src/views/components/textFields/inputDesing.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../controllers/login_controller.dart';

class LoginFormWidget extends StatelessWidget {
  final LoginController controller = Get.find();
  // final NetworkService networkService = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.maxFinite,
      margin: EdgeInsets.symmetric(horizontal: 75),
      child: Form(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Obx(() => Text('${networkService.downloadSpeed.toString()}MB/s')),
            // Obx(() => Text(networkService.connectionType.toString())),
            Spacer(),
            _logo(),
            SizedBox(height: 24),
            _emailField(),
            SizedBox(height: 8),
            _passwordField(),
            SizedBox(height: 8),
            _acceptTermsCheckbox(),
            SizedBox(height: 16),
            _submitButton(),
            SizedBox(height: 8),
            _passwordRecovery(),
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

  _passwordField() {
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
        obscureText: true,
        cursorColor: Colors.white,
        controller: controller.password,
        textAlign: TextAlign.center,
        autofocus: false,
        style: const TextStyle(fontSize: 14, color: Colors.white),
        decoration:
            InputDesingOwn().userInputDecoration('auth_fields_password'.tr),
      ),
    );
  }

  _acceptTermsCheckbox() {
    return Row(
      children: [
        Obx(
          () => Checkbox(
            tristate: false,
            value: controller.acceptTerms.value,
            onChanged: ((value) => controller.updateTermsCheckbox(value!)),
            checkColor: Colors.white,
            activeColor: Colors.transparent,
          ),
        ),
        Text(
          'auth_fields_terms'.tr,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  _submitButton() {
    return RoundedLoadingButton(
      color: Colors.white,
      onPressed: (() => controller.logIn()),
      controller: controller.submitButton,
      child: Text(
        'auth_login_submit'.tr,
        style: TextStyle(color: Colors.black),
      ),
    );
  }

  _passwordRecovery() {
    return TextButton(
      onPressed: () async {
        return Get.toNamed(Routes.FORGOT_PASSWORD);
      },
      child: Text(
        'auth_login_forgot_password'.tr,
        style: TextStyle(color: Colors.indigo),
      ),
    );
  }
}
