import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:onax_app/src/controllers/jsasSteperFormController.dart';
import 'package:onax_app/src/utils/styles/inputStyles.dart';
import 'package:onax_app/src/utils/styles/themWhite.dart';
import 'package:onax_app/src/views/components/JSas/dropDownCompany.dart';
import 'package:onax_app/src/views/components/JSas/dropDownLocation.dart';
import 'package:onax_app/src/views/components/JSas/dropDownProjectJsas.dart';
import 'package:onax_app/src/views/components/home/shift/dropdownCustome.dart';

import 'dropDownJsas.dart';

class GeneralInfoSteper extends StatelessWidget {
  final JsasSteperFormController controller;
  GeneralInfoSteper({Key? key, required this.controller}) : super(key: key);
  late double h, w;
  @override
  Widget build(BuildContext context) {
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;
    return SizedBox(
      width: w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: h * 0.01),
          //Location
          Container(
            height: h * 0.055,
            width: w * 0.7,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: PhysicalModel(
              color: Colors.white,
              elevation: 2,
              borderRadius: BorderRadius.circular(15),
              // child: CustomeDropDownLocationJSA(
              //   controller: controller,
              //   hint: 'new_jsas_generalinfo_location_hint'.tr,
              //   listItems:
              //       controller.listDestinations, //change to list destinations
              //   validator: 'new_jsas_generalinfo_location_validator'.tr,
              //   typeSelect: 0,
              // ),
              child: DropDownCompany(
                controller: controller,
                hint: 'new_ticket_customer_hint'.tr,
                listItems: controller.companiesList,
                validator: 'new_ticket_customer_validator'.tr,
              ),
            ),
          ),
          SizedBox(height: h * 0.02),
          Container(
            height: h * 0.055,
            width: w * 0.7,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: PhysicalModel(
              color: Colors.white,
              elevation: 2,
              borderRadius: BorderRadius.circular(15),
              // child: CustomeDropDownLocationJSA(
              //   controller: controller,
              //   hint: 'new_jsas_generalinfo_location_hint'.tr,
              //   listItems:
              //       controller.listDestinations, //change to list destinations
              //   validator: 'new_jsas_generalinfo_location_validator'.tr,
              //   typeSelect: 0,
              // ),
              child: dropDownProjectJsas(
                controller: controller,
                hint: 'new_ticket_project_hint'.tr,
                listItems: controller.projectsList,
                validator: 'new_ticket_project_validator'.tr,
              ),
            ),
          ),
          //Location
          // Container(
          //   decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
          //   height: h * 0.055,
          //   width: w * 0.7,
          //   child: PhysicalModel(
          //     color: Colors.white,
          //     elevation: 2,
          //     borderRadius: BorderRadius.circular(10),
          //     child: TextFormField(
          //       controller: controller.location,
          //       style: ThemeWhite().labelHomeTitles(Colors.black),
          //       onChanged: (value) {
          //         if (controller.location.text.isEmpty) {
          //           FocusManager.instance.primaryFocus?.unfocus();
          //         }
          //       },
          //       inputFormatters: [
          //         LengthLimitingTextInputFormatter(255),
          //       ],
          //       keyboardType: TextInputType.text,
          //       autofocus: false,
          //       decoration:
          //           StyleInput().inputTextSyle('Location', Colors.white),
          //     ),
          //   ),
          // ),
          SizedBox(height: h * 0.02),
          //jobDescription
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            height: h * 0.1,
            width: w * 0.7,
            child: PhysicalModel(
              color: Colors.white,
              elevation: 2,
              borderRadius: BorderRadius.circular(10),
              child: TextFormField(
                maxLines: null,
                controller: controller.jobDescription,
                style: ThemeWhite().labelHomeTitles(Colors.black),
                onChanged: (value) {
                  if (controller.jobDescription.text.isEmpty) {
                    FocusManager.instance.primaryFocus?.unfocus();
                  }
                },
                inputFormatters: [
                  LengthLimitingTextInputFormatter(2058),
                ],
                keyboardType: TextInputType.multiline,
                autofocus: false,
                decoration:
                    StyleInput().textAreaStyle('new_jsas_generalinfo_job'.tr, Colors.white),
              ),
            ),
          ),
          SizedBox(height: h * 0.02),
          //Company
          // Container(
          //   decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
          //   height: h * 0.055,
          //   width: w * 0.7,
          //   child: PhysicalModel(
          //     color: Colors.white,
          //     elevation: 2,
          //     borderRadius: BorderRadius.circular(10),
          //     child: TextFormField(
          //       controller: controller.company,
          //       style: ThemeWhite().labelHomeTitles(Colors.black),
          //       onChanged: (value) {
          //         if (controller.company.text.isEmpty) {
          //           FocusManager.instance.primaryFocus?.unfocus();
          //         }
          //       },
          //       inputFormatters: [
          //         LengthLimitingTextInputFormatter(255),
          //       ],
          //       keyboardType: TextInputType.text,
          //       autofocus: false,
          //       decoration: StyleInput().inputTextSyle('Company', Colors.white),
          //     ),
          //   ),
          // ),
          SizedBox(height: h * 0.02),
          //gps
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            height: h * 0.055,
            width: w * 0.7,
            child: PhysicalModel(
              color: Colors.white,
              elevation: 2,
              borderRadius: BorderRadius.circular(10),
              child: TextFormField(
                enabled: false,
                controller: controller.gps,
                style: ThemeWhite().labelHomeTitles(Colors.black),
                onChanged: (value) {
                  if (controller.gps.text.isEmpty) {
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
          ),
          SizedBox(height: h * 0.02),
          //HELPER
          Container(
            height: h * 0.055,
            width: w * 0.7,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: PhysicalModel(
              color: Colors.white,
              elevation: 2,
              borderRadius: BorderRadius.circular(15),
              child: CustomeDropDownJSAs(
                controller: controller,
                hint: 'start_shift_helper_hint'.tr,
                listItems: controller.listWorkersHelpers,
                validator: 'start_shift_helper_validator'.tr,
                typeSelect: 1,
              ),
            ),
          ),
          SizedBox(height: h * 0.02),
          //HELPER 2
          Container(
            height: h * 0.055,
            width: w * 0.7,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: PhysicalModel(
              color: Colors.white,
              elevation: 2,
              borderRadius: BorderRadius.circular(15),
              child: CustomeDropDownJSAs(
                controller: controller,
                hint: 'start_shift_helper_hint'.tr,
                listItems: controller.listWorkersHelpers,
                validator: 'start_shift_helper_validator'.tr,
                typeSelect: 2,
              ),
            ),
          ),
          //
          SizedBox(height: h * 0.01),
        ],
      ),
    );
  }
}
