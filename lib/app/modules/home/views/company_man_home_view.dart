import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class CompanyManHomeView extends GetView<HomeController> {
  const CompanyManHomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CompanyManHomeView'),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Text(
          'CompanyManHomeView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
