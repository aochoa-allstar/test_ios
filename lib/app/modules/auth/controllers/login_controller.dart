import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onax_app/app/data/repositories/auth_repository.dart';
import 'package:onax_app/app/routes/app_pages.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class LoginController extends GetxController {
  final AuthRepository authRepository = Get.find();

  final email = TextEditingController();
  final password = TextEditingController();
  final acceptTerms = Rx<bool>(false);
  final submitButton = RoundedLoadingButtonController();

  @override
  void onInit() {
    email.text = '';
    password.text = '';

    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  updateTermsCheckbox(bool value) {
    acceptTerms.value = value;
  }

  void logIn() async {
    if (!acceptTerms.value) {
      Get.snackbar('Error', 'You must accept the terms and conditions',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white);
      submitButton.reset();
      return;
    }
    final response = await authRepository.logIn(email.text, password.text);
    submitButton.reset();

    if (response.success == true) {
      Get.offNamed(Routes.TABS);
    }
  }
}
