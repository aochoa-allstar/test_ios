import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:onax_app/src/controllers/destinationController.dart';

import 'package:onax_app/src/utils/styles/inputStyles.dart';
import 'package:onax_app/src/utils/styles/themWhite.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class AddDestinationScreen extends StatelessWidget {
  AddDestinationScreen({super.key});
  late double w, h;
  @override
  Widget build(BuildContext context) {
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;
    final DestinationsController destinationsController =
        DestinationsController();
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
        icon: Icon(Icons.arrow_back_ios),
        onPressed: () {
          Get.offNamed('/pages');
        },
      )),
      body: GetBuilder<DestinationsController>(
        init: destinationsController,
        builder: (controller) => SafeArea(
            child: SizedBox(
          width: w,
          height: h,
          child: Column(
            children: [
              SizedBox(
                height: h * 0.01,
              ),
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: w * 0.95,
                  height: h * 0.05,
                  child: Text(
                    'menu_add_destination'.tr,
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(
                height: h * 0.02,
              ),
              _name(controller),
              SizedBox(
                height: h * 0.02,
              ),
              _gps(controller),
              SizedBox(
                height: h * 0.05,
              ),
              _btnSave(controller),
            ],
          ),
        )),
      ),
    );
  }

  _name(DestinationsController controller) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      height: h * 0.055,
      width: w * 0.7,
      child: PhysicalModel(
        color: Colors.white,
        elevation: 2,
        borderRadius: BorderRadius.circular(10),
        child: TextFormField(
          controller: controller.nameText,
          style: ThemeWhite().labelHomeTitles(Colors.black),
          onChanged: (value) {
            if (controller.nameText.text.isEmpty) {
              FocusManager.instance.primaryFocus?.unfocus();
            }
          },
          inputFormatters: [
            LengthLimitingTextInputFormatter(255),
          ],
          keyboardType: TextInputType.text,
          autofocus: false,
          decoration: StyleInput().inputTextSyle('utils_name'.tr, Colors.white),
        ),
      ),
    );
  }

  _gps(DestinationsController controller) {
    return //gps
        Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      height: h * 0.055,
      width: w * 0.7,
      child: PhysicalModel(
        color: Colors.white,
        elevation: 2,
        borderRadius: BorderRadius.circular(10),
        child: TextFormField(
          enabled: true,
          controller: controller.cordsText,
          style: ThemeWhite().labelHomeTitles(Colors.black),
          onChanged: (value) {
            if (controller.cordsText.text.isEmpty) {
              FocusManager.instance.primaryFocus?.unfocus();
            }
          },
          inputFormatters: [
            LengthLimitingTextInputFormatter(255),
          ],
          keyboardType: TextInputType.text,
          autofocus: false,
          decoration: StyleInput().inputTextSyle('GPS', Colors.white),
        ),
      ),
    );
  }

  _btnSave(DestinationsController controller) {
    return RoundedLoadingButton(
      width: w * 0.3,
      color: Colors.blue,
      controller: controller.saveDestinationBtn,
      onPressed: () async {
        await controller.saveDestination();
        // AccountPrefs.statusConnection == true
        //     ? await _.saveJSAs()
        //     : await _.saveJSAsNotWIFI();
        controller.saveDestinationBtn.reset();
      },
      borderRadius: 15,
      child: Text(
        'utils_save'.tr,
        style: ThemeWhite().labelBtnActions(Colors.white),
      ),
    );
  }
}
