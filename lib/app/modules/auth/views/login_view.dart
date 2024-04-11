import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:onax_app/app/modules/auth/widgets/login_form_widget.dart';
class LoginView extends GetView {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo,
      body: SafeArea(
        child: Container(
          width: double.maxFinite,
          height: double.maxFinite,
          
          // Login Form
          child: LoginFormWidget(),

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
