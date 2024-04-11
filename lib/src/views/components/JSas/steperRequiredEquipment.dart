import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:onax_app/src/controllers/jsasSteperFormController.dart';
import 'package:onax_app/src/utils/styles/inputStyles.dart';
import 'package:onax_app/src/utils/styles/themWhite.dart';
import 'package:onax_app/src/views/components/home/shift/dropdownCustome.dart';

import 'dropDownJsas.dart';

class RequiredSafeEquipSteper extends StatelessWidget {
  final JsasSteperFormController controller;
  RequiredSafeEquipSteper({Key? key, required this.controller})
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
          //check Steel Toed Shoes & Hard Hat
          SizedBox(
            //color: Colors.red,
            width: w,
            child: Row(
              children: [
                _steelShoe(),
                _hardHat(),
              ],
            ),
          ),
          //Safety Glass & H2S Monitor
          SizedBox(
            //color: Colors.red,
            width: w,
            child: Row(
              children: [
                _safetyGlasses(),
                _h2hMonitor(),
              ],
            ),
          ),
          //FRClotigh & Fall Protection
          SizedBox(
            //color: Colors.red,
            width: w,
            child: Row(
              children: [
                _frClothing(),
                _fallProtection(),
              ],
            ),
          ),
          //Hearing protec & Respirator
          SizedBox(
            //color: Colors.red,
            width: w,
            child: Row(
              children: [
                _hearingProtection(),
                _respirator(),
              ],
            ),
          ),
          //Other
          SizedBox(
            width: w,
            child: Row(children: [
              Checkbox(
                value: controller.otherEquipment,
                onChanged: (value) {
                  controller.updateCheck(value!, 'otherEquipment');
                },
                checkColor: Colors.white,
                activeColor: Colors.black,
              ),
              Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10)),
                height: h * 0.055,
                width: w * 0.65,
                child: PhysicalModel(
                  color: Colors.white,
                  elevation: 2,
                  borderRadius: BorderRadius.circular(10),
                  child: TextFormField(
                    controller: controller.otherEquipmentText,
                    style: ThemeWhite().labelHomeTitles(Colors.black),
                    onChanged: (value) {
                      if (controller.otherEquipmentText.text.isEmpty) {
                        FocusManager.instance.primaryFocus?.unfocus();
                      }
                    },
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(255),
                    ],
                    keyboardType: TextInputType.text,
                    autofocus: false,
                    decoration:
                        StyleInput().inputTextSyle('utils_other'.tr, Colors.white),
                  ),
                ),
              ),
            ]),
          ),

          //
          SizedBox(height: h * 0.01),
        ],
      ),
    );
  }

  _steelShoe() {
    return SizedBox(
      width: w * 0.42,
      child: Row(
        children: [
          Checkbox(
            value: controller.steelShoes,
            onChanged: (value) {
              controller.updateCheck(value!, 'steelShoes');
            },
            checkColor: Colors.white,
            activeColor: Colors.black,
          ),
          Expanded(
            child: Text(
              'new_jsas_safetyequip_steel'.tr,
              style: ThemeWhite().labelCheckbox(Colors.black),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  _hardHat() {
    return SizedBox(
      width: w * 0.3,
      child: Row(
        children: [
          Checkbox(
            value: controller.hardHat,
            onChanged: (value) {
              controller.updateCheck(value!, 'hardHat');
            },
            checkColor: Colors.white,
            activeColor: Colors.black,
          ),
          Expanded(
            child: Text(
              'new_jsas_safetyequip_hard'.tr,
              style: ThemeWhite().labelCheckbox(Colors.black),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
  
  _safetyGlasses() {
    return SizedBox(
      width: w * 0.42,
      child: Row(
        children: [
          Checkbox(
            value: controller.safetyGlasses,
            onChanged: (value) {
              controller.updateCheck(value!, 'safetyGlasses');
            },
            checkColor: Colors.white,
            activeColor: Colors.black,
          ),
          Expanded(
            child: Text(
              'new_jsas_safetyequip_glasses'.tr,
              style: ThemeWhite().labelCheckbox(Colors.black),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
  
  _h2hMonitor() {
    return SizedBox(
      width: w * 0.33,
      child: Row(
        children: [
          Checkbox(
            value: controller.h2hMonitor,
            onChanged: (value) {
              controller.updateCheck(value!, 'h2hMonitor');
            },
            checkColor: Colors.white,
            activeColor: Colors.black,
          ),
          Expanded(
            child: Text(
              'new_jsas_safetyequip_monitor'.tr,
              style: ThemeWhite().labelCheckbox(Colors.black),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
  
  _frClothing() {
    return SizedBox(
      width: w * 0.42,
      child: Row(
        children: [
          Checkbox(
            value: controller.frClothing,
            onChanged: (value) {
              controller.updateCheck(value!, 'frClothing');
            },
            checkColor: Colors.white,
            activeColor: Colors.black,
          ),
          Expanded(
            child: Text(
              'new_jsas_safetyequip_fr'.tr,
              style: ThemeWhite().labelCheckbox(Colors.black),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
  
  _fallProtection() {
    return SizedBox(
      width: w * 0.3,
      child: Row(
        children: [
          Checkbox(
            value: controller.fallProtection,
            onChanged: (value) {
              controller.updateCheck(value!, 'fallProtection');
            },
            checkColor: Colors.white,
            activeColor: Colors.black,
          ),
          Expanded(
            child: Text(
              'new_jsas_safetyequip_fall'.tr,
              style: ThemeWhite().labelCheckbox(Colors.black),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
  
  _hearingProtection() {
    return SizedBox(
      width: w * 0.42,
      child: Row(
        children: [
          Checkbox(
            value: controller.hearingProtection,
            onChanged: (value) {
              controller.updateCheck(value!, 'hearingProtection');
            },
            checkColor: Colors.white,
            activeColor: Colors.black,
          ),
          Expanded(
            child: Text(
              'new_jsas_safetyequip_hearing'.tr,
              style: ThemeWhite().labelCheckbox(Colors.black),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
  
  _respirator() {
    return SizedBox(
      width: w * 0.31,
      child: Row(
        children: [
          Checkbox(
            value: controller.respirator,
            onChanged: (value) {
              controller.updateCheck(value!, 'respirator');
            },
            checkColor: Colors.white,
            activeColor: Colors.black,
          ),
          Expanded(
            child: Text(
              'new_jsas_safetyequip_respirator'.tr,
              style: ThemeWhite().labelCheckbox(Colors.black),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

}
