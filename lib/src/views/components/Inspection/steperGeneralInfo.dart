import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:onax_app/src/controllers/inspectionsController.dart';

import 'package:onax_app/src/utils/styles/inputStyles.dart';
import 'package:onax_app/src/utils/styles/themWhite.dart';
import 'package:onax_app/src/views/components/Inspection/dropDownEquipment.dart';
import 'package:onax_app/src/views/components/Inspection/dropDownLocations.dart';
import 'package:onax_app/src/views/components/home/shift/dropdownCustome.dart';

class GeneralInfoInspectionSteper extends StatelessWidget {
  final InspectionController controller;
  GeneralInfoInspectionSteper({Key? key, required this.controller})
      : super(key: key);
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
              child: CustomeDropDownLocation(
                controller: controller,
                hint: 'new_jsas_generalinfo_location_hint'.tr,
                listItems:
                    controller.listDestinations, //change to list destinations
                validator: 'new_jsas_generalinfo_location_validator'.tr,
                typeSelect: 0,
              ),
            ),
          ),

          SizedBox(height: h * 0.02),
          Text('new_inspection_pretrip_odometer_label'.tr,
              style: ThemeWhite().labelCheckbox(Colors.black)),
          //jobDescription
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            height: h * 0.055,
            width: w * 0.7,
            child: PhysicalModel(
              color: Colors.white,
              elevation: 2,
              borderRadius: BorderRadius.circular(10),
              child: TextFormField(
                maxLines: null,
                controller: controller.odoMeterbeginTxt,
                style: ThemeWhite().labelHomeTitles(Colors.black),
                onChanged: (value) {
                  if (controller.odoMeterbeginTxt.text.isEmpty) {
                    FocusManager.instance.primaryFocus?.unfocus();
                  }
                },
                inputFormatters: [
                  LengthLimitingTextInputFormatter(255),
                ],
                keyboardType: TextInputType.number,
                autofocus: false,
                decoration: StyleInput().inputTextSyle('new_inspection_pretrip_odometer_hint'.tr+': ', Colors.white),
              ),
            ),
          ),
          SizedBox(height: h * 0.02),
          //Company
          controller.prePost == 2
              ? Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(10)),
                  height: h * 0.055,
                  width: w * 0.7,
                  child: PhysicalModel(
                    color: Colors.white,
                    elevation: 2,
                    borderRadius: BorderRadius.circular(10),
                    child: TextFormField(
                      controller: controller.odoMeterEndText,
                      style: ThemeWhite().labelHomeTitles(Colors.black),
                      onChanged: (value) {
                        if (controller.odoMeterEndText.text.isEmpty) {
                          FocusManager.instance.primaryFocus?.unfocus();
                        }
                      },
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(255),
                      ],
                      keyboardType: TextInputType.number,
                      autofocus: false,
                      decoration:
                          StyleInput().inputTextSyle('new_inspection_pretrip_odometer_hint2'.tr+': ', Colors.white),
                    ),
                  ),
                )
              : const SizedBox(),
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
              child: CustomeDropDownEquipment(
                type: 'truck',
                controller: controller,
                hint: 'new_inspection_pretrip_odometer_hint3'.tr,
                listItems: controller.listEquipment,
                validator: 'new_inspection_pretrip_odometer_validator'.tr,
                typeSelect: 0,
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
