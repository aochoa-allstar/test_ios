import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:onax_app/src/controllers/authController.dart';

import '../widgets/recover_password_form_widget.dart';

class RecoverPasswordView extends GetView<AuthController> {
  const RecoverPasswordView({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo,
      body: SafeArea(
        child: Container(
          width: double.maxFinite,
          height: double.maxFinite,

          // Recover Password Form
          child: RecoverPasswordFormWidget(),

          //Backgound Image
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fitHeight,
              image: AssetImage('assets/img/backgroundOnax.png'),
            ),
          ),
        ),
      ),
    );
  }
}
