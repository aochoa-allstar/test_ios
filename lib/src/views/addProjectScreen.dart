import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:onax_app/src/controllers/destinationController.dart';
import 'package:onax_app/src/controllers/projectsController.dart';

import 'package:onax_app/src/utils/styles/inputStyles.dart';
import 'package:onax_app/src/utils/styles/themWhite.dart';
import 'package:onax_app/src/views/components/projects/dropDownCustomer.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class AddProjects extends StatelessWidget {
  AddProjects({super.key});
  late double w, h;
  @override
  Widget build(BuildContext context) {
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;
    final ProjectController projectController = ProjectController();
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
        icon: Icon(Icons.arrow_back_ios),
        onPressed: () {
          Get.offNamed('/pages');
        },
      )),
      body: GetBuilder<ProjectController>(
        init: projectController,
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
                    'menu_add_project'.tr,
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(
                height: h * 0.02,
              ),
              _drowDownCustomer(controller),
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

  _name(ProjectController controller) {
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

  _gps(ProjectController controller) {
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

  _btnSave(ProjectController controller) {
    return RoundedLoadingButton(
      width: w * 0.3,
      color: Colors.blue,
      controller: controller.saveProject,
      onPressed: () async {
        await controller.saveProjects();
        // AccountPrefs.statusConnection == true
        //     ? await _.saveJSAs()
        //     : await _.saveJSAsNotWIFI();
        controller.saveProject.reset();
      },
      borderRadius: 15,
      child: Text(
        'utils_save'.tr,
        style: ThemeWhite().labelBtnActions(Colors.white),
      ),
    );
  }

  _drowDownCustomer(ProjectController controller) {
    return Container(
      height: h * 0.07,
      width: w * 0.7,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: PhysicalModel(
        color: Colors.white,
        elevation: 5,
        borderRadius: BorderRadius.circular(15),
        child: DropdownButtonFormField2(
          dropdownMaxHeight: h * 0.2,
          decoration: InputDecoration(
            label: Text('new_ticket_customer_label'.tr),
            //Add isDense true and zero Padding.
            //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
            isDense: true,
            contentPadding: EdgeInsets.zero,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            //Add more decoration as you want here
            //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
          ),
          isExpanded: true,
          hint: Center(
            child: Text(
              'new_ticket_customer_hint'.tr,
              style: TextStyle(fontSize: 14),
              textAlign: TextAlign.center,
            ),
          ),
          icon: const Icon(
            Icons.arrow_drop_down,
            color: Colors.black45,
          ),
          iconSize: 30,
          buttonHeight: 60,
          buttonPadding: const EdgeInsets.only(left: 20, right: 10),
          dropdownDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
          ),
          items: controller.customerList
              .map((item) => DropdownMenuItem<String>(
                    value: '${item.id}-${item.name}',
                    child: Center(
                      child: Text(
                        item.name,
                        style: const TextStyle(
                          fontSize: 14,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                  ))
              .toList(),
          validator: (value) {
            if (value == '') {
              return 'new_ticket_customer_validator'.tr;
            }
            return null;
          },
          onChanged: (value) async {
            //Do something when changing the item if you want.
            late List<String> valSend = value.toString().split('-');
            print(valSend);
            await controller.selectCustomer(valSend);
          },
          onSaved: (value) async {
            late List<String> valSend = value.toString().split('-');
            await controller.selectCustomer(valSend);
          },
        ),
      ),
    );
  }
}
